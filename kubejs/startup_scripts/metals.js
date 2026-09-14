global.METALS ={

    source_gold: {
        forms: [
            'ingot',
            'plate'
        ],

        processing:{
            alloys: true,
            press: true
        }


    }


}



global.METALS_FORMS ={
    
    ingot :{
        tag:'ingots'
    },
    plate :{
        tag:'plates'
    },
    dust :{
        tag:'dusts'
    },
    nugget:{
        tag:'nuggets'
    },
    gear:{
        tag:'gears'
    },
    rod:{
        tag:'rods'
    },
    block:{
        tag:'storage_blocks'
    }
}

global.metalItem = function(metal, form) {
    return `aurona:${metal}_${form}`
}

global.metalTag = function(metal, form) {
    let type = global.METALS_FORMS[form].tag
    return `c:${type}/${metal}`
}