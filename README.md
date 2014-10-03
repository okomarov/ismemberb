##### Description

Matlab function that applies ismember with flexible (reduced) memory footprint as shown below:

![Memory comparison](https://raw.githubusercontent.com/okomarov/ismemberb/master/ismember_VS_ismemberb.png)

If you are working with large datasets and ismember eats up completely the RAM, starts swapping on disk, freezes your pc,  and causes lots of frustration, you might then want to split the task. This is what `ismemberb()` does for you, with **equivalent** results to `ismember()` applied to the whole dataset.

##### Syntax
Basically, the same as in `ismember()` with the additional ability to specify in how many sub-blocks to process the inputs.
  

##### Examples:

Run unit tests

    ismemberb unit

Default use

    A = randi(100,[1e7,1]);
    B = randi(100,[1e7,1]);
    ismemberb(A,B)

Custom block split

    ismemberb(A,B, [2,3])

Stress test vs ismember()

    A = table(randi(1e6,[3e7,1]),randi(1e6,[3e7,1]));
    B = table(randi(1e6,[3e7,1]),randi(1e6,[3e7,1]));
    [idx1,pos1] = ismember(A,B);
    [idx2,pos2] = ismemberb(A,B);

