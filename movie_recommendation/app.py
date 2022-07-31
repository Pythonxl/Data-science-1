
from recommender import recommend_random,recommend_with_NMF
from utils import movies,lookup_movieId,get_movieId
from flask import Flask,render_template,request
# example input of web application
# user_rating = {
#     'the lion king': 5,
#     'terminator': 5,
#     'star wars': 2
# }

### initialize the flask framework
app = Flask(__name__)

# create route methods for main page and recommendation page
@app.route('/')
def hello():
    return render_template('index.html',name = 'Nihal',movies=movies['title'].to_list())

@app.route('/recommendation')
def recommendation():
    print(request.args)
    titles = request.args.getlist('input')
    ratings = request.args.getlist('rating')
    user_rating = dict(zip(titles,ratings))
    titles = []
    for indx in user_rating.keys():
        titles.append(get_movieId(movies,indx))
    user_rating = dict(zip(titles,list(map(int, user_rating.values()))))  
    print(user_rating)
    recs = recommend_with_NMF(user_rating,k=3)
    
    return render_template('recommendation.html',recs=recs)
# Please make sure that you output the ids and then modify the lookupmovieId to give the user the titles

### Terminal recommender:
if __name__=='__main__': ## Runs the app (main module) 
    app.run(debug=True,port=5000)
   
    # print('>>>> Here are some movie recommendations for you<<<<')
    # print('')
    # print('Random movies')
    # movie_ids = recommend_random(movies, user_rating)
    # print(movie_ids)


