# 1- Qual o número de hubs por cidade?
SELECT hub_city, COUNT(hub_id) as Numero_hubs
FROM exercicio4.hubs
GROUP BY hub_city
ORDER BY Numero_hubs DESC;

# 2- Qual o número de pedidos (orders) por status?
SELECT order_status, COUNT(order_id) as Numero_pedidos
FROM exercicio4.orders
GROUP BY order_status;

# 3- Qual o número de lojas (stores) por cidade dos hubs?
SELECT H.hub_city, COUNT(S.store_id) as Numero_stores
FROM exercicio4.hubs as H, exercicio4.stores as S
WHERE H.hub_id = S.hub_id
GROUP BY H.hub_city
ORDER BY Numero_stores DESC;

# 4- Qual o maior e o menor valor de pagamento (payment_amount) registrado?
SELECT MAX(payment_amount) as Maior_pagamento, MIN(payment_amount) as Menor_pagamento
FROM exercicio4.payments
WHERE payment_status = 'PAID';

# 5- Qual tipo de driver (driver_type) fez o maior número de entregas?
SELECT driver_type, COUNT(driver_id) as Numero_entregas
FROM exercicio4.drivers
GROUP BY driver_type
HAVING Numero_entregas = (
    SELECT MAX(contagem) 
    FROM (SELECT COUNT(driver_id) as contagem
			FROM exercicio4.drivers
			GROUP BY driver_type
			) AS subquery);
            
# 6- Qual a distância média das entregas por tipo de driver (driver_modal)?
SELECT A.driver_modal, ROUND(AVG(B.delivery_distance_meters),2) as Distancia_media
FROM exercicio4.drivers as A 
INNER JOIN exercicio4.deliveries as B
ON A.driver_id = B.driver_id
GROUP BY A.driver_modal;

# 7- Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?
SELECT A.store_name, ROUND(AVG(B.order_amount), 2) as Valor_medio_pedido
FROM exercicio4.stores as A
INNER JOIN exercicio4.orders as B
ON A.store_id = B.store_id
GROUP BY A.store_name
ORDER BY Valor_medio_pedido DESC;

# 8- Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?
SELECT COALESCE(B.store_name, 'SEM LOJA') as Store, COUNT(A.order_id) as Contagem
FROM exercicio4.orders as A LEFT JOIN exercicio4.stores as B
ON A.store_id = B.store_id
#WHERE B.store_name IS NULL
GROUP BY Store
ORDER BY Store;

# 9- Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?
SELECT A.channel_name, ROUND(SUM(B.order_amount), 2) as valor_total
FROM exercicio4.channels as A, exercicio4.orders as B
WHERE A.channel_id = B.channel_id
AND A.channel_name = 'FOOD PLACE';

# 10- Quantos pagamentos foram cancelados (chargeback)?
SELECT payment_status, COUNT(payment_id) as Contagem
FROM exercicio4.payments
WHERE payment_status = 'CHARGEBACK';

# 11- Qual foi o valor médio dos pagamentos cancelados (chargeback)?
SELECT payment_status, ROUND(AVG(payment_amount), 2) as Valor_medio
FROM exercicio4.payments 
WHERE  payment_status = 'CHARGEBACK';

# 12- Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?
SELECT payment_method, ROUND(AVG(payment_amount), 2) as Pagamento_medio
FROM exercicio4.payments
GROUP BY payment_method
ORDER BY Pagamento_medio DESC;

# 13- Quais métodos de pagamento tiveram valor médio superior a 100?
SELECT payment_method, ROUND(AVG(payment_amount),2) as Pagamento_medio
FROM exercicio4.payments
GROUP BY payment_method
HAVING Pagamento_medio > 100
ORDER BY Pagamento_medio DESC;

# 14- Qual a média de valor de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?
SELECT D.channel_type, C.store_segment, B.hub_state, ROUND(AVG(A.order_amount), 2) as Valor_medio
FROM (((exercicio4.hubs as B INNER JOIN exercicio4.stores as C ON B.hub_id = C.hub_id) 
INNER JOIN exercicio4.orders as A ON C.store_id = A.store_id)
INNER JOIN exercicio4.channels as D ON A. channel_id = D.Channel_id)
GROUP BY D.channel_type, C.store_segment, B.hub_state
ORDER BY D.channel_type;

