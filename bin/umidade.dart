import 'package:yaansi/yaansi.dart';

import 'lib/infrastructure/store/leitor.dart';

class UmidadeAr {
  static const String colunaUmidade = 'umidade_ar_%';

  final Leitor leitor;

  UmidadeAr({required this.leitor});

  Future<double> mediaPorEstadoPorAno(String siglaEstado, String ano) async {
    final arquivos = await leitor.getByYear(siglaEstado, ano);
    final valores = <double>[];

    for (final arquivo in arquivos) {
      if (arquivo == null) continue;

      final linhas = await arquivo.readAsLines();
      final colunas = linhas.first.trim().split(',');
      final indiceUmidade = colunas.indexOf(colunaUmidade);

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

    return valores.reduce((soma, valor) => soma + valor) / valores.length;
  }

  Future<double> mediaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final arquivo = await leitor.getByMonth(siglaEstado, mes, ano);
    if (arquivo == null) throw Exception('Erro ao filtrar arquivo');

    final linhas = await arquivo.readAsLines();
    final colunas = linhas.first.trim().split(',');
    final indiceUmidade = colunas.indexOf(colunaUmidade);
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

      final linhas = await arquivo.readAsLines();
      final colunas = linhas.first.trim().split(',');
      final indiceUmidade = colunas.indexOf(colunaUmidade);

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

    final linhas = await arquivo.readAsLines();
    final colunas = linhas.first.trim().split(',');
    final indiceUmidade = colunas.indexOf(colunaUmidade);
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

    return valores.reduce((maior, valor) => valor > maior ? valor : maior);
  }

  Future<double> minimaPorEstadoPorAno(String siglaEstado, String ano) async {
    final arquivos = await leitor.getByYear(siglaEstado, ano);
    final valores = <double>[];

    for (final arquivo in arquivos) {
      if (arquivo == null) continue;

      final linhas = await arquivo.readAsLines();
      final colunas = linhas.first.trim().split(',');
      final indiceUmidade = colunas.indexOf(colunaUmidade);

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

    return valores.reduce((menor, valor) => valor < menor ? valor : menor);
  }

  Future<double> minimaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final arquivo = await leitor.getByMonth(siglaEstado, mes, ano);
    if (arquivo == null) throw Exception('Erro ao filtrar arquivo');

    final linhas = await arquivo.readAsLines();
    final colunas = linhas.first.trim().split(',');
    final indiceUmidade = colunas.indexOf(colunaUmidade);
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

    return valores.reduce((menor, valor) => valor < menor ? valor : menor);
  }

  Future<void> informacoesMediaAno(String siglaEstado, String ano) async {
    print("\nMedia de umidade do ar no estado $siglaEstado no ano $ano:");
    final media = await mediaPorEstadoPorAno(siglaEstado, ano);
    print("${media.toStringAsFixed(2)}%".green);
  }

  Future<void> informacoesMediaMesAno(String ano, String siglaEstado) async {
    for (var i = 1; i <= 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      print(
        "\nMedia de umidade do ar no estado $siglaEstado do mes $mes de $ano:",
      );
      final media = await mediaPorEstadoPorMes(siglaEstado, mes, ano);
      print("${media.toStringAsFixed(2)}%".green);
    }
  }

  Future<void> informacoesMinimaAno(String siglaEstado, String ano) async {
    print("\nMinima de umidade do ar no estado $siglaEstado no ano $ano:");
    final minima = await minimaPorEstadoPorAno(siglaEstado, ano);
    print("${minima.toStringAsFixed(2)}%".blue);
  }

  Future<void> informacoesMinimaMesAno(String ano, String siglaEstado) async {
    for (var i = 1; i <= 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      print(
        "\nMinima de umidade do ar no estado $siglaEstado do mes $mes de $ano:",
      );
      final minima = await minimaPorEstadoPorMes(siglaEstado, mes, ano);
      print("${minima.toStringAsFixed(2)}%".blue);
    }
  }

  Future<void> informacoesMaximaAno(String siglaEstado, String ano) async {
    print("\nMaxima de umidade do ar no estado $siglaEstado no ano $ano:");
    final maxima = await maximaPorEstadoPorAno(siglaEstado, ano);
    print("${maxima.toStringAsFixed(2)}%".red);
  }

  Future<void> informacoesMaximaMesAno(String ano, String siglaEstado) async {
    for (var i = 1; i <= 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      print(
        "\nMaxima de umidade do ar no estado $siglaEstado do mes $mes de $ano:",
      );
      final maxima = await maximaPorEstadoPorMes(siglaEstado, mes, ano);
      print("${maxima.toStringAsFixed(2)}%".red);
    }
  }

  Future<void> informacoes() async {
    await informacoesMediaAno("SC", "2024");
    await informacoesMediaAno("SC", "2025");
    await informacoesMediaAno("SC", "2026");
    await informacoesMediaAno("SP", "2024");
    await informacoesMediaAno("SP", "2025");
    await informacoesMediaAno("SP", "2026");
    await informacoesMediaMesAno("2024", "SC");
    await informacoesMediaMesAno("2025", "SC");
    await informacoesMediaMesAno("2026", "SC");
    await informacoesMediaMesAno("2024", "SP");
    await informacoesMediaMesAno("2025", "SP");
    await informacoesMediaMesAno("2026", "SP");
    await informacoesMaximaAno("SC", "2024");
    await informacoesMaximaAno("SC", "2025");
    await informacoesMaximaAno("SC", "2026");
    await informacoesMaximaAno("SP", "2024");
    await informacoesMaximaAno("SP", "2025");
    await informacoesMaximaAno("SP", "2026");
    await informacoesMaximaMesAno("2024", "SC");
    await informacoesMaximaMesAno("2025", "SC");
    await informacoesMaximaMesAno("2026", "SC");
    await informacoesMaximaMesAno("2024", "SP");
    await informacoesMaximaMesAno("2025", "SP");
    await informacoesMaximaMesAno("2026", "SP");
    await informacoesMinimaAno("SC", "2024");
    await informacoesMinimaAno("SC", "2025");
    await informacoesMinimaAno("SC", "2026");
    await informacoesMinimaAno("SP", "2024");
    await informacoesMinimaAno("SP", "2025");
    await informacoesMinimaAno("SP", "2026");
    await informacoesMinimaMesAno("2024", "SC");
    await informacoesMinimaMesAno("2025", "SC");
    await informacoesMinimaMesAno("2026", "SC");
    await informacoesMinimaMesAno("2024", "SP");
    await informacoesMinimaMesAno("2025", "SP");
    await informacoesMinimaMesAno("2026", "SP");
  }
}
