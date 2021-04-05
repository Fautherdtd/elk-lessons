__Создание индекса:__

>asciifolding: https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-asciifolding-tokenfilter.html
```
PUT /stories
{
    "settings": {
        "analysis": {
            "analyzer": {
                "string_normalizer": {
                    "type": "custom",
                    "tokenizer": "standard",
                    "char_filter": [
                      "html_strip"
                    ],
                    "filter": [
                      "lowercase",
                      "asciifolding"
                    ]
                }
            }
        }
   },
   "mappings": {
       "properties": {
           "id": {
               "type": "long"
           },
           "title": {
               "type": "text",
               "analyzer": "string_normalizer",
               "fields": {
                   "key": {
                       "type": "keyword"
                   },
                   "space": {
                        "type": "text",
                        "analyzer": "whitespace"
                   }
               }
           },
           "description": {
               "type": "text"
           },
           "body": {
               "type": "text"
           },
           "category": {
               "type": "keyword"
           },
           "verifed": {
               "type": "boolean"
           },
           "factor": {
               "type": "float"
           }
       }
   }
}
```

__Просмотр настроек индекса:__
>GET /stories/_settings

__Просмотр маппинга индекса:__
>GET /stories/_mapping