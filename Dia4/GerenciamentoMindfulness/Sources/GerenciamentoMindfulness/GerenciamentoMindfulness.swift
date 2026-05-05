import Foundation

enum NivelExperiencia { case iniciante, intermediario, avancado }
enum CategoriaAula { case Zen, Fitness, Luta }
enum NomeAula { case Yoga, Pilates, Musculacao, Spinning } // Resumido para o exemplo
enum TipoContrato { case Mensal, Trimestral, Semestral, Anual }
enum NomePlano { case Bronze, Prata, Ouro }

//nível de experiência do aluno (Iniciante, Intermediário, Avançado)
// Níveis de experiência do aluno
enum NivelExperiencia {
    case iniciante
    case intermediario
    case avancado
}

// -------- Relacionado as Aulas ----------------
// Categorias de aulas oferecidas
enum CategoriaAula {
    case Zen
    case Fitness
    case Luta

}

// Categorias de aulas oferecidas
enum NomeAula {
    case Alongamento
    case Meditacao
    case Taichi
    case Pilates
    case Yoga
    case Jump
    case Musculacao
    case Spinning
    case Funcional
    case MuayThai
    case JiuJitsu
    case KravMaga
    case Boxe
}

// -------- Relacionado ao Plano ----------------
// Categorias de aulas oferecidas
enum TipoContrato {
    case Mensal
    case Trimestral
    case Semestral
    case Anual

    /*func fatorDesconto() -> Double {
        switch self {
        case .Mensal: return 0.0
        case .Trimestral: return 0.05
        case .Semestral: return 0.10
        case .Anual: return 0.15
        }
    }*/
}


enum NomePlano {
    case Bronze
    case Prata
    case Ouro
    
}



//planos de assinatura da academia. 
//propriedades estritas e obrigatórias de negócio: 
//nome, valor da mensalidade, indicador de inclusão de personal trainer, limite de aulas coletivas e duração em meses. 


//                        ===== STRUCTS  =====
// Catálogo em memória simulando o banco de dados
struct PacoteFechado {
    let nome: NomePlano
    let valor: Double
    let contemplaCategorias: [CategoriaAula]
}

struct BancoDePacotes {
    static let catalogo: [PacoteFechado] = [
        PacoteFechado(
            nome: .Bronze,
            valor: 120.0,
            contemplaCategorias: [.Zen]
        ),
        PacoteFechado(
            nome: .Prata,
            valor: 175.0,
            contemplaCategorias: [.Zen, .Fitness]
        ),
        PacoteFechado(
            nome: .Ouro,
            valor: 220.0,
            contemplaCategorias: [.Zen, .Fitness, .Luta]
        )
    ]
}

struct PacoteContratado {
    let pacote: PacoteFechado
    let tipoContrato: TipoContrato

    var valorFinal: Double {
        switch tipoContrato {
        case .Mensal:
            return pacote.valor
        case .Trimestral:
            return pacote.valor * 0.95
        case .Semestral:
            return pacote.valor * 0.90
        case .Anual:
            return pacote.valor * 0.85
        }
}
}

struct Pagamento {
    let valor: Double
    let metodo: String
    let data: Date
}

//                        ===== CLASSES  =====


// Entidade genérica para pessoas
class Pessoa {
    var nome: String
    var idade: Int
    var cpf: String
    var email: String
    var telefone: String
    
    init(nome: String,idade: Int,cpf: String, email: String, telefone: String) {
        self.nome = nome
        self.idade = idade
        self.cpf = cpf
        self .email = email
        self .telefone = telefone
    }
}

class Aluno: Pessoa {
    var matricula: String
    var nivel: NivelExperiencia
    var pacote: PacoteContratado
    //Variavel para ativar ou desativar essa pessoa
    var cadastroAtivo: Bool = false
    var comprovanteMatricula: Pagamento?

    init(
        nome: String,
        idade: Int,
        cpf: String,
        email: String,
        telefone: String,
        matricula: String,
        nivel: NivelExperiencia,
        pacote: PacoteContratado
    ) {
        self.matricula = matricula
        self.nivel = nivel
        self.pacote = pacote

        super.init(
            nome: nome,
            idade: idade,
            cpf: cpf,
            email: email,
            telefone: telefone
        )
    }
}

class Professor: Pessoa {
    var matricula: String
    var lecionaAulas: [NomeAula]

