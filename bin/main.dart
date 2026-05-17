import 'dart:io';

import 'lib/leitor.dart';
import 'temperatura.dart';

void main(List<String> arguments) async {
  Leitor leitor = Leitor("./bin/Clima/Sensores/");
  Temperatura temp = Temperatura(leitor: leitor);
  print(" 1 – TEMPERATURA");
  print(" 2 – UMIDADE");
  print(" 3 – DIREÇÃO DO VENTO");
  print("DIGITE O NÚMERO DA OPÇÃO DESEJADA:");
  int? opcao = int.tryParse(stdin.readLineSync()!);
  switch (opcao) {
    case 1:
      await temp.informacoes();
      break;
    case 2:
      break;
    case 3:
      break;
  }
}
