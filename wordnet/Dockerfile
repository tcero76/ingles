FROM python:3.9-slim
WORKDIR /app
RUN pip install nltk
RUN python -m nltk.downloader wordnet
# COPY wordnet_example.py /app/
RUN pip install --no-cache-dir flask
CMD ["python", "wordnet_example.py"]
