--[[

    ------------------------------
    ---       OVERVIEW         ---
    ------------------------------

    The visuals of your objects are just templates that are spawned in. The tables for your items have spots that
    let you specify the templates you want to use. ( To learn about those tables, check "HELP - Which tables do I
    need to make something?")

	Objects can require varying numbers of templates depending on what functions they are using. These might include
    Drop Icons, Inventory Icons, Placed States, Building States, Rebuilding States, Expired States, etc...

    If you have any questions or feedback please feel free to let us know!

        - Creators Discord: https://discord.gg/core-creators
        - Forums: https://forums.coregames.com/

    ------------------------------
    ---    TEMPLATE TYPES      ---
    ------------------------------

    There are two types of templates needed to define the visuals and physical shape of objects put in the world:

    	Client Template: This one should have your fancy kitbash, but no collision (so you walk through it)
    	Static Template: This one might have visuals, but at the very least it would have the collision.
    	Server Template: This one will generally be for server scripts and associated objects.

    	*In certain situations, you may only need one of these, it just depends on the thing you are making.


    For inventory items (stuff that the player can have in their inventory), you may also need:

    	Drop Icon: This will be spawned if the player drops the item out in the world, or if it drops as loot.
    	Inventory Icon: This will be shown in the inventory, you may use 2d icons instead if you wish.

    	*Both of these should have no collision, and turn off camera collision as well.


    Berry Bush Example:

    Lets pretend we have an example object that is a berry bush. The berry bush would need some kind of plant pot to
    be planted in. It would need the stages of the growing plant, as well as its ready look and harvested look. The
    berry bush would also need a berry object that could be placed in the inventory and used to plant new bushes.

    	For this example, you would want the following art templates:

    		Hooked up in Placeable table:
    			Producer Base - Plant Pot (Client)
    			Producer Base - Plant Pot (Static)

    		Hooked up in Producer table:
    			Producer - Berry Bush - Building 1 (Client)
    			Producer - Berry Bush - Building 1 (Static)

    			Producer - Berry Bush - Building 2 (Client)
   				Producer - Berry Bush - Building 2 (Static)

    			Producer - Berry Bush - Ready (Client)
    			Producer - Berry Bush - Ready (Static)

    			Producer - Berry Bush - Rebuilding (Client)
    			Producer - Berry Bush - Rebuilding (Static)

    		Hooked up in Item table:
    			Product - Berry (Inventory Icon)
    			Product - Berry (Drop Icon)

    	*By default, the inventory icon is a template of a 3D model (the icon generator takes a picture of that item
    	when your game is played to display in the inventory). Custom properties on the item data also allows you to use
    	a 2D icon from Core Content, or to use a template of a 2D kitbashed icons.

    	*Core now has the ability to put some contexts inside others for spawned items. So in the Berry Bush Example above,
    	you could also use a "Static" template for each producer state and have a "ClientContext" folder inside it that
    	holds your decorative (non collision) geo and things like FX.


    Tips:

		You don't need to use so many building (growing) states if you do not want to, You could use just one and
		leave the rest blank. Or add extras by adding more columns with the correct names.

		Names do not matter on art templates! I name things this way just so I know what everything is when hooking
		up the data in tables.

		It is also very good to reuse templates if it makes sense to do so. So if all bushes have the same collision,
		then just use one static template with the collision in it. eg. "Producer - Berry Bush (Static)"

		Most art templates don't have any special custom properties on them, or code in them unless the needed some
		extra functionality. Most of them are just art. (There are some advanced features you can optionally add to
		your templates, so that they can visually react to Buffs, or have procers grow at a specific point in the 
		template, but to get started don't worry about any of that.)

		Make sure that the center point (sometimes called a pivot point, or the 0,0,0 of your object) is consistent
		between all of the art for your Producer or Placeable. On most things, that will end up being the bottom
		center. Inventory icons will have their center point more in the middle of the art.

   	Tools work a little differently so they will be covered separately. More details on all of these items and features
   	can be found in the other HELP and README files throughout the project.

   	Have fun! :)

--]]