pragma solidity ^0.8.0;

contract Ticket{

    struct eventDetails{
        string eventName;
        string eventDate;
        string otherDetails;
    }
    struct organiser{
        address organiserId;
        string organiserName;
        string[] prviousEvents;
    }
    struct schedule{
        uint256 allowed;
        string shortListDate;
    }
    struct payment{
        uint256 amount;
        address[] paid;
    }
    struct ticket {
        string ticketId;
        eventDetails EventDetails;
        organiser Organiser;
        bool scheduleBooking; // default false
        schedule Schedule;
        uint256 maxBooking;
        //mapping(address => string) bookedBy;
        payment Payment;
    }


    struct AttendedHistory{
        uint256[] attended;
        uint256[] notAttended;
    }
    struct user {
        address userId;
        AttendedHistory ethvanaEvent;
    }


}