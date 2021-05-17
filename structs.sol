pragma solidity 0.7.5;

contract Helloworld {
    
    //structs demo
    struct person
    {
        uint age;
        string name;
    }
    
    //we now have made our own datat structure of type person.
    //we can now make a person array whcich stores instances of person
    person[] people;
    
    //we can now make a function to give a person instance name and age characteristcis
    function AddPerson(uint _age, string memory name) public 
    {
        //initialise a new person instance like this 
        person memory new_person = person(_age, name);
        //add that person to the people array
        people.push(new_person);
    }
    
    //next we make a function to print out the peple array
    function GetPerson(uint _index) public view returns (uint, string memory)
    {
        person memory person_to_return = people[_index];
        return (person_to_return.age, person_to_return.name);
    }
    
    
    
}
 