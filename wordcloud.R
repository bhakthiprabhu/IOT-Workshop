#To generate word clouds, you need to download the wordcloud package
#install.packages("wordcloud")
library(wordcloud)

#RcolorBrewer package for the colours
#install.packages("RColorBrewer")
library(RColorBrewer)

#wordcloud2 package, with a slightly different design and fun applications
#install.packages("wordcloud2")
library(wordcloud2)

#If you’re working on a speech, article or any other type of text, make sure to load your text data as a corpus. A useful way to do this is to use the tm package.
#install.packages("tm")
library(tm)

library(RTextTools) 

#Create a vector containing only the text
#text <- data$text

text <- readLines(file.choose())

# Create a corpus  
docs <- Corpus(VectorSource(text))

# Clean the text data
docs <- tm_map(docs,tolower)
docs <- tm_map(docs,removeWords,stopwords("english"))
docs <- tm_map(docs,removeNumbers)
docs <- tm_map(docs,removePunctuation)
docs <- tm_map(docs,stripWhitespace)
docs <- tm_map(docs,stemDocument)


#Create a document-term-matrix
dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

#Generate the word cloud
set.seed(1234) # for reproducibility 
wordcloud(words = df$word, freq = df$freq, min.freq = 1,max.words=20000, random.order=FALSE, rot.per=0.35,colors=brewer.pal(8, "Dark2"))

#wordcloud2(data=df, size=0.5, color='random-dark')
wordcloud2(data=df, size=0.5, color='random-light')
#wordcloud2(data=df, size = 0.5, shape = 'pentagon',backgroundColor="#056c5f")
wordcloud2(data=df, size = 0.5, shape = 'circle')
#letterCloud(df, word = "WORDCLOUD2", wordSize = 1)
