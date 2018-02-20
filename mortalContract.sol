contract mortal{

	address public owner;

	function mortal(){

		owner = msg.sender;

	}

}
