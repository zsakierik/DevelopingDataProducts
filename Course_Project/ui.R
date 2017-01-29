#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(fpc)


shinyUI(fluidPage(
  

  titlePanel("Iris clustering method"),
  

  sidebarLayout(
    sidebarPanel(
      p("We have to specify the number of clusters we want the data to be Grouped into. 
        The algorithm randomly assigns each observation to a cluster, and Finds the centroid of each cluster."),
      h3("Settings"),
       sliderInput("clustersNum",
                   "Number of cluster:",
                   min = 1,
                   max = 10,
                   value = 3),
       selectInput('xVar', 'X Variable', names(iris[1:4]), selected=names(iris)[[1]]),
       selectInput('yVar', 'Y Variable', names(iris[1:4]), selected=names(iris)[[2]]),
       selectInput('method', 'Methode', c("kmeans","pamk")),
       
       
       hr(),
       h3("Data"),
       helpText("This famous (Fisher's or Anderson's) iris data set gives the measurements in 
                centimeters of the variables sepal length and width and petal length and width, 
                respectively, for 50 flowers from each of 3 species of iris. The species are Iris setosa, versicolor, and virginica.
                Iris is a data frame with 150 cases (rows) and 5 variables (columns) named Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, and Species."),
       hr(),
       h3("Methode"),
       helpText("kmeans methode is k-means clustering"),
       helpText("pamk methode is k-medoids clustering")
    ),
    

    mainPanel(
      h2("Clusters Plot"),
      p("asterisk : centers of cluster"),
       plotOutput("distPlot"),
       
       h2("Clusters Table"),
       p("Compare the original values"),
       tableOutput("table")
       
    )
  )
))
