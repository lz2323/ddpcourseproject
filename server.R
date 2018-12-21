library(shiny)
library(randomForest)
library(ggplot2)

data("iris")
set.seed(335)
mdl.rf <- randomForest(Species ~ ., data = iris, ntree = 21)

sep.ggplot <- ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length, color = Species)) + 
                      geom_point(size = 3) + labs(title = 'Sepal Length vs. Sepal Width')
pet.ggplot <- ggplot(data = iris, aes(x = Petal.Width, y = Petal.Length, color = Species)) +
                      geom_point(size = 3) + labs(title = 'Petal Length vs. Petal Width')

shinyServer(function(input, output) {
    
  modelPredict <- reactive({
      predict(mdl.rf, newdata = data.frame(Sepal.Length = input$sl, Sepal.Width = input$sw,
                                              Petal.Length =input$pl, Petal.Width = input$pw))
  })
  
  output$pred <- renderText({
    p <- modelPredict()
    as.character(p)
  })
  
  plot1 <- reactive({
      if (input$sl*input$sw*input$pl*input$pw) {
          sep.ggplot + 
              geom_point(aes(x = input$sw, y = input$sl), color = 'black',shape =2, size = 3)
      } else {
          sep.ggplot
      }
  })
  plot2 <- reactive({
      if (input$sl*input$sw*input$pl*input$pw) {
          pet.ggplot + 
              geom_point(aes(x = input$pw, y = input$pl), color = 'black',shape =2, size = 3)
      } else {
          pet.ggplot
      }
  })
  
  output$sepalplot <- renderPlot({ 
      plot1()
  })
  output$petalplot <- renderPlot({
      plot2()
  })

  message <- reactive({ 
      if (input$sl*input$sw*input$pl*input$pw == 0) {
          t <- 'Please make sure all inputs are greater than 0.'
      }
  })    
  
  output$text1 <- renderText({
      message()
  })
  
  
})
