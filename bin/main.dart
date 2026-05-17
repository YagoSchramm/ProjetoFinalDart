import 'dart:io';

import 'lib/infrastructure/store/leitor.dart';
import 'lib/infrastructure/store/impl/csv_leitor.dart';
import 'lib/domain/usecase/impl/temperatura_usecase.dart';
import 'temperatura.dart';

void main(List<String> arguments) async {
  Leitor leitor = LeitorCSV("./bin/Clima/Sensores/");
  final temperaturaUseCase = TemperaturaUseCaseImpl(leitor: leitor);
  Temperatura temp = Temperatura(leitor: leitor, useCase: temperaturaUseCase);
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
