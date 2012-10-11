package feathers.examples.componentsExplorer.screens
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.TabBar;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class TabBarScreen extends Screen
	{
		public function TabBarScreen()
		{
		}

		private var _header:Header;
		private var _backButton:Button;
		private var _tabBar:TabBar;
		private var _label:Label;

		private var _onBack:Signal = new Signal(TabBarScreen);

		public function get onBack():ISignal
		{
			return this._onBack;
		}

		override protected function initialize():void
		{
			this._tabBar = new TabBar();
			this._tabBar.dataProvider = new ListCollection(
			[
				{ label: "One" },
				{ label: "Two" },
				{ label: "Three" },
			]);
			this._tabBar.onChange.add(tabBar_onChange);
			this.addChild(this._tabBar);

			this._label = new Label();
			this._label.text = "selectedIndex: " + this._tabBar.selectedIndex.toString();
			this.addChild(DisplayObject(this._label));

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._header = new Header();
			this._header.title = "Tab Bar";
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

			this._tabBar.width = this.actualWidth;
			this._tabBar.validate();
			this._tabBar.y = this.actualHeight - this._tabBar.height;

			const displayLabel:FeathersControl = FeathersControl(this._label);
			displayLabel.validate();
			displayLabel.x = (this.actualWidth - displayLabel.width) / 2;
			displayLabel.y = this._header.height + (this.actualHeight - this._header.height - this._tabBar.height - displayLabel.height) / 2;
		}

		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}

		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}

		private function tabBar_onChange(tabBar:TabBar):void
		{
			this._label.text = "selectedIndex: " + this._tabBar.selectedIndex.toString();
			this.invalidate();
		}
	}
}
