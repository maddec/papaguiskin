package feathers.examples.componentsExplorer.screens
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.Header;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class MainMenuScreen extends Screen
	{
		private static const LABELS:Vector.<String> = new <String>
		[
			"Button",
			"Callout",
			"Grouped List",
			"List",
			"Picker List",
			"Progress Bar",
			"Scroll Text",
			"Slider",
			"Tab Bar",
			"Text Input",
			"Toggles",
		];
		
		public function MainMenuScreen()
		{
			super();
		}
		
		private var _onButton:Signal = new Signal(MainMenuScreen);
		
		public function get onButton():ISignal
		{
			return this._onButton;
		}

		private var _onCallout:Signal = new Signal(MainMenuScreen);

		public function get onCallout():ISignal
		{
			return this._onCallout;
		}

		private var _onScrollText:Signal = new Signal(MainMenuScreen);

		public function get onScrollText():ISignal
		{
			return this._onScrollText;
		}
		
		private var _onSlider:Signal = new Signal(MainMenuScreen);
		
		public function get onSlider():ISignal
		{
			return this._onSlider;
		}
		
		private var _onToggles:Signal = new Signal(MainMenuScreen);
		
		public function get onToggles():ISignal
		{
			return this._onToggles;
		}

		private var _onGroupedList:Signal = new Signal(MainMenuScreen);

		public function get onGroupedList():ISignal
		{
			return this._onGroupedList;
		}
		
		private var _onList:Signal = new Signal(MainMenuScreen);
		
		public function get onList():ISignal
		{
			return this._onList;
		}
		
		private var _onPickerList:Signal = new Signal(MainMenuScreen);
		
		public function get onPickerList():ISignal
		{
			return this._onPickerList;
		}

		private var _onTabBar:Signal = new Signal(MainMenuScreen);

		public function get onTabBar():ISignal
		{
			return this._onTabBar;
		}

		private var _onTextInput:Signal = new Signal(MainMenuScreen);

		public function get onTextInput():ISignal
		{
			return this._onTextInput;
		}

		private var _onProgressBar:Signal = new Signal(MainMenuScreen);

		public function get onProgressBar():ISignal
		{
			return this._onProgressBar;
		}
		
		private var _header:Header;
		private var _buttons:Vector.<Button> = new <Button>[];
		private var _buttonMaxWidth:Number = 0;
		
		override protected function initialize():void
		{
			const signals:Vector.<Signal> = new <Signal>[this._onButton, this._onCallout, this._onGroupedList, this._onList,
				this._onPickerList, this._onProgressBar, this._onScrollText, this._onSlider, this._onTabBar, this._onTextInput,
				this._onToggles];
			const buttonCount:int = LABELS.length;
			for(var i:int = 0; i < buttonCount; i++)
			{
				var label:String = LABELS[i];
				var signal:Signal = signals[i];
				var button:Button = new Button();
				button.label = label;
				this.triggerSignalOnButtonRelease(button, signal);
				this.addChild(button);
				this._buttons.push(button);
				button.validate();
				this._buttonMaxWidth = Math.max(this._buttonMaxWidth, button.width);
			}

			this._header = new Header();
			this._header.title = "Feathers";
			this.addChild(this._header);
		}
		
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();

			const margin:Number = this._header.height * 0.25;
			const spacingX:Number = this._header.height * 0.2;
			const spacingY:Number = this._header.height * 0.2;

			const contentMaxWidth:Number = this.actualWidth - 2 * margin;
			const buttonCount:int = this._buttons.length;
			var horizontalButtonCount:int = 1;
			var horizontalButtonCombinedWidth:Number = this._buttonMaxWidth;
			while((horizontalButtonCombinedWidth + this._buttonMaxWidth + spacingX) <= contentMaxWidth)
			{
				horizontalButtonCombinedWidth += this._buttonMaxWidth + spacingX;
				horizontalButtonCount++;
				if(horizontalButtonCount == buttonCount)
				{
					break;
				}
			}

			const startX:Number = (this.actualWidth - horizontalButtonCombinedWidth) / 2;
			var positionX:Number = startX;
			var positionY:Number = this._header.y + this._header.height + spacingY;
			for(var i:int = 0; i < buttonCount; i++)
			{
				var button:Button = this._buttons[i];
				button.width = this._buttonMaxWidth;
				button.x = positionX;
				button.y = positionY;
				positionX += this._buttonMaxWidth + spacingX;
				if(positionX + this._buttonMaxWidth > margin + contentMaxWidth)
				{
					positionX = startX;
					positionY += button.height + spacingY;
				}
			}
		}
		
		private function triggerSignalOnButtonRelease(button:Button, signal:Signal):void
		{
			const self:MainMenuScreen = this;
			button.onRelease.add(function(button:Button):void
			{
				signal.dispatch(self);
			});
		}
	}
}