# 15- Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type) teve média de valor de pedido (order_amount) maior que 450?
SELECT D.channel_type, C.store_segment, B.hub_state, ROUND(AVG(A.order_amount), 2) as Valor_medio
FROM (((exercicio4.hubs as B INNER JOIN exercicio4.stores as C ON B.hub_id = C.hub_id) 
INNER JOIN exercicio4.orders as A ON C.store_id = A.store_id)
INNER JOIN exercicio4.channels as D ON A. channel_id = D.Channel_id)
GROUP BY D.channel_type, C.store_segment, B.hub_state
HAVING Valor_medio > 450
ORDER BY D.channel_type;

# 16- Qual o valor total de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)? Demonstre os totais intermediários e formate o resultado.
SELECT 
	IF(GROUPING(D.channel_type), 'Total de Todos os Canais', D.channel_type) AS Channel,
	IF(GROUPING(C.store_segment), 'Total de Todos os segmentos', C.store_segment) AS Segment, 
	IF(GROUPING(B.hub_state), 'Total de Todos os estados', B.hub_state) AS States, 
	ROUND(SUM(A.order_amount), 2) as Valor_total
FROM (((exercicio4.hubs as B INNER JOIN exercicio4.stores as C ON B.hub_id = C.hub_id)
INNER JOIN exercicio4.orders as A ON C.store_id = A.store_id)
INNER JOIN exercicio4.channels as D ON A. channel_id = D.Channel_id)
GROUP BY D.channel_type, C.store_segment, B.hub_state WITH ROLLUP
ORDER BY GROUPING(hub_state);

# 17- Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja 'FOOD', tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido (order_amount)?
SELECT O.order_status, C.channel_type, S.store_segment, H.hub_state, ROUND(AVG(O.order_amount), 2) as Valor_Medio
FROM (((exercicio4.hubs as H INNER JOIN exercicio4.stores as S ON H.hub_id = S.hub_id)
INNER JOIN exercicio4.orders as O ON S.store_id = O.store_id)
INNER JOIN exercicio4.channels as C ON O.channel_id = C.channel_id)
WHERE O.order_status = 'CANCELED' 
AND C.channel_type = 'MARKETPLACE' 
AND S.store_segment = 'FOOD' 
AND H.hub_state = 'RJ';

# 18- Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi cancelado, algum hub_state teve total de valor do pedido superior a 100.000?
SELECT O.order_status, C.channel_type, S.store_segment, H.hub_state, ROUND(SUM(O.order_amount), 2) as Valor_Total_Pedidos
FROM (((exercicio4.hubs as H INNER JOIN exercicio4.stores as S ON H.hub_id = S.hub_id)
INNER JOIN exercicio4.orders as O ON S.store_id = O.store_id)
INNER JOIN exercicio4.channels as C ON O.channel_id = C.channel_id)
GROUP BY O.order_status, C.channel_type, S.store_segment, H.hub_state
HAVING O.order_status = 'CANCELED' 
AND C.channel_type = 'MARKETPLACE' 
AND S.store_segment = 'FOOD' 
AND Valor_Total_Pedidos > 100000
ORDER BY Valor_Total_Pedidos DESC;

# 19- Em que data houve a maior média de valor do pedido (order_amount)? Dica: Pesquise e use a função SUBSTRING().
SELECT SUBSTRING(order_moment_created, 1, 9) as Data_Pedido, ROUND(AVG(order_amount), 2) as Valor_Medio_Pedido
FROM exercicio4.orders
GROUP BY Data_Pedido
HAVING Valor_Medio_Pedido = (SELECT MAX(Valor_Medio_Pedido)
                             FROM (SELECT SUBSTRING(order_moment_created, 1, 8) as Data_Pedido, ROUND(AVG(order_amount), 2) as Valor_Medio_Pedido
								  FROM exercicio4.orders
                                  GROUP BY Data_Pedido) as Subquery)
ORDER BY Valor_Medio_Pedido DESC;

# 20- Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)? Dica: Use a função SUBSTRING().
SELECT SUBSTRING(order_moment_created, 1, 9) as Data_Pedido, MIN(order_amount) as Valor_Min_Pedido
FROM exercicio4.orders
GROUP BY Data_Pedido
HAVING Valor_Min_Pedido = 0
ORDER BY Data_Pedido ASC;