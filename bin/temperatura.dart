import 'lib/infrastructure/store/leitor.dart';
import 'package:yaansi/yaansi.dart';
import './lib/domain/usecase/temperatura.dart';

class Temperatura {
  final Leitor _leitor;
  final TemperaturaUseCase useCase;

  Temperatura({required Leitor leitor, required this.useCase})
    : _leitor = leitor;

  Future<void> informacoesMediaAno(String siglaEstado, String ano) async {
    print("\nMedia de temperatuas do estado $siglaEstado no ano $ano :");
    final mediaC = await useCase.mediaPorEstadoPorAno(siglaEstado, ano);
    _imprimirTemperaturas(mediaC);
  }

  Future<void> informacoesMediaMesAno(String ano, String siglaEstado) async {
    for (var i = 1; i <= 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      print(
        "\nMedia de temperatuas do estado $siglaEstado do mes $mes de $ano :",
      );
      final mediaC = await useCase.mediaPorEstadoPorMes(siglaEstado, mes, ano);
      _imprimirTemperaturas(mediaC);
    }
  }

  Future<void> informacoesMinimaAno(String siglaEstado, String ano) async {
    print("\nMinima de temperatuas do estado $siglaEstado no ano $ano :");
    final minimaC = await useCase.minimaPorEstadoPorAno(siglaEstado, ano);
    _imprimirTemperaturas(minimaC);
  }

  Future<void> informacoesMinimaMesAno(String ano, String siglaEstado) async {
    for (var i = 1; i <= 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      print(
        "\nMinima de temperatuas do estado $siglaEstado do mes $mes de $ano :",
      );
      final minimaC = await useCase.minimaPorEstadoPorMes(siglaEstado, mes, ano);
      _imprimirTemperaturas(minimaC);
    }
  }

  Future<void> informacoesMaximaAno(String siglaEstado, String ano) async {
    print("\nMaxima de temperatuas do estado $siglaEstado no ano $ano :");
    final maximaC = await useCase.maximaPorEstadoPorAno(siglaEstado, ano);
    _imprimirTemperaturas(maximaC);
  }

  Future<void> informacoesMaximaMesAno(String ano, String siglaEstado) async {
    for (var i = 1; i <= 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      print(
        "\nMaxima de temperatuas do estado $siglaEstado do mes $mes de $ano :",
      );
      final maximaC = await useCase.maximaPorEstadoPorMes(siglaEstado, mes, ano);
      _imprimirTemperaturas(maximaC);
    }
  }

  Future<void> informacoesHoras(String siglaEstado) async {
    print("\nMedia de temperatuas do estado $siglaEstado por hora:");

    for (var i = 0; i < 24; i += 3) {
      final hora = "${i.toString().padLeft(2, "0")}:00:00";
      print("\nHorario $hora:");

      final mediaC = await useCase.mediaPorHorarioPorEstado(siglaEstado, hora);
      _imprimirTemperaturas(mediaC);
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
    await informacoesHoras("SC");
    await informacoesHoras("SP");
  }

  void _imprimirTemperaturas(double temperaturaCelsius) {
    print(temperaturaCelsius.toStringAsFixed(2).red);
    final temperaturaFahrenheit = temperaturaCelsius * 9 / 5 + 32;
    print(temperaturaFahrenheit.toStringAsFixed(2).yellow);
    final temperaturaKelvin = temperaturaCelsius + 273.15;
    print(temperaturaKelvin.toStringAsFixed(2).blue);
  }
}
