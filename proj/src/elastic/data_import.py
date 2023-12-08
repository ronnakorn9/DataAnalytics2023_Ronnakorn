# reference: https://github.com/TheRensselaerIDEA/twitter-nlp/tree/master/tools/keyword_analyzer
from elasticsearch import Elasticsearch
from elasticsearch_dsl import Search
import json 

from helper import get_query


### metadata
config = None
config_location = "./src/elastic/config.json"
with open(config_location, "r") as f:
    config = json.load(f)

es = Elasticsearch(hosts=[config["elasticsearch_host"]], 
                   verify_certs=config["elasticsearch_verify_certs"],
                   timeout=config["elasticsearch_timeout_secs"])

s = Search(using=es, index=config.elasticsearch_index_name)
s = s.params(size=10000)
s.update_from_dict(get_query())