import 'package:yaansi/yaansi.dart';

import 'lib/domain/usecase/umidade.dart';
import 'lib/infrastructure/store/leitor.dart';

class UmidadeAr {
  final UmidadeArUseCase useCase;

  UmidadeAr({required this.useCase});

  Future<void> informacoesMediaAno(String siglaEstado, String ano) async {
    print("\nMedia de umidade do ar no estado $siglaEstado no ano $ano:");
    final media = await useCase.mediaPorEstadoPorAno(siglaEstado, ano);
    _imprimirUmidadeAr(media);
  }

  Future<void> informacoesMediaMesAno(String ano, String siglaEstado) async {
    for (var i = 1; i <= 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      print(
        "\nMedia de umidade do ar no estado $siglaEstado do mes $mes de $ano:",
      );
      final media = await useCase.mediaPorEstadoPorMes(siglaEstado, mes, ano);
      _imprimirUmidadeAr(media);
    }
  }

  Future<void> informacoesMinimaAno(String siglaEstado, String ano) async {
    print("\nMinima de umidade do ar no estado $siglaEstado no ano $ano:");
    final minima = await useCase.minimaPorEstadoPorAno(siglaEstado, ano);
    _imprimirUmidadeAr(minima);
  }

  Future<void> informacoesMinimaMesAno(String ano, String siglaEstado) async {
    for (var i = 1; i <= 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      print(
        "\nMinima de umidade do ar no estado $siglaEstado do mes $mes de $ano:",
      );
      final minima = await useCase.minimaPorEstadoPorMes(siglaEstado, mes, ano);
      _imprimirUmidadeAr(minima);
    }
  }

  Future<void> informacoesMaximaAno(String siglaEstado, String ano) async {
    print("\nMaxima de umidade do ar no estado $siglaEstado no ano $ano:");
    final maxima = await useCase.maximaPorEstadoPorAno(siglaEstado, ano);
    _imprimirUmidadeAr(maxima);
  }

  Future<void> informacoesMaximaMesAno(String ano, String siglaEstado) async {
    for (var i = 1; i <= 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      print(
        "\nMaxima de umidade do ar no estado $siglaEstado do mes $mes de $ano:",
      );
      final maxima = await useCase.maximaPorEstadoPorMes(siglaEstado, mes, ano);
      _imprimirUmidadeAr(maxima);
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

  void _imprimirUmidadeAr(double umidadePercentual) {
    print("${umidadePercentual.toStringAsFixed(2)}%".blue);
  }
}