    init(
        nome: String,
        idade: Int,
        cpf: String,
        email: String,
        telefone: String,
        matricula: String,
        lecionaAulas: [NomeAula]
    ) {
        self.matricula = matricula
        self.lecionaAulas = lecionaAulas

        super.init(
            nome: nome,
            idade: idade,
            cpf: cpf,
            email: email,
            telefone: telefone
        )
    }
}


    protocol Manutenivel {
    var nomeItem: String { get }
    func realizarManutencao() -> Bool 
    }

    //Esse é o do dia 2... Nao implementei ainda muito bem a modelagem e a logica podem melhorar
    class Aparelho: Manutenivel {
        var nomeItem: String
        var precisaReparo: Bool 

        init(nome: String, precisaReparo: Bool = false) {
            self.nomeItem = nome
            self.precisaReparo = precisaReparo
        }

        func realizarManutencao() -> Bool {
            // Se precisar de reparo, ele "falha" na manutenção automática
            return !precisaReparo 
        }
    }



 //Aqui é para executar uma chamada por vez!
@MainActor 
class GeradorMatriculaAluno {
    // 
    private static var contador: Int = 0

    static func gerar() -> String {
        contador += 1
        return "A\(contador)"
    }
}

class GeradorMatriculaProfessor {
    private var contador: Int = 0

    func gerar() -> String {
        contador += 1
        return "P\(contador)"
    }
}

class AlunoRepository {
    private var alunos: [String: Aluno] = [:] //Dicionario do aluno para guardar alunos

    // CREATE
    // _ variavel: Quando eu dor digitar a funçao nao precisa escrever o nome dela! legal!
    func salvar(_ aluno: Aluno) {
        alunos[aluno.matricula] = aluno
    }

    // READ
    func buscar(_ matricula: String) -> Aluno? {
        return alunos[matricula]
    }
    func buscarPorCPF(_ cpf: String) -> Aluno? {
        return alunos.values.first { $0.cpf == cpf }
        //Sinonimo de
        /*for aluno in alunos.values {
            if aluno.cpf == cpf {
            return aluno}}*/
    }

    // Valida
    func existe(_ matricula: String) -> Bool {
        return alunos[matricula] != nil
    }

    // UPDATE
    func editar(matricula: String, atualizacao: (Aluno) -> Void) {
        guard let aluno = alunos[matricula] else {
            print("Aluno não encontrado")
            return
        }

        atualizacao(aluno)
    }

    // DELETE (faltando no seu CRUD completo)
    func remover(matricula: String) {
        alunos.removeValue(forKey: matricula)
    }
}

@MainActor
class CentroMindfulness {
    private let repo = AlunoRepository()
    private var equipamentos: [Manutenivel] = []

    // Eu ja tinhaa feito o cadastro na aula do dia 1. Tem as funções la... bom... depois da para trazer aqui mas acho que vou fazer uma pasta para o projeto final
    func cadastrarAluno(nome: String, cpf: String, pacote: PacoteContratado) {
        // Checagem de segurança por CPF para evitar duplicidade real
        if repo.buscarPorCPF(cpf) != nil {
            print("Aluno já cadastrado com este CPF.")
            return
        }

        let novaMatricula = GeradorMatriculaAluno.gerar()

        // Esssa função verifica se existe a matricula no repo... ela pode ser usada internamente pelo sistema...
        if repo.existe(novaMatricula) {
            print("A matrícula \(novaMatricula) já existe no sistema.")
            return
        }

        let novoAluno = Aluno(
    nome: nome, 
    idade: 0, 
    cpf: cpf, 
    email: "", 
    telefone: "",
    matricula: novaMatricula, 
    nivel: NivelExperiencia.iniciante, // <--- Aqui o nome completo
    pacote: pacote
)

        repo.salvar(novoAluno)
        print("Aluno \(nome) matriculado com sucesso! ID: \(novaMatricula)")
    }

    // 2. Manutenção Programada em Lote (Relata apenas as falhas)
    func executarManutencaoGeral() {
        print("\n--- Relatório de Falhas de Equipamentos ---")
        let maquinasComDefeito = equipamentos.filter { !$0.realizarManutencao() }
        
        if maquinasComDefeito.isEmpty {
            print("Sistemas operacionais. Nenhuma falha detectada.")
        } else {
            maquinasComDefeito.forEach { print("Falha detectada em: \($0.nomeItem)") }
        }
    }

