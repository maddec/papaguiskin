package feathers.examples.componentsExplorer.screens
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.Slider;
	import feathers.core.FeathersControl;
	import feathers.examples.componentsExplorer.data.SliderSettings;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class SliderScreen extends Screen
	{
		public function SliderScreen()
		{
			super();
		}

		public var settings:SliderSettings;

		private var _slider:Slider;
		private var _header:Header;
		private var _backButton:Button;
		private var _settingsButton:Button;
		private var _valueLabel:Label;
		
		private var _onBack:Signal = new Signal(SliderScreen);
		
		public function get onBack():ISignal
		{
			return this._onBack;
		}

		private var _onSettings:Signal = new Signal(SliderScreen);

		public function get onSettings():ISignal
		{
			return this._onSettings;
		}
		
		override protected function initialize():void
		{
			this._slider = new Slider();
			this._slider.minimum = 0;
			this._slider.maximum = 100;
			this._slider.value = 50;
			this._slider.step = this.settings.step;
			this._slider.page = this.settings.page;
			this._slider.direction = this.settings.direction;
			this._slider.liveDragging = this.settings.liveDragging;
			this._slider.onChange.add(slider_onChange);
			this.addChild(this._slider);
			
			this._valueLabel = new Label();
			this._valueLabel.text = this._slider.value.toString();
			this.addChild(DisplayObject(this._valueLabel));

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._settingsButton = new Button();
			this._settingsButton.label = "Settings";
			this._settingsButton.onRelease.add(settingsButton_onRelease);

			this._header = new Header();
			this._header.title = "Slider";
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

			const spacingX:Number = this._header.height * 0.2;

			//auto-size the slider and label so that we can position them properly
			this._slider.validate();

			const displayValueLabel:FeathersControl = FeathersControl(this._valueLabel);
			displayValueLabel.validate();

			const contentWidth:Number = this._slider.width + spacingX + displayValueLabel.width;
			this._slider.x = (this.actualWidth - contentWidth) / 2;
			this._slider.y = (this.actualHeight - this._slider.height) / 2;
			displayValueLabel.x = this._slider.x + this._slider.width + spacingX;
			displayValueLabel.y = this._slider.y + (this._slider.height - displayValueLabel.height) / 2;
		}
		
		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}
		
		private function slider_onChange(slider:Slider):void
		{
			this._valueLabel.text = this._slider.value.toString();
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