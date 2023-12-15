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

; templates to search for matching artists
(deftemplate ArtistSearchStarted)
(deftemplate ArtistFound)

; templates to search for matching genres 
(deftemplate GenreSearchStarted)
(deftemplate GenreFound)

; template specifies popularity range for song playlist recommendations in certain rules
(deftemplate PopularityRange
   (slot lower)
   (slot upper)
)

; template specifies popularity range for song recommendation in certain rules
(deftemplate PopRange
   (slot lower)
   (slot upper)
)


; template definition for additional user input 
(deftemplate ComplexQueryInput
   (slot genre (type STRING) (default "none"))
   (slot artist (type STRING) (default "none"))
   (slot year) 
)

; program start with homepage menu 
(defrule get-user-input
   =>
   (printout t crlf crlf)
   (printout t "============ Music Recommendation System ============" crlf)
   (printout t "1. Recommend based on genre" crlf)
   (printout t "2. Recommend based on artist" crlf)
   (printout t "3. Recommend based on beats" crlf)
   (printout t "4. Recommend based on mood & genre" crlf)
   (printout t "5. Recommend based on popularity & genre" crlf)
   (printout t "6. Recommend based on mood" crlf)
   (printout t "7. Recommend based on genre, artist, & year" crlf)
   (printout t "8. Exit program" crlf)
   (printout t "======================================================" crlf)
   (printout t "Enter a Value from the Menu: ")													; user interaction to select a rule
   (bind ?value (read))																					; reads user input 						
   (assert (UserInput (value ?value)))
)

; case 1, recommend song by genre
; user enters preferred genre, if exact genre is found then a playlist of matching songs will be output 
(defrule recommend-by-genre
   (UserInput (value 1))
   =>
   (printout t "Enter the genre you like: ")
   (bind ?userGenre (readline))
   (bind ?userGenre (lowcase ?userGenre))															; lowcase allows for case insensitive input and comparison 
   (printout t crlf crlf)
   (assert (GenreSearchStarted))
   (printout t "Recommended songs in the genre " ?userGenre ":" crlf)
   (do-for-all-facts ((?m Music)) 																	; iterates through facts list 
      (if (eq (str-compare (lowcase (nth$ 1 ?m:top_genre)) ?userGenre) 0) 				; compares user input to each matching slot in fact template
         then 
         (progn																							; prints title & artist of matching music 
            (printout t "Title: " (nth$ 1 ?m:title) ", Artist: " (nth$ 1 ?m:artist) crlf)	
            (assert (GenreFound))
         )
      )
   )
)

; fallback rule when no songs are found in the specified genre
; when no matching songs are found, songs in the specified popularity range will be recommended instead
(defrule no-songs-found-in-genre
   (UserInput (value 1))
   (GenreSearchStarted)
   (not (GenreFound))
   =>
   (printout t "No songs found for the specified genre. Recommending popular songs instead:" crlf)
   (assert (PopularityRange (lower 85) (upper 100)))											
)

; cleanup rule to retract these facts
(defrule cleanup-genre-search
   ?f1 <- (GenreSearchStarted)
   ?f2 <- (GenreFound)
   =>
   (retract ?f1 ?f2)
)

; case 2, recommend song by artist
; user enters preferred artist, if exact artist is found then a playlist of matching songs will be output 
(defrule recommend-by-artist
   (UserInput (value 2))
   =>
   (printout t "Enter the name of an artist you like: ")
   (bind ?userArtist (readline))
   (bind ?userArtist (lowcase ?userArtist))
   (printout t crlf crlf)
   (assert (ArtistSearchStarted))
   (printout t "Recommended songs by " ?userArtist ":" crlf) 
   (do-for-all-facts ((?m Music)) 
      (if (eq (str-compare (lowcase (nth$ 1 ?m:artist)) ?userArtist) 0) 
         then 
         (printout t "Title: " (nth$ 1 ?m:title) ", Artist: " (nth$ 1 ?m:artist) crlf)
         (assert (ArtistFound))
      )
   )
)

; fallback rule when no songs are found for the specified artist
; when no matching songs are found, songs in the specified popularity range will be recommended instead
(defrule no-songs-found-for-artist
   (UserInput (value 2))
   (ArtistSearchStarted)
   (not (ArtistFound))
   =>
   (printout t "No songs found for the specified artist. Recommending popular songs instead:" crlf)
   (assert (PopularityRange (lower 70) (upper 80)))
)

