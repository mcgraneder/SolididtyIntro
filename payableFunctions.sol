pragma solidity 0.8.4;

contract Helloworld {
    
    //this is how we initialise a mapping
    mapping(address => uint) balance;
    
    address owner;
    
    //we can add event logs into our smart contarct
    event depositDone(uint amount, address deposited_to);
    
    //create modifier for onlyowner
    modifier onlyOwner
    {
        require(msg.sender == owner);
        
        
        _;//means run the function
    }
    
    //create a constructor for user input
    constructor()
    {
        owner = msg.sender;
    }
    
    //now we want to create a function which adds or updates our balance
    function Deposit() public payable returns (uint)
    {
        //we only want certain people to be able to add balance//ie we dont want third parties tohave this privelage
        //the contract owner must be the sender (LOOK AT ONLY OWNDER)
        balance[msg.sender] += msg.value;
        
         //here we can log our event
        emit depositDone(msg.value, msg.sender);
        
        return balance[msg.sender];
    }
    
    
    //next we willl create a withdraw function
    function withdraw(uint amount) public returns (uint)
    {
        //we need to check the error handling to make sure that we cannot
        //withdraw more money than we tohave
        
        require(balance[msg.sender] >= amount, "Insuficient funds");
        
        //here we can keep track of the balance before withdrawals
        uint balanceBeforeWithdrawal = balance[msg.sender];
        
        
        //we use the following notation for withdrawals
        msg.sender.transfer(amount);
        
        //once we have transfered we can update our balance and do a few another
        //sanity checks
        balance[msg.sender] = balance[msg.sender] - amount;

        //as a final prrof to make sure our code its ok we can assert to make sure
        //our balance is correct. Our balance must be equal to our previous balance
        //minus the amount
        assert(balance[msg.sender] == balanceBeforeWithdrawal - amount);
        
        //return the balance for viewing
        return balance[msg.sender];
    }
    
    //now we want to create another function which displays our current balance
    function DisplayBalance() public view returns (uint)
    {
        
        return balance[msg.sender];
    }
    
    //what were going to do now is to make another public function which transfers money
    //from one account to another. it takes in the recipient and the amount to be sent
    function transferFunds(address recipient, uint amount_to_send) public
    {
        //we implement require to check the balance of msg.sender. This condition needs
        //to be true for our transfer to work
        require(balance[msg.sender] >= amount_to_send, "Insufficien funds");
        
        //another thing that must be true for our trandfer to work is that the sender is 
        //not the recipient
        require(msg.sender != recipient, "Dont transfer to yourself");
        
        //save previous balance
        uint previousBalance = balance[msg.sender];
        
        //here we are going to call a private transfer function that actually handles 
        //the logic of the transfer
        _transferFunds(msg.sender, recipient, amount_to_send);
        
        //assert correct balance to error handles
        assert(balance[msg.sender] == previousBalance - amount_to_send);
        
    }
    
    //this is the logic of the transfer
    function _transferFunds(address from , address to, uint amount_to_send) private 
    {
        //we first need to take out the transfer amoutn from the senders account
        balance[from] -= amount_to_send;
        
        //then we need to update the balance of the recipient
        balance[to] += amount_to_send;
    }
}
 