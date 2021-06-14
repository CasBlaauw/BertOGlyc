# BertOGlyc
Work done as part of a MSc project with Hiren Jitendra Joshi and Ole Winther, using BERT to predict O-GalNAc glycosylation.

# File explanations:
- `ProtBert_BFD_NetOGlyc.ipynb`: Takes protein sequences and returns contextual embeddings per amino acid, plus ID file.
- `ProtBert_NetOGlyc_classification_training.ipynb`: Takes amino acid embeddings and trains the CNN on it, returning model weights.
- `ProtBert_NetOGlyc_pipeline.ipynb`: Eventually: takes protein sequences and model weights, returns glycosylation site predictions. Currently: takes protein sequence embeddings and model weights, returns glycosylation site predictions.
