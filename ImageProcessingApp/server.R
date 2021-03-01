#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(magick)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$originalUploadedImage <- renderPlot({
        req(input$originalImage)
        tryCatch(
            plot(image_blur(image_read(input$originalImage$datapath),
                            radius = input$radBlurImage,
                            sigma = input$stdBlurImage)),
            catch = function(e) stop(safeError(e))
        )
    })
    output$rgbFilter <- renderPlot({
        req(input$originalImage)
        tryCatch(
            plot(image_modulate(
                image_read(input$originalImage$datapath),
                brightness = input$brightnessImage,
                saturation = input$saturationImage,
                hue = input$hueImage)),
            catch = function(e) stop(safeError(e))
        )
    })
    output$modMedian <- renderPlot({
        req(input$originalImage)
        tryCatch(
            plot(image_despeckle(
                image_read(input$originalImage$datapath),
                times = input$despeckleId)),
            catch = function(e) stop(safeError(e))
        )
    })
    output$modCharcoal <- renderPlot({
        req(input$originalImage)
        tryCatch(
            plot(image_charcoal(
                image_read(input$originalImage$datapath), 
                radius = input$charcoalId, sigma = input$stdCharcoalId)),
            catch = function(e) stop(safeError(e))
        )
    })
    output$convolveImage <- renderPlot({
        req(input$originalImage)
        tryCatch(
            plot(image_convolve(
                image_read(input$originalImage$datapath),
                kernel = matrix(data = c(
                    input$a00, input$a01, input$a02,
                    input$a10, input$a11, input$a12,
                    input$a20, input$a21, input$a22
                ), nrow = 3, ncol = 3, byrow = TRUE)
            )),
            catch = function(e) stop(safeError(e))
        )
    })
    output$modEdge <- renderPlot({
        req(input$originalImage)
        tryCatch(
            plot(image_edge(
                image_read(input$originalImage$datapath), radius = input$edgeId)),
            catch = function(e) stop(safeError(e))
        )
    })
    output$modOilpain <- renderPlot({
        req(input$originalImage)
        tryCatch(
            plot(image_oilpaint(
                image_read(input$originalImage$datapath), 
                radius = input$oilpainId)),
            catch = function(e) stop(safeError(e))
        )
    })
    output$inverseImage <- renderPlot({
        req(input$originalImage)
        tryCatch(
            plot(image_negate(
                image_read(input$originalImage$datapath))),
            catch = function(e) stop(safeError(e))
        )
    })
    output$noisedImage <- renderPlot({
        req(input$originalImage)
        typeNoise <- switch (input$noisyId,
                             "Gaussian" = "gaussian",
                             "Impulse" = "impulse",
                             "Poisson" = "poisson")
        tryCatch(
            plot(image_noise(
                image_read(input$originalImage$datapath),
                noisetype = typeNoise
            )),
            catch = function(e) stop(safeError(e))
        )
    })
    output$monochromeImage <- renderPlot({
        req(input$originalImage)
        tryCatch(
            plot(image_quantize(
                image_read(input$originalImage$datapath),
                colorspace = "gray"
            )),
            catch = function(e) stop(safeError(e))
        )
    })
    output$modEmboss <- renderPlot({
        req(input$originalImage)
        tryCatch(
            plot(image_emboss(
                image_read(input$originalImage$datapath),
                radius = input$embossId, sigma = 0.5)), 
            catch = function(e) stop(safeError(e))
        )
    })
    output$modEmplode <- renderPlot({
        req(input$originalImage)
        tryCatch(
            plot(image_implode(
                image_read(input$originalImage$datapath), 
                factor = input$implodeId)), catch = function(e) stop(safeError(e))
        )
    })
})
