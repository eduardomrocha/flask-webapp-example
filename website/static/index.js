function deleteNote(noteId) {
  fetch('/notes/'.concat(noteId), {
    method: 'DELETE',
  }).then((_res) => {
    window.location.href = "/";
  });
}
