#!/usr/bin/env sh

mvn -q clean package
java -jar target/*.jar
