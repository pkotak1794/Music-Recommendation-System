import csv

with open('songs.csv', 'r') as csvfile:
    reader = csv.DictReader(csvfile)
    clips_facts = []
    for row in reader:
        clips_facts.append(
            f"(Music (title {row['title']}) (artist {row['artist']}) (top_genre {row['top genre']}) (year {row['year']}) "
            f"(beats_per_minute {row['beats.per.minute']}) (energy {row['energy']}) (danceability {row['danceability']}) "
            f"(loudness_dB {row['loudness.dB']}) (liveness {row['liveness']}) (valance {row['valance']}) "
            f"(length {row['length']}) (acousticness {row['acousticness']}) (speechiness {row['speechiness']}) "
            f"(popularity {row['popularity']})"
        )

with open('output.clp', 'w') as clipsfile:
    for fact in clips_facts:
        clipsfile.write(fact + '\n')
