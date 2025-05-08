# Bebaralho Cearense

Um aplicativo Flutter modular feito para hospedar um jogo de cartas, este que também foi idealizado por mim no ano de 2021. Fácil de usar, com visual limpo, arquitetura escalável e código organizado por features.

---

---

## 🚀 Tecnologias Utilizadas

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- Modularização baseada em features
- Navegação centralizada por rotas nomeadas
- Customização de tema com `ThemeData`

---

## 📁 Estrutura do Projeto

```txt
lib/
│
├── core/ # Módulos centrais reutilizáveis
│ ├── routes/ # Rotas e gerenciamento de navegação
│ │ └── app_routes.dart
│ ├── theme/ # Tema e estilos globais
│ │ └── app_theme.dart
│ └── utils/ # Utilitários e helpers genéricos
│ └── helpers.dart
│
├── features/ # Funcionalidades principais divididas por domínio
│ └── sorteador/ # Módulo de sorteio
│ ├── controller/ # Lógica e controle da feature
│ │ └── sorteador_controller.dart
│ ├── models/ # Modelos de dados (opcional)
│ │ └── sorteador_model.dart
│ └── presentation/ # Interface e componentes visuais
│ ├── pages/ # Telas principais da feature
│ │ ├── about_page.dart
│ │ ├── rules_page.dart
│ │ ├── sorteador_page.dart
│ │ └── tela_inicial_page.dart
│ └── widgets/ # Widgets reutilizáveis
│ └── carta_widget.dart
│
└── main.dart # Ponto de entrada do aplicativo
```

um aplicativo inicialmente simples que deve servir apenas com objeto de estudo em flutter
