"""
UTILS 
- Helper functions to use for your recommender funcions, etc
- Data: import files/models here e.g.
    - movies: list of movie titles and assigned cluster
    - ratings
    - user_item_matrix
    - item-item matrix 
- Models:
    - nmf_model: trained sklearn NMF model
"""

import pandas as pd
import numpy as np
from fuzzywuzzy import process


movies = pd.read_csv('movies_ratings.csv', index_col=0) 


def match_movie_title(input_title, movie_titles):
    """
    Matches inputed movie title to existing one in the list with fuzzywuzzy
    #Matches movie titles to resp.movie id
    #"""
    matched_title = process.extractOne(input_title, movie_titles)[0]

    return matched_title


#def lookup_movieId(movies, movieId):
   # """
   # Convert output of recommendation to movie title
   # Convert movie index to title
    #"""
    # match movieId to title
    #movies = movies.reset_index()
   # boolean = movies["movieId"] == movieId
   # movie_title = list(movies[boolean]["title"])[0]
    #return movie_title

 
 
def lookup_movieId(movies: pd.DataFrame, movieId:int)->str: 
    """
    Convert output of recommendation to movie title
    
    """
    # match movieId to title
    movies = movies.reset_index()
    boolean = movies["movieId"] == movieId
    print(boolean)
    movie_title = list(movies[boolean]["title"])[0]
    return movie_title

def get_movieId(movies: pd.DataFrame, title:str)->int: 
    """
    Convert output of recommendation to movie title
    
    """
    # match movieId to title
   
    movies = movies.reset_index()

    boolean = movies["title"] == title
    movie_id = list(movies[boolean]["movieId"])[0]

    return movie_id
