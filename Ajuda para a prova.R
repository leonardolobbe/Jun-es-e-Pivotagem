a) left_join (Junção à Esquerda)

O left_join mantém todas as linhas do data frame à esquerda e adiciona as informações do data frame à direita. Se não encontrar correspondência, ele preencherá com NA nas colunas da tabela da direita.

Exemplo: Você tem informações de vendas (data_vendas) e informações de clientes (data_clientes). Mesmo que um cliente não tenha feito nenhuma compra, você ainda quer manter o registro desse cliente no resultado.

# Exemplo de left_join
library(dplyr)

data_vendas <- data.frame(
  id_cliente = c(1, 2, 3, 4),
  valor = c(100, 200, 150, 300)
)

data_clientes <- data.frame(
  id_cliente = c(1, 2, 3),
  nome = c("João", "Maria", "José")
)

resultado <- left_join(data_vendas, data_clientes, by = "id_cliente")
print(resultado)

Resultado:
  id_cliente	valor	nome
1	100	João
2	200	Maria
3	150	José
4	300	NA
b) right_join (Junção à Direita)

O right_join faz a junção mantendo todas as linhas do data frame à direita. Ou seja, se houver um registro no data frame da direita sem correspondência no da esquerda, ele será mantido e as colunas da esquerda ficarão com NA.

Exemplo: Se você quiser garantir que todos os clientes da tabela data_clientes apareçam, mesmo que não tenham feito compras.

# Exemplo de right_join
resultado <- right_join(data_vendas, data_clientes, by = "id_cliente")
print(resultado)

Resultado:
  id_cliente	valor	nome
1	100	João
2	200	Maria
3	150	José
NA	NA	João
c) inner_join (Junção Interna)

O inner_join retorna somente as linhas que têm correspondência em ambos os data frames. Ou seja, ele mantém apenas as linhas onde as chaves aparecem em ambas as tabelas.

Exemplo: Se você só quer clientes que tenham feito compras.

# Exemplo de inner_join
resultado <- inner_join(data_vendas, data_clientes, by = "id_cliente")
print(resultado)

Resultado:
  id_cliente	valor	nome
1	100	João
2	200	Maria
3	150	José
d) full_join (Junção Completa)

O full_join mantém todas as linhas de ambos os data frames, mesmo aquelas sem correspondência. As linhas sem correspondência são preenchidas com NA.

Exemplo: Se você quer reunir todas as informações de clientes e vendas, mesmo que nem todos os clientes tenham feito compras.

# Exemplo de full_join
resultado <- full_join(data_vendas, data_clientes, by = "id_cliente")
print(resultado)

Resultado:
  id_cliente	valor	nome
1	100	João
2	200	Maria
3	150	José
4	300	NA
e) semi_join (Junção Semântica)

O semi_join retorna todas as linhas do data frame da esquerda que têm correspondência no data frame da direita. Porém, a diferença é que ele não adiciona as colunas da direita — ele só verifica a presença.

Exemplo: Você quer saber quais clientes têm compras, mas não precisa das informações da tabela data_vendas.

# Exemplo de semi_join
resultado <- semi_join(data_vendas, data_clientes, by = "id_cliente")
print(resultado)

Resultado:
  id_cliente	valor
1	100
2	200
3	150
f) anti_join (Junção Anti)

O anti_join retorna todas as linhas do data frame da esquerda que não têm correspondência no data frame da direita.

Exemplo: Você quer saber quais clientes não realizaram compras.

# Exemplo de anti_join
resultado <- anti_join(data_vendas, data_clientes, by = "id_cliente")
print(resultado)

Resultado:
  id_cliente	valor


Perfeito! Vamos passar pela pivotagem de dados, que é outro conceito importante quando estamos manipulando tabelas no R. Pivotar é o processo de transformar dados de formato longo para largo (e vice-versa) para facilitar a análise.

No R, a pivotagem é feita principalmente com as funções pivot_wider() e pivot_longer(), que fazem parte do pacote tidyr. Essas funções são muito úteis quando você precisa reorganizar os dados para visualizações, agregações ou outras análises.
1. O que é Pivotagem?
  
  Pivotar para largo (wide): Transformar dados de formato longo (múltiplas linhas para uma combinação de valores) para formato largo, onde cada categoria se torna uma nova coluna.

Pivotar para longo (long): O contrário da pivotagem para largo. Aqui, dados que estavam em formato largo são transformados em formato longo, criando múltiplas linhas para uma categoria.

2. pivot_wider() (Pivotar para Largo)

A função pivot_wider() transforma os dados de formato longo para largo, criando novas colunas a partir de uma variável que tem valores únicos.
Sintaxe básica de pivot_wider():
  
  pivot_wider(data, names_from = coluna_de_onde_virão_os_nomes_das_colunas, values_from = coluna_de_valores)

data: O data frame original.
names_from: A coluna que contém os valores que se tornarão os nomes das novas colunas.
values_from: A coluna cujos valores serão distribuídos nas novas colunas.

Exemplo:
  
  Vamos imaginar um data frame que contém as vendas por ano de diferentes produtos. O formato é longo, ou seja, cada linha representa uma combinação de produto e ano, com a quantidade vendida.

