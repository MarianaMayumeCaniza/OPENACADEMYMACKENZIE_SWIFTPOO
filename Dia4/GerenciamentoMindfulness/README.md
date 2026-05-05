**As etapas do desenvolvimento:** 
Antes de tudo eu comecei identificando os atores do meu sistema.
Identifiquei três atores principais:
•	Administrador 
•	Aluno
•	Professor

Como eu já tinha uma ideia das funcionalidades que eu queria no sistema (eram algumas, mas eu precisei mapear para não me perder), segui uma abordagem bottom-up: Em vez de tentar criar o sistema inteiro de uma vez (dia 1 + dia 2 + dia 3), o foco foi construir primeiro as menores unidades do sistema para que elas servissem de base para tudo que viria depois. Usei uma lógica incremental e arborizada para me ajudar a manter o código organizado e fácil de evoluir.
1.	As Raízes/A base (menor unidade) — Enums: O ponto de partida foram as variáveis do sistema. Mapear os níveis de aluno/professor e categorias de aula através de Enums.
2.	O Tronco — Structs: Com as opções fixas definidas, vieram as Structs — como os Planos de Assinatura. Aqui eu queria organizar os planos para cada tipo de aula que a academia teria e para cada plano, para cada mensalidade haveria um valor diferente.
3.	Os Galhos e Ramificações — Classes e Herança: Com a base pronta, desenvolvi a hierarquia de pessoas: Alunos e Professores. O ponto de partida aqui foi o cadastro — sem aluno não existe sistema de academia. A partir do cadastro, os atributos e relacionamentos foram crescendo naturalmente, usando os Enums e Structs já criados.
5.	O Ecossistema — Central da Academia (uma classe a parte): A última etapa foi criar a central que conecta todas as partes do sistema, permitindo que alunos, instrutores, aulas e equipamentos interajam em um ambiente controlado.

**Onde sentiu dificuldade?**
No início eu tinha várias ideias de funcionalidades que queria implementar, , então precisei me organizar antes de escrever qualquer coisa. Tive que parar, mapear tudo e definir um núcleo central para depois ir crescendo o sistema. Eu precisei recomeçar o código algumas vezes, no começo eu esquecia alguma funcionalidade e, quando percebia, ela já afetava outras dependências — principalmente por causa de como o Swift funciona, a declaração e a inicialização dos os atributos explicitamente. Conforme as classes foram crescendo, os inicializadores ficaram longos e o arquivo começou a ficar poluído, com muitos parâmetros e variáveis ao mesmo tempo.

A saída foi manter o código bem documentado desde o início, com comentários separando as seções e uma nomenclatura consistente. 

Nem sempre ficava óbvio se eu devia usar uma subclasse ou protocolo. As vezes eu também não sabia se usava classe ou struct, eu precisei entender bem o que estava fazendo e como o sistema final iria ficar, então essa partde de modelar deu trabalho mesmo 

**Erros que ocorreram e como você os resolveu**
Teve somente um erro, quando eu fui fazer a classe para gerar a matricula.Em vez de usar UUID, optei por criar uma classe própria para gerar os códigos dos alunos de forma mais simples e legível: cada matrícula começaria com a letra A seguida de um número incremental — A1, A2, A3, e assim por diante.

Porém, ao chamar a função, o compilador apontou o seguinte aviso:
Static property 'contador' is not concurrency-safe because it is non-isolated global shared mutable state

Como eu fiz as classes fora do main, acredito que deu erro de concorrência e conflito. 
A solução foi usar na classe geradora de matrículas o @MainActor, e fazer o mesmo nas classes que a utilizavam. Isso garante que o acesso ao contador seja sempre feito na thread principal, eliminando o risco de conflito.

**Detalhes de novidade no código**:
As Classes e Planos de Pagamento. Eu criei categorias de aulas, aulas para meditação, aulas para musculação e aulas para luta. E cada plano ia ter um pacote de aula.
Os descontos para cada plano conforme recorrencia: Se a pessoa fizesse plano trimestral ela teria 5% de desconto, o semestral 10% e o anual 15%
