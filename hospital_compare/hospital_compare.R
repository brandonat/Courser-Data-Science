## Hopsital Compare

best <- function(state, outcome) {

  ## Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check conditions
  if (!(state %in% levels(factor(df$State)))) stop("invalid state")
  if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) stop("invalid outcome")
  
  ## Return hospital name in that state with lowest 30-day death
  if (outcome == "heart attack") col_n <- 11
  if (outcome == "heart failure") col_n <- 17
  if (outcome == "pneumonia") col_n <- 23
  
  ## Filter by state, and select hospital name and outcome-related death rate
  sub <- df[df$State == state, c(2, col_n)]
  sub[, 2] <- as.numeric(sub[, 2])
  sub <- sub[order(sub[, 2], sub[, 1]), ]
  
  ## Result
  sub[1, 1]
}

rankhospital <- function(state, outcome, num = "best") {
  
  ## Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check conditions
  if (!(state %in% levels(factor(df$State)))) stop("invalid state")
  if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) stop("invalid outcome")
  if (!(num %in% c("best", "worst") | is.numeric(num))) stop("invalid rank")
  
  ## Return hospital name in that state with lowest 30-day death
  if (outcome == "heart attack") col_n <- 11
  if (outcome == "heart failure") col_n <- 17
  if (outcome == "pneumonia") col_n <- 23
  
  ## Filter by state, and select hospital name and outcome-related death rate
  sub <- df[df$State == state, c(2, col_n)]
  sub <- sub[sub[, 2] != "Not Available", ]
  sub[, 2] <- as.numeric(sub[, 2])
  sub <- sub[order(sub[, 2], sub[, 1]), ]
  
  ## Select result based on rank from argument 'num'
  if (num == "best") {
    return(sub[1, 1])
  }
  else if (num == "worst") {
    return(sub[nrow(sub), 1])
  }
  else {
    if (num > nrow(sub)) return(NA)
    return(sub[num, 1])
  }
}

rankall <- function(outcome, num = "best") {
  
  ## Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check conditions
  if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) stop("invalid outcome")
  if (!(num %in% c("best", "worst") | is.numeric(num))) stop("invalid rank")
  
  ## Select hospital name, state, and identified outcome
  if (outcome == "heart attack") col_n <- 11
  if (outcome == "heart failure") col_n <- 17
  if (outcome == "pneumonia") col_n <- 23
  sub <- df[, c(2, 7, col_n)]
  names(sub) <- c("hospital", "state", "outcome")
  sub <- sub[sub$outcome != "Not Available", ]
  sub[, "outcome"] <- as.numeric(sub[, "outcome"])
  
  get_state_rank <- function(state, data) {
    
    x <- data[data$state == state, ]
    x <- x[order(x[, "outcome"], x[, "state"]), ]
    
    ## Select result based on rank from argument 'num'
    if (num == "best") {
      return(c(x$hospital[1], state))
    }
    else if (num == "worst") {
      return(c(x$hospital[nrow(x)], state))
    }
    else if (num <= nrow(x)) {
      return(c(x$hospital[num], state))
    }
    return(c(NA, state))
  }
  
  ## Apply get_state_rank function to each state
  states <- levels(factor(sub$state))
  list_res <- lapply(states, get_state_rank, sub)  
  
  ## Convert to dataframe
  res <- data.frame(do.call(rbind, list_res))
  names(res) <- c("hospital", "state")
  rownames(res) <- res$state
  res
}
