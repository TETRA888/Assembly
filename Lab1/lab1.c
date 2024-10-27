#include <stdio.h>

int main() {
char str[100], ch;
int count;
// Input string from user
printf("Enter a string: ");
fgets(str, sizeof(str), stdin); // Read string
// Input character to search from user
printf("Enter a character to find its occurrences: ");
scanf("%c", &ch);
// Count occurrences of the character
count = countOccurrences(str, ch);
// Print result
printf("The character '%c' occurs %d times in the string.\n", ch, count);
return 0;
}