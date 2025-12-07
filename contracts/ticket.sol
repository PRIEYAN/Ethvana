// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TicketSystem {

    uint256 public nextTicketId = 1;

    struct Ticket {
        uint256 ticketId;      
        string ticketCid;    
        address organiser;     
    }

    mapping(uint256 => Ticket) public tickets;

    event TicketCreated(
        uint256 indexed ticketId,
        string metadataCid,
        address indexed organiser
    );

    function createTicket(string memory _cid) external {
        require(bytes(_cid).length > 0, "CID cannot be empty");

        uint256 id = nextTicketId++;

        tickets[id] = Ticket({
            ticketId: id,
            ticketCid: _cid,
            organiser: msg.sender
        });

        emit TicketCreated(id, _cid, msg.sender);
    }
}
