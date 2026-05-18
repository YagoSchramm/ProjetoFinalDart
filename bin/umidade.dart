import 'dart:convert';
import 'dart:io';

import 'package:yaansi/yaansi.dart';
import 'lib/infrastructure/store/leitor.dart';

class UmidadeAr {
  static const String colunaUmidade = 'Umidade';

  final Leitor leitor;

  UmidadeAr({required this.leitor});

  Future<double> mediaPorEstadoPorAno(String siglaEstado, String ano) async {
    final arquivos = await leitor.getByYear(siglaEstado, ano);
    final valores = <double>[];

    for (final arquivo in arquivos) {
      if (arquivo == null) continue;

      final linhas = await arquivo.readAsLines(encoding: latin1);
      final colunas = linhas.first.trim().split(',');
      String? coluna;
      colunas.forEach((colunas) {
        if (coluna == null && colunas.startsWith(colunaUmidade)) {
          coluna = colunas;
        }
      });

      if (coluna == null) {
        throw Exception('Erro ao encontrar coluna $colunaUmidade');
      }

      final indiceUmidade = colunas.indexOf(coluna!);

      for (var i = 1; i < linhas.length; i++) {
        final linha = linhas[i].trim();
        if (linha.isEmpty) continue;

        final campos = linha.split(',');
        if (campos.length > indiceUmidade) {
          valores.add(double.parse(campos[indiceUmidade]));
        }
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de umidade do ar encontrado');
    }

    return valores.reduce((soma, valor) => soma + valor) / valores.length;
  }

  Future<double> mediaPorEstadoPorMes(
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
      if (coluna == null && colunas.startsWith(colunaUmidade)) {
        coluna = colunas;
      }
    });

    if (coluna == null) {
      throw Exception('Erro ao encontrar coluna $colunaUmidade');
    }

    final indiceUmidade = colunas.indexOf(coluna!);
    final valores = <double>[];

    if (indiceUmidade == -1) {
      throw Exception('Erro ao encontrar coluna $colunaUmidade');
    }

    for (var i = 1; i < linhas.length; i++) {
      final linha = linhas[i].trim();
      if (linha.isEmpty) continue;

      final campos = linha.split(',');
      if (campos.length > indiceUmidade) {
        valores.add(double.parse(campos[indiceUmidade]));
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de umidade do ar encontrado');
    }

    return valores.reduce((soma, valor) => soma + valor) / valores.length;
  }

  Future<double> maximaPorEstadoPorAno(String siglaEstado, String ano) async {
    final arquivos = await leitor.getByYear(siglaEstado, ano);
    final valores = <double>[];

    for (final arquivo in arquivos) {
      if (arquivo == null) continue;

      final linhas = await arquivo.readAsLines(encoding: latin1);
      final colunas = linhas.first.trim().split(',');
      String? coluna;
      colunas.forEach((colunas) {
        if (coluna == null && colunas.startsWith(colunaUmidade)) {
          coluna = colunas;
        }
      });

      if (coluna == null) {
        throw Exception('Erro ao encontrar coluna $colunaUmidade');
      }

      final indiceUmidade = colunas.indexOf(coluna!);

      if (indiceUmidade == -1) {
        throw Exception('Erro ao encontrar coluna $colunaUmidade');
      }

      for (var i = 1; i < linhas.length; i++) {
        final linha = linhas[i].trim();
        if (linha.isEmpty) continue;

        final campos = linha.split(',');
        if (campos.length > indiceUmidade) {
          valores.add(double.parse(campos[indiceUmidade]));
        }
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de umidade do ar encontrado');
    }

    return valores.reduce((maior, valor) => valor > maior ? valor : maior);
  }

  Future<double> maximaPorEstadoPorMes(
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
      if (coluna == null && colunas.startsWith(colunaUmidade)) {
        coluna = colunas;
      }
    });

    if (coluna == null) {
      throw Exception('Erro ao encontrar coluna $colunaUmidade');
    }

    final indiceUmidade = colunas.indexOf(coluna!);
    final valores = <double>[];

    for (var i = 1; i < linhas.length; i++) {
      final linha = linhas[i].trim();
      if (linha.isEmpty) continue;

      final campos = linha.split(',');
      if (campos.length > indiceUmidade) {
        valores.add(double.parse(campos[indiceUmidade]));
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de umidade do ar encontrado');
    }

    return valores.reduce((maior, valor) => valor > maior ? valor : maior);
  }

  Future<double> minimaPorEstadoPorAno(String siglaEstado, String ano) async {
    final arquivos = await leitor.getByYear(siglaEstado, ano);
    final valores = <double>[];

    for (final arquivo in arquivos) {
      if (arquivo == null) continue;

      final linhas = await arquivo.readAsLines(encoding: latin1);
      final colunas = linhas.first.trim().split(',');
      String? coluna;
      colunas.forEach((colunas) {
        if (coluna == null && colunas.startsWith(colunaUmidade)) {
          coluna = colunas;
        }
      });

      if (coluna == null) {
        throw Exception('Erro ao encontrar coluna $colunaUmidade');
      }

      final indiceUmidade = colunas.indexOf(coluna!);
      for (var i = 1; i < linhas.length; i++) {
        final linha = linhas[i].trim();
        if (linha.isEmpty) continue;

        final campos = linha.split(',');
        if (campos.length > indiceUmidade) {
          valores.add(double.parse(campos[indiceUmidade]));
        }
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de umidade do ar encontrado');
    }

    return valores.reduce((menor, valor) => valor < menor ? valor : menor);
  }

  Future<double> minimaPorEstadoPorMes(
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
      if (coluna == null && colunas.startsWith(colunaUmidade)) {
        coluna = colunas;
      }
    });

