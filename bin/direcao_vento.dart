import 'dart:math';

import 'package:yaansi/yaansi.dart';

import 'lib/infrastructure/store/leitor.dart';

class DirecaoVento {
  static const String colunaDirecaoVento = 'direcao_vento_graus';

  final Leitor leitor;

  DirecaoVento({required this.leitor});

  Future<double> direcaoMaisFrequentePorEstadoPorAno(
    String siglaEstado,
    String ano,
  ) async {
    final arquivos = await leitor.getByYear(siglaEstado, ano);
    final valores = <double>[];

    for (final arquivo in arquivos) {
      if (arquivo == null) continue;

      final linhas = await arquivo.readAsLines();
      final colunas = linhas.first.trim().split(',');
      final indiceDirecaoVento = colunas.indexOf(colunaDirecaoVento);

      if (indiceDirecaoVento == -1) {
        throw Exception('Erro ao encontrar coluna $colunaDirecaoVento');
      }

      for (var i = 1; i < linhas.length; i++) {
        final linha = linhas[i].trim();
        if (linha.isEmpty) continue;

        final campos = linha.split(',');
        if (campos.length > indiceDirecaoVento) {
          valores.add(double.parse(campos[indiceDirecaoVento]));
        }
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de direcao do vento encontrado');
    }

    final contagem = <double, int>{};
    for (final valor in valores) {
      contagem[valor] = (contagem[valor] ?? 0) + 1;
    }

    var maisFrequente = valores.first;
    var maiorQuantidade = 0;
    contagem.forEach((valor, quantidade) {
      if (quantidade > maiorQuantidade) {
        maiorQuantidade = quantidade;
        maisFrequente = valor;
      }
    });

    return maisFrequente;
  }

  Future<double> direcaoMaisFrequentePorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final arquivo = await leitor.getByMonth(siglaEstado, mes, ano);
    if (arquivo == null) throw Exception('Erro ao filtrar arquivo');

    final linhas = await arquivo.readAsLines();
    final colunas = linhas.first.trim().split(',');
    final indiceDirecaoVento = colunas.indexOf(colunaDirecaoVento);
    final valores = <double>[];

    if (indiceDirecaoVento == -1) {
      throw Exception('Erro ao encontrar coluna $colunaDirecaoVento');
    }

    for (var i = 1; i < linhas.length; i++) {
      final linha = linhas[i].trim();
      if (linha.isEmpty) continue;

      final campos = linha.split(',');
      if (campos.length > indiceDirecaoVento) {
        valores.add(double.parse(campos[indiceDirecaoVento]));
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de direcao do vento encontrado');
    }

    final contagem = <double, int>{};
    for (final valor in valores) {
      contagem[valor] = (contagem[valor] ?? 0) + 1;
    }

    var maisFrequente = valores.first;
    var maiorQuantidade = 0;
    contagem.forEach((valor, quantidade) {
      if (quantidade > maiorQuantidade) {
        maiorQuantidade = quantidade;
        maisFrequente = valor;
      }
    });

    return maisFrequente;
  }

  Future<void> informacoes() async {
    final estados = ['SC', 'SP'];
    final anos = ['2024', '2025', '2026'];

    for (final estado in estados) {
      for (final ano in anos) {
        final direcao = await direcaoMaisFrequentePorEstadoPorAno(estado, ano);
        print(
          '\nDirecao do vento com maior frequencia no estado $estado no ano $ano:',
        );
        print('${direcao.toStringAsFixed(1)} graus'.yellow);
        print('${(direcao * pi / 180).toStringAsFixed(1)} radianos'.yellow);
      }
    }

    for (final estado in estados) {
      for (final ano in anos) {
        for (var i = 1; i <= 12; i++) {
          final mes = i.toString().padLeft(2, '0');
          final direcao = await direcaoMaisFrequentePorEstadoPorMes(
            estado,
            mes,
            ano,
          );
          print(
            '\nDirecao do vento com maior frequencia no estado $estado no mes $mes de $ano:',
          );
          print('${direcao.toStringAsFixed(1)} graus'.yellow);
          print('${(direcao * pi / 180).toStringAsFixed(1)} radianos'.yellow);
        }
      }
    }
  }
}
