# 📦 Projeto de Análise de Dados: Centro de Entregas Brasileiro

## 📄 Descrição

Este projeto desafiador integra uma parcela do conhecimento adquirido durante os estudos com SQL para análise de dados. O objetivo é trabalhar com dados reais de um centro de entregas brasileiro, disponíveis publicamente no [Kaggle](https://www.kaggle.com). Permitindo que seja aplicado as habilidades em análise de dados aprendidas de forma prática e responsiva.

## 📥 Passos para o Projeto

1. **Download dos Datasets**: 
   - Acesse o link abaixo para baixar todos os arquivos CSV (será necessário criar uma conta gratuita no Kaggle):  
   [Kaggle - Brazilian Delivery Center](https://www.kaggle.com/nosbielcs/brazilian-delivery-center)

2. **Leia a Descrição dos Dados**: 
   - No mesmo link, você encontrará a descrição dos dados e detalhes sobre o cenário em que foram extraídos. É importante ler atentamente para compreender o que cada dataset representa (o texto está em português).

3. **Carregamento dos Dados no Banco de Dados**: 
   - Utilize o Table Import Wizard (mostrado na solução do exercício 3) para importar os dados no MySQL. Crie uma tabela para cada arquivo, usando o nome do arquivo como nome da tabela.
   - **Observações Importantes**:
     - Alguns arquivos têm milhões de registros, e o tempo de carga pode ser alto, então seja paciente ou faça o carregamento via terminal para que o processo seja rapido.
     - O arquivo `hubs.csv` contém caracteres especiais. Edite o arquivo para substituir "SÃO PAULO" por "SAO PAULO" (sem acento) para evitar problemas no MySQL Workbench.
     - O arquivo `deliveries.csv` pode apresentar erro em um dos IDs de driver. Se isso ocorrer, ignore ou substitua as duas vírgulas juntas por `,NULL,` em um editor de texto.

## ❓ Consultas SQL

Após carregar todos os arquivos, você poderá criar suas queries SQL para responder às seguintes perguntas:

1. Qual o número de hubs por cidade?
2. Qual o número de pedidos (orders) por status?
3. Qual o número de lojas (stores) por cidade dos hubs?
4. Qual o maior e o menor valor de pagamento (payment_amount) registrado?
5. Qual tipo de driver (driver_type) fez o maior número de entregas?
6. Qual a distância média das entregas por tipo de driver (driver_modal)?
7. Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?
8. Existem pedidos que não estão associados a lojas? Se sim, quantos?
9. Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?
10. Quantos pagamentos foram cancelados (chargeback)?
11. Qual foi o valor médio dos pagamentos cancelados (chargeback)?
12. Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?
13. Quais métodos de pagamento tiveram valor médio superior a 100?
14. Qual a média de valor de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?
15. Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type) teve média de valor de pedido (order_amount) maior que 450?
16. Qual o valor total de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)? Demonstre os totais intermediários e formate o resultado.
17. Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja 'FOOD', tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido (order_amount)?
18. Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi cancelado, algum hub_state teve total de valor do pedido superior a 100.000?
19. Em que data houve a maior média de valor do pedido (order_amount)?
20. Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)?

## 🛠️ Configuração do Ambiente

Para este projeto, você precisará dos seguintes softwares:

- **Banco de Dados Relacional** (ex: MySQL, PostgreSQL, SQL Server)
- **Ferramenta SQL** (ex: DBeaver, MySQL Workbench, pgAdmin)

⚠️ Certifique-se de que o banco de dados e as ferramentas estão configurados corretamente.

## 🤝 Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e enviar pull requests.
