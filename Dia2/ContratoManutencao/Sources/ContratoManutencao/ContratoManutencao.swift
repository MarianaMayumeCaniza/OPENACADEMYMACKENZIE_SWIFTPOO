// The Swift Programming Language
// https://docs.swift.org/swift-book


/*
        CONTRATOS DE COMPORTAMENTO

*/

protocol Manutencao {
    // propriedades de leitura (nome do item e histórico)
    var nomeItem: String { get }
    var historicoItem: [String] { get }
    
    // ações (realização de reparo informando data e status de regularidade)
    func realizarReparo(data: String, statusRegularidade: Bool) -> Bool
}

struct Equipamento: Manutencao {
    let nomeItem: String
    var historicoItem: [String] = []
    //estado de funcionamento que, quando defeituoso, deve obrigatoriamente fazer com que a tentativa de manutenção falhe.
    var estadoFuncionamento: String 

    
    func realizarReparo(data: String, statusRegularidade: Bool) -> Bool {
        if estadoFuncionamento == "defeituoso" {
            print("Erro: Não é possível realizar manutenção em item defeituoso.")
            return false
        }
        
        print("Manutenção realizada no item \(nomeItem) em \(data).")
        return true
    }
}

@main
struct ContratoManutencao {
    static func main() {
        print("Hello, world!")

        print("--- Iniciando Testes do Dia 2 ---")
        
        // Testando Equipamento [cite: 116, 135]
        let banco = Equipamento(nomeItem: "Banco de Supino", estadoFuncionamento: "defeituoso")
        _ = banco.realizarReparo(data: "30/04", statusRegularidade: true)
    }
}


