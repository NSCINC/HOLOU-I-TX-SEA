import Foundation

// Estrutura de Tarefa do Kernel
struct KernelTask {
    let provider: String // Provedor de armazenamento (AWS, Azure, Google, Local)
    let path: String     // Caminho no sistema de arquivos
    let taskId: Int      // ID da tarefa
}

// Classe do Kernel Index para gerenciamento de tarefas
class KernelIndex {
    var tasks: [KernelTask]
    var currentTask: Int
    let queue: DispatchQueue
    let semaphore: DispatchSemaphore

    init(tasks: [KernelTask]) {
        self.tasks = tasks
        self.currentTask = 0
        self.queue = DispatchQueue.global(qos: .userInitiated) // Fila de execução
        self.semaphore = DispatchSemaphore(value: 1) // Semáforo para controle de acesso
    }

    // Função de processamento de tarefa
    func processTasks() {
        let group = DispatchGroup()

        for _ in 0..<min(tasks.count, ProcessInfo.processInfo.activeProcessorCount) { // Utiliza o número de núcleos disponíveis
            group.enter()
            queue.async {
                while true {
                    self.semaphore.wait() // Espera pelo acesso

                    if self.currentTask >= self.tasks.count {
                        self.semaphore.signal() // Libera o semáforo
                        break // Nenhuma tarefa restante
                    }

                    let task = self.tasks[self.currentTask]
                    self.currentTask += 1
                    self.semaphore.signal() // Libera o semáforo

                    // Simular processamento
                    print("Kernel: Processando tarefa \(task.taskId) em \(task.provider) - caminho: \(task.path)")
                    sleep(1) // Simulação de tempo de processamento

                    print("Kernel: Finalizou tarefa \(task.taskId)")
                }
                group.leave()
            }
        }

        group.wait() // Espera todas as tarefas terminarem
        print("Kernel: Todas as tarefas foram processadas.")
    }
}

// Função principal
func main() {
    // Definir tarefas para serem processadas pelo kernel
    let tasks = [
        KernelTask(provider: "AWS", path: "s3://bucket1/data", taskId: 1),
        KernelTask(provider: "Azure", path: "azure://container/data", taskId: 2),
        KernelTask(provider: "Google", path: "gcs://bucket2/data", taskId: 3),
        KernelTask(provider: "Local", path: "/local/disk1/data", taskId: 4),
        KernelTask(provider: "AWS", path: "s3://bucket2/data", taskId: 5),
        KernelTask(provider: "Azure", path: "azure://container2/data", taskId: 6),
        KernelTask(provider: "Google", path: "gcs://bucket3/data", taskId: 7),
        KernelTask(provider: "Local", path: "/local/disk2/data", taskId: 8)
    ]

    // Rodar o kernel com as tarefas definidas
    let kernelIndex = KernelIndex(tasks: tasks)
    kernelIndex.processTasks()
}

// Executar a função principal
main()
