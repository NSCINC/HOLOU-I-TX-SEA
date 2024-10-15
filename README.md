
# HOLOU-I TX SEA 🚀


## Descrição
O **HOLOU-I TX SEA** é um sistema de processamento paralelo que utiliza threads para simular a execução de tarefas em diferentes provedores de armazenamento. O sistema é projetado para demonstrar o uso de multithreading em C, permitindo o processamento simultâneo de várias tarefas de entrada/saída (I/O).

## Funcionalidades ✨
- Processamento de dados de múltiplos provedores de armazenamento (AWS, Azure, Google Cloud, Local).
- Utilização de threads para execução paralela, melhorando a eficiência do processamento.
- Simulação de operações de I/O com tempos de espera programados.

## Estrutura do Projeto 📂
O projeto contém um único arquivo C, `r2d2.c`, que implementa a funcionalidade principal do sistema.

### Estrutura do Código
- **Inclusões de bibliotecas**: 
    - `stdio.h` - para entrada e saída padrão.
    - `stdlib.h` - para funções utilitárias, incluindo gerenciamento de memória.
    - `pthread.h` - para suporte a threads.
    - `string.h` - para manipulação de strings.
    - `unistd.h` - para funções de espera (`sleep`).

- **Definições**:
    - `NUM_THREADS` - define o número de threads que serão criadas (4).

- **Estruturas**:
    - `ProcessingTask` - define as tarefas de processamento, incluindo o provedor de armazenamento, caminho e ID da tarefa.

- **Funções**:
    - `process_storage_task` - função executada por cada thread para processar a tarefa.
    - `main` - função principal que configura as tarefas e cria as threads.

## Requisitos ⚙️
- GCC (GNU Compiler Collection) para compilar o código.
- Sistema operacional compatível com POSIX (Linux, macOS).

## Compilação ⚡
Para compilar o projeto, utilize o seguinte comando no terminal:

```bash
gcc -o r2d2 r2d2.c -lpthread
```

## Execução 🏃‍♂️
Após compilar, execute o programa gerado:

```bash
./r2d2
```

## Saída Esperada 📊
A execução do programa resultará na saída de mensagens indicando a criação de threads, processamento de dados em diferentes provedores de armazenamento e a conclusão das tarefas. Exemplo de saída:

```
Main: Criando thread 0
Thread 0: Processando dados em AWS no caminho s3://my-bucket/data
Main: Criando thread 1
Thread 1: Processando dados em Azure no caminho azure://my-container/data
Main: Criando thread 2
Thread 2: Processando dados em Google Cloud no caminho gcs://my-bucket/data
Main: Criando thread 3
Thread 3: Processando dados em Local no caminho /local/disk/path
Thread 0: Finalizou o processamento em AWS
Thread 1: Finalizou o processamento em Azure
Thread 2: Finalizou o processamento em Google Cloud
Thread 3: Finalizou o processamento em Local
Main: Finalizou todas as threads.
```

## Linguagens Utilizadas e Flags 💻

### C
- **Ícone**: ![C Icon](https://img.icons8.com/color/48/000000/c-programming.png)
- **Compilador**: GCC
- **Flags**: `-lpthread`  
  Para vinculação da biblioteca de threads POSIX.

### PHP
- **Ícone**: ![PHP Icon](https://img.icons8.com/color/48/000000/php.png)
- **Compilador**: PHP CLI
- **Flags**: `-d display_errors=1`  
  Ativa a exibição de erros durante a execução.

### Java
- **Ícone**: ![Java Icon](https://img.icons8.com/color/48/000000/java-coffee-cup-logo.png)
- **Compilador**: `javac`
- **Flags**: `-Xlint:unchecked`  
  Ativa avisos sobre operações não verificadas.

### JavaScript
- **Ícone**: ![JavaScript Icon](https://img.icons8.com/color/48/000000/javascript.png)
- **Compilador**: Node.js
- **Flags**: `--experimental-modules`  
  Habilita o uso de módulos ECMAScript experimentais.

### Python
- **Ícone**: ![Python Icon](https://img.icons8.com/color/48/000000/python.png)
- **Compilador**: Python CLI
- **Flags**: `-m`  
  Executa um módulo como um script.

### Ruby
- **Ícone**: ![Ruby Icon](https://img.icons8.com/color/48/000000/ruby-programming-language.png)
- **Compilador**: Ruby CLI
- **Flags**: `-w`  
  Ativa avisos de possíveis problemas no código.

### Go
- **Ícone**: ![Go Icon](https://img.icons8.com/color/48/000000/golang.png)
- **Compilador**: Go CLI
- **Flags**: `-race`  
  Habilita a detecção de condições de corrida.

### Rust
- **Ícone**: ![Rust Icon](https://img.icons8.com/color/48/000000/rust.png)
- **Compilador**: Rust Compiler (rustc)
- **Flags**: `--edition=2021`  
  Define a edição do Rust a ser usada.

### TypeScript
- **Ícone**: ![TypeScript Icon](https://img.icons8.com/color/48/000000/typescript.png)
- **Compilador**: TypeScript Compiler (tsc)
- **Flags**: `--strict`  
  Ativa todas as opções de verificação estrita.

## Licença 📜
Este projeto está licenciado sob a [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).

## Contribuições 🤝
NSC INC


