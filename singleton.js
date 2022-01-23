const singleton = (function () {
    var instance // private variable

    // /private funciton
    function init() {
        return {
            printHello: function () {
                console.log('Printing Hello');
                return 10
            }
        }
    }

    //public properties 
    return {
        get_instance: function () {
            if (!instance) {
                instance = init()
            }
            return instance
        },
        publicData: 'Somnath Paul'
    }
})()

// const mysingleton = new singleton().get_instance().printHello()
// console.log(mysingleton);

// const mysingleton1 = new singleton().init().printHello()

const mysingleton = singleton.publicData
console.log(mysingleton);
