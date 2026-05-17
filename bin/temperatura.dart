import 'lib/infrastructure/store/leitor.dart';
import 'package:yaansi/yaansi.dart';
import './lib/domain/usecase/temperatura.dart';

class Temperatura {
  final Leitor _leitor;
  final TemperaturaUseCase useCase;

  Temperatura({required Leitor leitor, required this.useCase})
    : _leitor = leitor;

  Future<void> informacoesAnos(String siglaEstado, String ano) async {
    print("\nMedia de temperatuas do estado $siglaEstado no ano $ano :");
    final mediaC = await useCase.mediaPorEstadoPorAno(siglaEstado, ano);
    print(mediaC.toStringAsFixed(2).red);
    final mediaF = mediaC * 9 / 5 + 32;
    print(mediaF.toStringAsFixed(2).yellow);
    final mediaK = mediaC + 273.15;
    print(mediaK.toStringAsFixed(2).blue);
  }

  Future<void> informacoesPorMes(String ano, String siglaEstado) async {
    for (var i = 1; i <= 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      print(
        "\nMedia de temperatuas do estado $siglaEstado do mês $mes de $ano :",
      );
      final mediaC = await useCase.minimaPorEstadoPorMes(mes, ano, siglaEstado);
      print(mediaC.toStringAsFixed(2).red);
      final mediaF = mediaC * 9 / 5 + 32;
      print(mediaF.toStringAsFixed(2).yellow);
      final mediaK = mediaC + 273.15;
      print(mediaK.toStringAsFixed(2).blue);
    }
  }
  Future<void> informacoesPor(Str)
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
