// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
/*
        Aplicativo Mindfulness

*/


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


// Eu nao vou colocar o personal trainer... Vou deixar um serviço para ele contratar a parte
//Também nao vou definir limite de aulas, vou deixar uma restrição por plano ao inves. 
//Também nao vai ter duracao em meses... pq o NomePlano ja define a duraçao do plano até a renovação


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

// -------- Relacionado Informacoes das Pessoas ----------------
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

    // Cadastro
    func cadastrarAluno(
    nome: String,
    idade: Int,
    cpf: String,
    email: String,
    telefone: String,
    nivel: NivelExperiencia,
    pacote: PacoteContratado
    ) {
    // CPF não pode existir senao vai ter que usar a matricula antiga!
    if repo.buscarPorCPF(cpf) != nil {
        print("Já existe um aluno com este CPF.")
        return
    }

    let matricula = GeradorMatriculaAluno.gerar()

    let aluno = Aluno(
        nome: nome,
        idade: idade,
        cpf: cpf,
        email: email,
        telefone: telefone,
        matricula: matricula,
        nivel: nivel,
        pacote: pacote
    )

    // 4. Salvar
    repo.salvar(aluno)

    print("Aluno cadastrado com sucesso! Matrícula: \(matricula)")
    print("\n--- FICHA DO ALUNO ---")
        print("Matrícula: \(aluno.matricula)")
        print("Nome: \(aluno.nome)")
        print("Nível: \(aluno.nivel)")
        print("Plano: \(aluno.pacote.pacote.nome) (\(aluno.pacote.tipoContrato))")
        
        // Aqui vemos a mágica do desconto acontecendo:
        let valorFormatado = String(format: "%.2f", aluno.pacote.valorFinal)
        print("Valor Mensal: R$ \(valorFormatado)")
}

    // Buscar aluno
    func buscarAluno(matricula: String) -> Aluno? {
        guard let aluno = repo.buscar(matricula) else {
            print("Aluno não encontrado")
            return nil
        }

        return aluno
    }

    // Atualizar aluno (ex: troca de plano, nível etc)
    func atualizarAluno(matricula: String, atualizacao: (Aluno) -> Void) {
        guard let aluno = repo.buscar(matricula) else {
            print("Aluno não encontrado")
            return
        }

        atualizacao(aluno)
    }

    // Remover aluno
    func removerAluno(matricula: String) {
        if repo.existe(matricula) {
            repo.remover(matricula: matricula)
            print("Aluno removido com sucesso")
        } else {
            print("Aluno não encontrado")
        }
    }


}
@main
struct Mindfulness {
    static func main() {
        print("Hello, world!")
        let centro = CentroMindfulness()

        // 2. Vamos buscar um pacote do nosso "Banco de Dados" (ex: Pacote Ouro)
        // O catálogo tem 0: Bronze, 1: Prata, 2: Ouro
        let pacoteOuro = BancoDePacotes.catalogo[2]

        // 3. Criamos o contrato específico (ex: Ouro Anual)
        let contratoAnual = PacoteContratado(
            pacote: pacoteOuro, 
            tipoContrato: .Anual
        )

        // 4. Agora sim, realizamos o cadastro do aluno!
        centro.cadastrarAluno(
            nome: "Mari",
            idade: 30,
            cpf: "123.456.789-02",
            email: "mari@email.com",
            telefone: "(11) 91234-9999",
            nivel: .iniciante,
            pacote: contratoAnual
        )

    
        
    }
}
