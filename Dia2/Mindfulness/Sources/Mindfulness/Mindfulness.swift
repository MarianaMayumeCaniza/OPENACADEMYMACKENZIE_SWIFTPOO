// The Swift Programming Language
// https://docs.swift.org/swift-book

//contrato base de "Aula" exigindo nome, instrutor, categoria e descrição
protocol Aula {
    var nome: String { get }
    var instrutor: String { get }
    var categoria: String { get }
    var descricao: String { get }
}

//treinos com personal.
class TreinoPersonal: Aula {
    let nome: String
    let instrutor: String
    let categoria: String
    let descricao: String

    init(nome: String, instrutor: String, categoria: String, descricao: String) {
        self.nome = nome
        self.instrutor = instrutor
        self.categoria = categoria
        self.descricao = descricao
    }
}
//treinos Aula coletiva.
class TurmaColetiva: Aula {
    // Propriedades do contrato
    let nome: String
    let instrutor: String
    let categoria: String
    let descricao: String
    
    // gerenciar inscrições controlando uma capacidade máxima e mínima
    let capacidadeMinima: Int
    let capacidadeMaxima: Int
    var alunosInscritos: [String] = []


    init(nome: String, instrutor: String, categoria: String, descricao: String, min: Int, max: Int) {
        self.nome = nome
        self.instrutor = instrutor
        self.categoria = categoria
        self.descricao = descricao
        self.capacidadeMinima = min
        self.capacidadeMaxima = max
    }

  
    func inscreverAluno(_ nomeAluno: String) {
        // As inscrições só podem ser efetivadas se houver vagas e se o aluno já não estiver na turma.
        if alunosInscritos.count < capacidadeMaxima && !alunosInscritos.contains(nomeAluno) {
            alunosInscritos.append(nomeAluno)
            print("Aluno \(nomeAluno) inscrito com sucesso na turma de \(nome)!")
        } else {
            print("Inscrição falhou: Turma lotada ou aluno já inscrito.")
        }
    }
}

@main
struct Mindfulness {
    static func main() {
        print("Hello, world!")
        let aulaGrupo = TurmaColetiva(nome: "Yoga", 
                                      instrutor: "Ana", 
                                      categoria: "Grupo", 
                                      descricao: "Prática em conjunto",
                                      min: 1, 
                                      max: 2) 

        
        print("Aula: \(aulaGrupo.nome) com \(aulaGrupo.instrutor)")
        aulaGrupo.inscreverAluno("Carlos") 
        aulaGrupo.inscreverAluno("Bia")    
        aulaGrupo.inscreverAluno("João")   
}
}