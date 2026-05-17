import 'lib/leitor.dart';
import 'package:yaansi/yaansi.dart';

class Temperatura {
  final Leitor _leitor;
  Temperatura({required Leitor leitor}) : _leitor = leitor;
  Future<double> _getMediaMes(
    String mes,
    String ano,
    String medida,
    String siglaEstado,
  ) async {
    List<String> temperaturas = [];
    final filtrado = await _leitor.filtrarMesEstado(siglaEstado, mes, ano);
    if (filtrado == null) {
      print(filtrado);
      throw Exception("Erro ao filtrar arquivo");
    }
    final conteudo = await filtrado.readAsString();
    List<String> linhas = conteudo.split('\n');
    List<String> colunas = linhas[0].split(',');
    int indiceColuna = colunas.indexOf(medida);
    if (indiceColuna == -1) {
      print('Coluna não encontrada');
      throw Exception("Erro ao encontrar coluna $medida");
    }

    for (int i = 1; i < linhas.length; i++) {
      List<String> valores = linhas[i].split(',');

      if (valores.length > indiceColuna) {
        temperaturas.add(valores[indiceColuna]);
      }
    }
    double somaTemperatura = 0;
    for (var temperatura in temperaturas) {
      somaTemperatura += double.parse(temperatura);
    }
    return somaTemperatura / (linhas.length);
  }

  Future<double> _getMediaAno(
    String ano,
    String medida,
    String siglaEstado,
  ) async {
    List<String> temperaturas = [];
    double somaTemperatura = 0;
    for (var i = 1; i < 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      final mediaMes = await _getMediaMes(mes, ano, medida, siglaEstado);
      somaTemperatura += mediaMes;
    }
    return somaTemperatura / (temperaturas.length);
  }

  Future<void> informacoesAnos(String siglaEstado,String ano) async {
        print(
        "\nMedia de temperatuas do estado $siglaEstado no ano $ano :",
      );
    final mediaC = await _getMediaAno(
      ano,
      "temperatura_celsius",
      siglaEstado,
    );
    print(mediaC.toStringAsFixed(2).red);
    final mediaF = await _getMediaAno(
      ano,
      "temperatura_fahrenheit",
      siglaEstado,
    );
    print(mediaF.toStringAsFixed(2).yellow);
    final mediaK = await _getMediaAno(
      ano,
      "temperatura_kelvin",
      siglaEstado,
    );
    print(mediaK.toStringAsFixed(2).blue);
  }

  Future<void> informacoesPorMes(String ano, String siglaEstado) async {
    for (var i = 1; i <= 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      print(
        "\nMedia de temperatuas do estado $siglaEstado do mês $mes de $ano :",
      );
      final mediaC = await _getMediaMes(
        mes,
        ano,
        "temperatura_celsius",
        siglaEstado,
      );
      print(mediaC.toStringAsFixed(2).red);
      final mediaF = await _getMediaMes(
        mes,
        ano,
        "temperatura_fahrenheit",
        siglaEstado,
      );
      print(mediaF.toStringAsFixed(2).yellow);
      final mediaK = await _getMediaMes(
        mes,
        ano,
        "temperatura_kelvin",
        siglaEstado,
      );
      print(mediaK.toStringAsFixed(2).blue);
    }
  }

  Future<void> informacoes() async {
    await informacoesAnos("2024", "SC");
    await informacoesAnos("2025", "SC");
    await informacoesAnos("2026", "SC");
    await informacoesAnos("2024", "SP");
    await informacoesAnos("2025", "SP");
    await informacoesAnos("2026", "SP");
    await informacoesPorMes("2024", "SC");
    await informacoesPorMes("2025", "SC");
    await informacoesPorMes("2026", "SC");
    await informacoesPorMes("2024", "SP");
    await informacoesPorMes("2025", "SP");
    await informacoesPorMes("2026", "SP");
  }
}
