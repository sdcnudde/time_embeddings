import gensim, logging
import gensim_cust
import pandas
from six import iteritems
from collections import defaultdict
import os
import time
import os
import sys
import numpy
import csv


logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)


class MySentences(object):
    def __init__(self, fname):
        self.fname = fname

    def __iter__(self):
        for line in open(os.path.expanduser(self.fname)):
            yield line.split()

sentences = MySentences('~/Documents/customer_sentences2.txt')
dates = MySentences('~/Documents/dates2_sentences.csv')

dims = [2, 4, 8, 16, 32, 64, 128, 256, 512]
wdws = [1, 2, 5, 10, 20]
iter = 5
skipg = 1

for i in range(0, len(dims)):
    for j in range(0, len(wdws)):
        start_time = time.time()
        dim = dims[i]
        wdw = wdws[j]
        model = gensim.models.Word2Vec(sentences, sample=0, size=dim, window=wdw, min_count=1, sg=skipg, seed=42, hs=0, negative=5, iter=iter)

        stop_time = time.time()
        print stop_time - start_time

        # Save output weights
        # numpy.savetxt('w2v_outputweights.txt', model.syn1neg)
        word_vectors = model.wv

        # Save input weights
        str_fname = '_dim_' + str(dim) + '_wdw_' + str(wdw) + '_iter_' + str(iter) + '_skip_' + str(skipg)
        word_vectors.save_word2vec_format('~/Documents/w2v_output' + str_fname + '.txt')
