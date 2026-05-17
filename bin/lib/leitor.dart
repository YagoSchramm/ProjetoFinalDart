import 'dart:io';

class Leitor {
  // Caminho dos arquivos de sensores (Mudar caso precise)
  String path = "/Clima/Sensores";
  Leitor(this.path);
  Future<List<File>> filtrarPorEstado(String sigla) async {
    List<File> arquivosFiltrados = <File>[];
    final directory = Directory(path);
    final arquivos = directory.listSync();
    for (var arquivo in arquivos) {
      if (arquivo is File) {
        // Pega o nome do arquivo sem as extensões
        String nomeArquivo = arquivo.path.split('/').last;
        String semCSV = nomeArquivo.replaceAll('.csv', '');
        List<String> partes = semCSV.split('_');
        String siglaEstado = partes[0];

        if (siglaEstado == sigla) {
          arquivosFiltrados.add(arquivo);
        }
      }
    }
    return arquivosFiltrados;
  }

  Future<File?> filtrarMesEstado(
    String siglaEstado,
    String mes,
    String ano,
  ) async {
    final arquivos = await filtrarPorEstado(siglaEstado);
    File? filtrado;
    for (var arquivo in arquivos) {
      String nomeArquivo = arquivo.path.split('/').last;
      String semCSV = nomeArquivo.replaceAll('.csv', '');
      List<String> partes = semCSV.split('_');
      if (partes[1] == ano && partes[2] == mes) {
        filtrado = arquivo;
      }
    }
    return filtrado;
  }
}
