SternClass.sty is a generical style for a course.

\ClassName, \Semester, and \Professor need to be defined;
see FM.sty for an example of a customized version.

The logo is included as an EPS file. This needs epsf.sty
to work, it could be modified to use the "graphics" package instead.

The command

  \title[optional short title]{full title}

should be used in the preamble. Then the document should begin
with

  \makehead
  
See sample.tex for an example.

SternClass.sty takes control of the vertical page parameters,
but not the horizontal ones (e.g., textwidth). I would usually
use narrower margins than in sample.tex.

tim vz

