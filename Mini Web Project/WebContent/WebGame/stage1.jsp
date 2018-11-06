<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko" style="background-color: #CFFFAB;">
<head>
<meta charset="utf-8">
<title>sora</title>
<style type="text/css">

#page {
   width: 595px;
   height: 560px;
   margin: 20px 15px 20px 15px;
   background-color: #E4FFD1;
}

section {
   padding-left: 20px;
   line-height: 25px;
   color: #183800;
}

caption {
   margin-top: 10px;
   margin-bottom: 10px;
   font-family: SunFlowerL;
   font-size: 140%;
}

div.backDiv {
  width:60px;
  height:60px;
  background-color: black;
  text-align: center;
  font: normal bolder 20pt Arial;
}

</style>
<script>
 
////////// ��� //////////
var SIZE_SMALL = "s";    //�ʱ�
 
var ROW_SIZE_SMALL = 2;    //�ʱ� ���� ���� ����
var COL_SIZE_SMALL = 2;    //�ʱ� ���� ���� ����
 
var BLOCK_WIDTH = "60";    //���� ���� ũ��
var BLOCK_HEIGHT = "60";  //���� ���� ũ��
 
var BACK_STATUS = 0;    //�޸� ����
var FRONT_STATUS = 1;    //�ո� ����
var TEMP_FRONT_STATUS = 2;  //�ӽ÷� ������ �ո� ����
 
var HEXA_ARRAY = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f");  //16����
////////// ��� //////////
 
////////// ���� ���� //////////
var rowSize = 0;      //���� ũ��
var colSize = 0;      //���� ũ��
var pairCount = 0;      //ī��� ����
var turnCount = 0;      //������ Ƚ��
 
var startFlag = false;    //���� ���� �÷���
var debugFlag = false;    //����� �÷���
 
var playTime = 0;      //���� ���� �ð�(��)
var playTimer = null;    //���� ���� �ð� ���� ����
var cardTimer = null;    //ī�� ������ �ð� ���� ����
 
var oTimeSpan = null;    //���� �ð� ǥ�� SPAN
var oDebugDiv = null;    //����׿� DIV
 
var pairsArray = null;    //ī�� �� ���� �迭 - [no][0]: ����, [no][1]: ��
var dataArray = null;    //���� ���� ���� �迭
var colorArray = null;    //ī�� �� ���� ���� �迭
var statusArray = null;    //ī�� ���� ���� ���� �迭
var cardArray = null;    //ī�� ���� ���� �迭
////////// ���� ���� //////////
 
//���� �ʱ�ȭ
function initGame(size) {
  endGame();
  
  if (size == SIZE_SMALL) {      //�ʱ�
    rowSize = ROW_SIZE_SMALL;
    colSize = COL_SIZE_SMALL;
  } 
  pairCount = rowSize * colSize;
  turnCount = 0;
  
  //�ð� �ʱ�ȭ
  oTimeSpan.innerHTML = 0;
  
  //���� ���̺� DIV ���� ����
  var oDiv = document.getElementById("puzzleDiv");
  oDiv.innerHTML = "";
  
  //���̺� ����
  var oTable = document.createElement("table");
  oTable.border = 0;
  oTable.cellPadding = 1;
  oTable.cellSpacing = 1;
  oTable.width = BLOCK_WIDTH * rowSize;
  oTable.height = BLOCK_HEIGHT * colSize;
  
  //��
  for (var i=0; i<rowSize; i++) {
    var oTR = document.createElement("tr");
    
    //��
    for (var j=0; j<colSize; j++) {
      var oTD = document.createElement("td");
      var sBlock = "<div onmousedown='turnOver(event, "+i+","+j+");' "
            + "class='backDiv'></div>";
      oTD.innerHTML = sBlock;
      oTR.appendChild(oTD);
    }
    oTable.appendChild(oTR);
  }
  
  oDiv.appendChild(oTable);
  
  //DIV�� ���̺��� appendChild�ϸ�
  //���̺��� ������ �ϴµ� ������ �ʾ� �̷��� ó��
  //Internet Explorer 7 ����?
  oDiv.innerHTML = oDiv.innerHTML;
  
  //DIV�� ���õ� �Ŀ� �ٽ� ���������� ��¥ TABLE ��ü��
  oTable = oDiv.childNodes[0];
  
  //���� ������ �迭 ����
  cardArray = new Array();
  
  //�Ź� document.getElementById() �Լ��� ����Ͽ�
  //ī�带 ã�� ���� ��ȿ�����̹Ƿ�
  //DIV ��ü�� ������ �迭�� ����
  for (var i=0; i<rowSize; i++) {
    cardArray[i] = new Array();
    var oTR = oTable.rows[i];
    
    for (var j=0; j<colSize; j++) {  
      var oTD = oTR.cells[j];
      cardArray[i][j] = oTD.childNodes[0];
    }
  }
}
 
