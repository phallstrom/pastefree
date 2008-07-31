
function switch_theme_to(theme_code) {

  css = $$('link[id=theme_' + theme_code + ']').first();
  css.rel = 'stylesheet';
  ele = $$('#paste_content pre').first();
  ele.removeClassName(ele.className).addClassName(theme_code);
}
