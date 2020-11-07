import pandas as pd
import numpy as np
from copy import deepcopy
import json
import matplotlib.pyplot as plt
import datetime
import shutil
import os
import re
import random

import tensorflow as tf
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM
from keras.layers import Dropout
from keras.layers import *
import keras
import pickle

import requests
from bs4 import BeautifulSoup
