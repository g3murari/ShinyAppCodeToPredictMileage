# This is the ui.R for the shiny app

library(shiny)

shinyUI (pageWithSidebar (

    headerPanel ("Predict Mileage - Miles Per Gallon (MPG) for Cars"),
    
    sidebarPanel (
        h2 ('Enter Car Details'),
        selectInput ('cyl','Number of Cylinders', sort (unique (mtcars$cyl))),
        sliderInput ('disp','Vehicle Displacement in cu.in', 
                     min = min (mtcars$disp), max = max (mtcars$disp),
                     value = median (mtcars$disp)),
        sliderInput ('hp','Gross horsepower', 
                     min = min (mtcars$hp), max = max (mtcars$hp),
                     value = median (mtcars$hp)),
        sliderInput ('wt','Weight (lb/1000)', 
                     min = min (mtcars$wt), max = max (mtcars$wt),
                     value = median (mtcars$wt))
        ),
    
    mainPanel (
    
        h2 ('Predicted Miles/(US) gallon'),
        h3 (textOutput ('mpg')),
        tags$style ("#mpg{color: red;
                                 font-size: 25px;
                                 font-style: bold;
                                 }"
        ),
        
        h2 ('You Entered'),
        h5 (strong ('Number of Cylinders: ')), 
        h5 (textOutput ('cyl')), 
        h5 (strong ('Vehicle Displacement in cu.in: ')), 
        h5 (textOutput ('disp')),
        h5 (strong ('Gross horsepower: ')), 
        h5 (textOutput ('hp')),
        h5 (strong ('Weight (lb/1000): ')), 
        h5 (textOutput ('wt')),
        
        tags$div(class="modal-footer", 
                 "Note: This is a course project by Kanthimathi Gayatri Sukumar 
            for the 'Developing Data Projects' on Coursera from Johns Hopkins Bloomberg School of Public
            Health. The dataset used for prediction is 'mtcars' in R and the 
            prediction algorithm is Random Forest.")
        )
    
))