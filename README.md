# CST8283 Project #2A - Student Report
This was my first major assignment in my "Business Programming (COBOL)" course at Algonquin College. Written in COBOL, the program loads a file (STUFILE) containing five student names, their student numbers, their program numbers, and their four course numbers and respective marks and generates a mock report card for each student containing their name, program number, and grade average as a number and actual letter. The student's grade was determined with the following numbers:

Grade   Average
A       85 to 100
B       75 to 84
C       65 to 74
D       50 to 64
F       less than 50

<table>
<tr>
<td>Grade</td>
<td>Average</td>
</tr>
<tr>
<td>A</td>
<td>85 to 100</td>
</tr>
<tr>
<td>B</td>
<td>75 to 84</td>
</tr>
<tr>
<td>C</td>
<td>65 to 74</td>
</tr>
<tr>
<td>D</td>
<td>50 to 64</td>
</tr>
<tr>
<td>F</td>
<td>less than 50</td>
</tr>
</table>

I added headers to the output file (STURPT) and formatted the columns to make reading the file easier. Each student was a record, where the average was calculated by adding the four marks together and dividing by four. I used an end-of-file flag to make sure I was not taking any more records than were in the input file.

This project was my first real introduction to programming in COBOL and required the use of the FILE SECTION and WORKING-STORAGE SECTION and various flags as the input file was looped through.
