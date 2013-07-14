package Classes
{
	import Classes.SetMatch;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import spark.components.Button;
	import spark.components.NumericStepper;

	public class GreedyWindow
	{
		import mx.core.Window;
		import mx.controls.Alert;
		import Classes.SetMatch;
		
		private var num:NumericStepper = new NumericStepper();
		private var playerNum:int = 0;
		private var greedlvl:int = 0;
		private var newWin:Window = new Window();
		private var sm:SetMatch = new SetMatch();
		
		
		public function GreedyWindow(playerNumber:int)
		{
			
			playerNum = playerNumber;
			newWin.width = 250;
			newWin.height = 400;
			
			newWin.x = 5;
			newWin.y = 100;
			newWin.title = "Set The Greedy Level for the Player";
			newWin.open(true);
			
			
			
			num.width = 200;
			num.height 75;
			num.maximum = 100;
			num.minimum = 1;
			num.x = 0;
			num.y =  0;
			num.addEventListener(Event.CHANGE, updateGr);
			newWin.addElement(num);
			
			var btn:Button = new Button();
			btn.width = 200;
			btn.height 75;
			btn.x = num.x;
			btn.y = num.y+100;
			btn.label = "Set";
			btn.addEventListener(MouseEvent.CLICK, setPlayerGreedy);
			newWin.addElement(btn);
		}
		
		private function updateGr(e:Event):void{
			greedlvl = num.value;
		}
	}
}