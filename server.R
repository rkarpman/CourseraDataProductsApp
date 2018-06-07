# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotly)

shinyServer(function(input, output) {
    options(warn = -1)
    ## Regression model predicts volume from Height, Girth
    model <- lm(Volume ~ I(Girth^2 * Height), data = trees)
    myPred <- reactive({predict(model, 
                     newdata = data.frame(Height = input$Height, Girth = input$Girth))})
    output$pred <- renderText({myPred()})
    output$plot <- renderPlotly({
    newPoint <- data.frame(Height = input$Height, Girth = input$Girth, Volume = round(myPred(), 2))
    p <- ggplot(trees, aes(x = Height, 
                           y = Girth, 
                           size = Volume, 
                           text = paste('Height: ', Height,
                                        '<br> Girth: ', Girth,
                                        '<br>Volume: ', Volume))) +
        geom_point(color = "green4", alpha = 0.4) +
        geom_point(data = newPoint, color = "sienna4", alpha = 0.8) +
        xlim(60, 90) +
        ylim(5, 25)
    ggplotly(p, tooltip = "text")
           })

})
