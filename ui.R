# This is ui.R for building first Shiny Application
# It is reading user inputs and passing those to server for preocessing
# It is using Tab panel to display help content for documentation purpose.

library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Health Risk Prediction!"),
  sidebarPanel(
    h3('Input Parameters'),
    numericInput('weight','Weight (Lbs)',100,min=0,max=300,step=1),
    numericInput('height','Height (Inches)',60,min=0,max=300,step=1),
    checkboxGroupInput("conditions","Existing conditions",
        c("Diabetic"="1", "High Blood Pressure"="2","Thyroid"="3")),
    dateInput("dob","Date of birth:",value = "1970-01-01"),
    submitButton("Submit")
    
    ),
  mainPanel(
    tabsetPanel(
 
      tabPanel("Prediction Output", verbatimTextOutput("prediction")),
      tabPanel("Help", fluidPage(includeHTML("Help.html")))
    )
    
    )
  ))