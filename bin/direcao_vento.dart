import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:yaansi/yaansi.dart';

import 'lib/infrastructure/store/leitor.dart';

class DirecaoVento {
  static const String colunaDirecaoVento = 'Dire';

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

      final linhas = await arquivo.readAsLines(encoding: latin1);
      final colunas = linhas.first.trim().split(',');
      String? coluna;
      colunas.forEach((colunas) {
        if (coluna == null && colunas.startsWith(colunaDirecaoVento)) {
          coluna = colunas;
        }
      });

      if (coluna == null) {
        throw Exception('Erro ao encontrar coluna $colunaDirecaoVento');
      }

      final indiceDirecaoVento = colunas.indexOf(coluna!);

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

    final linhas = await arquivo.readAsLines(encoding: latin1);
    final colunas = linhas.first.trim().split(',');
    String? coluna;
    colunas.forEach((colunas) {
      if (coluna == null && colunas.startsWith(colunaDirecaoVento)) {
        coluna = colunas;
      }
    });

    if (coluna == null) {
      throw Exception('Erro ao encontrar coluna $colunaDirecaoVento');
    }

    final indiceDirecaoVento = colunas.indexOf(coluna!);
    final valores = <double>[];

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
    const ano = '2024';

    for (final estado in estados) {
      final direcao = await direcaoMaisFrequentePorEstadoPorAno(estado, ano);
      print(
        '\nDirecao do vento com maior frequencia no estado $estado no ano $ano:',
      );
      print('${direcao.toStringAsFixed(1)} graus'.yellow);
      print('${(direcao * pi / 180).toStringAsFixed(1)} radianos'.yellow);
    }

    for (final estado in estados) {
      final meses = await leitor.getMonthsByYear(estado, ano);

      for (final mes in meses) {
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
      print(
        "\nVocê quer gerar um relatório do conteúdo apresentado (1-sim,2-não)?",
      );
      int? opcao = int.tryParse(stdin.readLineSync()!);
      if (opcao == null) {
        throw Exception("Erro ao codificar opção");
      }
      switch (opcao) {
        case 1:
          await gerarArquivo();
          print("Fim da execução");
          break;
        default:
          print("Fim da execução");
          break;
      }
  }

  Future<void> gerarArquivo() async {
    final estados = ['SC', 'SP'];
    const ano = '2024';
    final buffer = StringBuffer();

    for (final estado in estados) {
      final direcao = await direcaoMaisFrequentePorEstadoPorAno(estado, ano);
      buffer.writeln(
        '\nDirecao do vento com maior frequencia no estado $estado no ano $ano:',
      );
      buffer.writeln('Graus: ${direcao.toStringAsFixed(1)}');
      buffer.writeln('Radianos: ${(direcao * pi / 180).toStringAsFixed(1)}');
    }

    for (final estado in estados) {
      final meses = await leitor.getMonthsByYear(estado, ano);
      for (var mes in meses) {
        final direcao = await direcaoMaisFrequentePorEstadoPorMes(
          estado,
          mes,
          ano,
        );
        buffer.writeln(
          '\nDirecao do vento com maior frequencia no estado $estado no ano $ano:',
        );
        buffer.writeln('Graus: ${direcao.toStringAsFixed(1)}');
        buffer.writeln('Radianos: ${(direcao * pi / 180).toStringAsFixed(1)}');
      }
    }
    final pasta = Directory('relatorios');
    if (!await pasta.exists()) {
      await pasta.create();
    }
    final dataEHora = DateTime.now();
    final data = "${dataEHora.year}-${dataEHora.month}-${dataEHora.day}";
    final hora = "${dataEHora.hour}-${dataEHora.minute}";
    final arquivo = File('relatorios/VENTO_${data}_$hora.txt');
    await arquivo.writeAsString(buffer.toString());
    print("Arquivo salvo com sucesso em: ${arquivo.path}");
  }
}
