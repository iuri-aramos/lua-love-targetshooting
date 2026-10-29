# Meu Jogo

Base de jogo para LÖVE 11.5, com estados, entidades e `middleclass`.

## Executar e reiniciar ao salvar

Instale o [LÖVE 11.5](https://love2d.org/) e o Python 3. Execute na pasta `meu-jogo/`:

```sh
python3 dev.py
```

O lançador monitora `main.lua`, `conf.lua`, `lib/`, `src/` e `assets/`. Ao detectar uma
mudança, encerra o jogo e abre uma nova janela. Pressione `Ctrl+C` no terminal para parar.

Para escolher outro caminho do executável LÖVE, defina `LOVE_BIN`:

```sh
LOVE_BIN=/caminho/para/love python3 dev.py
```

Para iniciar sem monitoramento, execute `love .`.

## Controles

- `WASD` ou setas: mover
- `Espaço`: atirar
- `Enter`: iniciar ou reiniciar
- `Esc`: sair

## Estrutura

```text
meu-jogo/
├── main.lua
├── conf.lua
├── dev.py
├── lib/
│   ├── middleclass.lua
│   └── LICENSES.md
├── src/
│   ├── entities/
│   ├── systems/
│   └── states/
└── assets/
    ├── images/
    ├── audio/
    └── fonts/
```
