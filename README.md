# 🎯 Target Shooting

Jogo de tiro ao alvo 2D dinâmico e responsivo desenvolvido com **[LÖVE (Love2D)](https://love2d.org/) 11.5** e **Lua**. Teste seus reflexos e precisão mirando e acertando o maior número de alvos possíveis antes que o tempo esgote!

---

## ✨ Recursos e Mecânicas

- **⏱️ Temporizador e Pontuação em Tempo Real**: A partida inicia com 15 segundos (e 10 segundos nos reinícios). Cada acerto preciso no alvo concede 1 ponto ao jogador.
- **💥 Feedback Visual com Animação Elástica**: Ao ser atingido, o alvo expande para escala 1.4x e retorna suavemente ao tamanho original através de amortecimento exponencial (`math.exp`), sendo reposicionado em um local aleatório da tela.
- **🎯 Mira Personalizada (*Crosshairs*)**: O cursor padrão do sistema operacional é ocultado e substituído por uma mira temática com alinhamento centralizado.
- **🎵 Trilha Sonora e Efeitos de Áudio**:
  - Efeito sonoro de tiro de pistola a cada clique.
  - Música de fundo envolvente em loop durante toda a partida, pausada automaticamente no Game Over.
- **🏆 Tela de Game Over e Histórico de Pontuações**:
  - O cenário escurece ao término do tempo destacando o encerramento da partida.
  - Exibe a pontuação final da rodada e a lista histórica de recordes salvos (*General Score*).
  - Persistência automática das pontuações em arquivo local (`score.txt`).
- **🔄 Reinício Rápido**: Possibilidade de reiniciar uma nova partida instantaneamente pressionando a tecla **R**.
- **🖥️ Janela Responsiva**: Configurada em 1280x720 com suporte a redimensionamento (`resizable = true`), recalculando automaticamente a escala do cenário de fundo.

---

## 🎮 Controles

| Ação | Comando |
| :--- | :--- |
| **Mover a mira** | Mover o cursor do mouse |
| **Atirar / Pontuar** | **Botão Esquerdo do Mouse** |
| **Reiniciar partida** | Tecla **`R`** *(quando na tela de Game Over)* |

---

## 📁 Estrutura do Projeto

```text
targetshooting/
├── assets/
│   ├── audio/          # Trilha sonora de fundo e som de disparo
│   └── images/         # Texturas (mira, alvo e céu de fundo)
├── src/
│   └── entities/
│       ├── Game.lua    # Entidade principal, pontuação, persistência e áudio
│       ├── Pointer.lua # Lógica da mira personalizada e som do tiro
│       ├── Sky.lua     # Cenário de fundo com ajuste de escala
│       └── Target.lua  # Lógica do alvo, colisão e animação de escala
├── conf.lua            # Configurações do LÖVE (janela, resolução, vsync)
├── dev.py              # Script utilitário para auto-reload em desenvolvimento
├── main.lua            # Ciclo de vida principal do jogo (load, update, draw, input)
├── score.txt           # Registro persistido das pontuações obtidas
└── README.md           # Documentação do projeto
```

---

## 🚀 Como Executar

### Pré-requisitos

- Ter o [LÖVE 11.5+](https://love2d.org/) instalado em seu sistema operacional.
- *(Opcional)* Python 3 para execução em modo de desenvolvimento.

### Execução Normal

Abra o terminal no diretório do projeto e execute:

```sh
love .
```

### Modo de Desenvolvimento (Live Reload)

Para reiniciar o jogo automaticamente a cada modificação nos arquivos (`.lua`, imagens ou sons), utilize o script auxiliar:

```sh
python3 dev.py
```

---

## 📸 Screenshots

<img width="1286" height="750" alt="image" src="https://github.com/user-attachments/assets/32fb6b7d-4b18-4790-9afe-e5277c6b9dfa" />
<img width="1286" height="748" alt="image" src="https://github.com/user-attachments/assets/8caca456-8ce6-4346-9a53-26b8bea4f45e" />
