# CPSC 583 - Final Project <br>
## Music Recommendation System <br>
### Group Members: Xuan Bui & Priyanka Lee <br>


#### Dataset: 
_ Using Kaggle to get a dataset of the Top 100 Streamed Songs & their attributes from the Spotify API. <br>
_ Dataset:(https://www.kaggle.com/datasets/pavan9065/top-100-most-streamed-songs-on-spotify)<br>

#### Project Files: <br> 
<b> songs.csv </b> - holds the dataset downloaded from Kaggle of the "Top 100 Most Streamed Songs on Spotify" <br>
<b> pyscript.py </b> - Python script used to extract the data from the csv file and put it in CLIPS fact format <br>
<b> output.clp </b> - output file of CLIPS facts that were extracted using the Python script <br> 
<b> facts.clp </b> - all the fact templates and facts from the database <br> 
<b> music_rules.clp </b> - rules and user interface for the program <br> 

#### How To Run The Program: <br> 
1.) load the "facts.clp" file into your CLIPS IDE <br>
2.) load the "music_rules.clp" file into your CLIPS IDE <br>
3.) enter (reset) to initialize the fact list <br>
4.) enter (run) to start the program <br> 

#### Techniques: <br>
#### Using CLIPS to build rules and facts: <br>
##### Facts: including title, artist, genre, year, energy, danceability, loudness, liveness, valance, length, acousticsness, speechiness and popularity for each song. <br>
##### Rules: <br>
  + <b> Rule 1 (Genre): </b><br>
      Asks user to enter a genre and provides a playlist of songs that match the user entered genre. <br>
      If no matches are found, user will be recommended a playlist of popular songs instead based on the fallback rule. <br>
  + <b> Rule 2 (Artist): </b><br> 
      Asks user to enter an artist and provides a playlist of songs that match the artist input by the user. <br>
      If no matches are found, user will be recommended a playlist of popular songs instead based on the fallback rule. <br>
  + <b> Rule 3 (Beats Per Minute): </b><br>
      Asks user to enter a preferred beats per minute and provides a playlist of songs that match the bpm input by the user. <br>
      If no matches are found, user will be notified that no matches were found. <br>
  + <b> Rule 4 (Mood & Genre): </b><br>
      Asks user to enter a preferred genre and mood and provides a single song recommendation if there are applicable matches. <br>
      If no matches are found, user will be recommended a single song based on a fallback rule. <br>
  + <b> Rule 5 (Popularity & Genre): </b><br>
      Asks user to enter a popularity value and preferred genre and provides a single song recommendation if there are applicable matches. <br>
      If no matches are found, user will be recommended a single song based on a fallback rule. <br>
  + <b> Rule 6 (Mood): </b><br>
      Asks user to enter a mood preference and provides a playlist of songs if there are applicable matches. <br>
      If no matches are found, user will be recommended a playlist of songs that are within a specified range of the entered mood. <br>
  + <b> Rule 7 (Genre, Artist, & Year): </b><br>
      Asks user to enter a preferred genre, artist, and year and provides a single song recommendation if there are applicable matches. <br>
      If no matches are found, user will be recommended a single song based on a fallback rule. <br>
  + <b> Rule 8 (Exit): </b><br>
      When user is ready to exit the program, this rule will terminate the program. <br> 
 
