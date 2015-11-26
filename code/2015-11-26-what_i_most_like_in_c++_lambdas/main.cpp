//THIS CODE IS UNDER THE GPLv3 LICENSE
//Check the LICENSE file in the codes top folder.
//Author: n2omatt - n2o.matt@gmail.com
//Enjoy...

//std
#include <iostream>
//Example
#include "Monster.h"

//Usings
using namespace std;

void hitTheMonster(Monster &monster)
{
    cout << "Before: " << monster.getHealth() << endl;

    auto hitCallback = monster.getHitFunctionCallback();
    hitCallback();

    cout << "After: " << monster.getHealth() << endl;
}

int main()
{
    Monster m;

    hitTheMonster(m);
    hitTheMonster(m);
}
