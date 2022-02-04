class Person {
    first_name = ""
    last_name = ""
    constructor(first_name, last_name) {
        this.first_name = first_name
        this.last_name = last_name
    }
    printName() {
        return `My Name is: ${this.first_name} ${this.last_name}`
    }
}

class Developer extends Person {

    constructor(first_name, last_name, skill) {
        super(first_name, last_name)
        this.skill = skill
    }

    printName() {

        return `I am ${this.first_name} ${this.last_name} & I know ${this.skill}`
    }
}
Person.prototype.printName = function () {
    console.log(`Hey, my name is ${this.first_name} ${this.last_name}`);
}
Developer.prototype.printName = function () {
    console.log(`Helllllooooo, my name is ${this.first_name} ${this.last_name}`);
}
const dev1 = new Person('John', 'Doe')
dev1.printName()
// console.log(dev1.printName())

const dev2 = new Developer('Somnath', 'Paul', 'JavaScript')
dev2.printName();
// console.log(dev2.printName());


