pragma solidity ^0.4.13;

contract pairChance {
    
    address owner;
    uint payPercentaje = 90;
    
    event Status(string _msg, address user, uint amount);
    
    function pairChance() payable {
        
    }
    
    modifier onlyOwner {
		if (msg.sender != owner) {
			revert();
		} else {
			_;
		}
	}
    
    function FlipCoin() payable {
        if((block.timestamp % 2) == 0) {
            if(this.balance < ((msg.value*payPercentaje)/100)) {

                Status('Congratulations, You won! Sry, we didnt have enought Money to pay you, we pay you all the remaining balance of this contract', msg.sender, this.balance);

                msg.sender.transfer(this.balance);
            } else {
                msg.sender.transfer(msg.value * (100 + payPercentaje)/100);

                Status('Congratulations, You won!', msg.sender, msg.value * (100 + payPercentaje)/100);

            }
        } else {

            Status('We are sorry, you lose, try Again to recover your money', msg.sender, msg.value);

        }
    }
    
        
    function kill() onlyOwner {
        Status('Contracted Killed, not longer available to use', msg.sender, this.balance);
	    suicide(owner);
	}
}

contract Lotery {
    
    struct Participant {
        address adr;
        Ticket ticket;
    }
    
    struct Ticket {
        uint[] ticketNumbers;
    }
    
    address owner;
    uint public loteryNumbers;
    address[] public winners;
    bool public hasFinished = false;
    uint loteryMargin = 20;
    
    Participant[]  participants;
    
    uint min = 0;
    uint max = 30; 
    uint public otherRandomNumber = uint(block.number * block.timestamp)%(max + 1) + min;
    
    function Lotery() payable {
        
    }
    
    function buyTicket(uint[] numbers) {
        bool isParticipant = false;
        for(uint i = 0; i < participants.length; i++) {
            if(participants[i].adr == msg.sender) {
                participants[i].ticket = Ticket({ ticketNumbers: numbers});
            }
        }
        if(isParticipant == false) {
            participants.push(Participant({
                adr: msg.sender,
                ticket: Ticket({ ticketNumbers: numbers})
            }));
        }
    }
    
    function isParticipant() returns(bool) {
        for(uint i = 0; i < participants.length; i++) {
            if(participants[i].adr == msg.sender) {
                return true;
            }
        }
        return false;
    }
    
    
    function depositFunds() payable {
        
    }
    
    function withdrawFunds(uint amount) onlyOwner {
        if(this.balance >= amount) {
            owner.transfer(amount);
        } else {
            revert();
        }
    }
    
    function kill() onlyOwner {
        Status('Contracted Killed, not longer available to use', msg.sender, this.balance);
	    suicide(owner);
	}
	
    modifier onlyOwner {
		if (msg.sender != owner) {
			revert();
		} else {
			_;
		}
	}
}