; cleanup rule to retract these facts
(defrule cleanup-artist-search
   ?f1 <- (ArtistSearchStarted)
   ?f2 <- (ArtistFound)
   =>
   (retract ?f1 ?f2)
)

; case 3, recommend songs by beats_per_minute 
; asks user for their preferred bpm and provides songs that are an exact match to that
(defrule recommend-by-beats
   (UserInput (value 3))
   =>
   (printout t "Enter the beats-per-minute you prefer (between 70 - 200): ")
   (bind ?userBeats (read))
   (printout t crlf crlf)
   (bind ?songsFound FALSE)
   (printout t "Recommended songs that have " ?userBeats " bpm:" crlf)
   (do-for-all-facts ((?m Music)) (eq ?m:beats_per_minute ?userBeats) 
      (printout t "Title: " ?m:title ", Artist: " ?m:artist crlf)
      (bind ?songsFound TRUE))
   (if (not ?songsFound)
      then
      (printout t "No songs found for the specified bpm." crlf)						; if no songs found that match the user input bpm
   )
   (printout t crlf)
)


; case 4, recommend song by mood or genre
; recommends only one song instead of a playlist 
; asks user to enter a mood and genre, and recommends a random song from those matches 
(defrule recommend-by-mood-or-genre
   (UserInput (value ?v&:(eq ?v 4))) 
   =>
   (printout t "Enter a number between 5-50 for mellow or 51-100 for happy: ")
   (bind ?userMood (read))
   (printout t "Enter the genre you like: ")
   (bind ?userGenre (readline))
   (bind ?userGenre (lowcase ?userGenre))
   (printout t crlf)

   ; check if there are any songs matching the mood or genre
   (bind ?songsMatchingCriteria (find-all-facts ((?m Music)) 
                                   (or (and (neq ?userGenre "none") (str-compare (lowcase (nth$ 1 ?m:top_genre)) ?userGenre)) ; checks if user input matches, top_genre
                                       (<= (abs (- ?m:valance ?userMood)) 10)))) 			; checks if mood is within 10 units of user input mood & non-negative 

   ; if songs matching the user criteria exist, recommend one at random 
   (if (> (length$ ?songsMatchingCriteria) 0)
      then
      (bind ?randomIndex (random 1 (length$ ?songsMatchingCriteria)))
      (bind ?selectedSong (nth$ ?randomIndex ?songsMatchingCriteria))
      (printout t "Here is a song you may like: " crlf)
      (printout t "Title: " (fact-slot-value ?selectedSong title) ", Artist: " (fact-slot-value ?selectedSong artist) crlf)
      else
      (assert (PopRange (lower 50) (upper 100)))                       ; if no matches, assert popularity fallback rule 
   )
)


; case 5, recommend song by popularity or genre
; recommends only one song instead of a playlist
; asks user to enter a popularity range and genre, and recommends a random song from those matches
(defrule recommend-by-popularity-or-genre
   (UserInput (value ?v&:(eq ?v 5)))
   =>
   (printout t "Enter the popularity you prefer (between 50 (less popular) and 100 (more popular): ")
   (bind ?userPopularity (read))
   (printout t "Enter the genre you like: ")
   (bind ?userGenre (readline))
   (bind ?userGenre (lowcase ?userGenre))
   (printout t crlf)

   ; check if there are any songs matching the popularity or genre
   (bind ?songsMatchingCriteria (find-all-facts ((?m Music)) 
                                   (or (and (neq ?userGenre "none") (str-compare (lowcase (nth$ 1 ?m:top_genre)) ?userGenre))
                                       (and (>= ?m:popularity ?userPopularity) (<= ?m:popularity ?userPopularity)))))

   ; if songs matching the user criteria exist, recommend one at random
   (if (> (length$ ?songsMatchingCriteria) 0)
      then
      (bind ?randomIndex (random 1 (length$ ?songsMatchingCriteria)))
      (bind ?selectedSong (nth$ ?randomIndex ?songsMatchingCriteria))
      (printout t "Here is a song you may like: " crlf)
      (printout t "Title: " (fact-slot-value ?selectedSong title) ", Artist: " (fact-slot-value ?selectedSong artist) crlf)
      else
      (assert (PopRange (lower 50) (upper 100)))									; if there are no matches, assert popularity fallback rule
   )
)

