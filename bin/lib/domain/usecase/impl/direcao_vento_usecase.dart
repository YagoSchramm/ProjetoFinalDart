import 'dart:io';

import '../direcao_vento.dart';
import '../../../infrastructure/store/leitor.dart';

class DirecaoVentoUsecaseImpl implements DirecaoVentoUseCase {
  static const String _colunaDirecaoVento = 'direcao_vento_graus';

  final Leitor _leitor;

  DirecaoVentoUsecaseImpl({required Leitor leitor}) : _leitor = leitor;

  @override
  Future<double> direcaoMaisFrequentePorEstadoPorAno(
    String siglaEstado,
    String ano,
  ) async {
    final valores = await _valoresPorAno(siglaEstado, ano);
    final maisFrequente = _maisFrequente(valores);
    return maisFrequente;
  }

  @override
  Future<double> direcaoMaisFrequentePorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final valores = await _valoresPorMes(siglaEstado, mes, ano);
    final maisFrequente = _maisFrequente(valores);
    return maisFrequente;
  }

  // função que pega todos os valores de direção do vento de todos os arquivos do determinado ano
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

  // função que pega todos os valores de direção do vento de todos os arquivos do determinado mês e ano
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
    final indiceDirecaoVento = colunas.indexOf(_colunaDirecaoVento);
    if (indiceDirecaoVento == -1) {
      throw Exception('Erro ao encontrar coluna $_colunaDirecaoVento');
    }

    final valores = <double>[];

    for (var i = 1; i < linhas.length; i++) {
      final linha = linhas[i].trim();
      if (linha.isEmpty) {
        continue;
      }

      final campos = linha.split(',');
      if (campos.length <= indiceDirecaoVento) {
        continue;
      }

      valores.add(double.parse(campos[indiceDirecaoVento]));
    }

    return valores;
  }

  double _maisFrequente(List<double> valores) {
    Map<double, int> contagem = {};
    for (double numero in valores) {
      contagem[numero] = (contagem[numero] ?? 0) + 1;
    }

    double valor = valores.first;
    int maiorQuantidade = 0;
    contagem.forEach((numero, quantidade) {
      if (quantidade > maiorQuantidade) {
        maiorQuantidade = quantidade;
        valor = numero;
      }
    });
    return valor;
  }
}
