ServerEvents.recipes(event =>{
    event.custom({
        type:'ars_nouveau:enchanting_apparatus',
        
        reagent: {
            item:'immersiveengineering:light_engineering'
        },

        pedestalItems:[
            {
                tag:'c:glass_blocks'
            },
            {
                tag:'c:glass_blocks'
            },
            {
                item:'immersiveengineering:component_iron'
            },
            {
                item:'ars_nouveau:earth_essence'
            },
            {
                item:'ars_nouveau:water_essence'
            }
        ],
        
        result:{
            count:1,
            id:'immersiveengineering:cloche'
        },

        sourceCost: 2000,
        keepNbtOfReagent: true
    }).id('aurona:ars_nouveau/cloche')
})