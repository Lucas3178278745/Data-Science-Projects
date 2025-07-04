from fastapi import FastAPI, Query
from fastapi.responses import JSONResponse
import csv
import os

app = FastAPI(title="DataPile ETL")

def load_data():
    records = []
    path = os.path.join(os.path.dirname(__file__), 'sample_data.csv')
    with open(path, newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            records.append(row)
    return records

data = load_data()

@app.get('/search')
def search(component: str = Query(..., description="Component name")):
    results = [r for r in data if r['Component'].lower() == component.lower()]
    return JSONResponse({"results": results})

if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host='0.0.0.0', port=8000)
