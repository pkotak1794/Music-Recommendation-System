(deftemplate Music
   (multislot title)
   (multislot artist)
   (multislot top_genre)
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

(assert
   (Music 
      (title {"Blinding Lights"}) 
      (artist {"The Weeknd"}) 
      (top_genre {"canadian contemporary r&b"}) 
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
)

(assert
   (Music 
      (title {"Watermelon Sugar"}) 
      (artist {"Harry Styles"}) 
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

(assert
   (Music 
   	(title {"Mood (feat. iann dior)"}) 
   	(artist "24kGoldn") 
   	(top_genre {"cali rap"}) 
   	(year 2021) 
   	(beats_per_minute 91) 
   	(energy 72) 
   	(danceability 70) 
   	(loudness_dB -4) 
   	(liveness 32) 
   	(valance 73) 
   	(length 141) 
   	(acousticness 17) 
   	(speechiness 4) 
   	(popularity 88)
   )
)

(assert
   (Music 
   	(title {"Mood (feat. iann dior)"}) 
   	(artist "24kGoldn") 
   	(top_genre {"cali rap"}) 
   	(year 2021) 
   	(beats_per_minute 91) 
   	(energy 72) 
   	(danceability 70) 
   	(loudness_dB -4) 
   	(liveness 32) 
   	(valance 73) 
   	(length 141) 
   	(acousticness 17) 
   	(speechiness 4) 
   	(popularity 88)
   )
)

