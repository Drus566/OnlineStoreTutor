# The next line of code renders the HTML into the cart element. This is where we
# see that this file is a template and not just pure CoffeeScript. This content is
# formed by a call to the render method on the @cart object. The output of this
# method is processed by an escape_javascript helper method, using a convenient
# alias named j , that converts this Ruby string into a format acceptable as input to
# JavaScript. This is assigned to the cart element’s innerHTML property, [59] which
# inserts the rendered HTML into the page.

cart = document.getElementById("cart")
cart.innerHTML = "<%= j render(@cart) %>"

notice = document.getElementById("notice")
if notice
    notice.style.display = "none"