abstract interface class UmidadeArUseCase {
  Future<double> mediaPorEstadoPorAno(String siglaEstado, String ano);

  Future<double> mediaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  );

  Future<double> maximaPorEstadoPorAno(String siglaEstado, String ano);

  Future<double> maximaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  );

  Future<double> minimaPorEstadoPorAno(String siglaEstado, String ano);

  Future<double> minimaPorEstadoPorMes(
    String siglaEstado,
    String mes,
    String ano,
  );
}
