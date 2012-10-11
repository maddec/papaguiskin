package feathers.examples.componentsExplorer.screens
{
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.controls.Radio;
	import feathers.controls.Screen;
	import feathers.controls.Header;
	import feathers.controls.ToggleSwitch;
	import feathers.core.ToggleGroup;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class ToggleScreen extends Screen
	{
		public function ToggleScreen()
		{
			super();
		}
		
		private var _header:Header;
		private var _toggleSwitch:ToggleSwitch;
		private var _check1:Check;
		private var _check2:Check;
		private var _radio1:Radio;
		private var _radio2:Radio;
		private var _radioGroup:ToggleGroup;
		private var _backButton:Button;
		
		private var _onBack:Signal = new Signal(ToggleScreen);
		
		public function get onBack():ISignal
		{
			return this._onBack;
		}
		
		override protected function initialize():void
		{
			this._toggleSwitch = new ToggleSwitch();
			this._toggleSwitch.isSelected = false;
			this._toggleSwitch.onChange.add(toggleSwitch_onChange);
			this.addChild(this._toggleSwitch);

			this._check1 = new Check();
			this._check1.isSelected = false;
			this._check1.label = "Check 1";
			this.addChild(this._check1);

			this._check2 = new Check();
			this._check2.isSelected = false;
			this._check2.label = "Check 2";
			this.addChild(this._check2);

			this._radioGroup = new ToggleGroup();
			this._radioGroup.onChange.add(radioGroup_onChange);

			this._radio1 = new Radio();
			this._radio1.label = "Radio 1";
			this._radio1.toggleGroup = this._radioGroup;
			this.addChild(this._radio1);

			this._radio2 = new Radio();
			this._radio2.label = "Radio 2";
			this._radio2.toggleGroup = this._radioGroup;
			this.addChild(this._radio2);

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._header = new Header();
			this._header.title = "Toggles";
			this.addChild(this._header);
			this._header.leftItems = new <DisplayObject>
			[
				this._backButton
			];
			
			// handles the back hardware key on android
			this.backButtonHandler = this.onBackButton;
		}
		
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();

			const spacingX:Number = this._header.height * 0.2;
			const spacingY:Number = this._header.height * 0.4;

			//auto-size the toggle switch and label to position them properly
			this._toggleSwitch.validate();
			this._check1.validate();
			this._check2.validate();
			this._radio1.validate();
			this._radio2.validate();

			const contentHeight:Number = this._toggleSwitch.height + this._check1.height + this._radio1.height + 2 * spacingY;
			this._toggleSwitch.x = (this.actualWidth - this._toggleSwitch.width) / 2;
			this._toggleSwitch.y = (this.actualHeight - contentHeight) / 2;

			const checkWidth:Number = this._check1.width + this._check2.width + spacingX;
			this._check1.x = (this.actualWidth - checkWidth) / 2;
			this._check1.y = this._toggleSwitch.y + this._toggleSwitch.height + spacingY;
			this._check2.x = this._check1.x + this._check1.width + spacingX;
			this._check2.y = this._check1.y;

			const radioWidth:Number = this._radio1.width + this._radio2.width + spacingX;
			this._radio1.x = (this.actualWidth - radioWidth) / 2;
			this._radio1.y = this._check1.y + this._check1.height + spacingY;
			this._radio2.x = this._radio1.x + this._radio1.width + spacingX;
			this._radio2.y = this._radio1.y;
		}
		
		private function toggleSwitch_onChange(toggleSwitch:ToggleSwitch):void
		{
			trace("toggle switch isSelected:", this._toggleSwitch.isSelected);
		}

		private function radioGroup_onChange(group:ToggleGroup):void
		{
			trace("radio group change:", this._radioGroup.selectedIndex);
		}
		
		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}
		
		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}
	}
}