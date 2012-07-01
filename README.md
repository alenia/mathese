# Mathese

When talking to Rubyists who haven't had formal math training
I have learned that some math 'methods' that I take for granted 
don't appear to be as common as I once thought.

When working on this project I've been trying to explore a few things:

* How to translate math to Ruby to be able to teach Rubyists about math
* The interplay between 'Why I like TDD' and 'Why I like proofs'
* Learning neat stuff about procs and how things work by semi-randomly
  hacking.

## Structure
* In the spec directory you will see a bunch of files that are just unit tests.
* In the spec/proofs directory are essentially translations of
  mathematical proofs to rspec.
* The scratch work spec is just exploration which I have done while
  writing a spec instead of working in irb.

## Caveats
Since this is essentially free-form and not meant for a purpose beyond
learning and exploring, there are many methods that assume 'the
arguments are of a certain type' without explicitly validating the type.
Expect that I have made other similar oversights.
