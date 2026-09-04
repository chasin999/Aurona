const itemToAdd=[
    {
        name: 'manasteel_plate',
    },
    {
        name: 'terrasteel_plate',
    },
    {
        name: 'elementium_plate',
    },
    {
        name: 'infused_gold_ingot',
    }
]

StartupEvents.registry("item", event =>{
    itemToAdd.forEach(item => {
        event.create(`aurona:${item.name}`)
        .translationKey(`item.aurona.${item.name}`)
    })
})