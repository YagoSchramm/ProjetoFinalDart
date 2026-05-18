# Projeto Final Dart

Aplicacao de linha de comando em Dart para leitura e analise de dados climaticos a partir de arquivos CSV.

O programa le arquivos de sensores dos estados de Santa Catarina (`SC`) e Sao Paulo (`SP`) no ano de `2024`, calcula informacoes climaticas e exibe os resultados no terminal. Tambem permite gerar relatorios em arquivos `.txt`.

## Funcionalidades

- Consulta de temperatura por estado, mes, ano e horario.
- Consulta de umidade do ar por estado, mes e ano.
- Consulta da direcao do vento mais frequente por estado, mes e ano.
- Conversao de temperatura para Celsius, Fahrenheit e Kelvin.
- Conversao da direcao do vento de graus para radianos.
- Geracao de relatorios na pasta `/relatorios`.

## Tecnologias

- Dart
- Pacote `yaansi`, usado para colorir mensagens no terminal
- Leitura de arquivos CSV com encoding `latin1`

## Estrutura

```text
bin/
  main.dart
  temperatura.dart
  umidade.dart
  direcao_vento.dart
  Clima/Sensores/
    SC_2024_1.csv
    SP_2024_1.csv
    ...
  lib/infrastructure/store/
    leitor.dart
    impl/csv_leitor.dart
relatorios/
  arquivos .txt gerados pelo sistema
```

## Como executar

Instale as dependencias:

```bash
dart pub get
```

Execute o programa:

```bash
dart run bin/main.dart
```

Depois escolha uma opcao no menu:

```text
1 - TEMPERATURA
2 - UMIDADE
3 - DIRECAO DO VENTO
```

Ao final da consulta, o sistema pode perguntar se voce deseja gerar um relatorio do conteudo apresentado.

## Relatorios

Quando a geracao de relatorio e escolhida, o sistema cria arquivos `.txt` dentro da pasta `relatorios`.

Exemplos de nomes gerados:

```text
relatorios/TEMPERATURA_2026-5-18_20-12.txt
relatorios/UMIDADE_2026-5-18_20-20.txt
relatorios/VENTO_2026-5-18_20-31.txt
```

## Dados de entrada

Os arquivos CSV devem estar em:

```text
bin/Clima/Sensores/
```

O leitor procura arquivos seguindo o padrao de estado, ano e mes, como:

```text
SC_2024_1.csv
SP_2024_12.csv
```

## Observacoes

- O ano usado nas consultas atuais e `2024`.
- Os estados usados nas consultas atuais sao `SC` e `SP`.
- Os relatorios sao criados automaticamente se a pasta `relatorios` ainda nao existir.
- Os textos do terminal usam cores, mas os relatorios sao salvos como texto comum.
