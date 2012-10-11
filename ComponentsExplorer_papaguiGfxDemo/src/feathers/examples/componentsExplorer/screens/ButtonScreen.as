package feathers.examples.componentsExplorer.screens
{
	import feathers.display.Image;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.Header;
	import feathers.examples.componentsExplorer.data.ButtonSettings;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class ButtonScreen extends Screen
	{
		[Embed(source="/../assets/images/skull.png")]
		private static const SKULL_ICON:Class;
		
		public function ButtonScreen()
		{
			super();
		}

		public var settings:ButtonSettings;

		private var _button:Button;
		private var _header:Header;
		private var _backButton:Button;
		private var _settingsButton:Button;
		
		private var _icon:Image;
		
		private var _onBack:Signal = new Signal(ButtonScreen);
		
		public function get onBack():ISignal
		{
			return this._onBack;
		}

		private var _onSettings:Signal = new Signal(ButtonScreen);

		public function get onSettings():ISignal
		{
			return this._onSettings;
		}
		
		override protected function initialize():void
		{
			this._icon = new Image(Texture.fromBitmap(new SKULL_ICON()));
			this._icon.scaleX = this._icon.scaleY = this.dpiScale;
			
			this._button = new Button();
			this._button.label = "Click Me";
			this._button.isToggle = this.settings.isToggle;
			if(this.settings.hasIcon)
			{
				this._button.defaultIcon = this._icon;
			}
			this._button.horizontalAlign = this.settings.horizontalAlign;
			this._button.verticalAlign = this.settings.verticalAlign;
			this._button.iconPosition = this.settings.iconPosition;
			this._button.width = 264 * this.dpiScale;
			this._button.height = 264 * this.dpiScale;
			this.addChild(this._button);

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._settingsButton = new Button();
			this._settingsButton.label = "Settings";
			this._settingsButton.onRelease.add(settingsButton_onRelease);

			this._header = new Header();
			this._header.title = "Button";
			this.addChild(this._header);
			this._header.leftItems = new <DisplayObject>
			[
				this._backButton
			];
			this._header.rightItems = new <DisplayObject>
			[
				this._settingsButton
			];
			
			// handles the back hardware key on android
			this.backButtonHandler = this.onBackButton;
		}
		
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();

			this._button.validate();
			this._button.x = (this.actualWidth - this._button.width) / 2;
			this._button.y = (this.actualHeight - this._button.height) / 2;
		}
		
		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}
		
		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}

		private function settingsButton_onRelease(button:Button):void
		{
			this._onSettings.dispatch(this);
		}
	}
}