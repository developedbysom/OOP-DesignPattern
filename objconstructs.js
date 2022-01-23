var myObj1 = {}
var myObj2 = Object.create(null)
var myObj3 = new Object()

function car(model, year, miles) {
    this.model = model
    this.year = year
    this.miles = miles
}
var myObj4 = new car('Honda', 2020, 30000)
console.log(myObj4);
console.log(myObj2);
console.log(myObj3);

// adding attributes

myObj1.name = 'Somnath'
myObj2['name'] = 'Mike'

// Object.defineProperty(myObj3, 'name', {
//     value: 'John Doe',
//     writable: false
// })
// console.log(myObj3.name);
// myObj3.name = 'jkwqdjkwedjkwedew'
// console.log(myObj3.name);

Object.defineProperties(myObj3, {
    'color': {
        value: 'red',
        writable: true
    },
    'MaxSpeed': {
        value: 100,
        writable: false
    }

})