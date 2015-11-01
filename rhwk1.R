#HWK 1 BY ARMENOUSH ASLANIAN-PERSICO
#Q1
print(noquote("1. Write a loop that calculates 12-factorial."))
x<-1
for(i in 12:1){
  x<-x*i
  print(c(i,x)) #How can I get these to left-align in the console output?
}
#Q2
print(noquote(" ")) #What's a better way to achieve this line break?
print(noquote("2. Show how to create a numeric vector that contains the sequence from 20 to 50 by 5."))
print(seq(20,50,5)) 
#Q3
print(noquote(" "))
print(noquote("3. Show how to take a trio of input numbers a, b, and c and implement the quadratic equation."))
a <- as.integer(readline("Enter an integer for a:"))
b <- as.integer(readline("Enter an integer for b:"))
c <- as.integer(readline("Enter an integer for c:"))

root1<-( ( (-1*b)+sqrt(as.complex( (b^2)-(4*a*c) ))) /(2*a))
root2<-( ( (-1*b)-sqrt(as.complex( (b^2)-(4*a*c) ))) /(2*a))
print(noquote("Your roots are:"))
print(root1)
print(root2)