(deftemplate UserInput
   (slot value)
)

(defrule start-menu
   (not (_music-recommendation))
   =>
   (printout t crlf crlf crlf)
   (printout t "============ Music Recommendation System ============" crlf)
   (printout t "1. Recommend a song based on artist" crlf)
   (printout t "2. Recommend a song based on genre" crlf)
   (printout t "3. Recommend a song based on beats" crlf)
   (printout t "4. Recommend a song based on year" crlf)
   (printout t "5. Recommend a song based on popularity" crlf)
   (printout t "6. Recommend a song based on length" crlf)
   (printout t "7. Recommend a song based on mood" crlf)
   (printout t "8. Exit program" crlf)
   (printout t "=====================================================" crlf)
   (printout t "Enter Choice: ")
   (bind ?menu (read))
   (assert (UserInput (value ?menu)))
)

(defrule exit-program
   ?f <- (UserInput (value 8))
   =>
   (printout t "Exiting the Music Recommendation System." crlf)
   (exit)
)
