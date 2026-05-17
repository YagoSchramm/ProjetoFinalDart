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
     await temp.informacoesPorAno("2024", "SC");
     await temp.informacoesPorAno("2025", "SC");
     await temp.informacoesPorAno("2026", "SC");
     await temp.informacoesPorAno("2024", "SP");
     await temp.informacoesPorAno("2025", "SP");
     await temp.informacoesPorAno("2026", "SP");
      break;
    case 2:
      break;
    case 3:
      break;
  }
}
