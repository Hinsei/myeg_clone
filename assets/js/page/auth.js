// mouse enter make a huge div and get rid of the rest
// mose leave put back as original
if (document.getElementById("auth-container")){
  const navIcon = document.getElementsByClassName("nav-item")
  for (var navItemsIndex = 0; navItemsIndex < navIcon.length; navItemsIndex ++){
    const navIconElement = navIcon[navItemsIndex]
    navIconElement.addEventListener("mouseenter", function() {
      const navIconArray = Array.from(navIcon)
      const newArray = navIconArray.filter(function(element){
        return element != this
      }, this)
      newArray.forEach(function(element){
        element.setAttribute("style", "opacity: 0;")
      })
    })

    navIconElement.addEventListener("mouseleave", function(){
      const navIconArray = Array.from(navIcon)
      navIconArray.forEach(function(element){
        element.setAttribute("style", "")
      })
    })
  }
}
