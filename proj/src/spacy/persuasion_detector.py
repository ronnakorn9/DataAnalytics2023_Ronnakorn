import spacy
from spacy.tokens import DocBin
### for accuracy
### might need to do "python -m spacy download en_core_web_trf"
# nlp = spacy.load("en_core_web_trf")
# import en_core_web_trf
# nlp = en_core_web_trf.load()


### for speed 
# nlp = spacy.load("en_core_web_sm")
# import en_core_web_sm
# nlp = en_core_web_sm.load()

data_dir = "./data/converted/sem_eval_task6/"
data_name = "training_set_task1.spacy"
doc_bin = DocBin().from_disk(data_dir+data_name)
# doc = nlp("This is a sentence.")

print(f"doc bin: len {len(doc_bin.get_docs())}")
for i, doc in enumerate(doc_bin):
    print(f"doc {i}: len {len(doc)}")
# for token in doc:
#     print(token.text)
#     break

# print([(w.text, w.pos_) for w in doc])

### sample command
# python -m spacy init fill-config ./base_config/span_classify/gpu_small.cfg ./config/span_classify/gpu_small.cfg
# python -m spacy init fill-config ./base_config/span_classify/gpu_large.cfg ./config/span_classify/gpu_large.cfg
# python -m spacy init fill-config base_config.cfg config.cfg
# python -m spacy train small_config.cfg --paths.train ./train.spacy --paths.dev ./dev.spacy
# python -m spacy train ./config/text_classify/gpu_small.cfg  --paths.train ./data/converted/sem_eval_task6/training_set_task1.spacy --paths.dev ./data/converted/sem_eval_task6/dev_set_task1.spacy
# python -m spacy train ./config/text_classify/gpu_small.cfg  --paths.train ./data/converted/sem_eval_task6/training_set_task1.spacy --paths.dev ./data/converted/sem_eval_task6/dev_set_task1.spacy --gpu-id 0 --output ./model/text_classify/gpu_small
# python -m spacy train ./config/span_classify/gpu_small.cfg  --paths.train ./data/converted/sem_eval_task6/training_set_task2.spacy --paths.dev ./data/converted/sem_eval_task6/dev_set_task2.spacy --gpu-id 0 --output ./model/span_classify/gpu_small