FROM centos/python-38-centos7:latest

RUN pip install flask flask_restful flask-jsonpify

COPY python-api.py /python-api/python-api.py

CMD ["python3", "/python-api/python-api.py"]