    // Trava do Personal Trainer, essa função é nova... ela deve ser associada a logica do dia 1 depois... pq eu acho que todos poderiam solicitar o personal como serviço extra... Mas por hora
    //vamos fazer so para o plano ouro...
    func agendarPersonal(para matricula: String) {
        guard let aluno = repo.buscar(matricula) else {
            print("Aluno não encontrado.")
            return
        }

        // Regra: Somente o Plano Ouro permite agendar personal
        if aluno.pacote.pacote.nome == NomePlano.Ouro {
            print(" Personal agendado para \(aluno.nome).")
        } else {
            print("O plano \(aluno.pacote.pacote.nome) não possui acesso a Personal Trainer.")
        }
    }

    func adicionarEquipamento(_ item: Manutenivel) {
        equipamentos.append(item)
    }
}

protocol Aula {
    var nome: String { get }
    var instrutor: String { get }
}

class TurmaColetiva: Aula {
    var nome: String
    var instrutor: String
    var capacidadeMax: Int
    var alunos: [String] = []
    
    init(nome: String, instrutor: String, capMax: Int) {
        self.nome = nome
        self.instrutor = instrutor
        self.capacidadeMax = capMax
    }
    
    func inscrever(aluno: String) {
        if alunos.count < capacidadeMax {
            alunos.append(aluno)
            print("\(aluno) inscrito na aula \(nome).")
        } else {
            print(" Rejeição: Aula \(nome) está lotada!")
        }
    }
}

class TreinoPersonal: Aula {
    var nome: String
    var instrutor: String
    init(nome: String, instrutor: String) {
        self.nome = nome
        self.instrutor = instrutor
    }
}

@main
struct GerenciamentoMindfulness {
    static func main() {
        print("Hello, world!")
        let centro = CentroMindfulness()

        print("--- TESTE DE CADASTRO E DUPLICIDADE ---")
        
        // Criando pacotes para teste
        let pacoteOuro = BancoDePacotes.catalogo[2] // Ouro
        let pacoteBronze = BancoDePacotes.catalogo[0] // Bronze

        let contratoOuro = PacoteContratado(
            pacote: pacoteOuro, 
            tipoContrato: .Anual
        )

        let contratoBronze = PacoteContratado(
            pacote: pacoteBronze, 
            tipoContrato: .Mensal
        )
        
        
        centro.cadastrarAluno(nome: "Mari", cpf: "123.456.789-01", pacote: contratoOuro)
        // Tentativa de duplicidade por CPF
        centro.cadastrarAluno(nome: "Mariana Reetida", cpf: "123.456.789-01", pacote: contratoBronze)

        print("\n--- TESTE DE AGENDAMENTO (TRAVA DE SEGURANÇA) ---")
        
        // Mari (A1) tem plano Ouro -> Deve permitir
        centro.agendarPersonal(para: "A1")
        
        // Vamos cadastrar um aluno Bronze para testar o bloqueio
        centro.cadastrarAluno(nome: "Ana", cpf: "000.000.000-00", pacote: contratoBronze)
        centro.agendarPersonal(para: "A2")

        print("TESTE DE MANUTENÇÃO (RELATÓRIO DE FALHAS) ---")
        
        // Adicionando máquinas
        let tapeteYoga = Aparelho(nome: "Tapete Premium 01", precisaReparo: false)
        let esteiraCorrida = Aparelho(nome: "Esteira de Corrida Modelo E01", precisaReparo: true) // Vai falhar
        
        centro.adicionarEquipamento(tapeteYoga)
        centro.adicionarEquipamento(esteiraCorrida)
        
        // Executa a manutenção e mostra apenas quem falhou
        centro.executarManutencaoGeral()
        //A função/classe da aula precisa ser melhor descrita
        //melhor detalhada... ela está bem generica
        let aulaYoga = TurmaColetiva(nome: "Yoga", instrutor: "Bea", capMax: 1)
        aulaYoga.inscrever(aluno: "Mari")
        aulaYoga.inscrever(aluno: "Ana")// Ana nao cabe na aula pq so cabe 1 aluno

        // Teste 5: Polimorfismo 
        //Nao consegui testar... precisa ser melhorado esse codigo... esta confuso
        print("\n---  POLIMORFISMO ---")
        let comunidade: [Pessoa] = [Professor(nome: "JP", cpf: "7"), Aluno(nome: "Mari", cpf: "1", matricula: "A1", pacote: planoOuro)]
        comunidade.forEach { print("Pessoa: \($0.nome) - Função: \($0.funcao)") }

        let grade: [Aula] = [aulaYoga, TreinoVIP(nome: "Personal Camila", instrutor: "Igor")]
        grade.forEach { print("Aula: \($0.nome) - Instrutor: \($0.instrutor)") }
    }
}
