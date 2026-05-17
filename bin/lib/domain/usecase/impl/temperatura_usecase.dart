import 'dart:io';

import '../../../infrastructure/store/leitor.dart';
import '../temperatura.dart';

class TemperaturaUseCaseImpl implements TemperaturaUseCase {
  static const String _colunaTemperatura = 'temperatura_celsius';
  static const String _colunaHora = 'hora';

  final Leitor _leitor;

  TemperaturaUseCaseImpl({required Leitor leitor}) : _leitor = leitor;

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

  @override
  Future<double> mediaPorHorarioPorEstado(
    String siglaEstado,
    String hora,
  ) async {
    final arquivos = await _leitor.getByHour(siglaEstado, hora);
    final valores = <double>[];

    for (final arquivo in arquivos) {
      if (arquivo == null) {
        continue;
      }

      valores.addAll(await _lerValores(arquivo, hora: hora));
    }

    return _media(valores);
  }
  // função que pega todos os valores de temperatura de todos os arquivos do determinado ano
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

  // função que pega todos os valores de temperatura de todos os arquivos do determinado mês e ano
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
  // função para ler as temperaturas do arquivo e se necessário as horas 
  Future<List<double>> _lerValores(File arquivo, {String? hora}) async {
    final conteudo = await arquivo.readAsString();
    final linhas = conteudo.split('\n');
    if (linhas.isEmpty) {
      return <double>[];
    }

    final colunas = linhas.first.trim().split(',');
    final indiceTemperatura = colunas.indexOf(_colunaTemperatura);
    final indiceHora = colunas.indexOf(_colunaHora);

    if (indiceTemperatura == -1) {
      throw Exception('Erro ao encontrar coluna $_colunaTemperatura');
    }

    if (hora != null && indiceHora == -1) {
      throw Exception('Erro ao encontrar coluna $_colunaHora');
    }

    final valores = <double>[];

    for (var i = 1; i < linhas.length; i++) {
      final linha = linhas[i].trim();
      if (linha.isEmpty) {
        continue;
      }

      final campos = linha.split(',');
      if (campos.length <= indiceTemperatura) {
        continue;
      }

      if (hora != null &&
          (campos.length <= indiceHora || campos[indiceHora] != hora)) {
        continue;
      }

      valores.add(double.parse(campos[indiceTemperatura]));
    }

    return valores;
  }

  // Função que retorna a temperatura média entre os valores da lista
  double _media(List<double> valores) {
    _validarValores(valores);

    var soma = 0.0;
    for (final valor in valores) {
      soma += valor;
    }

    return soma / valores.length;
  }

  // Função que retorna a temperatura máxima entre os valores da lista
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

  // Validação simples para ver se o valor é vazio
  void _validarValores(List<double> valores) {
    if (valores.isEmpty) {
      throw Exception('Nenhum valor de temperatura encontrado');
    }
  }
}
