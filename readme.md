The sequence, time-independent model uses the standard gensim package.
The sequence, time-dependent model uses the gensim_cust package (I’ve only uploaded the files that differ from those of the standard gensim package.)
	- The time dependency is modeled in /gensim_cust/models/word2vec_inner.pyx (method train_batch_sg)
	- Before running the python code:
		- cython word2vec_inner.pyx (to compile .pyx file into C)
		- gcc -l python2.7 -o word2vec_inner.c -c (to compile the resulting C file)