//���� ������ �ʱ�ȭ
function initData() {
  pairsArray = new Array();
  for (var i=0; i<pairCount/2; i++) {
    var j=i*2;
    var colorCode = getRandomColor();
    
    pairsArray[j] = new Array();
    pairsArray[j][0] = i;
    pairsArray[j][1] = colorCode;
    
    pairsArray[j+1] = new Array();
    pairsArray[j+1][0] = i;
    pairsArray[j+1][1] = colorCode;
  }
  
  dataArray = new Array();
  colorArray = new Array();
  statusArray = new Array();
  for (var i=0; i<rowSize; i++) {
    dataArray[i] = new Array();
    colorArray[i] = new Array();
    statusArray[i] = new Array();
    for (var j=0; j<colSize; j++) {
      var randomIndex = Math.floor(Math.random() * pairCount);
      if (pairsArray[randomIndex][0] != -1) {
        dataArray[i][j] = pairsArray[randomIndex][0];
        colorArray[i][j] = pairsArray[randomIndex][1];
        
        //�Ҵ������� -1�� �����Ͽ� ��Ȱ��ȭ
        pairsArray[randomIndex][0] = -1;
        
        statusArray[i][j] = BACK_STATUS;
        //cardArray[i][j].innerHTML = dataArray[i][j];
        cardArray[i][j].innerHTML = "";
        cardArray[i][j].style.backgroundColor = "pink";
      } else {
        //������� ���� ���ڰ� ���� ������ �ݺ�
        j--;
      }
    }
  }
}
 
//������ �� ��ȸ
function getRandomColor() {
  var hexaCode = getRandomChar() + getRandomChar() +
          getRandomChar() + getRandomChar() +
          getRandomChar() + getRandomChar();
          
  return "#" + hexaCode;
}
 
//������ 16���� ��ȸ
function getRandomChar() {
  var num = Math.floor(Math.random() * 10) + 5;
  if (num >= 0 && num < HEXA_ARRAY.length) {
    return HEXA_ARRAY[num].toUpperCase();
  } else {
    return "F";
  }
}
 
//������
function turnOver(evt, i, j) {
  if (!startFlag) return;
  if (statusArray[i][j] != BACK_STATUS) return;
 
  //���¿� �� ����
  statusArray[i][j] = TEMP_FRONT_STATUS;
  cardArray[i][j].style.backgroundColor = colorArray[i][j];
  cardArray[i][j].innerHTML = dataArray[i][j];
  
  if (turnCount == 0) {      //ù ��° ������
    turnCount++;
  } else if (turnCount >= 1) {  //�� ��° ������
    turnCount = 0;
    
    //ù ��°�� ������ ���� ī�� ã��
    var oneTurnRowIndex = -1;
    var oneTurnColIndex = -1;
    for (var k=0; k<rowSize; k++) {
      for (var l=0; l<colSize; l++) {
        if (k != i || l != j) {
          if (statusArray[k][l] == TEMP_FRONT_STATUS) {
            oneTurnRowIndex = k;
            oneTurnColIndex = l;
            break;
          }
        }
      }
    }
    if (oneTurnRowIndex == -1 || oneTurnColIndex == -1) {
      //ī�� �ǵ����� Ÿ�̸� ����
      cardTimer = setTimeout(returnBack, 400);
      return;
    }
    
    //������
    if (dataArray[i][j] == dataArray[oneTurnRowIndex][oneTurnColIndex]) {
      statusArray[i][j] = FRONT_STATUS;
      statusArray[oneTurnRowIndex][oneTurnColIndex] = FRONT_STATUS;
 
      //���� ���� üũ
      checkEnd();
    } else {
      //ī�� �ǵ����� Ÿ�̸� ����
      cardTimer = setTimeout(returnBack, 400);
    }
  }
}
 
