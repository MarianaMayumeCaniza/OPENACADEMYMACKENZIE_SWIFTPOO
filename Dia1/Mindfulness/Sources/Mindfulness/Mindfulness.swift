// The Swift Programming Language
// https://docs.swift.org/swift-book


/*
        Aplicativo Mindfulness

*/

//nível de experiência do aluno (Iniciante, Intermediário, Avançado)
enum NivelPratica {
    case iniciante, intermediario, avancado
}

//categorias de aulas oferecidas (Musculação, Spinning, Yoga, Funcional, Luta).
enum CategoriaSessao {
    case aulaMeditacao, aulaTaichi, aulaYoga, aulaPilates, aulaAlongamento, aulaMusculacao, aulaJump, aulaFuncional
}

//planos de assinatura da academia. 
//propriedades estritas e obrigatórias de negócio: 
//nome, valor da mensalidade, indicador de inclusão de personal trainer, limite de aulas coletivas e duração em meses. 

struct PlanoMindfulness {
    let nome: String
    let mensalidade: Double
    let temPersonal: Bool
    let limiteAulas: Int
    let duracaoMeses: Int
}

// Crie um catálogo em memória simulando um banco de dados com instâncias pré-definidas (Mensal, Trimestral, Anual).
enum TipoRecorrencia: String {
    case mensal = "Mensal"
    case trimestral = "Trimestral"
    case semestral = "Semestral"
    case anual = "Anual"
}
@main
struct Mindfulness {
    static func main() {
        print("Hello, world!")
        print("--- Iniciando Testes do Dia 2 ---")
        
        // Testando Equipamento
        let banco = Equipamento(nomeItem: "Banco de Supino", estadoFuncionamento: "defeituoso")
        _ = banco.realizarReparo(data: "30/04", statusRegularidade: true)
    }
}
