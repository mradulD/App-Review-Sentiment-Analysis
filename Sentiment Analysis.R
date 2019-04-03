
## Data Preparation
require("readxl")
library(readxl)

#Load App data
app_data <- read_excel("Data Analyst Intern_Assignment.xlsx", sheet=1)
#Load comment data
app_comments <- read_excel("Data Analyst Intern_Assignment.xlsx", sheet=2)

#Using stringi package for string or character manipulation or 
#one can use stringr package which uses stringi package at the backend and provides simpler syntax
require("stringi")
library(stringi)
x <- stri_replace_all(app_comments$Translated_Review , "", regex = "<.*?>")
x<- stri_trim(x)
x<-stri_trans_tolower(x)
head(x)

## Data Pre-processing

# Tokenization (Tokenization is the process of splitting a text into tokens.)
install.packages("quanteda")
library(quanteda)

toks <- tokens(x)
str(toks)

# normalization : lowercasing and stemming (more advance technique is lemmitization)

toks <- tokens_tolower(toks)

toks <- tokens_wordstem(toks)
toks

# removing stopwords : stopwords are words that do not carry any information such as "the"

sw <- stopwords("english")
head(sw, 10)
toks <- tokens_remove(toks, sw)
head(toks)

#Care should be taken to perform some preprocessing steps in the correct order, for instance
#removing stopwords prior to stemming, otherwise “during” will be stemmed into “dure” and not
#matched to a stopword “during”

## Document-term matrix
## All the above steps can be done in a single line with DTM using dfm of quenteda package
dtm <- dfm(app_comments$Translated_Review, 
           tolower = TRUE, stem = TRUE,
           remove = stopwords("english")
           )

