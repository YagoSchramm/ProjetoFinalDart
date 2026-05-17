import 'dart:io';

import '../../../infrastructure/store/leitor.dart';
import '../umidade.dart';

class UmidadeArUseCaseImpl implements UmidadeArUseCase {
  String _colunaUmidade= "umidade_ar_%";

  final Leitor _leitor;

  UmidadeArUseCaseImpl({required Leitor leitor}) : _leitor = leitor;

  @override
  Future<double> mediaPorEstadoPorAno(String siglaEstado, String ano) async {
    final valores = await _valoresPorAno(siglaEstado, ano);
    return _media(valores);
  }

  @override
  Future<double> mediaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final valores = await _valoresPorMes(siglaEstado, mes, ano);
    return _media(valores);
  }

  @override
  Future<double> maximaPorEstadoPorAno(String siglaEstado, String ano) async {
    final valores = await _valoresPorAno(siglaEstado, ano);
    return _maxima(valores);
  }

  @override
  Future<double> maximaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final valores = await _valoresPorMes(siglaEstado, mes, ano);
    return _maxima(valores);
  }

  @override
  Future<double> minimaPorEstadoPorAno(String siglaEstado, String ano) async {
    final valores = await _valoresPorAno(siglaEstado, ano);
    return _minima(valores);
  }

  @override
  Future<double> minimaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final valores = await _valoresPorMes(siglaEstado, mes, ano);
    return _minima(valores);
  }

  Future<List<double>> _valoresPorAno(String siglaEstado, String ano) async {
    final arquivos = await _leitor.getByYear(siglaEstado, ano);
    final valores = <double>[];

    for (final arquivo in arquivos) {
      if (arquivo == null) {
        continue;
      }

      valores.addAll(await _lerValores(arquivo));
    }

    return valores;
  }

  Future<List<double>> _valoresPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final arquivo = await _leitor.getByMonth(siglaEstado, mes, ano);
    if (arquivo == null) {
      throw Exception('Erro ao filtrar arquivo');
    }

    return _lerValores(arquivo);
  }

  Future<List<double>> _lerValores(File arquivo) async {
    final conteudo = await arquivo.readAsString();
    final linhas = conteudo.split('\n');
    if (linhas.isEmpty) {
      return <double>[];
    }

    final colunas = linhas.first.trim().split(',');
    final indiceUmidade = colunas.indexOf(_colunaUmidade);
    if (indiceUmidade == -1) {
      throw Exception(
        'Erro ao encontrar coluna de umidade do ar. Colunas aceitas: ${_colunaUmidade}',
      );
    }

    final valores = <double>[];
    for (var i = 1; i < linhas.length; i++) {
      final linha = linhas[i].trim();
      if (linha.isEmpty) {
        continue;
      }

      final campos = linha.split(',');
      if (campos.length <= indiceUmidade) {
        continue;
      }

      valores.add(double.parse(campos[indiceUmidade]));
    }

    return valores;
  }

  double _media(List<double> valores) {
    _validarValores(valores);

    var soma = 0.0;
    for (final valor in valores) {
      soma += valor;
    }

    return soma / valores.length;
  }

  double _maxima(List<double> valores) {
    _validarValores(valores);

    var maxima = valores.first;
    for (var i = 1; i < valores.length; i++) {
      if (valores[i] > maxima) {
        maxima = valores[i];
      }
    }

    return maxima;
  }

  double _minima(List<double> valores) {
    _validarValores(valores);

    var minima = valores.first;
    for (var i = 1; i < valores.length; i++) {
      if (valores[i] < minima) {
        minima = valores[i];
      }
    }

    return minima;
  }

  void _validarValores(List<double> valores) {
    if (valores.isEmpty) {
      throw Exception('Nenhum valor de umidade do ar encontrado');
    }
  }
}
