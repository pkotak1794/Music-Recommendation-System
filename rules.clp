; defines structure of user input 
(deftemplate UserInput
   (slot value)
   (multislot genre)
   (multislot artist)
   (slot beats)
   (slot year)
   (slot popularity)
   (slot length)
   (slot mood)
) 

; function definition for searching facts by genre
; compares user entered genre to genres defined in facts
(deffunction find-song-by-genre (?genre)
   (find-all-facts ((?m Music))
      (eq ?m:top_genre ?genre)
   )
)

; function definition for searching facts by artist 
; compares user entered artist to artists defined in facts 
(deffunction find-song-by-artist (?artist)
   (find-all-facts ((?m Music))
      (eq ?m:artist ?artist)
   )
)

; menu for user to pick how they would like to get songs recommended to them
; 7 options for song discovery 
(defrule start-menu
   (not (_music-recommendation))
   =>
   (bind ?menu nil)
   (while (not (or (numberp ?menu) (eq ?menu 8)))
      (printout t crlf crlf)
      (printout t "============ Music Recommendation System ============" crlf)
      (printout t "1. Recommend a song based on genre" crlf)
      (printout t "2. Recommend a song based on artist" crlf)
      (printout t "3. Recommend a song based on beats" crlf)
      (printout t "4. Recommend a song based on year" crlf)
      (printout t "5. Recommend a song based on popularity" crlf)
      (printout t "6. Recommend a song based on length" crlf)
      (printout t "7. Recommend a song based on mood" crlf)
      (printout t "8. Exit program" crlf)
      (printout t "======================================================" crlf)
      (printout t "Enter Choice: ")
      (bind ?menu (read))

		; user selected option 1 from the menu
      (if (eq ?menu 1)
         then
         (printout t "Enter your preferred music genre: ")
         (bind ?userGenre (read))
         (assert (UserInput (value ?menu) (genre ?userGenre)))
         
         ; Retrieve songs that match the user's preferred genre
         (bind ?songs (find-song-by-genre ?userGenre))
         (printout t "Debug: User Genre - " ?userGenre crlf)
         (printout t "Debug: Matching Songs - " ?songs crlf)
         (if (neq (length$ ?songs) 0)
            then
            (printout t crlf crlf)
            (printout t "Recommended Songs:" crlf)
            (bind ?firstSong TRUE)
            (loop-for-count (?i (length$ ?songs))
               (bind ?song (nth$ ?i ?songs))
               (printout t "Title: " (fact-slot-value ?song 'title) crlf)
               (printout t "Artist: " (fact-slot-value ?song 'artist) crlf)
               (printout t crlf)
            )
            (assert (_music-recommendation))
            else
            (printout t "No songs found for the specified genre." crlf)
         )
      else
      
         (if (eq ?menu 2)
            then
            (printout t "Enter your preferred artist: ")
            (bind ?userArtist (read))
            (assert (UserInput (value ?menu) (artist ?userArtist)))
            
            ;Retrieve songs that match user's artist preference
            (bind ?songs (find-song-by-artist ?userArtist))
         	(if (neq (length$ ?songs) 0)
            	then
            	(printout t crlf crlf)
            	(printout t "Recommended Songs:" crlf)
            	(bind ?firstSong TRUE)
            	(loop-for-count (?i (length$ ?songs))
               	(bind ?song (nth$ ?i ?songs))
               	(printout t "Title: " (fact-slot-value ?song 'title) crlf)
               	(printout t "Artist: " (fact-slot-value ?song 'artist) crlf)
               	(printout t crlf)
            	)
            	(assert (_music-recommendation))
            	else
            	(printout t "No songs found for the specified genre." crlf)
         	)

         else
            (if (eq ?menu 3)
               then
               (printout t "Enter your preferred beats per minute: ")
               (bind ?userBeats (read))
               (assert (UserInput (value ?menu) (beats ?userBeats)))
            else
               (if (eq ?menu 4)
                  then
                  (printout t "Enter your preferred year: ")
                  (bind ?userYear (read))
                  (assert (UserInput (value ?menu) (year ?userYear)))
               else
                  (if (eq ?menu 5)
                     then
                     (printout t "Enter your preferred popularity: ")
                     (bind ?userPopularity (read))
                     (assert (UserInput (value ?menu) (popularity ?userPopularity)))
                  else
                     (if (eq ?menu 6)
                        then
                        (printout t "Enter your preferred song length: ")
                        (bind ?userLength (read))
                        (assert (UserInput (value ?menu) (length ?userLength)))
                     else
                        (if (eq ?menu 7)
                           then
                           (printout t "Enter your preferred mood: ")
                           (bind ?userMood (read))
                           (assert (UserInput (value ?menu) (mood ?userMood)))
                        else
                           (if (eq ?menu 8)
                              then
                              (printout t "Exiting the Music Recommendation System." crlf)
                              (exit)
                           else
                              (printout t "Invalid input. Please enter a number between 1 and 8." crlf)
                           )
                        )
                     )
                  )
               )
            )
         )
      )
   )
   (halt)
)