; recommend songs by predefined popularity range
; activates when PopularityRange fact is asserted 
(defrule recommend-by-pop-range
   ?pr <- (PopularityRange (lower ?lower) (upper ?upper))
   =>
   (do-for-all-facts ((?m Music)) 
      (and (>= ?m:popularity ?lower) (<= ?m:popularity ?upper))
      (printout t "Title: " ?m:title ", Artist: " ?m:artist crlf))
)


; case 6, recommend song by mood (valance)
; user enteres preferred mood value, if matches are found then a playlist of songs is output 
; if no matches, then songs within +/- 7 valance 
(defrule recommend-by-mood
   (UserInput (value 6))
   =>
   (printout t "Enter a number between 5-50 for a mellow song or 51-100 for a happy song:  ")
   (bind ?userMood (read))
   (printout t crlf crlf)
   (printout t "Recommended songs within the preferred mood: " crlf)
   
   ; defined range for alternative output 
   (bind ?moodLowerBound (- ?userMood 7))
   (bind ?moodUpperBound (+ ?userMood 7))
   
   (do-for-all-facts ((?m Music)) 
      (if (and (<= ?m:valance ?moodUpperBound) 
               (>= ?m:valance ?moodLowerBound))
         then
         (progn
            (printout t "Title: " ?m:title ", Artist: " ?m:artist crlf)
         )
      )
   )
   
   (printout t crlf)
)

; case 7, recommend based on genre, artist, and year
; recommends only one song instead of a playlist 
; if no matches are found, it recommends a random popular song instead 
(defrule handle-complex-query
   (UserInput (value 7))
   =>
   (printout t "Enter the genre you like: ")
   (bind ?genre (readline))
   (printout t "Enter the artist you like: ")
   (bind ?artist (readline))
   (printout t "Enter the year you want a song from: ")
   (bind ?year (read))
   (assert (ComplexQueryInput (genre ?genre) (artist ?artist) (year ?year)))
   (assert (ProcessComplexQuery))
)

; process the complex query and recommend a song
(defrule recommend-based-on-complex-query
   (ProcessComplexQuery)
   ?cq <- (ComplexQueryInput (genre ?genre) (artist ?artist) (year ?year))
   =>
   (bind ?songs (find-all-facts ((?m Music)) 
                (or (and (neq ?genre "none") (str-compare (lowcase (nth$ 1 ?m:top_genre)) (lowcase ?genre)))
                    (and (neq ?artist "none") (str-compare (lowcase (nth$ 1 ?m:artist)) (lowcase ?artist)))
                    (and (neq ?year "none") (eq ?m:year ?year)))))
   (if (> (length$ ?songs) 0)
      then
      (bind ?randomIndex (random 1 (length$ ?songs)))
      (bind ?selectedSong (nth$ ?randomIndex ?songs))
      (printout t crlf)
      (printout t "Here is a song you may like: " crlf)
      (printout t "Title: " (fact-slot-value ?selectedSong title) ", Artist: " (fact-slot-value ?selectedSong artist) ", Year: " (fact-slot-value ?selectedSong year) crlf)
      else
      (assert (PopRange (lower 50) (upper 100)))
   )
   (retract ?cq)
)

; fallback rule to recommend a random song by popularity if no match is found
(defrule recommend-by-pop-no-match
   (PopRange (lower ?lower) (upper ?upper))
   =>
   (bind ?songs (find-all-facts ((?m Music))
                (and (>= ?m:popularity ?lower) (<= ?m:popularity ?upper))))
   (if (> (length$ ?songs) 0)
      then
      (bind ?randomIndex (random 1 (length$ ?songs)))
      (bind ?selectedSong (nth$ ?randomIndex ?songs))
      (printout t crlf)
      (printout t "Here is a song you may like: " crlf) 
      (printout t "Title: " (fact-slot-value ?selectedSong title) ", Artist: " (fact-slot-value ?selectedSong artist) crlf)
   )
)

; exit program, when user is done 
(defrule exit-program
   (UserInput (value 8))
   =>
   (printout t "Thank you for using the Music Recommendation System! Now exiting the program." crlf)
   (halt)
)

(defrule invalide-choice
   (UserInput (value ?UserInput&:(or (< ?UserInput 1) (> ?UserInput 8))))
   =>
   (printout t "Invalid Choice! Please restart and enter a number 1-8." crlf)
   (halt)
)