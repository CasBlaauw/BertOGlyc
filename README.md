# BertOGlyc
Work done as part of a MSc project with Hiren Jitendra Joshi, Henrik Nielsen, and Ole Winther, using BERT to predict O-GalNAc glycosylation.

# File explanations:
- [`BertOGlyc_make_training_data.ipynb`](BertOGlyc_make_training_data.ipynb): Takes protein sequences and returns contextual embeddings per amino acid, plus ID file.
- [`BertOGlyc_train_CNN.ipynb`](BertOGlyc_train_CNN.ipynb): Takes amino acid embeddings and trains the CNN on it, returning model weights.
- [`BertOGlyc_train_per_protein_NN.ipynb`](BertOGlyc_train_per_protein_NN.ipynb): Takes amino acid embeddings and trains a simple neural network on the pooled embeddings to classify the entire protein, returning model weights.
- [`BertOGlyc_model.ipynb`](BertOGlyc_model.ipynb): (Work in progress!) Eventually: takes protein sequences and model weights, returns glycosylation site predictions. Currently: takes protein sequence embeddings and model weights, returns glycosylation site predictions.
