# Получение списка индексов
Поиск осуществляется по алгоритму
> https://ru.wikipedia.org/wiki/Okapi_BM25
**Список всех документов**
```
GET stories/_search
{
  "query": {
    "match_all": {}
  }
}
```
**Поиск по нужному полю**
```
GET stories/_search
{
  "query": {
    "match": {
      "title": "Javascript"
    }
  }
}
```

**Один из запросов**
```
GET stories/_search
{
  "query": {
    "function_score": {
      "query": {
        "bool": {
          "should": [
            {
              "match": {
                "title": {
                  "query": "вор",
                  "fuzziness": 2
                }
              }
            }
          ],
          "filter": [
            {
              "term": {
                "verifed": false
              }
            }
          ]
        }
      },
      "min_score": 0.1
    }
  }
}
```

**Painless**
```
  "post_filter": {
    "script": {
      "script": {
        "lang": "painless",
        "source": """
          //return doc['category'].value == params.category
          params.category.contains(doc['category'].value);
        """,
        "params": {
          "category": ["Статьи", "Новости"]
        }
      }
    }
  }
```

**Классификатор**

```

GET products/_search
{
  "size": 50, 
  "query": {
    "function_score": {
      "query": {
        "bool": {
          "should": [
            {
              "match": {
                "title": {
                  "query": "Амортизатор",
                  "fuzziness": 2
                }
              }
            },
            {
              "nested": {
                "path": "applicability",
                "query": {
                  "terms": {
                    "applicability.value": ["Lada 2101", "2101"]
                  }
                }
              }
            }
          ],
          "filter": [
            {
              "term": {
                "brand.id": 9653
              }
            }
          ]
        }
      },
      "field_value_factor": {
        "field": "factor",
        "modifier": "ln2p"
      }, 
      "min_score": 0.1
    }
  },
    "post_filter": {
    "script": {
      "script": {
        "lang": "painless",
        "source": """
          if ((int) doc['zone'].value == 4) {
            return params.source_id.contains((int) doc['contractor'].value);
					}
					return true;
        """,
        "params": {
          "source_id": []
        }
      }
    }
  },
  "sort": [
    {
      "factor": {
        "order": "desc"
      }
    },
    {
      "_score": {
        "order": "desc"
      }
    }
  ]
}

```