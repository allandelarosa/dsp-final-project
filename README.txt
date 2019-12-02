
We can make this more formal later; rn this is just for status updates,
outline of our game plan, etc...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

...some day:

- attempted to implement the gradient calculation outlined in the paper;
  after looking into this more, we figured out the method in the 
  paper is WRONG so we fixed it (at least we think we did?)

- in addition to using the built-in function for the gradient, we also
  found a different implementation on Github that did a convolution
  with the Prewitt operator; for some reason this works way better

- for edge detection, it looks like we just need to add the x and y 
  components of the gradient; the x component gives us the horizontal
  edges and y gives the vertical; we don't need to calculated the 
  magnitude and phase (at least, not for edge detection)

- the edge detection is wayyy too sensitive though, since the outlines
  of basically everything, including the features on the buildings, will
  show up; we tried using imresize to decrease the resolution, but it
  didn't really help...
	^might just end up using built-in function for edge detection,
	but we needed the gradient for damage detection anyway

- we ended up calculating the magnitude and phase anyway, since it looks
  like we might need it later for damage detection, but at the moment
  we're not sure what to do with it

We got stuck here since we weren't sure what to do with the 
information from the gradient. Chuyun wanted to ask Mariam for help
but we didn't have a specific question to ask.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

12/2:

- still stuck
- edge detection still too sensitive, probably because of the noise?
- came up with some ways to get around this; image enhancement, filter,
	increase contrast?, blurring, etc.
- going to meet with ta first to see if she has any insight before
	we go too far in the wrong direction


