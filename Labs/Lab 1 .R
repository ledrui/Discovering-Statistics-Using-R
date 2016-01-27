## BASICS
  # Setup some scalars
  x <- 3
  y <- 4
  z <- sqrt(x*x + y*y)
  use.dots.in.names <- z - 5

  # Print out z
  print(z)
  # The default action is print()
  z

  # So you have a neat scientific calculator
  sin(log(2.718281828)*pi)

## SCALARS
  # The basic scalar types
  x <- 3
  take.me <- FALSE
  s <- "this is a string"
  x
  take.me
  s

  # Exploring objects using str() --
  str(x)
  str(take.me)
  str(s)

## DATES: A SPECIAL KIND OF SCALAR
  s <- "2004-04-22"
  d <- as.Date(s)
  d
  str(d)
  s <- "22-Apr-2004"
  d <- as.Date(s, format="%d-%b-%Y")
  d
  as.Date("22-04-2004", format="%d-%m-%Y")
  as.Date("22-04-04", format="%d-%m-%y")
  as.Date("22-Apr-04", format="%d-%b-%y")

## VECTORS
  x <- c(2,3,7, 9, 10, 11)                # the c() operator, for concatenation
  x[1]
  x[6]
  length(x)

  # Help about all R functions is online:
  ?length

  # Arithmetic that gobbles a vector at a time
  x
  x+2
  y <- log(x)
  y

  # Clever vector addressing
  x[1]
  x[6]
  x[c(1,6)]
  indexes <- c(1,3,5)
  x[indexes]

  # Another shorthand
  1:4
  x[1:4]
  indexes <- 1:4
  x[indexes]

  # Another shorthand
  switches <- c(TRUE,FALSE,FALSE,FALSE,FALSE,TRUE)
  x[switches]

  # Dropping some elements
  x
  x[-2]
  x[c(-2,-3)]

  # Bottom line: Very nice mechanisms for addressing.

  # Let's stay in touch with how to explore objects --
  str(x)
  str(x[1])

## FACTORS: A SPECIAL KIND OF SCALAR
  names  <- c("Payal", "Shraddha", "Aditi", "Kritika", "Diwakar")
  attire <- c("Sari",  "Salwar",   "Sari",  "Sari",    "Kurta")
  # attire is a "categorical variable"
  attire <- factor(attire)
  attire
  table(attire)
  table(names, attire)

  # Internally, a factor is just stored as an integer
  as.numeric(attire)

## NOT AVAILABLE: A SPECIAL SCALAR
  x <- c(2,3,NA,4,5,NA)
  x
  x + 2                                   # Automatic rules about NA arithmetic

## MATRICES
  X <- matrix(NA, nrow=7, ncol=3)
  X
  X[4,] <- c(2,3,4)
  X
  X[,3] <- 1:7
  X
  str(X)
  nrow(X)
  ncol(X)

  # As with vectors, arithmetic that attacks a full matrix at a time!
  X + 1

## LISTS
  # Ability to make a parcel of apparently unrelated materials.
  results <- list(mu=0.2, sigma=0.9, x=c(1,2,3,9))
  str(results)
  # Accessing elements --
  results$mu
  results$sigma <- 9
  results$new <- "Hello"
  results