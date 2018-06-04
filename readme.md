# Music, Military, MATLAB
### Using MATLAB to Analyze Sound Waves

This project was completed by Ben Hollar, Megan Zuelke, Brennan Thomas, and Mitch Isler under the supervision of Dr. Nora Honken as part of the Freshman Research Experience at the University of Cincinnati. 

This is the entire codebase for the MATLAB project which was used to gather data in pursuit of answering the question: Does a country's national anthem relate to its military strength?

### How To Run

Download the repository, and add it to your MATLAB folder. The repository should retain the same folder structure for the automatic pathing to work.

Once downloaded, simply add MMM.m to your path and run it to create the object. To recreate our original output, do the following:

obj = MMM();
obj.doAnalysis();

### Characteristics Analyzed via MATLAB:
- Tempo and Pace
- Dynamic Expression
- Key

### Countries Analyzed:
1. USA
2. Russia
3. China
4. Japan
5. India
6. France
7. South Korea
8. Italy
9. UK
10. Turkey
11. Costa Rica
12. Andorra
13. Dominica
14. Grenada
15. Kiribati
16. Liechtenstein
17. Canada
18. Vatican City
19. Haiti
20. Palau
21. North Korea

### Can I analyze other songs?
Sure can! If you're using the latest commit, this should work easily -- simply add the MP3 file you'd like to analyze into the MP3 files folder.

If you're using v1.0 (the original code), this is not as simple, but still possible. It would require both adding the song to the MP3 files folder and then directly calling the proper functions, or modifying MMM_Master_Script to include the new song.

### I have more questions.

For more information about the project, please visit [benhollar.com](http://www.benhollar.com/posts/music-military-matlab/). Feel free to contact me directly -- you should find my contact information on the website.
