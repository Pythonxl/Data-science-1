FROM python:3.8
WORKDIR /app
#copy one by one like this copy requirements.txt /app

COPY . /app
RUN pip install -r requirements.txt
CMD ["python","etl.py"]