package 
{
	import com.brightcove.api.APIModules;
	import com.brightcove.api.CustomModule;
	import com.brightcove.api.events.AdEvent;
	import com.brightcove.api.events.ExperienceEvent;
	import com.brightcove.api.events.MenuEvent;
	import com.brightcove.api.modules.AdvertisingModule;
	import com.brightcove.api.modules.ExperienceModule;
	import com.brightcove.api.modules.MenuModule;
	import com.brightcove.api.modules.VideoPlayerModule;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	
	/**
	 * Logo overlay for Brightcove Video Cloud Players
	 */
	public class PlayerLogo extends CustomModule 
	{
		// Things to customise
		const LOG_TO_JAVASCRIPT:Boolean = true; // Log messages to Javascript console, if available
		private var _logoURL:String = "http://cs1.brightcodes.net/ben/img/genericlogo.png"; // Your image
		private var _logoParamName:String = "customLogoUrl"; // The name of a param that can be used in the publishing code to override the image URL
		private var _logoOffsetX:int = 10; // Offset from right
		private var _logoOffsetY:int = 30; // Offset from bottom
		
		private var _videoModule:VideoPlayerModule;
		private var _experienceModule:ExperienceModule;
		private var _advertisingModule:AdvertisingModule;
		private var _menuModule:MenuModule;
		private var _overlay:Sprite;
		private var _loader:Loader = new Loader();
		private var _logoWidth:int;
		private var _logoHeight:int;
		
		override protected function initialize():void {
			log("initialize");
			_videoModule = player.getModule(APIModules.VIDEO_PLAYER) as VideoPlayerModule;
			_experienceModule = player.getModule(APIModules.EXPERIENCE) as ExperienceModule;
			_menuModule = player.getModule(APIModules.MENU) as MenuModule;
			_advertisingModule = player.getModule(APIModules.ADVERTISING) as AdvertisingModule;
			
			// If a value has been given to override the image, use it if it is a valid image URL
			var customUrl:String = _experienceModule.getPlayerParameter(_logoParamName);
			var regex:RegExp = /(http(s?):)|([\/|.|\w|\s])*\.(?:jpg|jpeg|gif|png)/;
			if(regex.test(customUrl)) {
				_logoURL = customUrl;
				log("Using URL from customLogoUrl: " + customUrl);
			}
			else {
				log("No or invlaid value for customLogoUrl");
			}
			
			if (_experienceModule.getReady()) {
				setup();
			} else {
				_experienceModule.addEventListener(ExperienceEvent.TEMPLATE_READY, onTemplateReady);
			}
		}
		
		private function onTemplateReady(event: ExperienceEvent): void {
			log("Template ready");
			log("Logo URL: " + _logoURL);
			setup();
		}
		
		private function setup():void {
			log ("Setting up");

			// Events that would resize the player
			_experienceModule.addEventListener(ExperienceEvent.ENTER_FULLSCREEN, onResize);
			_experienceModule.addEventListener(ExperienceEvent.EXIT_FULLSCREEN, onResize);
			
			// Menu open/close events
			_menuModule.addEventListener(MenuEvent.OVERLAY_MENU_CLOSE, showOverlay);
			_menuModule.addEventListener(MenuEvent.OVERLAY_MENU_OPEN, hideOverlay);
			_menuModule.addEventListener(MenuEvent.MENU_PAGE_CLOSE, showOverlay);
			_menuModule.addEventListener(MenuEvent.MENU_PAGE_OPEN, hideOverlay);
			
			// Ad events
			if (_advertisingModule != null) {
				_advertisingModule.addEventListener(AdEvent.AD_START, hideOverlay);
				_advertisingModule.addEventListener(AdEvent.AD_COMPLETE, showOverlay);
			}
			
			// Get overlay
			_overlay = _videoModule.overlay();
			
			// Load image
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadError);
			_loader.load(new URLRequest(_logoURL));
			
		}
		
		private function loadComplete(event:Event):void {
			// Image has loaded; get dimensions
			log("Loaded image");
			_logoWidth = event.target.content.width;
			_logoHeight = event.target.content.height;
			// Add image to overlay and work out initial position
			_overlay.addChild(_loader);
			repositionOverlay();
		}
		
		private function loadError(event:Event):void {
			log("Error loading image " + event.toString);
		}
		
		private function onResize(event:Event): void {
			log("Resize (" + event.type + ")");
			// Move the overlay
			repositionOverlay();
		}
		
		private function repositionOverlay():void {
			log(_videoModule.getCurrentDisplayWidth().toString());
			log(_videoModule.getCurrentDisplayHeight().toString());
			// Move to new position
			_loader.x = _videoModule.getCurrentDisplayWidth() - _logoOffsetX - _logoWidth;
			_loader.y = _videoModule.getCurrentDisplayHeight() - _logoOffsetY - _logoHeight;;
		}
		
		private function showOverlay(event:Event):void {
			log("Show overlay");
			_overlay.visible = true;
		}
		
		private function hideOverlay(event:Event):void {
			log("Hide overlay");
			_overlay.visible = false;
		}
		
		private function log(message:String): void {
			trace(message);
			message = message.replace("'", "");
			if (LOG_TO_JAVASCRIPT == true) {
				try {
					ExternalInterface.call("function() { if (window.console && window.console.log) {window.console.log('Plugin: " + message + "')} }()");
				}
				catch(error:Error) {
					// Bah, Facebook and your allowscriptaccess=never
				}
			}
		}
		
	}
	
}