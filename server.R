# This is the corresponding server.R file

#Let us perform a random forest model for the mtcars data set, the very first 
#   time that it was loaded. We will then use the model fit to predict new data
#   that would be entered by the user through the shiny web app UI.

library (caret)
library (randomForest)
fitControl = trainControl (method = "cv", number = 3)
rfFit = train (mpg ~ ., data = mtcars, method = "rf", trControl = fitControl, 
               verbose = FALSE)

#importance (rfFit)

#We find the below importance 
# IncNodePurity
# cyl     172.025395
# disp    299.026029
# hp      207.695016
# drat     35.174095
# wt      333.014762
# qsec     15.011274
# vs        3.181159
# am        1.243913
# gear      1.743137
# carb      7.719783

# To reduce the complexity in use input, we will refrain the model to use only
#   CYL, DISPLACEMENT, HP and WT for prediction.
rfFit = train (mpg ~ cyl + disp + hp + wt, data = mtcars, method = "rf", trControl = fitControl, 
               verbose = FALSE)

# Let us create a test DF for user input data. All initialized to 0s.
testData = mtcars [1,]
testData [1,] = 0

# Now let us move on to our shiny server

library (shiny)
shinyServer (function (input, output) {
    
    testData$cyl = reactive ({as.numeric (input$cyl)})
    testData$disp = reactive ({as.numeric (input$disp)})
    testData$hp = reactive ({as.numeric (input$hp)})
    testData$wt = reactive ({as.numeric (input$wt)})
    
    intVal = function (input) {
        input
    }
    
    output$cyl = renderText ({intVal(input$cyl)})
    output$disp = renderText ({intVal(input$disp)})
    output$hp = renderText ({intVal(input$hp)})
    output$wt = renderText ({intVal(input$wt)})
    
    predictMPG = function (cyl, disp, hp, wt) {
        testData$cyl = as.numeric (cyl)
        testData$disp = as.numeric (disp)
        testData$hp = as.numeric (hp)
        testData$wt = as.numeric (wt)
        
        paste (round (predict (rfFit, testData), 1), "mpg")
    }
    
    output$mpg = renderText ({
                    predictMPG(input$cyl, input$disp, input$hp, input$wt)})
}
)

