pragma solidity ^0.4.21;

contract ServerContract {
    
    // user authorize
	mapping(address =>bool) public authorizeUsers;
    address public SCSP;
    address public Client;
    mapping(address => uint256) public balanceOf;
    
    // constructor 

  	function ServerContract() public payable{
		SCSP = msg.sender;
		authorizeUsers[SCSP] = true;
    	balanceOf[msg.sender] = 1000;
	}
	//fallback function
	 function() payable{
	 }
  
    modifier onlySCSP(){
		require(msg.sender == SCSP);
		_;
	}
    modifier onlyClient(){
		require(msg.sender == Client);
		_;
	}
    // only SCSP can add a new user
	function addUser(address newUser) onlySCSP() public returns(bool){
			if (!authorizeUsers[newUser])
			{
				authorizeUsers[newUser] = true;	
			}
		return authorizeUsers[newUser];
	}
    
    // only the SCSP can remove a user
	function removeUser(address oldUser) onlySCSP() public {
			authorizeUsers[oldUser] = false;
	}
    //dangqianshijian
    function nowInSeconds() returns (uint256){
        return now;
    }
  
    //chengfajiaoyi
    function fine(address _client, uint256 _value, uint start, uint daysAfter)  public payable returns (bool success) {
        if (now >= start + daysAfter * 1 days){
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_client] += _value;
        return true;
        }
    }
    
    function withDraw() onlySCSP() payable public{
		require(this.balance > 0);
		SCSP.transfer(this.balance);
	}
    
}	