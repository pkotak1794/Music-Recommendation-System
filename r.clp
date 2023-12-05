
; need to delete this section
(deftemplate Music
   (multislot title)
   (slot artist)
   (slot top_genre)
   (slot year)
   (slot beats_per_minute)
   (slot energy)
   (slot danceability)
   (slot loudness_dB)
   (slot liveness)
   (slot valance)
   (slot length)
   (slot acousticness)
   (slot speechiness)
   (slot popularity)
)

(deffacts initial-data
   (Music 
      (title "Blinding Lights") 
      (artist "The Weeknd") 
      (top_genre "canadian contemporary r&b") 
      (year 2020) 
      (beats_per_minute 171) 
      (energy 73) 
      (danceability 51) 
      (loudness_dB -6) 
      (liveness 9) 
      (valance 33) 
      (length 200) 
      (acousticness 0) 
      (speechiness 6) 
      (popularity 91)
   )

   (Music 
      (title "Watermelon Sugar") 
      (artist "Harry Styles") 
      (top_genre "pop") 
      (year 2019) 
      (beats_per_minute 95) 
      (energy 82) 
      (danceability 55) 
      (loudness_dB -4) 
      (liveness 34) 
      (valance 56) 
      (length 174) 
      (acousticness 12) 
      (speechiness 4) 
      (popularity 88)
   )
)
; delete up to this portion 

; defines structure of user input 
(deftemplate UserInput
   (slot value)
   (slot genre (type STRING))
   (slot artist (type STRING))
   (slot beats_per_minute)
   (slot year)
   (slot popularity)
   (slot length)
   (slot mood)
) 

; program start with homepage menu 
(defrule get-user-input
   =>
   (printout t crlf crlf)
   (printout t "============ Music Recommendation System ============" crlf)
   (printout t "1. Recommend based on genre" crlf)
   (printout t "2. Recommend based on artist" crlf)
   (printout t "3. Recommend based on beats" crlf)
   (printout t "4. Recommend based on year" crlf)
   (printout t "5. Recommend based on popularity" crlf)
   (printout t "6. Recommend based on length" crlf)
   (printout t "7. Recommend based on mood" crlf)
   (printout t "8. Exit program" crlf)
   (printout t "======================================================" crlf)
   (printout t "Enter a Value from the Menu: ")
   (bind ?value (read))
   (assert (UserInput (value ?value)))
)

; case 1, recommend song by genre
(defrule recommend-by-genre
   (UserInput (value 1))
   =>
   (printout t "Enter the genre you like: ")
   (bind ?userGenre (read))
   (printout t crlf crlf)
   (printout t "Recommended songs in the genre " ?userGenre ":" crlf)
   (do-for-all-facts ((?m Music)) (eq ?m:top_genre ?userGenre) 
      (printout t "Title: " ?m:title ", Artist: " ?m:artist crlf))
   (printout t crlf)
)

; case 2, recommend song by artist
(defrule recommend-by-artist
   (UserInput (value 2))
   =>
   (printout t "Enter the name of an artist you like: ")
   (bind ?userArtist (read))
   (printout t crlf crlf)
   (printout t "Recommended songs by " ?userArtist ":" crlf)
   (do-for-all-facts ((?m Music)) (eq ?m:artist ?userArtist) 
      (printout t "Title: " ?m:title ", Artist: " ?m:artist crlf))
   (printout t crlf)
)

; case 3, recommend song by beats_per_minute 
(defrule recommend-by-beats
   (UserInput (value 3))
   =>
   (printout t "Enter the beats-per-minute you prefer (between 70 - 200): ")
   (bind ?userBeats (read))
   (printout t crlf crlf)
   (printout t "Recommended songs with " ?userBeats " per minute:" crlf)
   (do-for-all-facts ((?m Music)) (eq ?m:beats_per_minute ?userBeats) 
      (printout t "Title: " ?m:title ", Artist: " ?m:artist crlf))
   (printout t crlf)
)

; case 4, recommend song by year of release
(defrule recommend-by-year
   (UserInput (value 4))
   =>
   (printout t "Enter a production year for a song you want to hear: ")
   (bind ?userYear (read))
   (printout t crlf crlf)
   (printout t "Recommended songs made in " ?userYear ":" crlf)
   (do-for-all-facts ((?m Music)) (eq ?m:year ?userYear) 
      (printout t "Title: " ?m:title ", Artist: " ?m:artist crlf))
   (printout t crlf)
)

; case 5, recommend song by popularity 
(defrule recommend-by-popularity
   (UserInput (value 5))
   =>
   (printout t "How popular of a song would you like to discover? Enter a number between 50 (less popular) - 100 (more popular): ")
   (bind ?userPopularity (read))
   (printout t crlf crlf)
   (printout t "Recommended songs:" crlf)
   (do-for-all-facts ((?m Music)) (eq ?m:popularity ?userPopularity) 
      (printout t "Title: " ?m:title ", Artist: " ?m:artist crlf))
   (printout t crlf)
)

; case 6, recommend song by length in seconds 
(defrule recommend-by-length
   (UserInput (value 6))
   =>
   (printout t "Enter in seconds how long of a song you want recommended: ")
   (bind ?userLength (read))
   (printout t crlf crlf)
   (printout t "Recommended songs that are " ?userLength " seconds long:" crlf)
   (do-for-all-facts ((?m Music)) (eq ?m:length ?userLength) 
      (printout t "Title: " ?m:title ", Artist: " ?m:artist crlf))
   (printout t crlf)
)

; recommend song by mood (valance in defftemplate) 
(defrule recommend-by-mood
   (UserInput (value 7))
   =>
   (printout t "Enter a number between 5-50 for a mellow song or 51-100 for a happy song: ")
   (bind ?userMood (read))
   (printout t crlf crlf)
   (printout t "Recommended songs that match your mood: " crlf)
   (do-for-all-facts ((?m Music)) (eq ?m:valance ?userMood) 
      (printout t "Title: " ?m:title ", Artist: " ?m:artist crlf))
   (printout t crlf)
)

; exit program, when user is done 
(defrule exit-program
   (UserInput (value 8))
   =>
   (printout t "Thank you for using the Music Recommendation System! Now exiting the program." crlf)
   (halt)
)


