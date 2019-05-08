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
    console.log('[posts] connected')
  }

  disconnect() {
    console.log('[posts] disconnected')
  }

  loadMore () {
    const more_posts_url = $('#paginate-load-more-button > div > a.next_page').attr('href')
    $('#load-more-post').hide()
    $.ajax({
      type: 'GET',
      url: `posts${more_posts_url}`,
      dataType: 'script',
      success: function () {
        console.log('succeed')
        $('#load-more-post').show()
      },
      error: function () {
        $('#load-more-post').show()
      }
    })
  }
}
