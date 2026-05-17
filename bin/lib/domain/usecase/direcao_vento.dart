abstract interface class DirecaoVentoUseCase {
  Future<double> direcaoMaisFrequentePorEstadoPorAno(
    String siglaEstado,
    String ano,
  );

  Future<double> direcaoMaisFrequentePorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  );
}
