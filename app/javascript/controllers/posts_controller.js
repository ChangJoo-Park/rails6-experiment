// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    console.log('connected')
  }

  onScroll () {
    console.log('on scroll')
  }

  loadMore () {
    const more_posts_url = $('#paginate-load-more-button > div > a.next_page').attr('href')
    $.ajax({
      type: 'GET',
      url: `posts/${more_posts_url}`,
      dataType: 'script',
      success: function () {
        console.log('succeed')
      }
    })
  }
}
