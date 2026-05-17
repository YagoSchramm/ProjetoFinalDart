import 'dart:io';

abstract class Leitor {
  Future<List<File>> getByState(String sigla);
  Future<File?> getByMonth(String siglaEstado, String mes, String ano);
  Future<List<File?>> getByYear(String siglaEstado,String mes,String ano);
  Future<List<File?>> getByHour(String siglaEstado,String hora);
}
