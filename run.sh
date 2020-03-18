#!/usr/bin/env sh
mvn -q clean package
java -jar target/syntaxhighligther-1.0-jar-with-dependencies.jar sample1.txt
