import 'dart:io';

import './lib/infrastructure/store/impl/csv_leitor.dart';
import './lib/infrastructure/store/leitor.dart';
import './direcao_vento.dart';
import './temperatura.dart';
import './umidade.dart';

void main(List<String> arguments) async {
  Leitor leitor = LeitorCSV("./bin/Clima/Sensores/");
  Temperatura temp = Temperatura(leitor: leitor);
  UmidadeAr umidadeAr = UmidadeAr(leitor: leitor);
  DirecaoVento direcaoVento = DirecaoVento(leitor: leitor);

  print(" 1 - TEMPERATURA");
  print(" 2 - UMIDADE");
  print(" 3 - DIRECAO DO VENTO");
  print("DIGITE O NUMERO DA OPCAO DESEJADA:");

  int? opcao = int.tryParse(stdin.readLineSync()!);
  switch (opcao) {
    case 1:
      await temp.informacoes();
      break;
    case 2:
      await umidadeAr.informacoes();
      break;
    case 3:
      await direcaoVento.informacoes();
      break;
  }
}
