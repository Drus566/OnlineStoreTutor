import React from 'react'
import ReactDom from 'react-dom'
import PayTypeSelector from 'PayTypeSelector'

// Due to how Turbolinks works, that event isn’t fired every time our page is
// reloaded. Turbolinks manages the page-loading events for us and instead
// fires the turbolinks:load event. If you were to use DOMContentLoaded , then
// navigate away from the page, and then use the back button, the page would
// not properly set up React and nothing would work. Using turbolinks:load
// ensures that React is set up every time the page is rendered.
document.addEventListener('turbolinks:load', function(){
    var element = document.getElementById("pay-type-component");
    //is to replace element with the React component
    // PayTypeSelector .
    React.render(<PayTypeSelector />, element);
});