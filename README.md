# Solução de navegação interna para pessoas com deficiência visual

Este projeto apresenta um protótipo de aplicativo desenvolvido para auxiliar pessoas com deficiência visual a navegar em ambientes fechados.
O aplicativo foi construído com flutter e é um sistema distribuído, que através do uso de Beacons pode mapear um ambiente interno e permitir que as informações de localização e orientação sejam fornecidas ao usuário.

O destaque deste projeto é a abordagem de grafos, que pode ser apresentada como uma alternativa à triangulação, trilateração e outras abordagens conhecidas.

Nesta versão, os beacons utilizados ainda são fixados no backend, mas versões futuras podem incluir uma interface para adicionar/remover esses dispositivos, facilitando ainda mais a sua utilização

O funcionamento da aplicação pode ser observado na Figura abaixo:
![a03](https://github.com/joaovitorgit/TFG-FINAL/assets/110136151/c65a9ffe-680c-4b49-8950-36cd0b69ef4d)

Os plugins utilizados nesse projeto foram:
- flutter_beacon
- flutter-tts
- directed_graph
