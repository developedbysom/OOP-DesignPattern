'use strict'
let country_cache = []
function Server() {
    return {
        get_data: function (country_id) {
            switch (country_id) {
                case 'IN':
                    return 'India'
                    break;
                case 'DE':
                    return 'Germany'
                    break;
                default:
                    return 'Invalid Country ID'
                    break;
            }
        }
    }
}

function proxy() {
    return {
        get_data: function (country_id) {
            // validation
            if (country_id === undefined || country_id === '') {
                return 'Country ID is mandatory'
            }

            //check the cache
            let countryName = country_cache.filter((obj) => {
                if (obj['id'] === country_id) {
                    return obj['name']
                }
            })

            if (countryName.length > 0) {
                return countryName[0].name
            }
            console.log('Calling API');
            let country_name = new Server().get_data(country_id)
            let countryObj = {
                id: country_id,
                name: country_name
            }
            country_cache.push(countryObj)
            return country_name
        }
    }
}
const client = (function () {
    let country_name = new proxy().get_data('IN')
    console.log(country_name);
    country_name = new proxy().get_data('DE')
    console.log(country_name);
    country_name = new proxy().get_data('FR')
    console.log(country_name);
    country_name = new proxy().get_data()
    console.log(country_name);
    country_name = new proxy().get_data('DE')
    console.log(country_name);
    country_name = new proxy().get_data('IN')
    console.log(country_name);
})()
