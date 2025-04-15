# 📦 Monitorador e Compilador Automático de Arquivos C++

## 📖 Descrição

Este projeto é um script Bash que monitora arquivos `.cpp` em tempo real e recompila automaticamente aqueles que sofrerem alterações. Ele verifica periodicamente a data de modificação dos arquivos e, ao identificar mudanças, compila novamente o arquivo C++ correspondente usando o `g++`.

---

## 📦 Pré-requisitos

- Bash
- `g++` (compilador C++)

---

## 📝 Como Funciona

- Se **nenhum argumento** for passado ao script, ele procurará todos os arquivos `.cpp` no diretório atual.
- Caso **nomes de arquivos sejam passados como argumentos**, apenas esses arquivos serão monitorados.
- O script exibe a lista de arquivos monitorados e inicia um loop infinito.
- A cada 5 segundos, verifica a data de modificação de cada arquivo.
- Se algum arquivo for alterado, ele é recompilado automaticamente.
- Exibe mensagens indicando o sucesso ou falha na compilação.

---

## 📦 Uso

### 📌 Executar com todos os arquivos `.cpp` do diretório atual:

```bash
./autocompiler.sh

./autocompiler.sh arquivo1.cpp arquivo2.cpp
