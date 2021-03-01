#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(plotly)

ui <- fluidPage(
  fluidPage(
      hr(),
      h1("Monte Carlo Simulation"),
      h3("version 1.0"),
      hr(),
      fluidRow(
          column(width = 12, DT::dataTableOutput(outputId = "dframeId"))
      ),
      fluidRow(
          column(width = 12, verbatimTextOutput(outputId = "sumarize"))
      ),
      fluidRow(
          column(width = 12, sidebarLayout(
              sidebarPanel(
                  numericInput(inputId = "surveyed", label = "People has been surveyed",
                               min = 10, max = 1000000, value = 100),
                  numericInput(inputId = "nDays", label = "Due to (in day)", 
                               min = 5, max = 100, value = 15),
                  selectInput(inputId = "choiceChili", label = "Chili",
                              choices = c("Red", "Green", "Cayenne"))
              ),
              mainPanel(
                  tabsetPanel(
                      tabPanel(
                          title = "Probability",
                          DT::dataTableOutput(outputId = "probChili")
                      ),
                      tabPanel(
                          title = "Probability Mass Function", 
                          plotlyOutput(outputId = "plotProbabilityMassFunction")),
                      tabPanel(
                          title = "Cumulative Probability",
                          plotlyOutput("plotCumulativeProbability")),
                      tabPanel(
                          title = "Monte Carlo",
                          verbatimTextOutput(outputId = "monteCarlo")
                      )
                  )
              )
          ))
      ),
      hr(),
  )
)

server <- function(input, output, session) {
    beratPembelian <- c(5, 10, 15, 20, 25)
    redChili <- c(10, 19, 31, 25, 15)
    greenChili <- c(12, 28, 35, 18, 7)
    cayenne <- c(6, 18, 21, 33, 22)
    dframe <- data.frame("berat.pembelian" = beratPembelian,
                         "red.chili" = redChili,
                         "green.chili" = greenChili,
                         "cayennee.chili" = cayenne)
    switchChili <- reactive({
        switch (input$choiceChili,
                "Red" = redChili,
                "Green" = greenChili,
                "Cayenne" = cayenne)
    })
    output$dframeId <- DT::renderDataTable({
        #DT::datatable(dframe)
        dframe
    })
    output$sumarize <- renderPrint({
        print(tibble(beratPembelian, redChili, greenChili, cayenne))
        print("Data Descriptive")
        summary(tibble(beratPembelian, redChili, greenChili, cayenne))
    })
    output$probChili <- DT::renderDataTable({
        nOfCustomer <- switchChili()
        cmltvProbChili <- c()
        probChili <- nOfCustomer / sum(nOfCustomer)
        for (i in 1:length(probChili)) {
            cmltvProbChili[i] <- sum(probChili[1:i])
        }
        tibble(beratPembelian, probChili, cmltvProbChili, nOfCustomer)
    })
    output$plotProbabilityMassFunction <- renderPlotly({
        nOfCustomer <- switchChili()
        probChili <- nOfCustomer / sum(nOfCustomer)
        probDataFrame <- tibble(beratPembelian, probChili)
        ggplotly(ggplot(probDataFrame, aes(beratPembelian, probChili)) + 
            geom_bar(stat = "identity", color = "skyblue", aes(fill = probChili)))
    })
    output$plotCumulativeProbability <- renderPlotly({
        nOfCustomer <- switchChili()
        cmltvProbChili <- c()
        probChili <- nOfCustomer / sum(nOfCustomer)
        for (i in 1:length(probChili)) {
            cmltvProbChili[i] <- sum(probChili[1:i])
        }
        probDataFrame <- tibble(beratPembelian, cmltvProbChili)
        ggplotly(ggplot(probDataFrame, aes(beratPembelian, cmltvProbChili)) +
            geom_point(color = "darkblue") + geom_step(color = "blue"))
    })
    output$monteCarlo <- renderPrint({
        nOfCustomer <- switchChili()
        cmltvProbChili <- c()
        probChili <- nOfCustomer / sum(nOfCustomer)
        for (i in 1:length(probChili)) {
            cmltvProbChili[i] <- sum(probChili[1:i])
        }
        cmltvProbChiliInPercent <- cmltvProbChili * 100
        NUMBERSURVEYED <- input$surveyed
        vectMonteCarlo <- c()
        for (days in 1:input$nDays) {
            getRandomNumber <- runif(n = 1, min = 1, max = NUMBERSURVEYED)
            if (getRandomNumber > 0 && getRandomNumber <= cmltvProbChiliInPercent[1])
                vectMonteCarlo[days] <- nOfCustomer[1]
            else if (getRandomNumber > cmltvProbChiliInPercent[1] && getRandomNumber <= cmltvProbChiliInPercent[2])
                vectMonteCarlo[days] <- nOfCustomer[2]
            else if (getRandomNumber > cmltvProbChiliInPercent[2] && getRandomNumber <= cmltvProbChiliInPercent[3])
                vectMonteCarlo[days] <- nOfCustomer[3]
            else if (getRandomNumber > cmltvProbChiliInPercent[3] && getRandomNumber <= cmltvProbChiliInPercent[4])
                vectMonteCarlo[days] <- nOfCustomer[4]
            else if (getRandomNumber > cmltvProbChiliInPercent[4] && getRandomNumber <= cmltvProbChiliInPercent[5])
                vectMonteCarlo[days] <- nOfCustomer[5]
        }
        nday <- seq(1, input$nDays)
        monteCarloEstimation <- tibble(nday, vectMonteCarlo)
        print(monteCarloEstimation)
        print("Data Descriptive")
        print(summary(monteCarloEstimation))
        paste("Total customer for the next", input$nDays, "day is", sum(vectMonteCarlo))
    })
}

shinyApp(ui, server)