//�ٽ� �ǵ�����
function returnBack() {
  for (var i=0; i<rowSize; i++) {
    for (var j=0; j<colSize; j++) {
      if (statusArray[i][j] == TEMP_FRONT_STATUS) {
        statusArray[i][j] = BACK_STATUS;
        cardArray[i][j].style.backgroundColor = "pink";
        cardArray[i][j].innerHTML = "";
      }
    }
  }
  
  clearTimeout(cardTimer);
}
 
//���� ���� �˻�
function checkEnd() {
  var allTurnCount = 0;
  for (var i=0; i<rowSize; i++) {
    for (var j=0; j<colSize; j++) {
      if (statusArray[i][j] == FRONT_STATUS) allTurnCount++;
    }
  }
  
  //������ ������ ī�� ���� ��
  if (allTurnCount == rowSize * colSize) {
     var retVal = confirm("��� ������ �Ͻðڽ��ϱ�?");
     if(retVal == true){
        location.href = "stage2.jsp";
     }else{
        endGame();
     }
  }
}
 
//���� ����
function startGame() {
  //���� ���� ������
  endGame();
  
  startFlag = true;
 
  //���� ������ �ʱ�ȭ
  initData();
  
  //�ð� �ʱ�ȭ
  playTime = 15;
  
  oTimeSpan = document.getElementById("timeSpan");
  oTimeSpan.innerHTML = playTime;
  
  setplayTime();
}
 
//������ ���
function print(s) {
  if (!debugFlag) return;
  oDebugDiv.innerHTML += s + "<br>";
}
 
//�ð� ����
function setplayTime() {
  if (startFlag) {
    oTimeSpan.innerHTML = playTime--;
    playTimer = setTimeout(setplayTime, 1000);  //1�ʸ��� �ð� ����
    if(playTime == -1){
       endGame();
    }
  }
}
 
//���� ����
function endGame() {
  startFlag = false;
  clearTimeout(playTimer);
}
 
//ȭ�� �ʱ�ȭ(onload)
function initPage() {
  //��ü �ʱ�ȭ
  oTimeSpan = document.getElementById("timeSpan");
  oDebugDiv = document.getElementById("debugDiv");
  
  
  //�⺻ �ʱ� ������� ����
  initGame(SIZE_SMALL);
}

 
</script>
</head>


<body onload="initPage();"> 

 
<br><br>
 
<!-- ���� ���̺� DIV -->
<div id="puzzleDiv"></div>
 
<br>
 
<!-- ���� ���۰� �� ���� -->
<button onclick="startGame();" style = margin:10px>
<img src ='../image/button1.png' width="30px" height="70px"/></button>
<button onclick="endGame();">
<img src ='../image/button2.png' width="30px" height="70px"/></button>
 
<br><br>
 
<!-- ��� �ð� ǥ�� -->
�ð�: <span id="timeSpan">0</span>��
 
<br><br>
 
<div id="debugDiv"></div>
<embed src = "../sounds/bg1.mp3" autostart ="false" loop="flase" width ="280"height="25"  hidden="true">
</body>

</html>