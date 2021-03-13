/* prime-number finding program
Originally by Norman Matloff, UC Davis
http://wwwcsif.cs.ucdavis.edu/~davis/40/gdb_Tutorial.htm
Modified by Mark Ardis, RIT, 11/1/2006

Will report a list of all primes which are less than
or equal to the user-supplied upper bound.
WARNING: There are bugs in this program! */

#include <stdio.h>

int primes[15];  /* prime[i] will be 1 if i is prime, 0 otherwise 
*/
int upper_bound; /* check all numbers up through this one for primeness */

void check_prime(int k, int prime[]) {
  int j;

  /* the plan:  see if j divides k, for all values j which are
  themselves prime (no need to try j if it is nonprime), and
  less than or equal to sqrt(k) (if k has a divisor larger
  than this square root, it must also have a smaller one,
  so no need to check for larger ones) */
 
  j = 2;//this while loop checks if the number is prime
  while (j * j <= k) {
    if (primes[j] == 1){
      if (k % j == 0)  {
        primes[k] = 0;
        return;
      } /* if (k % j == 0) */
    } /* if (primes[j] == 1) */
    j++;
  } /* while (1) */

  /* if we get here, then there were no divisors of K, so it is prime */
  primes[k] = 1;

}  /* check_prime() */

int main() {
  int i;

  printf("Enter upper bound:\n");
  scanf("%d", &upper_bound);
  upper_bound = 50 ;
  primes[1] = 1;
  primes[2] = 1;
  for (i = 3; i <= upper_bound; i += 2) { /*this loop goes through and 
then calls CheckPrime to see if the number is divisible by another 
number.*/
    check_prime(i, primes);
    if (primes[i]) {
      printf("%d is a prime\n", i);
    } /* if (primes[i]) */
  } /* for (i = 3; i <= upperbound; i += 2) */
  return 0;
} /* main() */
