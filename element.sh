#!/bin/bash
#Executable file for Periodic Table project for FCC

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if  [[ -z $1 ]]
then
echo Please provide an element as an argument.
else
if [[ $1 =~ ^[0-9]+$ ]]
then
  ATOMIC_NUMBER=$1
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$NAME'")
else
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
  if [[ -z $SYMBOL ]]
  then
    NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
    if [[ -z $NAME ]]
    then
    echo Please provide an element atomic number, symbol or name as an argument.
    else
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$NAME'")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$NAME'")
    fi
  else
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$SYMBOL'")
  NAME=$($PSQL "SELECT name FROM elements WHERE symbol = $SYMBOL")
  fi
fi
TYPE=$($PSQL "SELECT type FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")

echo The element with atomic number $ATOMIC_NUMBER is $NAME \($SYMBOL\). It\'s a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.

fi

#The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

#test the argument - is it in the atomic number list?
#if yes, print the message using atomic number as key joining props and elements tables


#if not in the atomic number list, test the argument - is it in the symbol list?
#if yes, print the message using the symbol as key joining props and elements tables

#if not in the symbol list, test the argument - is it in the name list?
#if yest, print the message using the name as key joining props and elements tables





