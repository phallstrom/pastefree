class Paste < ActiveRecord::Base

  THEMES = %w[
   active4d
   all_hallows_eve
   amy
   blackboard
   brilliance_black
   brilliance_dull
   cobalt
   dawn
   eiffel
   espresso_libre
   idle
   iplastic
   lazy
   mac_classic
   magicwb_amiga
   pastels_on_dark
   slush_poppies
   spacecadet
   sunburst
   twilight
   zenburnesque
  ] unless const_defined?('THEMES')

  SYNTAXES = %w[
   actionscript
   active4d
   active4d_html
   active4d_ini
   active4d_library
   ada
   antlr
   apache
   applescript
   asp
   asp_vb.net
   bibtex
   blog_html
   blog_markdown
   blog_text
   blog_textile
   build
   bulletin_board
   c
   c++
   cake
   camlp4
   cm
   coldfusion
   context_free
   cs
   css
   css_experimental
   csv
   d
   diff
   dokuwiki
   dot
   doxygen
   dylan
   eiffel
   erlang
   f-script
   fortran
   fxscript
   greasemonkey
   gri
   groovy
   gtd
   gtdalt
   haml
   haskell
   html
   html-asp
   html_django
   html_for_asp.net
   html_mason
   html_rails
   html_tcl
   icalendar
   inform
   ini
   installer_distribution_script
   io
   java
   javaproperties
   javascript
   javascript_+_prototype
   javascript_+_prototype_bracketed
   jquery_javascript
   json
   languagedefinition
   latex
   latex_beamer
   latex_log
   latex_memoir
   lexflex
   lighttpd
   lilypond
   lisp
   literate_haskell
   logo
   logtalk
   lua
   m
   macports_portfile
   mail
   makefile
   man
   markdown
   mediawiki
   mel
   mips
   mod_perl
   modula-3
   moinmoin
   mootools
   movable_type
   multimarkdown
   objective-c
   objective-c++
   ocaml
   ocamllex
   ocamlyacc
   opengl
   pascal
   perl
   php
   plain_text
   pmwiki
   postscript
   processing
   prolog
   property_list
   python
   python_django
   qmake_project
   qt_c++
   quake3_config
   r
   r_console
   ragel
   rd_r_documentation
   regexp
   regular_expressions_oniguruma
   regular_expressions_python
   release_notes
   remind
   restructuredtext
   rez
   ruby
   ruby_experimental
   ruby_on_rails
   s5
   scheme
   scilab
   setext
   shell-unix-generic
   slate
   smarty
   sql
   sql_rails
   ssh-config
   standard_ml
   strings_file
   subversion_commit_message
   sweave
   swig
   tcl
   template_toolkit
   tex
   tex_math
   textile
   tsv
   twiki
   txt2tags
   vectorscript
   xhtml_1.0
   xml
   xml_strict
   xsl
   yaml
   yui_javascript
  ] unless const_defined?('SYNTAXES')

  validates_inclusion_of :theme, :in => THEMES, :allow_blank => true
  validates_inclusion_of :syntax, :in => SYNTAXES, :allow_blank => true
  validates_presence_of :file_type, :unless => Proc.new {|p| p.file_path.blank?}
  validates_presence_of :user_ip
  validates_format_of :user_ip, :with => /\A\d{0,3}\.\d{0,3}\.\d{0,3}\.\d{0,3}\Z/
  validates_presence_of :user_agent

  belongs_to :user

  # 
  # Increment the user's paste count every time we save a paste.
  #
  def after_save
    user.increment!(:paste_count) unless user.nil?
  end

end
