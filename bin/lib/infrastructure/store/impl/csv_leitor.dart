import 'dart:io';

import '../leitor.dart';

class LeitorCSV implements Leitor {
  String path;

  LeitorCSV(this.path);

  @override
  Future<List<File>> getByState(String sigla) async {
    List<File> arquivosFiltrados = <File>[];
    final directory = Directory(path);
    final arquivos = directory.listSync();

    for (var arquivo in arquivos) {
      if (arquivo is File) {
        // Pega o nome do arquivo sem a extensao.
        String nomeArquivo = arquivo.uri.pathSegments.last;
        String semCSV = nomeArquivo.replaceAll('.csv', '');
        List<String> partes = semCSV.split('_');
        String siglaEstado = partes[0];

        if (siglaEstado == sigla) {
          arquivosFiltrados.add(arquivo);
        }
      }
    }
    if(arquivosFiltrados.length==0){
      throw Exception("O estado não está no banco de dados");
    }
    return arquivosFiltrados;
  }

  @override
  Future<File?> getByMonth(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final arquivos = await getByState(siglaEstado);
    for (var arquivo in arquivos) {
      String nomeArquivo = arquivo.uri.pathSegments.last;
      String semCSV = nomeArquivo.replaceAll('.csv', '');
      List<String> partes = semCSV.split('_');

      if (partes[1] == ano && partes[2] == mes) {
        return arquivo;
      }
    }

    return null;
  }

  @override
  Future<List<File?>> getByYear(
    String siglaEstado,
    String ano,
  ) async {
    final arquivos = await getByState(siglaEstado);
    List<File?> filtrados = <File?>[];
    for (var arquivo in arquivos) {
      String nomeArquivo = arquivo.uri.pathSegments.last;
      String semCSV = nomeArquivo.replaceAll('.csv', '');
      List<String> partes = semCSV.split('_');

      if (partes[1] == ano) {
        filtrados.add(arquivo);
      }
    }

    return filtrados;
  }
  
  @override
  Future<List<File?>> getByHour(String siglaEstado, String hora) async {
    final arquivos=await getByState(siglaEstado);
    List<File?> filtrados = <File?>[];

    for (var arquivo in arquivos) {
        filtrados.add(arquivo);
    }
    return filtrados;
  }
  
}
