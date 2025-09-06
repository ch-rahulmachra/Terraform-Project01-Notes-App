const API_URL = "https://37ropufp92.execute-api.ap-south-1.amazonaws.com/development";

async function createNote() {
  const title = document.getElementById("note-title").value;
  const content = document.getElementById("note-content").value;

  const res = await fetch(`${API_URL}/create`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ title, content }),
  });

  const data = await res.json();
  document.getElementById("output").innerText = "Created: " + JSON.stringify(data);
}

async function getNote() {
  const noteId = document.getElementById("note-id").value;

  const res = await fetch(`${API_URL}/get`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ noteId }),
  });

  const data = await res.json();
  document.getElementById("output").innerText = "Fetched: " + JSON.stringify(data);
}

async function updateNote() {
  const noteId = document.getElementById("note-id").value;
  const title = document.getElementById("note-title").value;
  const content = document.getElementById("note-content").value;

  const res = await fetch(`${API_URL}/update`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ noteId, title, content }),
  });

  const data = await res.json();
  document.getElementById("output").innerText = "Updated: " + JSON.stringify(data);
}

async function deleteNote() {
  const noteId = document.getElementById("note-id").value;

  const res = await fetch(`${API_URL}/delete`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ noteId }),
  });

  const data = await res.json();
  document.getElementById("output").innerText = "Deleted: " + JSON.stringify(data);
}