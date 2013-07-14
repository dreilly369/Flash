package Classes
{
	
	import mx.controls.Alert;
	public class SetMatch
	{
		private var maxPay:int = 10;
		private var bothNice:int = 0;
		private var bothMean:int = 0;
		private var i:int = 0;
		private var player1Type:String = "NS";
		private var p1g:int = 0;
		private var player2Type:String = "NS";
		private var p2g:int = 0;
		private var totalScore:int = 0;
		private var p1Choice:String = "nice";
		private var p2Choice:String = "nice";
		private var p1Last:String = "nice";
		private var p2Last:String = "nice";
		private var outputString:String = "";
		private var RoundMax:int = 0;
		private var p1Score:int = 0;
		private var p2Score:int = 0;
		private var p1Ready:Boolean = false;
		private var p2Ready:Boolean = false;
		private var matchMax:int = 0;
		private var matchComplete:Boolean = false;
		private var ClassicPts:Boolean = false;
		
		public function SetMatch()
		{
	
		}
		
		public function setRounds(numRounds:int):void{
			i = numRounds;
		}
		
		public function setClassicPay(sel:String):void{
			if(sel=="true"){
				ClassicPts = true;
				Alert.show("Classic points on");
			}else if(sel=="false"){
				ClassicPts = false;
				
			}
		}
		
		public function setMaxPayout(MaxPay:int):void{
			maxPay = MaxPay;
		}
		
		public function ScoreRound(currPay:int):void
		{
			
			if(p1Choice=="nice"&&p2Choice=="mean"){
				p1Last = "nice";
				p2Last = "mean";
				p2Score += currPay;
				outputString += currPay.toString()+" Is the max possible pay this round\n\n"
				outputString += "Player 1 = "+p1Score+" Player 2 = "+p2Score+"\n\n";
			}
			if(p1Choice=="nice"&&p2Choice=="nice"){
				p1Last = "nice";
				p2Last = "nice";
				p1Score += bothNice;
				p2Score += bothNice;
				outputString += "Player 1 = "+p1Score+" Player 2 = "+p2Score+"\n\n";
			}
			if(p1Choice=="mean"&&p2Choice=="nice"){
				p1Last = "mean";
				p2Last = "nice";
				p1Score += currPay;
				outputString += "Player 1 = "+p1Score+" Player 2 = "+p2Score+"\n\n";
			}
			if(p1Choice=="mean"&&p2Choice=="mean"){
				p1Last = "mean";
				p2Last = "mean";
				p1Score += bothMean;
				p2Score += bothMean;
				outputString += "Player 1 = "+p1Score+" Player 2 = "+p2Score+"\n\n";
			}
		}
		
		private function playGreedy(plNum:int, GreedLevel:int,Payout:int,last:String):void
		{
			var BreakingPoint:int = Math.round((maxPay/100)*GreedLevel);
			
			outputString += BreakingPoint.toString()+" is the level that should switch greedy\n";
			var ret:String = "";
			if(plNum==1){
				if(BreakingPoint>Payout&&last=="nice"){
					outputString += "BreakingPoint>Payout&&last==nice\n";
					p1Choice = "nice";
				}else if(BreakingPoint>Payout&&last=="mean"){
					//Check to see if this player will maintain a lead.
					if(Payout<=(BreakingPoint/2)){
						outputString += "Greedy will maintain advantage so\n";
						p1Choice = "nice";
					}else{
						//if not play mean
						p1Choice = "mean";
					}
				}else if(BreakingPoint<=Payout){
					outputString += "BreakingPoint<=Payout\n";
					p1Choice = "mean";
					p1Ready = true;
					
				}
			}else{
				if(BreakingPoint>Payout&&last=="nice"){
					outputString += "BreakingPoint>Payout&&last==nice\n";
					p2Choice = "nice";
				}else if(BreakingPoint>Payout&&last=="mean"){
					//Check to see if this player will maintain a lead.
					if(Payout<=(BreakingPoint/2)){
						outputString += "Greedy will maintain advantage so\n";
						p2Choice = "nice";
					}else{
						//if not play mean
						p2Choice = "mean";
					}
				}else if(BreakingPoint<=Payout){
					outputString += "BreakingPoint<=Payout\n";
					p2Choice = "mean";
					p2Ready = true;
					
				}
			}
		}
		
		private function playTFT(playerNum:int, p1l:String,p2l:String):String{
			if(playerNum==1){
				p1Choice = p2Last;
				var ret:String = p1Choice;
				p1Ready=true;
			}else{
				p2Choice = p1Last;
			    ret = p2Choice;
				p2Ready=true;
			}
			return ret
		}
		
		private function playTFT2010(playerNum:int, p1Score:int,p2Score:int):String{
			if(playerNum==1){
				if(p2Score-p1Score>0){
					p1Choice = "mean";
					var ret:String = p1Choice;
					
				}else{
					p1Choice = "nice";
				    ret = p1Choice;
					
				}
			}else{
				if(p1Score-p2Score>0){
					p2Choice = "mean";
					 ret = p2Choice;
					 
				}else{
					p2Choice = "nice";
					 ret = p2Choice;
					 
				}
			}
			return ret;
		}
		
		private var CurrPay:int = 0;
		public function playMatch():void
		{
			outputString += i+" Rounds to play\n"+player1Type+" vs. "+player2Type+"\n\n";
			
			if(player1Type&&player2Type!="NS"){
				while(i>0){
					if(ClassicPts==true){
						CurrPay = 5;
						outputString += "Playing with Classic Points \n";
						bothNice = 3;
						bothMean = 1;
					}else{
					    CurrPay = Math.random()*maxPay;
						matchMax += CurrPay;
						outputString += CurrPay+" is the Max Pay this round\n";
						bothNice = Math.round((CurrPay/100)*60);
						bothMean = Math.round((CurrPay/100)*40);
					}
					
					if(player1Type=="greedy"){
						playGreedy(1,p1g,CurrPay,p1Last);
						outputString += p1Choice+" is "+player1Type+"'s choice this round  ";
						
						p1Ready=true;
					}
					if(player2Type=="greedy"){
						playGreedy(2,p2g,CurrPay,p2Last);
						outputString += p2Choice+" is "+player2Type+"'s choice this round\n";
						
						p2Ready=true;
					}
					if(player1Type=="tft2010"){
						p1Choice = playTFT2010(1,p1Score,p2Score);
						outputString += p1Choice+" is "+player1Type+"'s choice this round  ";
						
						p1Ready=true;
					}
					if(player2Type=="tft2010"){
						p2Choice = playTFT2010(2,p1Score,p2Score);
						outputString += p2Choice+" is "+player2Type+"'s choice this round\n";
						
						p2Ready=true;
					}
					if(player1Type=="tft"){
						playTFT(1,p1Last,p2Last);
						outputString += p1Choice+" is "+player1Type+"'s choice this round  ";
						
						p1Ready=true;
					}
					if(player2Type=="tft"){
						playTFT(2,p1Last,p2Last);
						outputString += p2Choice+" is "+player2Type+"'s choice this round\n";
						
						p2Ready=true;
					}
					if(p1Ready==true&&p2Ready==true){
						ScoreRound(CurrPay);
						p1Ready = false;
						p2Ready = false;
					}
					
					i--;
				}
			}else{
				Alert.show("Please Select Both Players before Starting\n"+player1Type+"\n"+player2Type);
			}
			
			if(i==0){
				outputString += "\n\n The Result is \n ";
				if(p1Score>p2Score){
					var dif:int = p1Score-p2Score;
					outputString += "Player 1 WINS by "+dif.toString()+" with a score of "+p1Score+" Max Possible Earnings this Competition was"+matchMax+"\n.\n.\n.\n";;
				}else if(p1Score<p2Score){
					 dif= p2Score-p1Score;
					outputString += "Player 2 WINS by "+dif.toString()+" with a score of "+p1Score+" Max Possible Earnings this Competition was"+matchMax+"\n.\n.\n.\n";
				}else if(p1Score==p2Score){
					outputString += "It's a TIE "+p1Score +" Max Possible Earnings this Competition was"+matchMax+"\n.\n.\n.\n";;
				}
				//buildGraph();
			}
			
		}
		
		public function getResultText():String{
			return outputString;
		}
		
		//Set the player types
		
		public function setP1Greedy(gl:int):void
		{
			player1Type = "greedy";
			p1g = gl;
			Alert.show(player1Type+" is Player 1's Type\n"+p1g+" is their greed level");
		}
		
		public function setP2Greedy(gl:int):void
		{
			player2Type = "greedy";
			p2g = gl;
			Alert.show(player2Type+" is Player 2's Type\n"+p2g+" is their greed level");
		}
		
		public function setP1TFT():void
		{
			player1Type = "tft";
		}
		
		public function setP2TFT():void
		{
			player2Type = "tft";
		}
		
		public function setP1TFT2010():void
		{
			player1Type = "tft2010";
		}
		
		public function setP2TFT2010():void
		{
			player2Type = "tft2010";
		}
		
		public function getP1Type():String
		{
			return player1Type;
		}
		
		public function getP2Type():String
		{
			return player2Type;
		}
		
		public function getP1Score():int
		{
			 return p1Score;
		}
		
		public function getP2Score():int
		{
			return p2Score;
		}
		
		public function getCompMax():int
		{
			return matchMax;
		}
		
		public function resetBoard():void
		{
			 maxPay = 0;
			 bothNice = 0;
			 bothMean = 0;
			 i = 0;
			 player1Type= "NS";
			 p1g = 0;
			 player2Type= "NS";
			 p2g = 0;
			 totalScore = 0;
			 p1Choice= "nice";
			 p2Choice= "nice";
			 p1Last= "nice";
			 p2Last= "nice";
			 outputString= "";
			 RoundMax = 0;
			 p1Score = 0;
			 p2Score = 0;
			 p1Ready = false;
			 p2Ready= false;
			 matchMax = 0;
		}
	}
}