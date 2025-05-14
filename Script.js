const usersTable = document.querySelector("#usersTable tbody");
const editForm = document.getElementById("editForm");
const editName = document.getElementById("editName");
const editUsername = document.getElementById("editUsername");
const editEmail = document.getElementById("editEmail");

let currentEditId = null;
let localUsers = JSON.parse(localStorage.getItem("addedUsers")) || [];

function renderUser(user, isLocal = false) {
  const row = document.createElement("tr");
  row.setAttribute("data-id", user.id);
  row.setAttribute("data-local", isLocal);

  row.innerHTML = `
    <td>${user.id}</td>
    <td>${user.name}</td>
    <td>${user.username}</td>
    <td>${user.email}</td>
    <td>
      <button onclick="editUser(${user.id}, '${user.name}', '${user.username}', '${user.email}')">Update</button>
      <button onclick="deleteUser(${user.id})">Delete</button>
    </td>
  `;
  usersTable.appendChild(row);
}

function deleteUser(id) {
  const row = document.querySelector(`tr[data-id='${id}']`);
  const isLocal = row.getAttribute("data-local") === "true";
  if (isLocal) {
    localUsers = localUsers.filter(u => u.id !== id);
    localStorage.setItem("addedUsers", JSON.stringify(localUsers));
  }
  row.remove();
}

fetch("https://jsonplaceholder.typicode.com/users")
  .then(response => response.json())
  .then(data => {
    const baseUsers = data.slice(0, 6);
    baseUsers.forEach(user => renderUser(user, false));
    localUsers.forEach(user => renderUser(user, true));
  });

function editUser(id, name, username, email) {
  currentEditId = id;
  editName.value = name;
  editUsername.value = username;
  editEmail.value = email;
  editForm.style.display = "block";
}

editForm?.addEventListener("submit", function(e) {
  e.preventDefault();

  const updatedUser = {
    id: currentEditId,
    name: editName.value,
    username: editUsername.value,
    email: editEmail.value
  };

  const row = document.querySelector(`tr[data-id='${currentEditId}']`);
  const isLocal = row.getAttribute("data-local") === "true";

  if (isLocal) {
    localUsers = localUsers.map(user => user.id === currentEditId ? updatedUser : user);
    localStorage.setItem("addedUsers", JSON.stringify(localUsers));
    location.reload();
  } else {
    fetch(`https://jsonplaceholder.typicode.com/users/${currentEditId}`, {
      method: "PUT",
      headers: { "Content-type": "application/json" },
      body: JSON.stringify(updatedUser)
    }).then(() => location.reload());
  }
});

const addForm = document.getElementById("addForm");
if (addForm) {
  addForm.addEventListener("submit", function(e) {
    e.preventDefault();

    const name = document.getElementById("newName").value;
    const username = document.getElementById("newUsername").value;
    const email = document.getElementById("newEmail").value;

    const maxId = localUsers.length > 0 ? Math.max(...localUsers.map(u => u.id)) : 6;
    const newId = maxId + 1;

    const newUser = { id: newId, name, username, email };
    localUsers.push(newUser);
    localStorage.setItem("addedUsers", JSON.stringify(localUsers));
    window.location.href = "index.html";
  });
}