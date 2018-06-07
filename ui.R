# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotly)

shinyUI(fluidPage(

  # Title
   titlePanel("Timber Volume"),

  ## Tabs for app and documentation
  tabsetPanel(
  
  ## App panel
  tabPanel("App",
  sidebarLayout(
      ## Sidebar with sliders
      sidebarPanel(
          sliderInput("Height", "Height of tree, feet:", 60, 90, value = 75),
          sliderInput("Girth", "Diameter of tree trunk, inches:", 5, 25, value = 15),
          tags$b("Predicted volume, cubic feet:"),
          textOutput("pred")
      ),
      ## Main panel with plot
      mainPanel(
          h4("Observed trees (green) and predicted tree (brown)"),
          h5("Point size is proportional to volume"),
          plotlyOutput("plot")
      ))
  ),
  ## Tab with documentation
  tabPanel("Documentation",
          tags$p("This apps predicts timber volume of trees, 
                   using a simple polynomial model."),
          tags$p("Move the sliders to select the dimensions of your tree. 
                  Predicted timber volume appears below the sliders."),
          tags$p("Green points on the plot represent points in the trees data set,
                  which comes included with Rstudio.
                  The brown point represents the predicted tree."),
          tags$p("Hover over points on the plot for precise tree dimensions.")     
  )
  ))
)