// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import { TurboLinks } from "turbolinks" // 追記
import $ from 'jquery' // 追記
import 'jquery-ui/ui/widgets/autocomplete.js'; // 追記
import 'bootstrap'; // 追記
import 'tag-it'; // 追記
import "channels"
import "calendar.js"
import "theme.js"
import "image_preview.js"
Rails.start()
ActiveStorage.start()