library(tidyr)

# Dados de exemplo
dados <- data.frame(
  produto = c("A", "A", "B", "B", "C", "C"),
  ano = c(2020, 2021, 2020, 2021, 2020, 2021),
  vendas = c(100, 150, 200, 180, 250, 300)
)

# Exibir os dados
print(dados)

Resultado:
  produto	ano	vendas
A	2020	100
A	2021	150
B	2020	200
B	2021	180
C	2020	250
C	2021	300

Agora, se quisermos pivotar os dados para que os anos se tornem colunas, podemos usar pivot_wider().

# Pivotar os dados para largo
dados_largos <- dados %>%
  pivot_wider(names_from = ano, values_from = vendas)

# Exibir os resultados
print(dados_largos)

Resultado após pivot_wider():
  produto	2020	2021
A	100	150
B	200	180
C	250	300

Agora temos um formato largo, onde cada ano virou uma coluna com as vendas correspondentes.
3. pivot_longer() (Pivotar para Longo)

A função pivot_longer() faz o processo inverso de pivot_wider(). Ela transforma dados em formato largo para longo, ou seja, várias colunas são "desempacotadas" em linhas.
Sintaxe básica de pivot_longer():
  
  pivot_longer(data, cols = colunas_que_vão_ser_combinadas, names_to = "nome_da_nova_coluna", values_to = "valores")

data: O data frame original.
cols: As colunas que você deseja "combinar" (ou seja, transformar em uma única coluna de valores).
names_to: O nome da nova coluna que terá os nomes das colunas que foram combinadas.
values_to: O nome da nova coluna que conterá os valores das colunas combinadas.

Exemplo:
  
  Agora, vamos pegar o data frame dados_largos (já no formato largo) e transformá-lo de volta para o formato longo.

# Pivotar os dados para o formato longo
dados_longos <- dados_largos %>%
  pivot_longer(cols = `2020`:`2021`, names_to = "ano", values_to = "vendas")

# Exibir os resultados
print(dados_longos)

Resultado após pivot_longer():
  produto	ano	vendas
A	2020	100
A	2021	150
B	2020	200
B	2021	180
C	2020	250
C	2021	300

Agora os dados estão no formato original, onde cada linha é uma combinação de produto, ano e vendas.
4. Outras Considerações Importantes

Seleção de colunas: Ao usar pivot_wider() e pivot_longer(), é comum precisar selecionar quais colunas usar para names_from e values_from (ou cols, names_to e values_to), especialmente quando se trabalha com grandes conjuntos de dados.

Funções de agregação: Quando você usa pivot_wider() e há múltiplos valores para uma mesma combinação de chave, você pode usar a função values_fn para agregar esses valores. Por exemplo, você pode somar as vendas se houver múltiplos registros para o mesmo produto/ano.

Exemplo com agregação:
  
  # Suponha que temos vendas duplicadas por produto e ano
  dados <- data.frame(
    produto = c("A", "A", "B", "B", "C", "C", "A"),
    ano = c(2020, 2020, 2021, 2021, 2020, 2021, 2020),
    vendas = c(100, 200, 180, 220, 250, 300, 150)
  )

# Pivotar com agregação (somando as vendas)
dados_largos <- dados %>%
  pivot_wider(names_from = ano, values_from = vendas, values_fn = sum)

# Exibir o resultado
print(dados_largos)

Resultado com agregação:
  produto	2020	2021
A	300	150
B	NA	400
C	250	300

Aqui, as vendas de 2020 para o produto A foram somadas (100 + 200), e as vendas de 2021 para o produto B foram somadas também (180 + 220).
5. Resumo das Funções

pivot_wider(): Transforma dados do formato longo para largo. Você cria novas colunas a partir de uma variável.

pivot_wider(data, names_from = "coluna", values_from = "valores")

pivot_longer(): Transforma dados do formato largo para longo. Você "empacota" várias colunas em uma só.

pivot_longer(data, cols = c("coluna1", "coluna2"), names_to = "nova_coluna", values_to = "valores")

Função de agregação (values_fn): Quando há múltiplos valores para uma chave, você pode agregar os valores usando funções como sum(), mean(), etc.

6. Exemplos Práticos para Revisão

Agora, é hora de praticar! Tente os seguintes exercícios:
  
  Crie um data frame com dados de vendas de diferentes produtos em diferentes meses. Depois, use o pivot_wider() para transformar o mês em colunas e as vendas como valores.
Crie um data frame no formato largo, onde cada produto tem múltiplas vendas em diferentes anos. Use o pivot_longer() para transformar isso em formato longo.
Experimente o uso do values_fn para agregar dados ao fazer um pivot_wider().

Conclusão

Pivotagem é uma técnica fundamental para manipulação de dados, especialmente quando você está lidando com diferentes formatos de dados (longos e largos). Com as funções pivot_wider() e pivot_longer(), você pode facilmente reestruturar seus dados de acordo com as necessidades da análise. Lembre-se de praticar para se familiarizar com o uso dessas funções e entender como elas funcionam em diferentes cenários!
  
