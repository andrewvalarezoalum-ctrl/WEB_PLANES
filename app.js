//ANIMACIONES

const filtroBoton = document.querySelector("#filtroBoton")
const menuFiltro = document.querySelector("#menuFiltro")

filtroBoton.addEventListener("click", () =>{
    menuFiltro.classList.toggle("menuFiltroOculto");
    menuFiltro.classList.toggle("menuFiltro")
})  


