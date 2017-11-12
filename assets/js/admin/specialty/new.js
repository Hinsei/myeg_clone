if( document.getElementById("add-form-data-field")){
  const addFormData = document.getElementById("add-form-data-field")

  addFormData.addEventListener("click", function(e){
    e.preventDefault()
    const containerFormData = document.getElementById("form-data-container")
    const numberOfField = containerFormData.childElementCount
    const newField = document.createElement("input")
    newField.setAttribute("type", "text")
    newField.setAttribute("name", "specialty[form_data_" + numberOfField + "]")
    newField.setAttribute("id", "form-field-" + numberOfField)
    containerFormData.append(newField)
  })
}
