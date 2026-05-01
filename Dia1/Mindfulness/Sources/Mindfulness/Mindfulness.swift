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

// Categorias de aulas oferecidas
enum CategoriaAula {
    case musculacao
    case spinning
    case yoga
    case funcional
    case luta
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



// Catálogo em memória simulando o banco de dados
struct BancoDeDadosPlanos {
    static let catalogo: [PlanoMindfulness] = [
        PlanoMindfulness(nome: "Mensal", mensalidade: 150.0, temPersonal: false, limiteAulas: 10, duracaoMeses: 1),
        PlanoMindfulness(nome: "Trimestral", mensalidade: 400.0, temPersonal: true, limiteAulas: 30, duracaoMeses: 3),
        PlanoMindfulness(nome: "Anual", mensalidade: 1200.0, temPersonal: true, limiteAulas: 999, duracaoMeses: 12)
    ]
}

// Entidade genérica para pessoas
class Pessoa {
    var nome: String
    var email: String
    var funcao: String
    
    init(nome: String, email: String, funcao: String) {
        self.nome = nome
        self.email = email
        self.funcao = funcao
    }
}

class Aluno: Pessoa {
    let matricula: String
    var plano: PlanoMindfulness
    var nivel: NivelExperiencia
    
    init(nome: String, email: String, matricula: String, plano: PlanoMindfulness, nivel: NivelExperiencia) {
        self.matricula = matricula
        self.plano = plano
        self.nivel = nivel
        super.init(nome: nome, email: email, funcao: "Aluno")
    }
}

class Instrutor: Pessoa {
    var especialidade: CategoriaAula
    
    init(nome: String, email: String, especialidade: CategoriaAula) {
        self.especialidade = especialidade
        super.init(nome: nome, email: email, funcao: "Instrutor")
    }
}



class CentroMindfulness {
    var alunos: [String: Aluno] = [:] // Dicionário para busca rápida
    
    func admitirAluno(_ aluno: Aluno) {
        if alunos[aluno.matricula] != nil {
            print("❌ Erro: Aluno com matrícula \(aluno.matricula) já cadastrado!")
        } else {
            alunos[aluno.matricula] = aluno
            print("✅ Aluno \(aluno.nome) admitido com sucesso!")
        }
    }
    
    func agendarSessaoPersonal(para matricula: String) {
        guard let aluno = alunos[matricula] else {
            print("❌ Aluno não encontrado.")
            return
        }
        
        if aluno.plano.temPersonal {
            print("🚀 Sessão de Personal agendada para \(aluno.nome)!")
        } else {
            print("⚠️ Bloqueado: O plano \(aluno.plano.nome) não inclui Personal Trainer.")
        }
    }
}
@main
struct Mindfulness {
    static func main() {
        print("Hello, world!")
        let centro = CentroMindfulness()
        // [0] = Mensal, [1] = Trimestral, [2] = Anual
        let planoEscolhido = BancoDeDadosPlanos.catalogo[0] 
        
        let aluno1 = Aluno(
            nome: "Mari", 
            email: "mari@email.com", 
            matricula: "A01", 
            plano: planoEscolhido, // Atribuiu o plano sem digitar valores
            nivel: .iniciante
        )
        
        centro.admitirAluno(aluno1)
        
        // Se a Mari quiser mudar para o plano ANUAL depois:
        aluno1.plano = BancoDeDadosPlanos.catalogo[2] 
        print("Upgrade feito! Novo plano: \(aluno1.plano.nome)")
    }
}
