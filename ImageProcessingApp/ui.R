#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
    fluidPage(
        tags$head(tags$link(rel="shortcut icon", href="www/ai_artificial_intelligence_laptop_software_robot_icon_179480")),
        #shinythemes::themeSelector(),
        hr(),
        h1("Shiny", span("Image Processing", style = "font-weight: 300"), 
           style = "font-family: 'Source Sans Pro';
           color: #fff; text-align: center;
           background-image: url('texturebg.png');
           padding: 20px;
           border-radius : 1pc;
           box-shadow : 1px 2px 2pc #92b2ff;
           text-shadow : 1px 2px 2px #92b2ff;"),
        hr(),
        tabsetPanel(
            tabPanel(
                style = "box-shadow : 1px 2px 2pc #92b2ff",
                title = "Original Image",
                sidebarLayout(
                    sidebarPanel(
                        h3(icon("file-image"), "Upload Image"),
                        fileInput(inputId = "originalImage", label = "",
                                  accept = c("image/png", "image/jpeg")),
                        h3("Blur Image"),
                        sliderInput(inputId = "radBlurImage", label = "radiusValue",
                                    min = 0, max = 20, value = 10),
                        numericInput(inputId = "stdBlurImage", label = "Standard Deviation",
                                     min = 0, max = 10, value = 0.5, step = 0.1)
                    ),
                    mainPanel(plotOutput("originalUploadedImage"), 
                              style = "background-image : url('776716658.png');
                              background-repeat : no-repeat;
                              background-position: center;")
                )
            ),
            tabPanel(
                style = "box-shadow : 1px 2px 2pc #92b2ff",
                title = "RGB Filtering",
                sidebarLayout(
                    sidebarPanel(
                        sliderInput(inputId = "brightnessImage", label = "Brightness",
                                    min = 0, max = 255, value = 120),
                        sliderInput(inputId = "saturationImage", label = "Saturation",
                                    min = 0, max = 255, value = 20),
                        sliderInput(inputId = "hueImage", label = "Hue",
                                    min = 0, max = 255, value = 20)
                    ),
                    mainPanel(plotOutput("rgbFilter"),
                              style = "background-color: rgb(65, 137, 199);
                              background-image : url('hexlogo.png');
                              background-repeat : no-repeat;
                              background-position: center;")
                )
            ),
            tabPanel(
                style = "box-shadow : 1px 2px 2pc #92b2ff",
                title = "Median Filtering",
                sidebarLayout(
                    sidebarPanel(
                        sliderInput(inputId = "despeckleId", label = "Median Filter",
                                    min = 0, max = 50, value = 1)
                    ),
                    mainPanel(plotOutput("modMedian"),
                              style = "background-image : url('776716658.png');
                              background-repeat : no-repeat;
                              background-position: center;")
                )
            ),
            tabPanel(
                style = "box-shadow : 1px 2px 2pc #92b2ff",
                title = "Charcoal",
                sidebarLayout(
                    sidebarPanel(
                        sliderInput(inputId = "charcoalId", label = "radiusCharcoal",
                                    min = 0, max = 20, value = 1),
                        numericInput(inputId = "stdCharcoalId", 
                                     label = "Standard Deviation", 
                                     min = 0.0, max = 1.5, value = 0.5, step = 0.1)
                        
                    ),
                    mainPanel(plotOutput("modCharcoal"),
                              style = "background-color: rgb(65, 137, 199);
                              background-image : url('hexlogo.png');
                              background-repeat : no-repeat;
                              background-position: center;")
                )
            ),
            tabPanel(
                style = "box-shadow : 1px 2px 2pc #92b2ff",
                title = "Convolution",
                sidebarLayout(
                    sidebarPanel(
                        h4("3x3 Matrix Kernel"),
                        width = 5,
                        fluidRow(
                            column(
                                numericInput(inputId = "a00", label = "00",
                                             min = -10, max = 10, value = -1, step = 0.1),
                                width = 4
                            ),
                            column(
                                numericInput(inputId = "a01", label = "01",
                                             min = -10, max = 10, value = 0, step = 0.1),
                                width = 4
                            ),
                            column(
                                numericInput(inputId = "a02", label = "02",
                                             min = -10, max = 10, value = 1, step = 0.1),
                                width = 4
                            )
                        ),
                        fluidRow(
                            column(
                                numericInput(inputId = "a10", label = "10",
                                             min = -10, max = 10, value = -2, step = 0.1),
                                width = 4,
                            ),
                            column(
                                numericInput(inputId = "a11", label = "11",
                                             min = -10, max = 10, value = 0, step = 0.1),
                                width = 4
                            ),
                            column(
                                numericInput(inputId = "a12", label = "12",
                                             min = -10, max = 10, value = 2, step = 0.1),
                                width = 4
                            )
                        ),
                        fluidRow(
                            column(
                                numericInput(inputId = "a20", label = "20",
                                             min = -10, max = 10, value = -1, step = 0.1),
                                width = 4
                            ),
                            column(
                                numericInput(inputId = "a21", label = "21",
                                             min = -10, max = 10, value = 0, step = 0.1),
                                width = 4
                            ),
                            column(
                                numericInput(inputId = "a22", label = "22",
                                             min = -10, max = 10, value = 1, step = 0.1),
                                width = 4
                            )
                        )
                    ),
                    mainPanel(plotOutput("convolveImage"),
                              style = "background-image : url('776716658.png');
                              background-repeat : no-repeat;
                              background-position: center;")
                )
            ),
            tabPanel(
                style = "box-shadow : 1px 2px 2pc #92b2ff",
                title = "Edge Detection",
                sliderInput(inputId = "edgeId", label = "radiusEdge",
                            min = 0, max = 20, value = 1),
                plotOutput("modEdge")
            ),
            tabPanel(
                style = "box-shadow : 1px 2px 2pc #92b2ff",
                title = "Oil Paint",
                sliderInput(inputId = "oilpainId", label = "oilpainRadius",
                            min = 0, max = 20, value = 1),
                plotOutput("modOilpain")
            ),
            tabPanel(
                style = "box-shadow : 1px 2px 2pc #92b2ff",
                title = "Negate",
                plotOutput("inverseImage")
            ),
            tabPanel(
                style = "box-shadow : 1px 2px 2pc #92b2ff",
                title = "Noise",
                sidebarLayout(
                    sidebarPanel(
                        selectInput(inputId = "noisyId", label = "Type",
                                    choices = c("Gaussian", "Impulse", "Poisson"))
                    ),
                    mainPanel(plotOutput("noisedImage"),
                              style = "background-color: rgb(65, 137, 199);
                              background-image : url('hexlogo.png');
                              background-repeat : no-repeat;
                              background-position: center;")
                )
            ),
            tabPanel(
                style = "box-shadow : 1px 2px 2pc #92b2ff",
                title = "Monochrome",
                plotOutput("monochromeImage")
            ),
            tabPanel(
                style = "box-shadow : 1px 2px 2pc #92b2ff",
                title = "Emboss",
                sliderInput(inputId = "embossId", label = "embossRadius",
                            min = 0, max = 20, value = 1),
                plotOutput("modEmboss")
            ),
            tabPanel(
                style = "box-shadow : 1px 2px 2pc #92b2ff",
                title = "Emplode",
                sliderInput(inputId = "implodeId", label = "implodeRadius",
                            min = 0, max = 2, value = 0.5, step = 0.1),
                plotOutput("modEmplode")
            )
        ),
        hr(),
        h3("version 1.2", 
           style = "font-family: 'Source Sans Pro';
           color: #fff; text-align: center;
           background-image: url('texturebg.png');
           padding: 2pc;
           border-radius : 1pc;
           box-shadow : 1px 2px 2pc #92b2ff;
           text-shadow : 1px 2px 2px #92b2ff;"),
        hr()
    )
)
