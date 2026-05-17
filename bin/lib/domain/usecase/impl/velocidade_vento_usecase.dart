import 'dart:io';

import '../velocidade_vento.dart';
import '../../../infrastructure/store/leitor.dart';

class VelocidadeVentoUsecaseImpl implements VelocidadeVentoUseCase {
  final Leitor _leitor;
  static const String _colunaVelocidadeVento = 'direcao_vento_ms';
  VelocidadeVentoUsecaseImpl({required Leitor leitor}) : _leitor = leitor;

  @override
  Future<double> maximaPorEstadoPorAno(String siglaEstado, String ano) async {
    final valores = await _valoresPorAno(siglaEstado, ano);
    final maxima = _maxima(valores);
    return maxima;
  }

  @override
  Future<double> maximaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final valores = await _valoresPorMes(siglaEstado, mes, ano);
    final maxima = _maxima(valores);
    return maxima;
  }

  @override
  Future<double> mediaPorEstadoPorAno(String siglaEstado, String ano) async {
    final valores = await _valoresPorAno(siglaEstado, ano);
    final media = _media(valores);
    return media;
  }

  @override
  Future<double> mediaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final valores = await _valoresPorMes(siglaEstado, mes, ano);
    final media = _media(valores);
    return media;
  }

  @override
  Future<double> minimaPorEstadoPorAno(String siglaEstado, String ano) async {
    final valores = await _valoresPorAno(siglaEstado, ano);
    final minima = _minima(valores);
    return minima;
  }

  @override
  Future<double> minimaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final valores = await _valoresPorMes(siglaEstado, mes, ano);
    final minima = _minima(valores);
    return minima;
  }

  Future<List<double>> _valoresPorAno(String siglaEstado, String ano) async {
    final arquivos = await _leitor.getByYear(siglaEstado, ano);
    final valores = <double>[];
    for (var arquivo in arquivos) {
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
    final linhas = conteudo.split("\n");
    if (linhas.isEmpty) {
      return <double>[];
    }

    final colunas = linhas.first.trim().split(",");
    final indiceVelocidade = colunas.indexOf(_colunaVelocidadeVento);
    if (indiceVelocidade == -1) {
      throw Exception('Erro ao encontrar coluna $_colunaVelocidadeVento');
    }
    final valores = <double>[];
    for (var i = 0; i < linhas.length; i++) {
      final linha = linhas[i].trim();
      if (linha.isEmpty) {
        continue;
      }

      final campos = linha.split(',');
      if (campos.length <= indiceVelocidade) {
        continue;
      }

      valores.add(double.parse(campos[indiceVelocidade]));
    }
    return valores;
  }

  // Função que retorna a velocidade do vento média entre os valores da lista
  double _media(List<double> valores) {
    var soma = 0.0;
    for (final valor in valores) {
      soma += valor;
    }

    return soma / valores.length;
  }

  // Função que retorna a velocidade máxima do vento entre os valores da lista
  double _maxima(List<double> valores) {
    var maxima = valores.first;
    for (var i = 1; i < valores.length; i++) {
      if (valores[i] > maxima) {
        maxima = valores[i];
      }
    }

    return maxima;
  }

  // Função que retorna a velocidade mínima do vento entre os valores da lista
  double _minima(List<double> valores) {
    var minima = valores.first;
    for (var i = 1; i < valores.length; i++) {
      if (valores[i] < minima) {
        minima = valores[i];
      }
    }

    return minima;
  }
}
