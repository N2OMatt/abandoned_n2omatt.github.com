//THIS CODE IS UNDER THE GPLv3 LICENSE
//Check the LICENSE file in the codes top folder.
//Author: n2omatt - n2o.matt@gmail.com
//Enjoy...

//Should have a include guard :)

//std
#include <functional> //std::function

class Monster
{
    // CTOR //
public:
    Monster();

    // Public Methods //
public:
    std::function<void ()> getHitFunctionCallback();

    int getHealth() const;

    // Private Methods //
private:
    int m_health;
};
