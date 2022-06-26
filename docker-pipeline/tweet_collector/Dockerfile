FROM python:3.8
WORKDIR /app
#copy one by one like this copy requirements.txt /app

COPY requirements.txt /app
RUN pip install --trusted-host pypi.python.org -r requirements.txt
#RUN pip install -r requirements.txt
CMD ["python","get_tweets.py"]