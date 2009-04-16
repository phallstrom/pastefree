
function switch_theme_to(theme_code) {
  css = $$('link[id=theme_' + theme_code + ']').first();
  css.rel = 'stylesheet';
  ele = $$('#pasted_content pre').first();
  ele.removeClassName(ele.className).addClassName(theme_code);
}

function toggle_file_instructions(event) {
  $('file_instructions').toggle();
}
function toggle_syntax_instructions(event) {
  $('syntax_instructions').toggle();
}
Event.observe(window, 'load', function() {  
    Event.observe($('paste_image'), "mouseover", toggle_file_instructions);
    Event.observe($('paste_image'), "mouseout", toggle_file_instructions);
    Event.observe($('paste_syntax_tf'), "mouseover", toggle_syntax_instructions);
    Event.observe($('paste_syntax_tf'), "mouseout", toggle_syntax_instructions);
});
