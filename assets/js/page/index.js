if (document.getElementsByClassName("bureau-link")){
  const links = document.getElementsByClassName("bureau-link")

  var render_specialties = function(json){
    const main_cont = document.getElementById("main")
    const { bureau, specialties } = json
    while(main_cont.firstChild){
      main_cont.removeChild(main_cont.firstChild)
    }

    const specialty_cont = document.createElement("div")
    specialty_cont.setAttribute("id", "specialties-container")
    main_cont.append(specialty_cont)

    const bureau_banner = document.createElement("div")
    bureau_banner.setAttribute("id", "bureau-banner")
    const banner_img = document.createElement("img")
    banner_img.setAttribute("src", bureau.logo) 
    const banner_text = document.createElement("p")
    banner_text.innerHTML = bureau.name
    bureau_banner.append(banner_img)
    bureau_banner.append(banner_text)

    specialty_cont.append(bureau_banner)

    for(var specialties_index = 0; specialties_index < specialties.length; specialties_index ++){
      const specialty_banner = document.createElement("div")
      specialty_banner.setAttribute("class", "specialty-banner")
      const specialty_link = document.createElement("a")
      specialty_link.setAttribute("href", "/specialties/" + specialties[specialties_index].id + "/submissions/new")
      specialty_link.innerHTML = specialties[specialties_index].title
      
      specialty_banner.addEventListener("click", function(){
        window.location.replace(specialty_link.getAttribute("href"))
      })

      specialty_banner.append(specialty_link)
      specialty_cont.append(specialty_banner)
    }
  }

  for(var bureau_links_index = 0; bureau_links_index < links.length; bureau_links_index ++) {
    links[bureau_links_index].addEventListener("click", function(e){
      e.preventDefault()
      let a_tag = e.target.parentNode
      let api_link = a_tag.getAttribute("href")

      fetch(api_link).then(function(response){
        return response.json()
      }).then(function(json){
        console.log(json)
        render_specialties(json)  
      })
    })
  }
}

