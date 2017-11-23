$(document).ready(function () {
  $(".repo-switch").on("change", function (e) {
    element = $(e.target);
    id = element.attr("id");
    state = element.is(":checked");

    updateRepositoryState(id, state);
  })
})

function updateRepositoryState(id, state) {
  var csrf = document.querySelector("meta[name=csrf]").content;

  $.ajax({
    url: "/repositories/" + id,
    type: "PUT",
    headers: {
      "X-CSRF-TOKEN": csrf
    },
    data: { enable: state },
    success: function (response) {
      Notification.Show("Repository updated", "success");
    },
    error: function (response) {
      Notification.Show("Error updatring repository state", "error");
    }
  })
}
