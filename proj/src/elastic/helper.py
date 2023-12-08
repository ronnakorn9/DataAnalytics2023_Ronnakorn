# reference: https://github.com/TheRensselaerIDEA/twitter-nlp/tree/master/tools/keyword_analyzer
def get_query():
    query = {
        "_source": [
            "text",
            "full_text",
            "extended_tweet.full_text",
            "quoted_status.text",
            "quoted_status.full_text",
            "quoted_status.extended_tweet.full_text"
        ],
        "query": {
            "bool": {
                "filter": [
                    {
                        "bool": {
                            "must_not": {
                                "exists": {
                                    "field": "retweeted_status.id"
                                }
                            }
                        }
                    }
                ]
            }
        }
    }
    return query

def get_query_extend():
    query = {
        "_source": [
            "created_at",
            "text",
            "full_text",
            "extended_tweet.full_text",
            "quoted_status.text",
            "quoted_status.full_text",
            "quoted_status.extended_tweet.full_text",
            "sentiment.roberta.primary",
            "sentiment.roberta.quoted",
            "embedding.sbert.primary"
            
        ],
        "query": {
            "bool": {
                "filter": [
                    {
                        "bool": {
                            "must_not": {
                                "exists": {
                                    "field": "retweeted_status.id"
                                }
                            }
                        }
                    }
                ]
            }
        }
    }
    return query


def get_query_all():
    query = {
        "query": {
            "match_all": {}
        }
    }
    return query

def get_tweet_text(hit):
    date = hit["created_at"]
    
    text = (hit["extended_tweet"]["full_text"] if "extended_tweet" in hit 
            else hit["full_text"] if "full_text" in hit 
            else hit["text"])
    quoted_text = None
    if "quoted_status" in hit:
        quoted_status = hit["quoted_status"]
        quoted_text = (quoted_status["extended_tweet"]["full_text"] if "extended_tweet" in quoted_status 
                      else quoted_status["full_text"] if "full_text" in quoted_status 
                      else quoted_status["text"])
        
    sentiment = hit["sentiment"]["roberta"]
    sentiment_primary = sentiment["primary"]
    sentiment_quoted = None
    if "quoted" in sentiment:
        sentiment_quoted = sentiment["quoted"]
        
    embedding = hit["embedding"]["sbert"]["primary"]

    return date, text, quoted_text, sentiment_primary, sentiment_quoted, embedding
