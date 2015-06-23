# --------------------------------------------------------------------------------------------------------------------------------
# PLAYER
# --------------------------------------------------------------------------------------------------------------------------------
# A cross-browser javascript shim for html5 audio
((audiojs, audiojsInstance, container) ->
	# Use the path to the audio.js file to create relative paths to the swf and player graphics
	# Remember that some systems (e.g. ruby on rails) append strings like '?1301478336' to asset paths
	path = do ->
		`var path`
		re = new RegExp('audio(.min)?.js.*')
		scripts = document.getElementsByTagName('script')
		i = 0
		ii = scripts.length
		while i < ii
			path = scripts[i].getAttribute('src')
			if re.test(path)
				return path.replace(re, '')
			i++
		return
	# ##The audiojs interface
	# This is the global object which provides an interface for creating new `audiojs` instances.
	# It also stores all of the construction helper methods and variables.
	container[audiojs] =
		instanceCount: 0
		instances: {}
		flashSource: '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="$1" width="1" height="1" name="$1" style="position: absolute; left: -1px;"> <param name="movie" value="$2?playerInstance=' + audiojs + '.instances[\'$1\']&datetime=$3"> <param name="allowscriptaccess" value="always"> <embed name="$1" src="$2?playerInstance=' + audiojs + '.instances[\'$1\']&datetime=$3" width="1" height="1" allowscriptaccess="always"> </object>'
		settings:
			autoplay: false
			loop: false
			preload: true
			imageLocation: path + 'img/interface/sprite-player.svg'
			swfLocation: path + 'audiojs.swf'
			useFlash: do ->
				a = document.createElement('audio')
				!(a.canPlayType and a.canPlayType('audio/mpeg;').replace(/no/, ''))
			hasFlash: do ->
				if navigator.plugins and navigator.plugins.length and navigator.plugins['Shockwave Flash']
					return true
				else if navigator.mimeTypes and navigator.mimeTypes.length
					mimeType = navigator.mimeTypes['application/x-shockwave-flash']
					return mimeType and mimeType.enabledPlugin
				else
					try
						ax = new ActiveXObject('ShockwaveFlash.ShockwaveFlash')
						return true
					catch e
				false
			createPlayer:
				markup: '<div class="play-pause"> <p class="play"><img src="img/interface/sprite-player.svg" alt="Play icon"/></p> <p class="pause"><img src="img/interface/sprite-player.svg" alt="Pause icon"/></p> <p class="loading"><img src="img/interface/sprite-player.svg" alt="Loading icon"/></p> <p class="error"><img src="img/interface/sprite-player.svg" alt="Error icon"/></p> </div> <div class="scrubbercontener"> <div class="scrubber"> <div class="progress"></div> <div class="loaded"></div> </div> </div> <div class="time"> <em class="played">00:00</em>/<strong class="duration">00:00</strong> </div> <div id="tracklist"><img src="img/interface/sprite-player.svg" alt="Open and close icon"/></div> <div class="error-message"></div>'
				playPauseClass: 'play-pause'
				scrubberClass: 'scrubber'
				progressClass: 'progress'
				loaderClass: 'loaded'
				timeClass: 'time'
				durationClass: 'duration'
				playedClass: 'played'
				errorMessageClass: 'error-message'
				playingClass: 'playing'
				loadingClass: 'loading'
				errorClass: 'error'
			css: '*{-moz-box-sizing: border-box;-webkit-box-sizing: border-box;box-sizing: border-box;} #wrapperaudiojs {width: 100%; height: 50px;position: relative; text-align: center;transition: height 0.2s ease-in-out 0s;-webkit-transition: height 0.2s ease-in-out 0s;} .audiojs audio {position: absolute; left: -1px; } .audiojs {width: 100%; height: 50px; display: inline-block; overflow: hidden; font-family: monospace; font-size: 12px; vertical-align: bottom;box-shadow: 0 -1px 0 #000;position: relative; z-index: 1;} .audiojs .play-pause {width: 50px; height: 50px; display: inline-block; float: left;  margin: 0px; overflow: hidden; } .audiojs p {display: none; width: 50px; height: 50px; margin: 0px; cursor: pointer; } .audiojs .play {display: block; } .audiojs .scrubbercontener {display: inline-block; float: left;  position: relative; width: calc(100% - 220px); padding: 17px 20px; height: 50px; overflow: hidden;} .audiojs .scrubber {display: inline-block; position: relative; width: 100%; height: 16px; overflow: hidden; background-color: #636363;} .audiojs .progress {position: absolute; height: 16px; width: 0px; z-index: 1; background-color: #F67211; } .audiojs .loaded {position: absolute; top: 0px; left: 0px; height: 16px; width: 0px; background-color: #000 } .audiojs .time {display: inline-block; float: left;  width: 120px; height: 50px; line-height: 49px; color: #ddd; text-shadow: 1px 1px 0px rgba(0, 0, 0, 0.5); text-align: center; box-shadow: 1px 0 0 #000000 inset;} .audiojs .time em {padding: 0px 2px 0px 0px; color: #f9f9f9; font-style: normal; } .audiojs .time strong {padding: 0px 0px 0px 2px; font-weight: normal; color: #636363;} .audiojs #tracklist {position: relative; display: inline-block; float: left;  width: 50px; height: 50px; text-indent: -9000px; cursor: pointer;} .audiojs .error-message {float: left; display: none; margin: 0px 10px; height: 36px; width: 400px; overflow: hidden; line-height: 36px; white-space: nowrap; color: #fff; text-overflow: ellipsis; -o-text-overflow: ellipsis; -icab-text-overflow: ellipsis; -khtml-text-overflow: ellipsis; -moz-text-overflow: ellipsis; -webkit-text-overflow: ellipsis; } .audiojs .error-message a { color: #eee; text-decoration: none; padding-bottom: 1px; border-bottom: 1px solid #999; white-space: wrap; } .audiojs .play {box-shadow: -1px 0 0 #000000 inset, 1px 0 0 #000000 inset;} .audiojs .loading {box-shadow: -1px 0 0 #000000 inset, 1px 0 0 #000000 inset;} .audiojs .error {box-shadow: -1px 0 0 #000000 inset, 1px 0 0 #000000 inset;} .audiojs .pause {box-shadow: -1px 0 0 #000000 inset, 1px 0 0 #000000 inset;} .audiojs #tracklist {box-shadow: -1px 0 0 #000000 inset, 1px 0 0 #000000 inset;} .audiojs .play img {width: 50px; position: absolute; left: 0; top: 0;} .audiojs .loading img {width: 50px; position: absolute; left: 0; top: -50px;} .audiojs .error img {width: 50px; position: absolute; left: 0; top: -100px;} .audiojs .pause img {width: 50px; position: absolute; left: 0; top: -150px;} .audiojs #tracklist img {width: 50px; position: absolute; left: 0; top: -200px;} .audiojs #tracklist.tracklist-opened img {top: -100px;} #wrapperaudiojs, .audiojs .scrubbercontener, .audiojs .time {background: #494949; background: linear-gradient(to bottom, #494949 0%, #040404 100%); background: -webkit-linear-gradient(top, #494949 0%, #040404 100%); background: -o-linear-gradient(top, #494949 0%, #040404 100%); background: -ms-linear-gradient(top, #494949 0%, #040404 100%);} .audiojs .play, .audiojs .loading, .audiojs .error, .audiojs .pause, .audiojs #tracklist {background: #494949;background: linear-gradient(to bottom, #494949 0%, #040404 100%);background: -webkit-linear-gradient(top, #494949 0%, #040404 100%);background: -o-linear-gradient(top, #494949 0%, #040404 100%);background: -ms-linear-gradient(top, #494949 0%, #040404 100%);} .audiojs .play:hover, .audiojs .play:focus, .audiojs .pause:hover, .audiojs .pause:focus, .audiojs #tracklist:hover, .audiojs #tracklist:focus {box-shadow: -50px 0 0 rgba(255, 255, 255, 0.15) inset, -1px 0 0 #000000 inset, 1px 0 0 #000000 inset;} .audiojs .play:active, .audiojs .pause:active, .audiojs #tracklist:active {box-shadow: -50px 0 0 rgba(0, 0, 0, 0.4) inset, -1px 0 0 #000000 inset, 1px 0 0 #000000 inset;} .playing .play, .playing .loading, .playing .error { display: none; } .playing .pause { display: block; } .loading .play, .loading .pause, .loading .error { display: none; } .loading .loading { display: block; } #wrapperaudiojs #playerlist {transition: top 0.2s ease-in-out; -webkit-transition: top 0.2s ease-in-out;overflow: visible;counter-reset: mycontenercounter;background-color: #000;bottom: 0;box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.3);display: inline-block;left: 0;list-style: decimal inside none;margin: 0 auto !important;padding: 0 !important;position: absolute;text-align: left;width: 100% !important;z-index: 0;} #wrapperaudiojs #playerlist li {border-bottom: 1px dashed grey;display: inline-block;margin: 0 20px !important;position: relative;width: calc(100% - 40px);z-index: 1;} #wrapperaudiojs #playerlist li:before {background-color: #F67211;border-radius: 100%;color: #000;content: counter(mycontenercounter, decimal);counter-increment: mycontenercounter;font-size: 18px;height: 30px;line-height: 32px;position: absolute;text-align: center;top: 50%;margin-top: -15px;left: 5px;width: 30px;} #wrapperaudiojs #playerlist li:first-child {margin-top: 10px !important;} #wrapperaudiojs #playerlist li:last-child {margin-bottom: 10px !important; border: none;} #wrapperaudiojs #playerlist li:hover, #wrapperaudiojs #playerlist li:focus {background-color: rgba(255, 255, 255, 0.2);} .error .time, .error .play, .error .pause, .error .scrubber, .error .loading { display: none; } #wrapperaudiojs #playerlist li a {display: inline-block;line-height: 100%;padding: 11px 0 13px 50px;text-decoration: none !important;width: 100%;color: grey !important;} #wrapperaudiojs #playerlist li a:hover, #wrapperaudiojs #playerlist li a:focus {background-color: transparent;} #wrapperaudiojs #playerlist li.playing a {color: white !important;} #wrapperaudiojs #playerlist li.playing:before {background-color: white !important;} .error .error { display: block; } .error .play-pause p { cursor: auto; } .error .error-message { display: block; }'
			trackEnded: (e) ->
			flashError: ->
				player = @settings.createPlayer
				errorMessage = getByClass(player.errorMessageClass, @wrapper)
				html = 'Missing <a href="http://get.adobe.com/flashplayer/">flash player</a> plugin.'
				if @mp3
					html += ' <a href="' + @mp3 + '">Download audio file</a>.'
				container[audiojs].helpers.removeClass @wrapper, player.loadingClass
				container[audiojs].helpers.addClass @wrapper, player.errorClass
				errorMessage.innerHTML = html
				return
			loadError: (e) ->
				player = @settings.createPlayer
				errorMessage = getByClass(player.errorMessageClass, @wrapper)
				container[audiojs].helpers.removeClass @wrapper, player.loadingClass
				container[audiojs].helpers.addClass @wrapper, player.errorClass
				errorMessage.innerHTML = 'Error loading: "' + @mp3 + '"'
				return
			init: ->
				player = @settings.createPlayer
				container[audiojs].helpers.addClass @wrapper, player.loadingClass
				return
			loadStarted: ->
				player = @settings.createPlayer
				duration = getByClass(player.durationClass, @wrapper)
				m = Math.floor(@duration / 60)
				s = Math.floor(@duration % 60)
				container[audiojs].helpers.removeClass @wrapper, player.loadingClass
				duration.innerHTML = (if m < 10 then '0' else '') + m + ':' + (if s < 10 then '0' else '') + s
				return
			loadProgress: (percent) ->
				player = @settings.createPlayer
				loaded = getByClass(player.loaderClass, @wrapper)
				loaded.style.width = 100 * percent + '%'
				return
			playPause: ->
				if @playing
					@settings.play()
				else
					@settings.pause()
				return
			play: ->
				player = @settings.createPlayer
				container[audiojs].helpers.addClass @wrapper, player.playingClass
				return
			pause: ->
				player = @settings.createPlayer
				container[audiojs].helpers.removeClass @wrapper, player.playingClass
				return
			updatePlayhead: (percent) ->
				player = @settings.createPlayer
				progress = getByClass(player.progressClass, @wrapper)
				progress.style.width = 100 * percent + '%'
				played = getByClass(player.playedClass, @wrapper)
				p = @duration * percent
				m = Math.floor(p / 60)
				s = Math.floor(p % 60)
				played.innerHTML = (if m < 10 then '0' else '') + m + ':' + (if s < 10 then '0' else '') + s
				return
		create: (element, options) ->
			`var options`
			options = options or {}
			if element.length
				@createAll options, element
			else
				@newInstance element, options
		createAll: (options, elements) ->
			audioElements = elements or document.getElementsByTagName('audio')
			instances = []
			options = options or {}
			i = 0
			ii = audioElements.length
			while i < ii
				instances.push @newInstance(audioElements[i], options)
				i++
			instances
		newInstance: (element, options) ->
			`var element`
			element = element
			s = @helpers.clone(@settings)
			id = 'audiojs' + @instanceCount
			wrapperId = 'audiojs_wrapper' + @instanceCount
			instanceCount = @instanceCount++
			# Check for `autoplay`, `loop` and `preload` attributes and write them into the settings.
			if element.getAttribute('autoplay') != null
				s.autoplay = true
			if element.getAttribute('loop') != null
				s.loop = true
			if element.getAttribute('preload') == 'none'
				s.preload = false
			# Merge the default settings with the user-defined `options`.
			if options
				@helpers.merge s, options
			# Inject the player html if required.
			if s.createPlayer.markup
				element = @createPlayer(element, s.createPlayer, wrapperId)
			else
				element.parentNode.setAttribute 'id', wrapperId
			# Return a new `audiojs` instance.
			audio = new (container[audiojsInstance])(element, s)
			# If css has been passed in, dynamically inject it into the `<head>`.
			if s.css
				@helpers.injectCss audio, s.css
			# If `<audio>` or mp3 playback isn't supported, insert the swf & attach the required events for it.
			if s.useFlash and s.hasFlash
				@injectFlash audio, id
				@attachFlashEvents audio.wrapper, audio
			else if s.useFlash and !s.hasFlash
				@settings.flashError.apply audio
			# Attach event callbacks to the new audiojs instance.
			if !s.useFlash or s.useFlash and s.hasFlash
				@attachEvents audio.wrapper, audio
			# Store the newly-created `audiojs` instance.
			@instances[id] = audio
			audio
		createPlayer: (element, player, id) ->
			wrapper = document.createElement('div')
			newElement = element.cloneNode(true)
			wrapper.setAttribute 'class', 'audiojs'
			wrapper.setAttribute 'className', 'audiojs'
			wrapper.setAttribute 'id', id
			# Fix IE's broken implementation of `innerHTML` & `cloneNode` for HTML5 elements.
			if newElement.outerHTML and !document.createElement('audio').canPlayType
				newElement = @helpers.cloneHtml5Node(element)
				wrapper.innerHTML = player.markup
				wrapper.appendChild newElement
				element.outerHTML = wrapper.outerHTML
				wrapper = document.getElementById(id)
			else
				wrapper.appendChild newElement
				wrapper.innerHTML = wrapper.innerHTML + player.markup
				element.parentNode.replaceChild wrapper, element
			wrapper.getElementsByTagName('audio')[0]
		attachEvents: (wrapper, audio) ->
			if !audio.settings.createPlayer
				return
			player = audio.settings.createPlayer
			playPause = getByClass(player.playPauseClass, wrapper)
			scrubber = getByClass(player.scrubberClass, wrapper)

			leftPos = (elem) ->
				curleft = 0
				if elem.offsetParent
					loop
						curleft += elem.offsetLeft
						unless elem = elem.offsetParent
							break
				curleft

			container[audiojs].events.addListener playPause, 'click', (e) ->
				audio.playPause.apply audio
				return
			container[audiojs].events.addListener scrubber, 'click', (e) ->
				relativeLeft = e.clientX - leftPos(this)
				audio.skipTo relativeLeft / scrubber.offsetWidth
				return
			# _If flash is being used, then the following handlers don't need to be registered._
			if audio.settings.useFlash
				return
			# Start tracking the load progress of the track.
			container[audiojs].events.trackLoadProgress audio
			container[audiojs].events.addListener audio.element, 'timeupdate', (e) ->
				audio.updatePlayhead.apply audio
				return
			container[audiojs].events.addListener audio.element, 'ended', (e) ->
				audio.trackEnded.apply audio
				return
			container[audiojs].events.addListener audio.source, 'error', (e) ->
				# on error, cancel any load timers that are running.
				clearInterval audio.readyTimer
				clearInterval audio.loadTimer
				audio.settings.loadError.apply audio
				return
			return
		attachFlashEvents: (element, audio) ->
			audio['swfReady'] = false

			audio['load'] = (mp3) ->
				# If the swf isn't ready yet then just set `audio.mp3`. `init()` will load it in once the swf is ready.
				audio.mp3 = mp3
				if audio.swfReady
					audio.element.load mp3
				return

			audio['loadProgress'] = (percent, duration) ->
				audio.loadedPercent = percent
				audio.duration = duration
				audio.settings.loadStarted.apply audio
				audio.settings.loadProgress.apply audio, [ percent ]
				return

			audio['skipTo'] = (percent) ->
				if percent > audio.loadedPercent
					return
				audio.updatePlayhead.call audio, [ percent ]
				audio.element.skipTo percent
				return

			audio['updatePlayhead'] = (percent) ->
				audio.settings.updatePlayhead.apply audio, [ percent ]
				return

			audio['play'] = ->
				# If the audio hasn't started preloading, then start it now.
				# Then set `preload` to `true`, so that any tracks loaded in subsequently are loaded straight away.
				if !audio.settings.preload
					audio.settings.preload = true
					audio.element.init audio.mp3
				audio.playing = true
				# IE doesn't allow a method named `play()` to be exposed through `ExternalInterface`, so lets go with `pplay()`.
				# <http://dev.nuclearrooster.com/2008/07/27/externalinterfaceaddcallback-can-cause-ie-js-errors-with-certain-keyworkds/>
				audio.element.pplay()
				audio.settings.play.apply audio
				return

			audio['pause'] = ->
				audio.playing = false
				# Use `ppause()` for consistency with `pplay()`, even though it isn't really required.
				audio.element.ppause()
				audio.settings.pause.apply audio
				return

			audio['setVolume'] = (v) ->
				audio.element.setVolume v
				return

			audio['loadStarted'] = ->
				# Load the mp3 specified by the audio element into the swf.
				audio.swfReady = true
				if audio.settings.preload
					audio.element.init audio.mp3
				if audio.settings.autoplay
					audio.play.apply audio
				return

			return
		injectFlash: (audio, id) ->
			flashSource = @flashSource.replace(/\$1/g, id)
			flashSource = flashSource.replace(/\$2/g, audio.settings.swfLocation)
			# `(+new Date)` ensures the swf is not pulled out of cache. The fixes an issue with Firefox running multiple players on the same page.
			flashSource = flashSource.replace(/\$3/g, +new Date + Math.random())
			# Inject the player markup using a more verbose `innerHTML` insertion technique that works with IE.
			html = audio.wrapper.innerHTML
			div = document.createElement('div')
			div.innerHTML = flashSource + html
			audio.wrapper.innerHTML = div.innerHTML
			audio.element = @helpers.getSwf(id)
			return
		helpers:
			merge: (obj1, obj2) ->
				for attr of obj2
					`attr = attr`
					if obj1.hasOwnProperty(attr) or obj2.hasOwnProperty(attr)
						obj1[attr] = obj2[attr]
				return
			clone: (obj) ->
				if obj == null or typeof obj != 'object'
					return obj
				temp = new (obj.constructor)
				for key of obj
					temp[key] = arguments.callee(obj[key])
				temp
			addClass: (element, className) ->
				re = new RegExp('(\\s|^)' + className + '(\\s|$)')
				if re.test(element.className)
					return
				element.className += ' ' + className
				return
			removeClass: (element, className) ->
				re = new RegExp('(\\s|^)' + className + '(\\s|$)')
				element.className = element.className.replace(re, ' ')
				return
			injectCss: (audio, string) ->
				# If an `audiojs` `<style>` tag already exists, then append to it rather than creating a whole new `<style>`.
				prepend = ''
				styles = document.getElementsByTagName('style')
				css = string.replace(/\$1/g, audio.settings.imageLocation)
				i = 0
				ii = styles.length
				while i < ii
					title = styles[i].getAttribute('title')
					if title and ~title.indexOf('audiojs')
						style = styles[i]
						if style.innerHTML == css
							return
						prepend = style.innerHTML
						break
					i++
				head = document.getElementsByTagName('head')[0]
				firstchild = head.firstChild
				style = document.createElement('style')
				if !head
					return
				style.setAttribute 'type', 'text/css'
				style.setAttribute 'title', 'audiojs'
				if style.styleSheet
					style.styleSheet.cssText = prepend + css
				else
					style.appendChild document.createTextNode(prepend + css)
				if firstchild
					head.insertBefore style, firstchild
				else
					head.appendChild styleElement
				return
			cloneHtml5Node: (audioTag) ->
				fragment = document.createDocumentFragment()
				doc = if fragment.createElement then fragment else document
				doc.createElement 'audio'
				div = doc.createElement('div')
				fragment.appendChild div
				div.innerHTML = audioTag.outerHTML
				div.firstChild
			getSwf: (name) ->
				swf = document[name] or window[name]
				if swf.length > 1 then swf[swf.length - 1] else swf
		events:
			memoryLeaking: false
			listeners: []
			addListener: (element, eventName, func) ->
				# For modern browsers use the standard DOM-compliant `addEventListener`.
				if element.addEventListener
					element.addEventListener eventName, func, false
					# For older versions of Internet Explorer, use `attachEvent`.
					# Also provide a fix for scoping `this` to the calling element and register each listener so the containing elements can be purged on page unload.
				else if element.attachEvent
					@listeners.push element
					if !@memoryLeaking
						window.attachEvent 'onunload', ->
							if @listeners
								i = 0
								ii = @listeners.length
								while i < ii
									container[audiojs].events.purge @listeners[i]
									i++
							return
						@memoryLeaking = true
					element.attachEvent 'on' + eventName, ->
						func.call element, window.event
						return
				return
			trackLoadProgress: (audio) ->
				`var audio`
				# If `preload` has been set to `none`, then we don't want to start loading the track yet.
				if !audio.settings.preload
					return
				readyTimer = undefined
				loadTimer = undefined
				audio = audio
				ios = /(ipod|iphone|ipad)/i.test(navigator.userAgent)
				# Use timers here rather than the official `progress` event, as Chrome has issues calling `progress` when loading mp3 files from cache.
				readyTimer = setInterval((->
					if audio.element.readyState > -1
						# iOS doesn't start preloading the mp3 until the user interacts manually, so this stops the loader being displayed prematurely.
						if !ios
							audio.init.apply audio
					if audio.element.readyState > 1
						if audio.settings.autoplay
							audio.play.apply audio
						clearInterval readyTimer
						# Once we have data, start tracking the load progress.
						loadTimer = setInterval((->
							audio.loadProgress.apply audio
							if audio.loadedPercent >= 1
								clearInterval loadTimer
							return
						), 200)
					return
				), 200)
				audio.readyTimer = readyTimer
				audio.loadTimer = loadTimer
				return
			purge: (d) ->
				a = d.attributes
				i = undefined
				if a
					i = 0
					while i < a.length
						if typeof d[a[i].name] == 'function'
							d[a[i].name] = null
						i += 1
				a = d.childNodes
				if a
					i = 0
					while i < a.length
						purge d.childNodes[i]
						i += 1
				return
			ready: do ->
				(fn) ->
					win = window
					done = false
					top = true
					doc = win.document
					root = doc.documentElement
					add = if doc.addEventListener then 'addEventListener' else 'attachEvent'
					rem = if doc.addEventListener then 'removeEventListener' else 'detachEvent'
					pre = if doc.addEventListener then '' else 'on'

					init = (e) ->
						if e.type == 'readystatechange' and doc.readyState != 'complete'
							return
						(if e.type == 'load' then win else doc)[rem] pre + e.type, init, false
						if !done and (done = true)
							fn.call win, e.type or e
						return

					poll = ->
						try
							root.doScroll 'left'
						catch e
							setTimeout poll, 50
							return
						init 'poll'
						return

					if doc.readyState == 'complete'
						fn.call win, 'lazy'
					else
						if doc.createEventObject and root.doScroll
							try
								top = !win.frameElement
							catch e
							if top
								poll()
						doc[add] pre + 'DOMContentLoaded', init, false
						doc[add] pre + 'readystatechange', init, false
						win[add] pre + 'load', init, false
					return
	# ## The audiojs class
	# We create one of these per `<audio>` and then push them into `audiojs['instances']`.

	container[audiojsInstance] = (element, settings) ->
		# Each audio instance returns an object which contains an API back into the `<audio>` element.
		@element = element
		@wrapper = element.parentNode
		@source = element.getElementsByTagName('source')[0] or element
		# First check the `<audio>` element directly for a src and if one is not found, look for a `<source>` element.
		@mp3 = do (element) ->
			source = element.getElementsByTagName('source')[0]
			element.getAttribute('src') or (if source then source.getAttribute('src') else null)
		@settings = settings
		@loadStartedCalled = false
		@loadedPercent = 0
		@duration = 1
		@playing = false
		return

	container[audiojsInstance].prototype =
		updatePlayhead: ->
			percent = @element.currentTime / @duration
			@settings.updatePlayhead.apply this, [ percent ]
			return
		skipTo: (percent) ->
			if percent > @loadedPercent
				return
			@element.currentTime = @duration * percent
			@updatePlayhead()
			return
		load: (mp3) ->
			@loadStartedCalled = false
			@source.setAttribute 'src', mp3
			# The now outdated `load()` method is required for Safari 4
			@element.load()
			@mp3 = mp3
			container[audiojs].events.trackLoadProgress this
			return
		loadError: ->
			@settings.loadError.apply this
			return
		init: ->
			@settings.init.apply this
			return
		loadStarted: ->
			# Wait until `element.duration` exists before setting up the audio player.
			if !@element.duration
				return false
			@duration = @element.duration
			@updatePlayhead()
			@settings.loadStarted.apply this
			return
		loadProgress: ->
			if @element.buffered != null and @element.buffered.length
				# Ensure `loadStarted()` is only called once.
				if !@loadStartedCalled
					@loadStartedCalled = @loadStarted()
				durationLoaded = @element.buffered.end(@element.buffered.length - 1)
				@loadedPercent = durationLoaded / @duration
				@settings.loadProgress.apply this, [ @loadedPercent ]
			return
		playPause: ->
			if @playing
				@pause()
			else
				@play()
			return
		play: ->
			ios = /(ipod|iphone|ipad)/i.test(navigator.userAgent)
			# On iOS this interaction will trigger loading the mp3, so run `init()`.
			if ios and @element.readyState == 0
				@init.apply this
			# If the audio hasn't started preloading, then start it now.
			# Then set `preload` to `true`, so that any tracks loaded in subsequently are loaded straight away.
			if !@settings.preload
				@settings.preload = true
				@element.setAttribute 'preload', 'auto'
				container[audiojs].events.trackLoadProgress this
			@playing = true
			@element.play()
			@settings.play.apply this
			return
		pause: ->
			@playing = false
			@element.pause()
			@settings.pause.apply this
			return
		setVolume: (v) ->
			@element.volume = v
			return
		trackEnded: (e) ->
			@skipTo.apply this, [ 0 ]
			if !@settings.loop
				@pause.apply this
			@settings.trackEnded.apply this
			return
	# **getElementsByClassName**
	# Having to rely on `getElementsByTagName` is pretty inflexible internally, so a modified version of Dustin Diaz's `getElementsByClassName` has been included.
	# This version cleans things up and prefers the native DOM method if it's available.

	getByClass = (searchClass, node) ->
		matches = []
		node = node or document
		if node.getElementsByClassName
			matches = node.getElementsByClassName(searchClass)
		else
			i = undefined
			l = undefined
			els = node.getElementsByTagName('*')
			pattern = new RegExp('(^|\\s)' + searchClass + '(\\s|$)')
			i = 0
			l = els.length
			while i < l
				if pattern.test(els[i].className)
					matches.push els[i]
				i++
		if matches.length > 1 then matches else matches[0]

	# The global variable names are passed in here and can be changed if they conflict with anything else.
	return
) 'audiojs', 'audiojsInstance', this
$ ->
	# Setup the player to autoplay the next track
	a = audiojs.createAll(trackEnded: ->
		next = $('ol li.playing').next()
		if !next.length
			next = $('ol li').first()
		next.addClass('playing').siblings().removeClass 'playing'
		audio.load $('a', next).attr('data-src')
		audio.play()
		return
	)
	# Load in the first track
	audio = a[0]

	playerlaunchanim = ->
		if $('#tracklist').hasClass('tracklist-opened')
			$('#tracklist').removeClass 'tracklist-opened'
			$('#tracklist').addClass 'tracklist-closed'
			$('#playerlist').css 'top': '0'
		else
			$('#tracklist').removeClass 'tracklist-closed'
			$('#tracklist').addClass 'tracklist-opened'
			$('#playerlist').css 'top': -heightplayerlist
		return

	first = $('ol a').attr('data-src')
	$('ol li').first().addClass 'playing'
	audio.load first
	# Load in a track on click
	$('ol li').click (e) ->
		e.preventDefault()
		$(this).addClass('playing').siblings().removeClass 'playing'
		audio.load $('a', this).attr('data-src')
		audio.play()
		return
	# Keyboard shortcuts
	$(document).keydown (e) ->
		`var heightplayerlist`
		unicode = if e.charCode then e.charCode else e.keyCode
		# right arrow
		if unicode == 39
			next = $('li.playing').next()
			if !next.length
				next = $('ol li').first()
			next.click()
			# back arrow
		else if unicode == 37
			prev = $('li.playing').prev()
			if !prev.length
				prev = $('ol li').last()
			prev.click()
			# spacebar
		else if unicode == 32
			audio.playPause()
		return
	windowHeight = $(window).height()
	heightplayerlist = $('#playerlist').height()
	# Change variable if playlist is langer at the window height
	if heightplayerlist + 120 >= windowHeight
		heightplayerlist = windowHeight - 140
		$('#wrapperaudiojs #playerlist').css 'height': windowHeight - 140
		$('#wrapperaudiojs #playerlist').css 'overflow': 'scroll'
	# Mask Time if contener is less as 450px width
	if $('#wrapperaudiojs').width() <= 500
		$('.audiojs .time').css 'display': 'none'
		$('.audiojs .scrubbercontener').css 'width': 'calc(100% - 100px)'
	# Playlist animation
	$('#playerlist').css 'top': '0'
	$('#tracklist').addClass 'tracklist-closed'
	$('#tracklist').click playerlaunchanim
	$('#playerlist li a').click playerlaunchanim
	return

# ---
# generated by js2coffee 2.0.4