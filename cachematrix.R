## Cache an inverse matrix on first use and recall from memory on subsequent calls

## Returns a function that returns an inverse matrix in cache, or creates one
makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  set_inverse <- function(inverse) m <<- inverse
  get_inverse <- function() m
  list(set = set, get = get,
       set_inverse = set_inverse,
       get_inverse = get_inverse)
}

## Calculate the inverse of the matrix, taking advantage of cache
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$get_inverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$set_inverse(m)
  m
}

## Test, 1st run calculates, 2nd run read from cache

# i <- 1000 # number of rows or columns
# large_mat <- matrix(rnorm(i*i), nrow = i)
# 
# x <- makeCacheMatrix(large_mat)
# system.time(cacheSolve(x))
# system.time(cacheSolve(x))
