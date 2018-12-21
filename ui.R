library(shiny)

shinyUI(fluidPage(
  titlePanel("Iris Species Predictor"),
  
  sidebarLayout(
      
    sidebarPanel(
       p('Type in sepal length, sepal width, petal length, and petal width, 
          then click "submit" button to predict.'),
       p('The submit point will be shown in the following plots as a black triangle after submit.'),
       numericInput('sl', 'Sepal Length in cm', value = 0, min = 0),
       numericInput('sw', 'Sepal Width in cm', value = 0, min = 0),
       numericInput('pl', 'Petal Length in cm', value = 0, min = 0),
       numericInput('pw', 'Petal Width in cm', value = 0, min = 0),
       submitButton('Submit'),
       textOutput('text1')
    ),
    
    mainPanel(
       h3('Predicted Iris Species:'),
       h3(textOutput('pred')),
       plotOutput('sepalplot'),
       plotOutput('petalplot')
    )
  )
))
