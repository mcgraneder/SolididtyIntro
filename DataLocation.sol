pragma solidity 0.8.4;

contract DataLocation
{
    
    //storage --- permenant storage of data (e.g state variable)
    //memory --- temporary storage of data (e.g string variables)
    //calldata --- similar to memory only its READ ONLY
    
    function getString(string memory text) public pure returns(string memory)
    {
        return text;
        
    }
    
    //assignment prompt

}



contract MemoryAndStorage {

    mapping(uint => User) users;

    struct User{
        uint id;
        uint balance;
    }
    
    User[] people; 
    
    function addUserAndBalance(uint id, uint balance) public {
        users[id] = User(id, balance);
        
        //people.push(users[id]);
        
    }

    function updateBalance(uint id, uint balance) public {
        
        //we need to require that we actually have an address
        
         User storage user = users[id];
         user.balance = balance;
    }

    function getBalance(uint id) view public returns (uint) {
        return users[id].balance;
    }

}

