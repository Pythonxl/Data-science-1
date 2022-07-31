"""
Contains various recommondation implementations
all algorithms return a list of movieids
"""
from scipy.sparse import csr_matrix
import pickle
import pandas as pd
import numpy as np
from utils import lookup_movieId,get_movieId,match_movie_title,movies


def recommend_random(movies, user_rating, k=5):
    """
    return k random unseen movies for user 
    """
    user = pd.DataFrame(user_rating, index=[0])
    user_t = user.T.reset_index()
    user_movie_entries = list(user_t["index"])
    movie_titles = list(movies["title"])
    intended_movies = [match_movie_title(title, movie_titles) for title in user_movie_entries]
    
    # convert these movies to intended movies and convert them into movie ids
    recommend = movies.copy()
    recommend = recommend.reset_index()
    recommend = recommend.set_index("title")
    recommend.drop(intended_movies, inplace=True)
    random_movies = np.random.choice(list(recommend.index), replace=False, size=k)
    return random_movies  



def recommend_with_NMF(query, k=5):
    """
    NMF Recommender
    INPUT
    - user_vector with shape (1, #number of movies)
    - user_item_matrix
    - trained NMF model
    OUTPUT
    - a list of movieIds
    """
    with open('./nmf_recommender.pkl', 'rb') as file:  # This "with open" mimic is a so-called "context manager".
     model = pickle.load(file)
    
    
    data = list(query.values())   # the ratings of the new user
    row_ind = [0]*len(data)       # we use just a single row 0 for this user 
    col_ind = list(query.keys())  # the columns (=movieId) of the ratings

    R_user = csr_matrix((data, (row_ind, col_ind)), shape = (1,168253))
    P_user = model.transform(R_user)
    # Q does not change
    R_recommended = np.dot(P_user, model.components_)

    # The same result can be obtained by:
    scores = model.inverse_transform(model.transform(R_user)) 
    scores = pd.Series(scores[0])
    scores[query.keys()] = 0
    scores = scores.sort_values(ascending=False)
    recommendations = scores.head(k).index
    print(recommendations)
    titles = []
    for indx in recommendations:
        titles.append(lookup_movieId(movies,indx))
    
    return titles

    # initialization - impute missing values    
    
    # transform user vector into hidden feature space
    
    # inverse transformation

    # build a dataframe

    # discard seen movies and sort the prediction
    
    # return a list of movie ids
    pass

def recommend_with_user_similarity(user_item_matrix, user_rating, k=5):
    pass
