# compiler course phase1 project: simple C syntax highligther

## rules:
+ write syntax highlither in java
+ use jflex for build scanner
+ save output (highligthed) to html output
+ more info about color and etc in todo.pdf

## how to run
+ this project is based on maven (and of course java)
+ to compile : execute `mvn clean package` on terminal
+ and to run : `java -jar target/syntaxhighligther-1.0-jar-with-dependencies.jar someTextFile.cpp`
 commands!
 
 ### important note: first time you run maven, it download essential files and it might take a long, dont worry, after first time, it takes less than 5 seconds

### TODO
+ [ ] unit test!
+ [ ] scientefic notation 
+ [ ] tab characters 
+ [ ] bug on character ending

+ [ ] use library for creating html!
+ [ ] write DFA on paper
+ [ ] print with color on terminal
+ [ ] keyword table
