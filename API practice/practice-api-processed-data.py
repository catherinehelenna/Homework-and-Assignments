import pandas as pd
import json
from fastapi import FastAPI, HTTPException, Header
from fastapi.responses import JSONResponse

app = FastAPI()

df = pd.read_csv('/Users/catherinemulyadi/Desktop/NGC_Catherine H Mulyadi/Homework-and-Assignments/API practice/processed data.csv')

# df_json = df.to_json()

df_dict = df.to_dict(orient="records")

print(df_dict)

# parsed_data = json.loads(df_json)


API_KEY = 'api-key-2024'

@app.get('/')
def root():
    return {"message":'Hello World'}

@app.get('/show/data')
def show_data():
    return df_dict

@app.get('/duration_sec/{number}')
def find_duration_sec(number: str):
    number = int(number)
    try:
        # Iterate through all dictionaries in df_dict
        for item in df_dict:
            if item.get('duration_sec') == number:
                if item['duration_sec'] is not None:
                    return {"duration_sec": number}

        # If no match is found, raise a 404 exception
        raise HTTPException(status_code=404, detail='Data not found')

    except ValueError:
        raise HTTPException(status_code=400, detail='Invalid number provided')
    
# delete a data entry
@app.delete('/duration_sec/delete/{number}')
def del_duration_sec(number:int):
    try:
        initial_length = len(df_dict)
        for index, item in enumerate(df_dict):
            if item.get('duration_sec') == number:
                deleted_value = df_dict.pop(index)
                break
        if len(df_dict) < initial_length:
            return {"message": f"Successfully deleted entry with number {number}"}
        else:
            raise HTTPException(status_code=404, detail=f"Entry with number {number} not found")
    except ValueError:
        raise HTTPException(status_code=400, detail='Invalid number provided')
        

