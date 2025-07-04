async function performSearch() {
    const comp = document.getElementById('component').value;
    document.getElementById('status').innerText = 'Searching...';
    const resp = await fetch(`http://localhost:8000/search?component=${encodeURIComponent(comp)}`);
    const data = await resp.json();
    renderTable(data.results);
    window.currentResults = data.results;
    document.getElementById('status').innerText = `Found ${data.results.length} result(s)`;
}

function renderTable(results) {
    const tbl = document.getElementById('results');
    tbl.innerHTML = '';
    if (!results.length) return;
    const headers = Object.keys(results[0]);
    const thead = document.createElement('tr');
    headers.forEach(h => {
        const th = document.createElement('th');
        th.textContent = h;
        thead.appendChild(th);
    });
    tbl.appendChild(thead);
    results.forEach(row => {
        const tr = document.createElement('tr');
        headers.forEach(h => {
            const td = document.createElement('td');
            td.textContent = row[h];
            tr.appendChild(td);
        });
        tbl.appendChild(tr);
    });
}

function exportCSV() {
    if (!window.currentResults || !window.currentResults.length) return;
    const headers = Object.keys(window.currentResults[0]);
    let csv = headers.join(',') + '\n';
    window.currentResults.forEach(row => {
        csv += headers.map(h => JSON.stringify(row[h] || '')).join(',') + '\n';
    });
    const blob = new Blob([csv], {type: 'text/csv'});
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'results.csv';
    a.click();
    URL.revokeObjectURL(url);
}
