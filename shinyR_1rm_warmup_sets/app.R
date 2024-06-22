# One rep max shiny app -------------------------------------------------------
#
# - A shiny app to find your one rep max
# - and create warm up sets to attempt it
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

# source(here::here("scripts", "00_libs.R"))

# -----------------------------------------------------------------------------
ui <- fluidPage(
  titlePanel("Warm-up Set Generator for One Rep Max"),
  fluidRow(
    column(12,
            wellPanel(
              p("This app allows you to input weights and reps completed
                to determine what your one rep max may be.",
                br(),
                "It automatically generates a warm up set for you based 
                on your predicted one rep max.")
            ))
  ),
  sidebarLayout(
    sidebarPanel(
      HTML("Enter the weight and number of reps for however many sets
           you have recorded. The weight can be in any unit as long as
           you are consistent."),
      numericInput("wt", "Weight",
                   value = 0,
                   min = 0),
      numericInput("reps", "Number of reps completed",
                   value = 1,
                   min = 1),
      actionButton("addSet", "Add Set"),
      actionButton("clearSets", "Clear Sets"),
      hr(),
      tableOutput("inputTable")
      ),
    mainPanel(
      tableOutput("warmUpTable")
    )
  )
)


server <- function(input, output, session) {
  sets <- reactiveValues(data = data.frame(
    Weight = numeric(0), 
    Reps = integer(0)
  ))
  
  observeEvent(input$addSet, {
    new_set <- data.frame(
      Weight = input$wt,
      Reps = input$reps
    )
    sets$data <- rbind(sets$data, new_set)
  })
  
  observeEvent(input$clearSets, {
    sets$data <- data.frame(Weight = numeric(0), Reps = integer(0))
  })
  
  output$inputTable <- renderTable({
    sets$data
  }, rownames = FALSE)
  
  predicted_max <- reactive({
    if (nrow(sets$data) == 0) return(0)
    predicted_max_values <- (sets$data$Reps * sets$data$Weight * 0.0333) + sets$data$Weight
    mean(predicted_max_values)
  })
  
  warm_up_sets <- reactive({
    if (predicted_max() == 0) return(NULL)
    data.frame(
      Set = as.factor(seq(1, 5, length.out = 5)),
      Weight = c(0.5 * predicted_max(), 
                 0.6 * predicted_max(),
                 0.75 * predicted_max(),
                 0.85 * predicted_max(),
                 predicted_max()),
      Reps = factor(c(10, 5, 3, 2, 1))
    )
  })
  
  output$warmUpTable <- renderTable({
    warm_up_sets()
  }, rownames = FALSE)
}

shinyApp(ui, server)
