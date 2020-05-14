FROM python:3.8-slim-buster

RUN apt-get update -y

# gcc compiler and opencv prerequisites
RUN apt-get -y install nano git build-essential libglib2.0-0 libsm6 libxext6 libxrender-dev

# Detectron2 prerequisites
RUN pip install torch==1.4.0+cpu torchvision==0.5.0+cpu -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install cython
RUN pip install -U 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'

# Detectron2 - CPU copy
RUN git clone https://github.com/facebookresearch/detectron2 detectron2
RUN python -m pip install -e detectron2
# Development packages
RUN pip install flask flask-cors requests opencv-python

ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY app/server.py app/server.py

ENTRYPOINT ["python", "/app/server.py"]
