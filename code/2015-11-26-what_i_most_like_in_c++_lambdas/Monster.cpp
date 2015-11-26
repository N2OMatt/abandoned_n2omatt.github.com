//THIS CODE IS UNDER THE GPLv3 LICENSE
//Check the LICENSE file in the codes top folder.
//Author: n2omatt - n2o.matt@gmail.com
//Enjoy...

//Header
#include "Monster.h"

//Usings.
using namespace std;

// CTOR //
Monster::Monster() :
    m_health(100)
{
    //Empty...
}

// Public Methods //
std::function<void ()> Monster::getHitFunctionCallback()
{
    return [this]() { m_health -= 10; };
}

int Monster::getHealth() const
{
    return m_health;
}
