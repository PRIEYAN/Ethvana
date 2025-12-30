pragma solidity ^0.8.0;

contract Ticket {
/**
 * @dev Creates a new ticket.
 * @param ticketCid The content identifier for the ticket.
 * @param owner The address of the ticket owner.
 * @return The unique identifier for the created ticket.
 */
    struct TicketInfo{
        string ticketCid;
        address owner;
        uint256 createdAt;
        bool isActive;
    }

    mapping(bytes32 => TicketInfo) public tickets;

    function createTicket(string memory ticketCid,address owner) public returns (bytes32){
        bytes32 ticketId = keccak256(
            abi.encodePacked(ticketCid, owner, block.timestamp)
        );
        tickets[ticketId] = TicketInfo({
            ticketCid: ticketCid,
            owner: owner,
            createdAt: block.timestamp,
            isActive: true
        });
        return ticketId;
    }


/**
 * @dev Books a ticket for a user.
 * @param users The address of the user booking the ticket.
 * @param ticketId The unique identifier of the ticket to be booked.
 * @return The booking information for the ticket.
 */

    struct Booking{
        address user;
        bytes32 ticketId;
        uint256 bookedAt;
    }

    // map address -> Booking to track per-user booking
    mapping(address => Booking) public bookings;
    uint256 public bookingCount = 0;

    function bookTicket(bytes32 ticketId) public returns (Booking memory) {
        require(tickets[ticketId].isActive, "Ticket does not exist");
        require(bookings[msg.sender].bookedAt == 0, "Already booked");

        bookings[msg.sender] = Booking({
            user: msg.sender,
            ticketId: ticketId,
            bookedAt: block.timestamp
        });

        bookingCount += 1;

        return bookings[msg.sender];
    }

}

