import 'dart:convert';

import 'package:yaansi/yaansi.dart';

import 'lib/infrastructure/store/leitor.dart';

class Temperatura {
  static const String colunaTemperatura = 'Temperatura';
  static const String colunaHora = 'Hora';

  final Leitor leitor;

  Temperatura({required this.leitor});

  Future<double> mediaPorEstadoPorAno(String siglaEstado, String ano) async {
    final arquivos = await leitor.getByYear(siglaEstado, ano);

    final valores = <double>[];
    for (final arquivo in arquivos) {
      if (arquivo == null) continue;

      final linhas = await arquivo.readAsLines(encoding: latin1);
      final colunas = linhas.first.trim().split(',');
      String? coluna;
      colunas.forEach((colunas) {
        if (coluna == null && colunas.startsWith(colunaTemperatura)) {
          coluna = colunas;
        }
      });

      if (coluna == null) {
        throw Exception('Erro ao encontrar coluna $colunaTemperatura');
      }

      final indiceTemperatura = colunas.indexOf(coluna!);
      for (var i = 1; i < linhas.length; i++) {
        final linha = linhas[i].trim();
        if (linha.isEmpty) continue;

        final campos = linha.split(',');
        if (campos.length > indiceTemperatura) {
          valores.add(double.parse(campos[indiceTemperatura]));
        }
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de temperatura encontrado');
    }

    return valores.reduce((soma, valor) => soma + valor) / valores.length;
  }

  Future<double> mediaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final arquivo = await leitor.getByMonth(siglaEstado, mes);
    if (arquivo == null) throw Exception('Erro ao filtrar arquivo');

    final linhas = await arquivo.readAsLines(encoding: latin1);
    final colunas = linhas.first.trim().split(',');
    String? coluna;
    colunas.forEach((colunas) {
      if (coluna == null && colunas.startsWith(colunaTemperatura)) {
        coluna = colunas;
      }
    });

    if (coluna == null) {
      throw Exception('Erro ao encontrar coluna $colunaTemperatura');
    }

    final indiceTemperatura = colunas.indexOf(coluna!);
    final valores = <double>[];

    for (var i = 1; i < linhas.length; i++) {
      final linha = linhas[i].trim();
      if (linha.isEmpty) continue;

      final campos = linha.split(',');
      if (campos.length > indiceTemperatura) {
        valores.add(double.parse(campos[indiceTemperatura]));
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de temperatura encontrado');
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
        if (coluna == null && colunas.startsWith(colunaTemperatura)) {
          coluna = colunas;
        }
      });

      if (coluna == null) {
        throw Exception('Erro ao encontrar coluna $colunaTemperatura');
      }

      final indiceTemperatura = colunas.indexOf(coluna!);

      for (var i = 1; i < linhas.length; i++) {
        final linha = linhas[i].trim();
        if (linha.isEmpty) continue;

        final campos = linha.split(',');
        if (campos.length > indiceTemperatura) {
          valores.add(double.parse(campos[indiceTemperatura]));
        }
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de temperatura encontrado');
    }

    return valores.reduce((maior, valor) => valor > maior ? valor : maior);
  }

  Future<double> maximaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final arquivo = await leitor.getByMonth(siglaEstado, mes);
    if (arquivo == null) throw Exception('Erro ao filtrar arquivo');

    final linhas = await arquivo.readAsLines(encoding: latin1);
    final colunas = linhas.first.trim().split(',');
    String? coluna;
    colunas.forEach((colunas) {
      if (coluna == null && colunas.startsWith(colunaTemperatura)) {
        coluna = colunas;
      }
    });

    if (coluna == null) {
      throw Exception('Erro ao encontrar coluna $colunaTemperatura');
    }

    final indiceTemperatura = colunas.indexOf(coluna!);
    final valores = <double>[];

    for (var i = 1; i < linhas.length; i++) {
      final linha = linhas[i].trim();
      if (linha.isEmpty) continue;

      final campos = linha.split(',');
      if (campos.length > indiceTemperatura) {
        valores.add(double.parse(campos[indiceTemperatura]));
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de temperatura encontrado');
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
        if (coluna == null && colunas.startsWith(colunaTemperatura)) {
          coluna = colunas;
        }
      });

      if (coluna == null) {
        throw Exception('Erro ao encontrar coluna $colunaTemperatura');
      }

      final indiceTemperatura = colunas.indexOf(coluna!);
      for (var i = 1; i < linhas.length; i++) {
        final linha = linhas[i].trim();
        if (linha.isEmpty) continue;

        final campos = linha.split(',');
        if (campos.length > indiceTemperatura) {
          valores.add(double.parse(campos[indiceTemperatura]));
        }
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de temperatura encontrado');
    }

