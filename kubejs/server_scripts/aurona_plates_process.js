const plateMaterial = [
    {
        id: 'manasteel',
        ingot: 'c:ingots/manasteel',
        plate: 'aurona:manasteel_plate',
        create: true,
        ie: true
    },
    {
        id: 'terrasteel',
        ingot: 'c:ingots/terrasteel',
        plate: 'aurona:terrasteel_plate',
        create: true,
        ie: true
    },
    {
        id: 'elementium',
        ingot: 'c:ingots/elementium',
        plate: 'aurona:elementium_plate',
        create: true,
        ie: true
    }
]


ServerEvents.recipes(event => {
    plateMaterial.forEach(m => {

        // Create Mechanical Press
        if (m.create) {
            event.custom({
                type: 'create:pressing',
                ingredients:[
                    {
                        tag: m.ingot
                    }
                ],
                results: [
                    {
                        id: m.plate
                    }
                ]
            }).id(`aurona:create/pressing/${m.id}_plate`)
        }

        // Immersive Engineering Metal Press
        if (m.ie) {
            event.custom({
                type: 'immersiveengineering:metal_press',

                mold: 'immersiveengineering:mold_plate',

                input: {
                    tag: m.ingot
                },

                result: {
                    id: m.plate
                },

                energy: 2400
            }).id(`aurona:immersiveengineering/metal_press/${m.id}_plate`)
        }
    })
})
