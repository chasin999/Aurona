const recipesToRemove =[
    'immersiveengineering:crafting/cloche'
]












ServerEvents.recipes(event =>{
    recipesToRemove.forEach(id =>{
        event.remove({id})
    })
})