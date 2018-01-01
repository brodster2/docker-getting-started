FROM python:3.6-slim

WORKDIR /app

ADD . /app

# Install python dependencies
RUN pip install --trusted-host pypi.python.com -r requirements.txt

EXPOSE 80

# Define a random environment variable
ENV NAME World

# Run app when container launches
CMD ["python", "app.py"]