    return valores.reduce((menor, valor) => valor < menor ? valor : menor);
  }

  Future<double> minimaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final arquivo = await leitor.getByMonth(siglaEstado, mes);
    if (arquivo == null) throw Exception('Erro ao filtrar arquivo');

    final linhas = await arquivo.readAsLines(encoding: latin1);
    final colunas = linhas.first.trim().split(',');
    String? coluna;
    colunas.forEach((colunas) {
      if (coluna == null && colunas.startsWith(colunaTemperatura)) {
        coluna = colunas;
      }
    });

    if (coluna == null) {
      throw Exception('Erro ao encontrar coluna $colunaTemperatura');
    }

    final indiceTemperatura = colunas.indexOf(coluna!);
    final valores = <double>[];

    for (var i = 1; i < linhas.length; i++) {
      final linha = linhas[i].trim();
      if (linha.isEmpty) continue;

      final campos = linha.split(',');
      if (campos.length > indiceTemperatura) {
        valores.add(double.parse(campos[indiceTemperatura]));
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de temperatura encontrado');
    }

    return valores.reduce((menor, valor) => valor < menor ? valor : menor);
  }

  Future<double> mediaPorHorarioPorEstado(
    String siglaEstado,
    String hora,
  ) async {
    final arquivos = await leitor.getByHour(siglaEstado, hora);
    final valores = <double>[];

    for (final arquivo in arquivos) {
      if (arquivo == null) continue;

      final linhas = await arquivo.readAsLines(encoding: latin1);
      final colunas = linhas.first.trim().split(',');
      String? coluna;
      colunas.forEach((colunas) {
        if (coluna == null && colunas.startsWith(colunaTemperatura)) {
          coluna = colunas;
        }
      });

      if (coluna == null) {
        throw Exception('Erro ao encontrar coluna $colunaTemperatura');
      }

      final indiceTemperatura = colunas.indexOf(coluna!);
      final indiceHora = colunas.indexOf(colunaHora);

      if (indiceHora == -1) {
        throw Exception('Erro ao encontrar coluna $colunaHora');
      }

      for (var i = 1; i < linhas.length; i++) {
        final linha = linhas[i].trim();
        if (linha.isEmpty) continue;

        final campos = linha.split(',');
        if (campos[indiceHora] == hora) {
          valores.add(double.parse(campos[indiceTemperatura]));
        }
      }
    }

    if (valores.isEmpty) {
      throw Exception('Nenhum valor de temperatura encontrado');
    }

    return valores.reduce((soma, valor) => soma + valor) / valores.length;
  }

  Future<void> informacoes() async {
    final estados = ['SC', 'SP'];
    const ano = '2024';

    for (final estado in estados) {
      final media = await mediaPorEstadoPorAno(estado, ano);
      print('\nMedia de temperatura do estado $estado no ano $ano:');
      print(media.toStringAsFixed(2).red);
      print((media * 9 / 5 + 32).toStringAsFixed(2).yellow);
      print((media + 273.15).toStringAsFixed(2).blue);
    }

    for (final estado in estados) {
      for (var i = 1; i <= 12; i++) {
        final mes = i.toString();
        final media = await mediaPorEstadoPorMes(estado, mes, ano);
        print(
          '\nMedia de temperatura do estado $estado no mes $mes de $ano:',
        );
        print(media.toStringAsFixed(2).red);
        print((media * 9 / 5 + 32).toStringAsFixed(2).yellow);
        print((media + 273.15).toStringAsFixed(2).blue);
      }
    }

    for (final estado in estados) {
      final maxima = await maximaPorEstadoPorAno(estado, ano);
      print('\nMaxima de temperatura do estado $estado no ano $ano:');
      print(maxima.toStringAsFixed(2).red);
      print((maxima * 9 / 5 + 32).toStringAsFixed(2).yellow);
      print((maxima + 273.15).toStringAsFixed(2).blue);
    }

    for (final estado in estados) {
      for (var i = 1; i <= 12; i++) {
        final mes = i.toString();
        final maxima = await maximaPorEstadoPorMes(estado, mes, ano);
        print(
          '\nMaxima de temperatura do estado $estado no mes $mes de $ano:',
        );
        print(maxima.toStringAsFixed(2).red);
        print((maxima * 9 / 5 + 32).toStringAsFixed(2).yellow);
        print((maxima + 273.15).toStringAsFixed(2).blue);
      }
    }

    for (final estado in estados) {
      final minima = await minimaPorEstadoPorAno(estado, ano);
      print('\nMinima de temperatura do estado $estado no ano $ano:');
      print(minima.toStringAsFixed(2).red);
      print((minima * 9 / 5 + 32).toStringAsFixed(2).yellow);
      print((minima + 273.15).toStringAsFixed(2).blue);
    }

    for (final estado in estados) {
      for (var i = 1; i <= 12; i++) {
        final mes = i.toString();
        final minima = await minimaPorEstadoPorMes(estado, mes, ano);
        print(
          '\nMinima de temperatura do estado $estado no mes $mes de $ano:',
        );
        print(minima.toStringAsFixed(2).red);
        print((minima * 9 / 5 + 32).toStringAsFixed(2).yellow);
        print((minima + 273.15).toStringAsFixed(2).blue);
      }
    }

    for (final estado in estados) {
      print('\nMedia de temperatura do estado $estado por hora:');
      for (var i = 1; i <= 24; i++) {
        final hora = i.toString();
        final media = await mediaPorHorarioPorEstado(estado, hora);
        print('\nHorario ${hora.padLeft(2,"0")}:00:00 :');
        print(media.toStringAsFixed(2).red);
        print((media * 9 / 5 + 32).toStringAsFixed(2).yellow);
        print((media + 273.15).toStringAsFixed(2).blue);
      }
    }
  }
}
