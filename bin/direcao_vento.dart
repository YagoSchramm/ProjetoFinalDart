import 'dart:math';

import 'package:yaansi/yaansi.dart';

import 'lib/domain/usecase/direcao_vento.dart';

class DirecaoVento {
  final DirecaoVentoUseCase useCase;

  DirecaoVento({required this.useCase});

  Future<void> informacoesAno(String siglaEstado, String ano) async {
    print(
      "\nDirecao do vento com maior frequencia no estado $siglaEstado no ano $ano:",
    );
    final direcao = await useCase.direcaoMaisFrequentePorEstadoPorAno(
      siglaEstado,
      ano,
    );
    _imprimirDirecao(direcao);
  }

  Future<void> informacoesMesAno(String ano, String siglaEstado) async {
    for (var i = 1; i <= 12; i++) {
      final mes = i.toString().padLeft(2, "0");
      print(
        "\nDirecao do vento com maior frequencia no estado $siglaEstado do mes $mes de $ano:",
      );
      final direcao = await useCase.direcaoMaisFrequentePorEstadoPorMes(
        siglaEstado,
        mes,
        ano,
      );
      _imprimirDirecao(direcao);
    }
  }

  Future<void> informacoes() async {
    await informacoesAno("SC", "2024");
    await informacoesAno("SC", "2025");
    await informacoesAno("SC", "2026");
    await informacoesAno("SP", "2024");
    await informacoesAno("SP", "2025");
    await informacoesAno("SP", "2026");
    await informacoesMesAno("2024", "SC");
    await informacoesMesAno("2025", "SC");
    await informacoesMesAno("2026", "SC");
    await informacoesMesAno("2024", "SP");
    await informacoesMesAno("2025", "SP");
    await informacoesMesAno("2026", "SP");
  }

  void _imprimirDirecao(double direcaoGraus) {
    print("${direcaoGraus.toStringAsFixed(1)} graus".yellow);
    double radianos=direcaoGraus * pi / 180;
     print("${radianos.toStringAsFixed(1)} radianos".yellow);
  }
}
