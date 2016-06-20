## Html
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
html_code <- readLines(con)
close(con)

## Fixed width file
x <- read.fwf(
  file=url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
  widths = c(12, 7, 4, 9, 4, 9, 4, 9, 4),
  skip = 4)


