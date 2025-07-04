# DataPile ETL

This project provides a minimal prototype of the **DataPile ETL – Automotive Supplier Finder & Enrichment App**.

It includes a simple FastAPI backend with a sample dataset and a small static HTML frontend.
Due to the limited environment the backend returns data from a local CSV file instead of performing online queries.

## Structure
- `backend/` – FastAPI application with a `/search` endpoint.
- `frontend/` – static HTML and JavaScript files to query the backend.
- `requirements.txt` – Python dependencies for the backend.

## Running the Backend
Use Uvicorn to start the API:
```bash
cd backend
python3 main.py
```
The API will listen on `http://127.0.0.1:8000`.

## Running the Frontend
Open `frontend/index.html` in a browser while the backend is running.

## Export Data
The frontend can download search results as a CSV file.
