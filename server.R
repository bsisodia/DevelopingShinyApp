#This is server.R file for processing inout from ui.R for Shiny App
# It is computing health risk prediction using some basic parameters

library(shiny)
age = function(from, to) {
  from_lt = as.POSIXlt(from)
  to_lt = as.POSIXlt(to)
  
  age = to_lt$year - from_lt$year
  
  ifelse(to_lt$mon < from_lt$mon |
           (to_lt$mon == from_lt$mon & to_lt$mday < from_lt$mday),
         age - 1, age)
}

healthRisk<-function(weight,height,conditions,dob) {
     bmi <- (weight/(height*height))*703
     risk<-0.15
     if ( bmi > 25.0) { risk<-0.4 }
     if ( bmi > 30.0) { risk<-0.6}
     if(!is.null(conditions))
     {
       risk<-risk+0.1*length(conditions)
     }
     currentAge<-age(dob,Sys.Date())
    
     if(currentAge>75)
       risk <- risk+0.2
     else if(currentAge>65)
       risk<- risk+0.15
     else if (currentAge>50)
       risk<- risk+0.1
     return(risk)
}

shinyServer(
  function(input,output) {
    output$prediction<-renderPrint({healthRisk(input$weight,input$height,input$conditions,input$dob)})
  }
  )