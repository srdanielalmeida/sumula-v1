# Protótipo SÚMULA.AI (Flutter + Firebase)

Este repositório contém um protótipo mobile-first para validar o MVP do SÚMULA.AI.

## Fluxos implementados
- Autenticação com e-mail/senha (login, cadastro, recuperação).
- Firestore com coleções `users`, `items_conhecimento` e `conexoes`.
- Dashboard com listagem de itens do usuário.
- Ingestão com simulação do Crisol usando MOCK data.
- Tela de detalhes com edição de título, tags, relacionados e geração de post mock.

## Adaptação para programação no Antigravity
Para facilitar implementação híbrida (workflows visuais + código), foi criada a camada
`lib/antigravity/antigravity_schema.dart` com:
- Constantes de coleções e campos usados no Firestore.
- Builders de payload para ingestão (`cru`) e resultado mock do Crisol (`destilado`).

Com isso, o app e os fluxos no Antigravity conseguem compartilhar o mesmo contrato de dados,
evitar strings hardcoded duplicadas e reduzir erros de mapeamento.

## Como rodar
1. Crie um projeto Firebase e conecte no Flutter.
2. Adicione `google-services.json` (Android) e/ou `GoogleService-Info.plist` (iOS).
3. Rode:
   ```bash
   flutter pub get
   flutter run
   ```

## Observações
- Este protótipo **não** chama API de IA real; usa dados fictícios para validar UX e dados no Firestore.
- Recomendado configurar regras do Firestore para restringir documentos por usuário autenticado.
