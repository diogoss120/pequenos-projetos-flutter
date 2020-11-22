O app 'Acompanhamento Financeiro' possibilita que usuários saibam quando custa o real brasileiro convertido de outras moedas estrangeiras, como dolar, euro, bitcoin, e outras,
também permite que o usuário escolha uma quantidade de dias anteriores para que seja possivel ver um pequeno histórico das converções moedas.
O app faz requisições http assíncronas ao site 'https://docs.awesomeapi.com.br/' através de sua api baseado nas opções selecionadas pelo usuário,
a api retorna um json, então percorro ele, filtrando as informações e exibo para o usuário.

No app 'Cidades dos Estados' listo todos os estados brasileiros e possibilito que o usuário possa selecionar o estado desejado e que ver todas as cidades que fazem parte dele.
Para listar os estados e as cidades eu faço requisiçoes http à api do ibge de localidades brasileiras 'https://servicodados.ibge.gov.br/api/docs/localidades', 
como resposta ela me retorna um json, onde eu leio os dados e exibo ao usuário.