    if (coluna == null) {
      throw Exception('Erro ao encontrar coluna $colunaUmidade');
    }

    final indiceUmidade = colunas.indexOf(coluna!);
    final valores = <double>[];

    for (var i = 1; i < linhas.length; i++) {
      final linha = linhas[i].trim();
      if (linha.isEmpty) continue;

      final campos = linha.split(',');
      if (campos.length > indiceUmidade) {
        valores.add(double.parse(campos[indiceUmidade]));
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de umidade do ar encontrado');
    }

    return valores.reduce((menor, valor) => valor < menor ? valor : menor);
  }

  Future<void> informacoes() async {
    final estados = ['SC', 'SP'];
    const ano = '2024';

    for (final estado in estados) {
      final media = await mediaPorEstadoPorAno(estado, ano);
      print("\nMedia de umidade do ar no estado $estado no ano $ano:");
      print("${media.toStringAsFixed(6)} kg/kg".green);
    }

    for (final estado in estados) {
      final meses = await leitor.getMonthsByYear(estado, ano);

      for (final mes in meses) {
        final media = await mediaPorEstadoPorMes(estado, mes, ano);
        print(
          "\nMedia de umidade do ar no estado $estado do mes $mes de $ano:",
        );
        print("${media.toStringAsFixed(6)} kg/kg".green);
      }
    }

    for (final estado in estados) {
      final maxima = await maximaPorEstadoPorAno(estado, ano);
      print("\nMaxima de umidade do ar no estado $estado no ano $ano:");
      print("${maxima.toStringAsFixed(6)} kg/kg".red);
    }

    for (final estado in estados) {
      final meses = await leitor.getMonthsByYear(estado, ano);

      for (final mes in meses) {
        final maxima = await maximaPorEstadoPorMes(estado, mes, ano);
        print(
          "\nMaxima de umidade do ar no estado $estado do mes $mes de $ano:",
        );
        print("${maxima.toStringAsFixed(6)} kg/kg".red);
      }
    }

    for (final estado in estados) {
      final minima = await minimaPorEstadoPorAno(estado, ano);
      print("\nMinima de umidade do ar no estado $estado no ano $ano:");
      print("${minima.toStringAsFixed(6)} kg/kg".blue);
    }

    for (final estado in estados) {
      final meses = await leitor.getMonthsByYear(estado, ano);

      for (final mes in meses) {
        final minima = await minimaPorEstadoPorMes(estado, mes, ano);
        print(
          "\nMinima de umidade do ar no estado $estado do mes $mes de $ano:",
        );
        print("${minima.toStringAsFixed(6)} kg/kg".blue);
      }
    }

    print(
      "\nVoce quer gerar um relatorio do conteudo apresentado (1-sim,2-nao)?",
    );
    int? opcao = int.tryParse(stdin.readLineSync()!);
    if (opcao == null) {
      throw Exception("Erro ao codificar opcao");
    }
    switch (opcao) {
      case 1:
        await gerarArquivo();
        print("Fim da execucao");
        break;
      default:
        print("Fim da execucao");
        break;
    }
  }

  Future<void> gerarArquivo() async {
    final estados = ['SC', 'SP'];
    const ano = '2024';

    final buffer = StringBuffer();

    for (final estado in estados) {
      buffer.writeln("\nMedia de umidade do ar no estado $estado no ano $ano:");
      final media = await mediaPorEstadoPorAno(estado, ano);
      buffer.writeln("${media.toStringAsFixed(6)} kg/kg");
    }
    for (final estado in estados) {
      final meses = await leitor.getMonthsByYear(estado, ano);

      for (final mes in meses) {
        final media = await mediaPorEstadoPorMes(estado, mes, ano);
        buffer.writeln(
          '\nMedia de umidade do ar no estado $estado do mes $mes de $ano:',
        );
        buffer.writeln("${media.toStringAsFixed(6)} kg/kg");
      }
    }

    for (final estado in estados) {
      final maxima = await maximaPorEstadoPorAno(estado, ano);
      buffer.writeln('\nMaxima de umidade do ar no estado $estado no ano $ano:');
      buffer.writeln("${maxima.toStringAsFixed(6)} kg/kg");
    }

    for (final estado in estados) {
      final meses = await leitor.getMonthsByYear(estado, ano);

      for (final mes in meses) {
        final maxima = await maximaPorEstadoPorMes(estado, mes, ano);
        buffer.writeln(
          '\nMaxima de umidade do ar no estado $estado do mes $mes de $ano:',
        );
        buffer.writeln("${maxima.toStringAsFixed(6)} kg/kg");
      }
    }

    for (final estado in estados) {
      final minima = await minimaPorEstadoPorAno(estado, ano);
      buffer.writeln('\nMinima de umidade do ar no estado $estado no ano $ano:');
      buffer.writeln("${minima.toStringAsFixed(6)} kg/kg");
    }

    for (final estado in estados) {
      final meses = await leitor.getMonthsByYear(estado, ano);

      for (final mes in meses) {
        final minima = await minimaPorEstadoPorMes(estado, mes, ano);
        buffer.writeln(
          '\nMinima de umidade do ar no estado $estado do mes $mes de $ano:',
        );
        buffer.writeln("${minima.toStringAsFixed(6)} kg/kg");
      }
    }
    final pasta = Directory('relatorios');
    if (!await pasta.exists()) {
      await pasta.create();
    }
    final dataEHora = DateTime.now();
    final data = "${dataEHora.year}-${dataEHora.month}-${dataEHora.day}";
    final hora = "${dataEHora.hour}-${dataEHora.minute}";
    final arquivo = File('relatorios/UMIDADE_${data}_$hora.txt');
    await arquivo.writeAsString(buffer.toString());
    print("Arquivo salvo com sucesso em: ${arquivo.path}");
  }
}
