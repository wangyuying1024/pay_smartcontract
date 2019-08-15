pragma solidity ^0.4.21;

contract ClientContract {
    string public name;
    uint8 public decimals;
    string public symbol;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    address public Client;
   	
    //ServerContract _serverContract;
   	
    //包含小数的初始余额
   function ClientContract(uint256 _initialAmount, string _tokenName, uint8 _decimalUnits, string _tokenSymbol) public{
        decimals = _decimalUnits;
        totalSupply = _initialAmount*10**uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
        name = _tokenName;
        symbol = _tokenSymbol;
        Client = msg.sender;
       
    }
 
   	modifier onlyClient(){
		require(msg.sender == Client);
		_;
	}
   	
   	//fallback function
	 function() payable{
	 }
    
    function deposite() public payable{
		this.transfer(msg.value);
	}
    
   function transfer(address _to, uint256 _value) onlyClient() public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    //合约余额
   	function getBalance() onlyClient() constant public returns(uint){
		return this.balance;		
	}
	
	function deleteContract() onlyClient() public{
		selfdestruct(Client);
	}
   event Transfer(address indexed _from, address indexed _to, uint256 _value);
   event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}   