const hamburger = document.querySelector(".hamburger");
const nav = document.querySelector("nav");
hamburger.addEventListener("click", function() {
    hamburger.classList.toggle("is-active");
    nav.classList.toggle("open");
});