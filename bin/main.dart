import 'dart:io';

import 'lib/infrastructure/store/leitor.dart';
import 'lib/infrastructure/store/impl/csv_leitor.dart';
import 'lib/domain/usecase/impl/temperatura_usecase.dart';
import 'lib/domain/usecase/impl/umidade_usecase.dart';
import 'lib/domain/usecase/impl/direcao_vento_usecase.dart';
import 'temperatura.dart';
import 'umidade.dart';
import 'direcao_vento.dart';


void main(List<String> arguments) async {
  Leitor leitor = LeitorCSV("./bin/Clima/Sensores/");
  final temperaturaUseCase = TemperaturaUseCaseImpl(leitor: leitor);
  final umidadeArUseCase = UmidadeArUseCaseImpl(leitor: leitor);
  final direcaoVentoUseCase = DirecaoVentoUsecaseImpl(leitor: leitor);
  Temperatura temp = Temperatura(useCase: temperaturaUseCase);
  UmidadeAr umidadeAr = UmidadeAr(useCase: umidadeArUseCase);
  DirecaoVento direcaoVento = DirecaoVento(useCase: direcaoVentoUseCase);
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
      await umidadeAr.informacoes();
      break;
    case 3:
      await direcaoVento.informacoes();
      break;
  }
}
