package main

import "fmt"

func main() {
	var conferenceName = "Go conference"
	const priceTicket = 20
	var remainingTickets = 34
	fmt.Printf("Hello World %v", conferenceName)
	fmt.Printf("we get total of %v", priceTicket)
	fmt.Println("this is worth RM", priceTicket, "we still have", remainingTickets, "Tickets")

	var userName string
	var ticketmoney int
	userName = "Ronaldo"
	ticketmoney = 99
	fmt.Println(userName)
	fmt.Printf("Hey %v ,this is the new price of the ticket, which is RM%v", userName, ticketmoney)
}
