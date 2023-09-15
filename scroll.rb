require 'dxruby' 
#define SCROLL_SPEED 2
void BACK::Draw()
{
    //1枚目描画
    DrawGraph(x,y,gh,FALSE);
    //二枚目描画
    DrawGraph(x,y-460,gh,FALSE);
 

    //一番下までスクロールしたら初期値に戻す
    if(y==460+MARGIN)
        y=10;
 
 
}
void BACK::Move()
{
    y+=SCROLL_SPEED;
}
 
void BACK::All()
{
    Draw();
    Move();
}
