#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(fpc)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  data <- reactive({
    iris[, c(input$xVar, input$yVar)]
  }) 
  
  
  irisCluster <- reactive({
    
    if(input$method == "kmeans"){
      set.seed(1234)
      kmeans(data(), input$clustersNum, nstart = 20)
    }else if(input$method == "pamk"){
      set.seed(1234)
      pamk(data(),krange = input$clustersNum)
    }
    
  })
  
   
  output$distPlot <- renderPlot({
    
    palette(rainbow(10,s = 0.9))
    
    if(input$method == "kmeans"){
      plot(data(), col = irisCluster()$cluster, pch = 20, cex = 3)
      points(irisCluster()$centers, pch = 8, cex = 4, lwd = 4)
    }
    
    if(input$method == "pamk"){
      plot(data(),  col = irisCluster()$pamobject$clustering, pch = 20, cex = 3)
      points(irisCluster()$pamobject$medoids, pch = 8, cex = 4, lwd = 4)
    }
  
    
  })
  
  output$table <- renderTable({
    if(input$method == "kmeans"){
      as.data.frame.matrix(table(irisCluster()$cluster, iris$Species))
    }else if(input$method == "pamk"){
      as.data.frame.matrix(table(irisCluster()$pamobject$clustering, iris$Species))
    }
  })
  
})

