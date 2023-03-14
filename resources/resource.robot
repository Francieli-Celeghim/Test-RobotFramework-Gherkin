*** Settings ***
Library       SeleniumLibrary

*** Variables ***
${BROWSER}                    chrome
${URL}                        https://www.amazon.com.br/


*** Keywords ***
Abrir o navegador
  Open Browser      browser=${BROWSER}
  Maximize Browser Window

Fechar o navegador
  Capture Page Screenshot
  Close Browser

Acessar a home page do site Amazon.com.br 
  Go To             url=${URL}

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
  Input Text                        locator=twotabsearchtextbox               text=${PRODUTO}

Clicar no botão de pesquisa
  Click Element                     locator=nav-search-submit-button

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
  Wait Until Element Is Visible     locator=(//span[contains(.,'${PRODUTO}')])[2]

Clicar no "${PRODUTO}"
  Click Element                     locator=(//span[contains(.,'${PRODUTO}')])[2]

Adicionar o produto "${PRODUTO}" no carrinho
  Wait Until Element Is Visible     locator=add-to-cart-button
  Click Element                     locator=add-to-cart-button

Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
  Wait Until Element Is Visible     locator=//div[@class='a-section a-padding-medium sw-atc-message-section'][contains(.,'Adicionado ao carrinho') and contains(.,'${PRODUTO}')]

Clicar no "Ir para o carrinho"
  Wait Until Element Is Visible     locator=//a[contains(@data-csa-c-type,'button')]
  Click Element                     locator=//a[contains(@data-csa-c-type,'button')]

Remover o produto "${PRODUTO}" do carrinho
  Wait Until Element Is Visible     locator=//input[contains(@aria-label,'Excluir ${PRODUTO}')]
  Click Element                     locator=//input[contains(@aria-label,'Excluir ${PRODUTO}')]

Verificar se o carrinho fica vazio
  Wait Until Element Is Visible     locator=//h1[contains(.,'Seu carrinho de compras da Amazon está vazio.')]

# GHERKIN STEPS
Dado que estou na home page da Amazon.com.br
  Acessar a home page do site Amazon.com.br
  Digitar o nome de produto "Xbox Series S" no campo de pesquisa
  Clicar no botão de pesquisa

Quando adicionar o produto "Console Xbox Series S" no carrinho
  Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
  Adicionar o produto "Console Xbox Series S" no carrinho

Então o produto "Console Xbox Series S" deve ser mostrado no carrinho
  Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso 

Quando remover o produto "Console Xbox Series S" do carrinho
  Remover o produto "Console Xbox Series S" do carrinho

Então o carrinho deve ficar vazio
  Verificar se o carrinho fica vazio