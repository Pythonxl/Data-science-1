import pymongo
from sqlalchemy import create_engine
import time
import logging
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
print('0')
#s  = SentimentIntensityAnalyzer()
 

time.sleep(10) #seconds 

# Establish a connection to the MongoDB server
client = pymongo.MongoClient(host="MongoDB", port=27017)

# Select the database you want to use withing the MongoDB server
db = client.twitter

pg = create_engine('postgresql://docker_user:1234@postgresdb:5432/twitter', echo=True)
print('1')
pg.execute('''
    CREATE TABLE IF NOT EXISTS tweets (
    text VARCHAR(500),
    sentiment NUMERIC
    );
''')
#Sentiment Intensity Analyzer
s  = SentimentIntensityAnalyzer()
docs = db.tweets.find(limit=5)
for doc in docs:
	text = doc['text']
	#score = 1.0  placeholder value
	sentiment = s.polarity_scores(text)
	score = sentiment['compound']
	query = "INSERT INTO tweets (text,sentiment) VALUES (%s, %s);"
	pg.execute(query, (text, score))
	print(text)
#print('2')
#entries=db.collections.tweets.find()
#for e in entries:
 #logging.critical('\n {}'.format(e))
 #text=e['text']
 #id=e['id']
 #score = s.polarity_scores(e['text'])  # assuming your JSON docs have a text field
 #print(sentiment)
# replace placeholder from the ETL chapter
 #sentiment = score['compound']
 
#docs = db.tweets.find(limit=5)
#for doc in docs:
   # print(doc)
#print('3')
