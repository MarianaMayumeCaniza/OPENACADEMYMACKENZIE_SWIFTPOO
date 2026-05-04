# OPENACADEMYMACKENZIE_SWIFTPOO
Repositorio criado para o curso de programação orientada a objetos na Linguagem Swift ministrada pela Open Academy Mackenzie

Este repositório apresenta o desenvolvimento de um sistema de gerenciamento para uma academia focada em Mindfulness, desenvolvido integralmente em Swift.
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


Class Diagram
![Diagrama](https://www.plantuml.com/plantuml/png/jLN1RXmt3BtFLmY-E2qGfxqEt4NMcssRmdODZtCgUg1dk1iL6d4WKGl7HS_zWdvHVgoKHfR7iX7qq1WmXXB9H-ezSVNMCpWEescErG_nJsqlFrnqizsW3QEwr0Sqsxi9dKRRQr1_DaffgyMqZCbcT2CE6fmcMSC1R0y3DNyrCy866FVaDAo3cTELkaURlZlD5hrFjWaC9UcIHYpnO_2zs3r4V3zfQxNTY_c9zY2VIHjWZ21_wF2BPXyAp8sUQ4EM7J0bg0kq7emODqwFwDcbHOUFzje6-Ixxk39WQUxxp96znsHU2IOawzVWucaBXztDzOVDJQSoZOqWXvxL5UnXHCkaKYS7CEHQzOx2hOc88p8DrAgBz2t14RW0zCJu8_OVOSWWLjfh7vkKdPx6oQ3yG-7Tj-fSUpvz8iJgMGjreSnRgJMbtVPf6xBF2uxR9umt2ympi3szmpdPgzDJXnDvpUG-hLO9lmS6GtlAtJufireWhKsmT5soNuA262B7_grZf-s-dND-BuJDsxBK0mooVcyvDZ3j5YuSGPl5cj7WZkmoUmInuirSxDbgNjfd4nIfh0XkQyf5zdATDkVhhji-36NJ6_1UTUWEkgVj7JkPaVfWjRH9f2nEpfG26IgDMO58v3zCNr8bNvfsESZ9zURDHtBWj03_F1ifNWwteBMKkKBlIGhzlo8K-AImmZj6EooAVLsHb3eZCghjOG3FZjQi3t6tJ6-Rvj7H0IpZnKCd2r8SxMAhxhzs3i6KUNvGQVM8znCwwSkLIecLURh8SdHLgjG9fQ4NauxdfCKlwh5I0p2yZmy2oNq3nhW7aOWsiTCSbs8Rb3owq7RO1MEbJ7uDwedEyog-J2oujF6g2ln68cw3xxDRlUG73c3q_PT278vqm2y4o06Kce-mlTEtscsothd_oMdBwMNPuzY5FXBuAYUMCRxUdgy___tvdpB9MUcZxu_KwzVgwBkJ4x5IzPTTHPgcIL7PlOhVwcrebiiwiBh3rKOLNPwXOYtzpnLjdcjyShAgQMihOOMiShg27u_zhJ0I1-OjsY6Cvby0)

UseCaseDiagram
![Diagrama](https://www.plantuml.com/plantuml/svg/dLVRRXj73xwVfo3qNoZ13xbnpX428OgSE4th0sAvHNj7xrBI8BCxoioiQwVrmmIz27BHgw1Fe1Shvw3LQhrgYmf8GYu_SaZEH-xcXNLeN5KeiI3CoS1ukOGZMUQpIfLaBGpW29U41PLEGqvme8lL7wNKLZZf5EiIvmOBzBO9McszS6uPgpcMaXawUQcR8OLGD7F0uOoSBnpaqb3cf2w5VI_B9N8qmCnfS-Qk-G3yXQmkI0ZHXy5W0EDAeOKF5LiOnZaN4k5aHXo4F43uQ5ZEsRKtGRVwfFGyP1uSU_2_i_VNBnMx_oe4y6-9sNkSC_XdAYUgkc34cDEcY0cGHiGfocmXUu0MejW6754k7Qu-htxN0TNGsz2nqkKyT3P26teR-fEUOy1ueMqybGeTsM1FihWHTLslfUEs-yeFT3udqrtOKMMpIZKIRpveWzzMnJA0lD0slgxAJEeILK3KMXjsWENgSomgYisSlwySSiBlz3MgxdnVwYiApbwuNGnUmtI1CY2yvfKswZk3bypkr5clUULMhRA2jzBPAg1O2uguyJ0GDu6N4vHN2BckorrzCf8rqRmbCZCPfkFKw1bPgmtvIpbSQEj-N4YNYepSXzuhkwHCefBMnGHdgPCSkMc3vy_vrDe4er4pIiCIWZJqltVaT2qR54mDof9Cy5u_JC-Q-Bge0Aor9kIuSaRwu-gIjfu4QFYh3s_814uCOQfzMosJ49nSnlLoM4cq0RbLpc-3mQucTO9RMUvm3T1MvV_iq2fDDCWoyE4KbhuMxQU-Oh6zkI8W6PabYa_Toz4kA6_I907XfT7bHne2xx3GsAZVnfqQT1XWy7-e5mFQQBYDFwcCRi5PYjE9DfXzLMsQgt-H-BSbjmTB5wUurhOXZan1kQpfk_Ma2HrV1hxa4LPhhUIcpA3mejAbuu8rT2JOskQbJOiiYct0rCY2h3C9j57Rm3DgubZhXetBAa6252cJ-NIrWjuFg6JEPPdmFfjJcJTU7qUQEo7w5xhYn-QQSoE57bY_FFm3qHzVyCbnhmS2DhbhuSuRIGRDXqhYNT4_jsHWC0gUu8SnGw02Ul5iqnDYixFFE00Ls7pLzq97wwaUEoClAib7_qcU_B1scTEw5NMqezNNl58Q9bmV6xyvz13_zbRewD3WTGWTVvMb32qxdKzWVmWJp95Br964SAmlDOJwpoVxdJxtXyn_eZ9Ra66ApRGfC2QPtEvtkZqOSkyohTWh3dH2F-X4FnokGnjuTRKa8_b0YSddOQVFeyq9DMUJmwDEXyUDwklj5ZgGt1vtkZrfd5FJWOb6oUj9fzVJ-Z0qCAsuCflmJyNcscyWAltsvs6ydivRhwryuIScMyXynsq_stbpZH0XfMVTRBatN3SM3K-bkMHsQa0uHUDeJPfxiP3_L4Pz2vwxg0fTxYBkVaXb9WD36iDjrsaayjQDhILnaruh1pIJfToCzjXfG_7TijwJTKk2nDy0IHYD8gIUumZA2raoA0gCwVwiQBuAapixDK3icLBa4kagND2TTwGm06APTqEU_LE_GgK9UtfQSGSvMlZSTsH0GvRe7Uh3-EwavlcMDnnKfSmGbhxn69ndQ10agx3w0ZgM8pbENAO8u_G_2I62YLCP-PO31-DL24lDsLWouVXmEgM-wQenQENgozxU7XIa5gnPMg91myx6fu0MxaEcq5goeIYvpLSv8yED82luu9J00nXo8sMPgIgdqIXOzlP6l94WMEZACK-I8ReyRBlKbaSjY-YV08Pg7HONLAnxoutRVA5kzUEnu3z9VWAj0AilHUmJ-ne_JWLABZJi1Tylh1HkXtiQ8iG-1izbFSlSLigbZuAstIXIn7UAPQxv7sd9Y10Y1Nqc-gyKRMUKrIDkquXRu2hHkDsHmjmpQK-W_IaCMHfJq82REGqysv1o9Z-ImK9qZ4OAlo_wV95ydvsNinwOO-rY_zxHt4JfcEQhhnmq3CmBJg0gr5y0
)

Fluxograma Cadastro Aluno Novo
![Diagrama](https://www.plantuml.com/plantuml/png/PLBD3jCm3BxdANnifJr1Us1e0saI6XFZ1RpKtOoIk4hI8Q6-3EB0YHFY2VfYUEqGtPPJOdy_yIUlKyQOU-_CyDRrGM0lLndCL3NLbX9zGMZn6qNmcEFuo_OEQwFendFWb2Cs4WTJxG9RnWK86W6yIIgwEaIYO2y4ZS8JdCRlYQrUv1JvZ7dy7LbIiJcyNm5vPBU2J8vQ2LJM1inmL2Tj3ERhXHr1iPraFivikP6XcorO6szAu0J5VlmXfG4z3_xFjlKCsKZK8W67LgB7yUVuXxH7eRbx7jcNPl6LwWEVA29Gik8k20r1vp38QpgB-H_KeP3EiWHqTMcg8pcQNlzaDFwM0u6Le49v2l8JdITPwF2Cdi9KVOddNKkvL-l_A1Nna7fBASbhFBlvLq0n2eG5RSxcQPoPyrdx61SEGQxJZMRISt3L9Zxk1u751bLK5gi2zsDCojAPjQheSlu5)
