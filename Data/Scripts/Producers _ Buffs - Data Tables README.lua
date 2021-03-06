--[[
     _____               _                                    ____         __  __
    |  __ \             | |                           ___    |  _ \       / _|/ _|
    | |__) | __ ___   __| |_   _  ___ ___ _ __ ___   ( _ )   | |_) |_   _| |_| |_ ___ 
    |  ___/ '__/ _ \ / _` | | | |/ __/ _ \ '__/ __|  / _ \/\ |  _ <| | | |  _|  _/ __|
    | |   | | | (_) | (_| | |_| | (_|  __/ |  \__ \ | (_>  < | |_) | |_| | | | | \__ \
    |_|   |_|  \___/ \__,_|\__,_|\___\___|_|  |___/  \___/\/ |____/ \__,_|_| |_| |___/

    ----------------------------------
    ---          OVERVIEW          ---
    ----------------------------------

    The Producers system allows you to build objects that take an input, change over time and generate an output. They
    were designed with farming / crops in mind, but can be used for a multitude of other cases. Some ideas:

        1. A corn plant that grows over time and produces some corn. If not harvested in time it withers and dies.
        2. A gas engine that can be filled, runs until it's empty and then stops.
        3. A building that takes time to become fully constructed. Once constructed it generates currency periodically.

    When mixed with the Buffs system these examples can become even more interesting:

        1. A corn plant that needs a "watered" buff to grow.
        2. A gas engine that, when running, emits a "power" buff that allows other Producers to progress.
        3. A building that requires the "power" buff to generate currency. While generating currency it emits a "happiness" buff that affects other gameplay.

    Like Gatherables, Producers make use of the Replicator functionality. This means they use 0 networked objects and
    run fairly efficiently at scale. Gatherables are more efficient when you wants many objects in your scene, so it
    becomes a choice between the two systems that depends on how much functionality you need vs. efficiency.

    Producers also introduce a new system called Placeables. Placeables are objects that can be placed by the Player
    during game play. In most cases you will also want to use Player Lots to allow placed Producers to be saved to the
    Players Storage.

    Producers can also be pre-placed by you. This is explained in more detail in the Setup section below.

    If you have any questions or feedback please feel free to let us know!

        - Creators Discord: https://discord.gg/core-creators
        - Forums: https://forums.coregames.com/

    ----------------------------------
    ---           SETUP            ---
    ----------------------------------

    Producers can be pre-placed by you, or placed by Players. Since they are quite flexible and offer a wide variety of
    functionality, they take several steps to set up. Setting Producers up in either case is the same, so we will start
    there.

    Every Producer needs data that defines the functionality and look of that Producer. This data is created in a
    Database that lives in the hierarchy of your project. See the Database README for more details on how they work.

    The "Farming Framework" example project contains a Database that you can use and modify. If you use this as a
    starting point, you can skip ahead to the "Creating the Data" section below.

    --- Creating the Database ---

        1. Create a folder in your hierarchy and name it appropriately. In this example we will use the name "Producers
        Database".

        2. Add a "DatabaseLoader" script as a child of that folder and set the "Database" Custom Property on the script
        to point at the folder you created.

        3. Add a ClientContext as a child of the folder.

        4. Add another "DatabaseLoader" script to that ClientContext and point the "Database" property to the original
        folder again.

    Your hierarchy should now look something like this:

        Database
        |___ DatabaseLoader
        |___ ClientContext
            |___ DatabaseLoader (client)

    --- Creating the Data ---

    Each Producer is made up of multiple types of data. This data defines how the Producer function, exists in
    Inventory, looks and more. The process for creating the various data types is outlined below.

    --- Creating Item Data ---

    Item data is needed if the Producer will exist in an Inventory. This is not required for Pre-placed Producers but is
    a requirement for Placeable Producers. One exception to this rule is a Tool that is set up to place a specific
    Placeable. In this case that Placeable does not need to exist as an Item.

        1. If an "Items" category doesn't already exist, drop a "DataGroup" script into the database and name it "Items".

        2. If one doesn't exist, create a Data Table called "Items" and reference it in the "DataTable" Custom Property
        on the "Items" category.

        3. Add columns (if needed) and rows to the Items table for each Producer you want and fill in the fields.

            a. Id (String, Key Column)

                - This must be unique across all Items. It is referenced in many other tables.

            b. Name (String)

                - The name of the item. This shows up in Inventory Tooltips and other UI.

            c. Description (String)

                - The description of the item. This shows up in Inventory Tooltips and other UI.

            d. Tags (String)

                - (Optional) A comma separated list of tags. These are used by several systems to allow for grouping of
                Items instead of pointing at specific Item Ids.

            e. ContextActions (String)

                - A comma separated list of actions that you want to appear in the right click context menu. Supported
                actions are "Details", "Equip" and "Drop". Leave this blank to disable the context menu for this Item.

            --- Inventory ---

            a. IsInventory (Boolean)

                - If true, the item is an inventory. Useful for chests and other containers. See the Container Inventory
                template.

            b. InventoryId (String)

                - If "IsInventory" is true, this should match the Inventory Id defined in a "Container Inventory
                Settings" in your scene.

            c. StackLimit (Integer)

                - If greater than 0, this will override the stack limit set on the Inventory the Item is in.

            --- Drops ---

            a. CanDrop (Boolean)

                - If true, this item can be dropped out of Inventories that support dropping.

            b. DropTemplate (Asset Reference)

                - The template to use to display the dropped item in world.

            --- Icon ---

            a. IconCameraId (Boolean)

                - If "Is3DIcon" is true, this should match the "CameraId" of an "Icon Generator" in the scene.

            b. IconAsset (Asset Reference)

                - The image or template to use for an icon. If "IsKitbashed2DIcon" is true, this should be a UI
                template. If "Is3DIcon" is true, this should be a 3D object template. If "IsImageIcon" is true, this
                should be an image/brush asset.

            c. IsKitbashed2DIcon (Boolean)

                - If true, the "IconAsset" should point to a UI template. This template will be spawned as the icon.

            d. Is3DIcon (Boolean)

                - If true, the "IconAsset" should point to a 3D object template. An image of this template will be used
                as the icon.

            e. IsImageIcon (Boolean)

                - If true, the "IconAsset" should point to an image/brush asset. This will be used as the icon.

            --- Equipment ---

            a. CanEquip (Boolean)

                - If true, this item can be equipped from inventories that allow equipping.

            b. EquipmentTemplate (Asset Reference)

                - The Equipment to spawn and attach to the Player when this item is equipped from an Inventory.

            c. EquipmentVisualTemplate (Asset Reference)

                - An optional visual asset to spawn into invisible Equipment that supports this feature. This is useful
                for sharing a single Equipment across many items.

            --- Item Details ---

            a. DetailsText (String)

                - If the "Details" option is in the "ContextActions" list this lets you set text that will display in
                the Item Details window.

            b. DetailsIconAsset (Asset Reference)

                - The image or template to use for the Item Details window icon. If "IsDetailsKitbashed2DIcon" is true,
                this should be a UI template. If "IsDetails3DIcon" is true, this should be a 3D object template. If
                "IsDetailsImageIcon" is true, this should be an image/brush asset.

            c. IsDetailsKitbashed2DIcon (Boolean)

                - If true, the "DetailsIconAsset" should point to a UI template. This template will be spawned as the
                icon.

            d. Is3DIcon (Boolean)

                - If true, the "DetailsIconAsset" should point to a 3D object template. An image of this template will
                be used as the icon.

            e. IsImageIcon (Boolean)

                - If true, the "DetailsIconAsset" should point to an image/brush asset. This will be used as the icon.

            f. DetailsScreen (String)

                - This should be set to an Id that exists in the Screens Data Table.

        5. If this is a Placeable Producer you will need to set "CanEquip" to true and choose an "EquipmentTemplate" to
        use for placing this Producer. You may also need to define a "EquipmentVisualTemplate" if you are sharing one
        Tool to place multiple Producers (eg: An invisible "Hand" tool that places various "Seed Packet" Producers for
        different crops)

    --- Creating Placeable Data ---

    Both pre-placed and Placeable Producers need Placeable Data. This is because the Replicator they will exist in is a
    Placeable Replicator, or more specifically a Replicator with code in it meant to deal with Placeable objects,
    whether they are placed by the creator or Players.

        1. If a "Placeables" category doesn't already exist, drop a "DataGroup" script into the database and name it
        "Placeables".

        2. If one doesn't exist, create a Data Table called "Placeables" and reference it in the "DataTable" Custom
        Property on the "Placeables" category.

        3. Add columns (if needed) and rows to the Placeables table for each Producer you want and fill in the fields.

            --- General ---

            a. Id (String, Key Column)

                - This must be unique across all Placeables. It is referenced in other tables.

            b. Name (String)

                - (Optional) If set, will be used for displaying information on tooltips. Will default to using the
                associated Item Id if that exists.

            c. Tags (String)

                - (Optional) A comma separated list of tags. These are used by several systems to allow for grouping of
                Placeables instead of pointing at specific Placeable Ids.

            d. UniqueStorageId (Integer)

                - This number is used when saving data to keep it small and to allow you to re-order your Database. It
                must be unique across all Placeables.

            e. Client (Asset Reference)

                - (Optional) If set, this template will be spawned into the Client context when this Placeable is in the
                world.

            f. Static (Asset Reference)

                - (Optional) If set, this template will be spawned into the Static context when this Placeable is in the
                world.

            g. Server (Asset Reference)

                - (Optional) If set, this template will be spawned into the Server context when this Placeable is in the
                world.

            h. ValidReplicatorIdentifiers (String)

                - A comma separated list of Replicator Identifiers this can be placed into. This identifier is defined
                on the Player Lot Replicator Loader.

            i. ValidPlaceToolTypes (String)

                - (Optional) A comma separated list of Tool Types or Item Ids that can be used to place this item. If
                left blank, any Tool that can place items could potentially place this one.

            j. ValidRemoveToolTypes (String)

                - (Optional) A comma separated list of Tool Types or Item Ids that can be used to remove this item. If
                left blank, any Tool that can remove items could potentially remove this one.

            --- VFX ---

            a. PlaceEffects (Asset Reference)

                - (Optional) If set, this template will be spawned when this is placed into the world. It is recommended
                to have a lifespan on this template. A default lifespan of 5 seconds will be used if it is set to 0.

            b. RemoveEffects (Asset Reference)

                - (Optional) If set, this template will be spawned when this is removed from the world. It is
                recommended to have a lifespan on this template. A default lifespan of 5 seconds will be used if it is
                set to 0.

            c. PlaceEffectsOffset (Vector3)

                - This will move where the "PlaceEffects" template spawns. It can be used to position the effect exactly
                where you need it.

            d. RemoveEffectsOffset (Vector3)

                - This will move where the "RemoveEffects" template spawns. It can be used to position the effect
                exactly where you need it.

            --- Placement ---

            a. RemoveItemWhenPlaced (Boolean)

                - If true, the item will be removed from the Players Inventory when placed.

            b. PlacementPreview (Asset Reference)

                - (Optional) if set, this template will be spawned to act as a preview of where the item will be placed
                in world.

            c. PlacementOverlapCheckTrigger (Asset Reference)

                - (Optional) If set, this template will be spawned to act as an overlap checker when placing this object.
                Placement will not be allowed if it overlaps with anything marked as "Can Overlap Triggers". The
                template must include one or more Triggers to work.

            d. PlacementAreaTypes (String)

                - (Optional) If set, this comma separated list of Placement Area Types will restrict this item to only
                being allowed to be placed on matching Placement Areas. If blank, the item can be placed on any surface.

            e. SnapToGrid (Boolean)

                - If true, the item will be constrained to a grid defined by the "GridSize" property.

            f. GridSize (Vector2)

                - The dimensions of the grid that the item will snap to if "SnapToGrid" is true.

            g. CanRotate (Boolean)

                - If true, the item can be rotated with the "RotateCWBinding", "RotateCCWBinding" and "RotationSpeed"
                that are set on the Tool or EquipmentData for the Tool the Player is using.

            h. SnapRotation (Boolean)

                - If true, rotation will be snapped in increments of the angle set by "RotationSnapAngle".

            i. RotationSnapAngle (Float)

                - The angle increment to snap rotation of the item to if "SnapRotation" is true.

            j. AlignToSurface (Boolean)

                - If true, the items up vector will point along the normal of the surface it is being placed on.

            k. RotateWithLook (Boolean)

                - If true, the item will maintain its angle relative to the Player while being moved around before it is
                placed.

            --- Costs ---

            a. CostItemId[n] (String)

                - (Optional) If set this should point to an Item Id. This Item will be removed from the Player's
                Inventory when the Placeable is placed, and placement won't be allowed if the Player doesn't have enough
                of this item. [n] is a numeric increment. To add more costs just add more columns in the same naming
                style and increase the number. Make sure you also add additional "CostAmount[n]" columns to match.

            b. CostCurrencyId[n] (String)

                - (Optional) If set this should point to an Currency Id. This Currency will be removed from the Player
                when the Placeable is placed, and placement won't be allowed if the Player doesn't have enough of this
                currency. [n] is a numeric increment. To add more costs just add more columns in the same naming style
                and increase the number. Make sure you also add additional "CostAmount[n]" columns to match.

            c. CostAmount[n]

                - The amount of the Item or Currency to remove when the Placeable is placed.[n] is a numeric increment.
                To add more costs just add more columns in the same naming style and increase the number.

            --- Removal ---

            a. DestroyOnRemove (Boolean)

                - If true, the item will be destroyed when removed and no drops will be given to the Player.

            b. DropInWorldOnRemove (Boolean)

                - If true, drops will appear in world as Item Pickups when the item is removed. Otherwise they will go
                into the Players Inventory.

            c. DropPlacementCostsOnRemove (Boolean)

                - If true, any Costs for placing this item will be dropped along with other Drops.

            d. DropBehaviorId (String)

                - (Optional) If "DropInWorldOnRemove" is true, this should be set to an Id that exists in the Drop
                Behaviors Data Table.

            --- Buffs ---

            a. PlaceableBuffIds (String)

                - (Optional) A comma separated list of Ids that exist in the Placeable Buffs Data Table. These buffs are
                used on Basic Placeables (not Producers or Crafting Stations).

            b. ProducerBuffIds (String)

                - (Optional) A comma separated list of Ids that exist in the Prodcuer Buffs Data Table. These buffs are
                used on Producers (not Basic Placeables, Inventories or Crafting Stations).

            c. CraftingStationBuffIds (String)

                - (Optional) A comma separated list of Ids that exist in the Crafting Station Buffs Data Table. These
                buffs are used on Crafting Stations (not Basic Placeables, Producers or Inventories).

            --- Producer Base ---

            a. IsProducerBase (Boolean)

                - If true, this Placeable object will act as a Producer Base. Producers require a Producer Base with a
                valid "ProducerBaseType" in order to work.

            b. ProducerBaseType (String)

                - This will be referenced by ProducerData and will create the connection between a Producer and Producer
                Bases. Any Producer with this "ProducerBaseType" in its "ValidProducerBaseTypes" can be placed into this
                Producer Base.

            c. InitialProducerId (String)

                - (Optional) When a Player places a Producer Base, this property will make the producer base come with
                an initial Producer. If left blank, the Producer Base will be empty and the Player must place a Producer
                on it.

            d. BuildRate (Float)

                - The build rate is a mutliplier. If a Producer has a BuildSeconds of 10 seconds, but the BuildRate is
                2, then it will only take 5 seconds. Useful if you want special Producer Bases that can build Producers
                faster or slower.

            e. AllowExpiry (Boolean)

                - If true, Producers will expire after building when produced on this base.

            f. ExpireRate (Float)

                - The Expire Rate is a mutliplier. If a Producer has a ExpireSeconds of 10 seconds, but the ExpireRate
                is 2, then it will only take 5 seconds. Useful if you want special Producer Bases that expire faster or
                slower.

            g. AddProducerText (String)

                - (Optional) This will be used in tooltips to display any requirements for adding a Producer to this
                Producer Base to the Player. It is recommended to use a sentence like "Plant seeds in this" or similar.

            h. AllowProducerRemoval (Boolean)

                - If true, a Producer in this Producer Base can be removed without also removing the Producer Base.
                Otherwise both the Producer Base and the Producer will be removed together. This is useful in cases
                where it doesn't make sense to remove things in 2 steps.

            i. Other fields...

                - The rest of the fields are related to Crafting Stations and Placeable Inventories.

    --- Creating Producer Data ---

    Pre-placed and Placeable Producers also need Producer Data. This data defines the object that will exist in the
    Producer Base. For example a plant Producer would be placed into a soil Producer Base.

        1. If a "Producers" category doesn't already exist, drop a "DataGroup" script into the database and name it
        "Producers".

        2. If one doesn't exist, create a Data Table called "Producers" and reference it in the "DataTable" Custom
        Property on the "Producers" category.

        3. Add columns (if needed) and rows to the Producers table for each Producer you want and fill in the fields.

            --- General ---

            a. Id (String, Key Column)

                - This must be unique across all Producers in the Data Table. It is referenced in other tables.

            b. UniqueStorageId (Integer)

                - This number is used for storing the Producer associated with a Producer Base into Player Storage.
                After publishing you should not change this number. This number must be unique within Producer Data.

            c. SourceItemId (String)

                - (Optional) You can use this to point this Producer at a specific ItemId. This is useful when you want
                to consume a different ItemId when placing this Producer. By default this will look for an ItemId that
                matches the Producer Id.

            d. NumberOfSeeds (Integer)

                - If greater than 0, this many of the "SourceItemId" or Item Id matching the Producer Id will be
                consumed when this Producer is placed.

            e. ValidProducerBaseTypes (String)

                - A player will only be able to place this Producer on Producer Bases that have this base type set. See
                ProducerBaseData. You can include multiple types by separating with a comma.

            f. BuildSeconds (Float)

                - The number of seconds this producer takes to build.

            g. NumberOfCollects (Integer)

                - The number of times a player can 'collect' the product the Producer has created. After the first
                collect, the Producer will use the 'Rebuild' states to visually show it building again. After this many
                collects, the Producer will either be removed or replaced.

            h. RebuildSeconds (Float)

                - After the first collect of a Producer, this is the number of second its takes for the Producer to
                rebuild.

            i. AutoBuild (Boolean)

                - If true, one you place a Producer on a Producer Base, it will begin building, and doesnt require
                equipment to be interacted with it. If buffs are required to start building, once the buff requirement
                is fulfilled it will start building. Leave ticked if you never want the player to have to manually
                activate a Producer to start building.

            j. AutoCollect (Boolean)

                - When a Producer has finished building, have this unticked to have the Player interact with the
                Producer Base to collect the product. If this is ticked, it will automatically produce a drop.

            k. ReplaceProducerOnFinalCollect (Boolean)

                - By default, when a Producer has been collected "NumberOfCollects" times, the Producer base will be
                empty. Tick this if you wish for the Producer to be replaced with a different Producer.

            l. ReplacementProducerId (String)

                - (Optional) When "ReplaceProducerOnFinalCollect" is ticked, this is the ProducerId used for replacing a
                Producer when its been collected for the final time. This can be a comma separated list if you want a
                random Producer to replace this.

            m. ProducerStatesId (String)

                - This should match the Id of an an entry in the Producer States Data Table.

            --- Expiry ---

            a. CanExpire (Boolean)

                - Tick if you wish for this Producer to be able to expire. When a Producer has expired, it can no longer
                build and must be replaced and repaired.

            b. ExpireSeconds (Float)

                - The number of seconds it takes for a Producer to expire if "CanExpire" is true.

            c. CanExpireInPlacedState (Boolean)

                - Tick if this Producer is able to expire when its in the placed state.

            d. CanExpireInBuldingState (Boolean)

                - Tick if this Producer is able to expire while building.

            e. CanExpireInReadyState (Boolean)

                - Tick if this Producer is able to expire when its in the ready state.

            --- Interaction ---

            a. ValidPlaceToolTypes (String)

                - (Optional) A comma separated list of Tool Types that are allowed to place this Producer into a
                Producer Base. If left empty, any Tool will be allowed to place this. Set this to a non existent Tool
                Type to disable all Tools from being allowed to place it.

            b. ToolsConsumedWhenPlaced (Integer)

                - If greater than 0, when a Tool places this Producer into a Producer Base this number of that equipped
                Tool will be removed from the Player's Inventory.

            c. PlaceInteractionText (String)

                - This text will appear in a tooltip in some cases to explain to the Player how to place this Producer.
                It's recommended to use something like "Add a seed to this plot".

            d. ValidBuildToolTypes (String)

                - (Optional) A comma separated list of Tool Types that are allowed to start building this Producer. If
                left empty, any Tool will be allowed to make this start building. Set this to a non existent Tool Type
                to disable all Tools from being allowed to make it start building.

            e. ToolsConsumedWhenBuilt (Integer)

                - If greater than 0, when a Tool makes this Producer start building, this number of that equipped Tool
                will be removed from the Player's Inventory.

            f. BuildInteractionText (String)

                - This text will appear in a tooltip in some cases to explain to the Player how to make this Producer
                start building. It's recommended to use something like "Use matches to light the fire".

            g. ValidDestroyToolTypes (String)

                - (Optional) A comma separated list of Tool Types that are allowed to remove this Producer. If left
                empty, any Tool will be allowed to remove this. Set this to a non existent Tool Type to disable all
                Tools from being allowed to remove it.

            h. ToolsConsumedWhenDestroyed (Integer)

                - If greater than 0, when a Tool removes this Producer this number of that equipped Tool will be removed
                from the Player's Inventory.

            i. DestroyInteractionText (String)

                - This text will appear in a tooltip in some cases to explain to the Player how to remove this Producer.
                It's recommended to use something like "Use a Hammer to remove this".

            j. ValidCollectToolTypes (String)

                - (Optional) A comma separated list of Tool Types that are allowed to collect from this Producer. If
                left empty, any Tool will be allowed to collect from this. Set this to a non existent Tool Type to
                disable all Tools from being allowed to collect from it.

            k. ToolsConsumedWhenCollected (Integer)

                - If greater than 0, when a Tool collects from this Producer this number of that equipped Tool will be
                removed from the Player's Inventory.

            l. CollectInteractionText (String)

                - This text will appear in a tooltip in some cases to explain to the Player how to collect from this
                Producer. It's recommended to use something like "Use your hands to pick berries".

            --- VFX ---

            a. PlacementPreview (Asset Reference)

                - (Optional) if set, this template will be spawned to act as a preview of where the Producer will be
                placed in the Producer Base.

            b. HologramMaterial (Asset Reference)

                - (Optional) If set, this Material will be applied to the "PlacementPreview" when the Producer is being
                placed.

            c. PlacementColor (Color)

                - If a "PlacementPreview" is being used, this color will be applied to it.

            d. PlaceEffects (Asset Reference)

                - (Optional) If set, this template will be spawned when this Producer is placed into a Producer Base.
                It is recommended to have a lifespan on this template. A default lifespan of 5 seconds will be used if
                it is set to 0.

            e. CollectEffects (Asset Reference)

                - (Optional) If set, this template will be spawned when this Producer is collected from. It is
                recommended to have a lifespan on this template. A default lifespan of 5 seconds will be used if it is
                set to 0.

            r. RemoveEffects (Asset Reference)

                - (Optional) If set, this template will be spawned when this Producer is removed from a Producer Base.
                It is recommended to have a lifespan on this template. A default lifespan of 5 seconds will be used if
                it is set to 0.

            s. PlaceEffectsOffset (Vector3)

                - This will move where the "PlaceEffects" template spawns. It can be used to position the effect exactly
                where you need it.

            t. CollectEffectsOffset (Vector3)

                - This will move where the "CollectEffects" template spawns. It can be used to position the effect
                exactly where you need it.

            u. RemoveEffectsOffset (Vector3)

                - This will move where the "RemoveEffects" template spawns. It can be used to position the effect
                exactly where you need it.

            --- Drops ---

            a. DropOnCollect (Boolean)

                - If true, the Producer will drop the products into the world. Otherwise they will be directly added to
                the highest priority Inventory.

            b. DropIds (String)

                - A comma separated list of Ids that exist in the Drops Data Table. These will be dropped when the
                Producer is collected.

            c. PlacedDropIds (String)

                - A comma separated list of Ids that exist in the Drops Data Table. These will be dropped when the
                Producer is removed while not building or ready to collect.

            d. BuildingDropIds (String)

                - A comma separated list of Ids that exist in the Drops Data Table. These will be dropped when the
                Producer is removed while building.

            e. RebuildingDropIds (String)

                - A comma separated list of Ids that exist in the Drops Data Table. These will be dropped when the
                Producer is removed while rebuilding.

            f. ExpiredDropIds (String)

                - A comma separated list of Ids that exist in the Drops Data Table. These will be dropped when the
                Producer removed while expired.

            --- Buffs ---

            a. ProducerBuffIds (String)

                - (Optional) A comma separated list of Ids that exist in the Producer Buffs Data Table.

    "ValidReplicatorIdentifiers" is important if you are building a Producer that can be placed into Player Lots. More
    information on that can be found in the "Placeable Producers" section.

    The "IsProducerBase" section at the bottom of the data is very important since your item won't be a Producer if this
    isn't set up.

    --- Creating Producer States Data ---

    Producers need templates to update their visual look in the various states they can be in. These template references
    are kept in the Producer States Data Table.

        1. If a "ProducerStates" category doesn't already exist, drop a "DataGroup" script into the database and name it
        "ProducerStates".

        2. If one doesn't exist, create a Data Table called "Producer States" and reference it in the "DataTable" Custom
        Property on the "ProducerStates" category.

        3. Add columns (if needed) and rows to the Producer States table for each Producer you want and fill in the
        fields.

            --- Placeable ---

            a. PlacedState_Client (Asset Reference)

                - (Optional) If set, this template will be spawned into the Client context when the Producer has
                been placed into a Producer Base but has not started building yet.

            b. PlacedState_Server (Asset Reference)

                - (Optional) If set, this template will be spawned into the Server context when the Producer has
                been placed into a Producer Base but has not started building yet.

            c. PlacedState_Static (Asset Reference)

                - (Optional) If set, this template will be spawned into the Static context when the Producer has
                been placed into a Producer Base but has not started building yet.

            --- Building ---

            a. BuildingState1_Client (Asset Reference)

                - (Optional) This template will be spawned into the Client context when the Producer has been placed
                into a Producer Base but has started building. Producers support up to 32 of these building states.
                To add additional states create new Asset Reference Custom Properties and follow the naming
                convention of "State[n]_Client" where [n] is the state number.

            b. BuildingState1_Server (Asset Reference)

                - (Optional) This template will be spawned into the Server context when the Producer has been placed
                into a Producer Base but has started building. Producers support up to 32 of these building states.
                To add additional states create new Asset Reference Custom Properties and follow the naming
                convention of "State[n]_Server" where [n] is the state number.

            c. BuildingState1_Static (Asset Reference)

                - (Optional) This template will be spawned into the Static context when the Producer has been placed
                into a Producer Base but has started building. Producers support up to 32 of these building states.
                To add additional states create new Asset Reference Custom Properties and follow the naming
                convention of "State[n]_Static" where [n] is the state number.

            You can define up to 32 states for building. These states will be spawned based on the current build
            amount of the Producer.

            --- Rebuilding ---

            a. RebuildingState1_Client (Asset Reference)

                - (Optional) This template will be spawned into the Client context when the Producer has been placed
                into a Producer Base but is rebuilding. Producers support up to 32 of these rebuilding states. To
                add additional states create new Asset Reference Custom Properties and follow the naming convention
                of "RebuildingState[n]_Client" where [n] is the state number.

            b. RebuildingState1_Server (Asset Reference)

                - (Optional) This template will be spawned into the Server context when the Producer has been placed
                into a Producer Base but is rebuilding. Producers support up to 32 of these rebuilding states. To
                add additional states create new Asset Reference Custom Properties and follow the naming convention
                of "RebuildingState[n]_Server" where [n] is the state number.

            c. RebuildingState1_Static (Asset Reference)

                - (Optional) This template will be spawned into the Static context when the Producer has been placed
                into a Producer Base but is rebuilding. Producers support up to 32 of these rebuilding states. To
                add additional states create new Asset Reference Custom Properties and follow the naming convention
                of "RebuildingState[n]_Static" where [n] is the state number.

            You can define up to 32 states for rebuilding. These states will be spawned based on the current build
            amount of the Producer.

            --- Ready ---

            a. ReadyState_Client (Asset Reference)

                - (Optional) If set, this template will be spawned into the Client context when the Producer is
                ready to be collected.

            b. ReadyState_Server (Asset Reference)

                - (Optional) If set, this template will be spawned into the Server context when the Producer is
                ready to be collected.

            c. ReadyState_Static (Asset Reference)

                - (Optional) If set, this template will be spawned into the Static context when the Producer is
                ready to be collected.

            --- Expired ---

            a.  ExpiredState_Client (Asset Reference)

                - (Optional) If set, this template will be spawned into the Client context when the Producer has
                expired.

            b.  ExpiredState_Server (Asset Reference)

                - (Optional) If set, this template will be spawned into the Server context when the Producer has
                expired.

            c.  ExpiredState_Static (Asset Reference)

                - (Optional) If set, this template will be spawned into the Static context when the Producer has
                expired.

    The "Client" states should contain templates for the visual aspect of your Producer. The "Static" states should
    contain any collision you need. "Server" is just there is you have any specific server only logic you would like to
    spawn with your Producer.

    At this point you should be able to use this data in the "Prebuilt Producers" and "Placeable Producers" sections
    below.

    ----------------------------------
    ---     PREBUILT PRODUCERS     ---
    ----------------------------------

    All you need for a Prebuilt Producer is a Replicator and a simple object in the scene that defines a Producer Base
    Id and a Producer Id. These can be placed anywhere in the scene including into Player Lots if you want to restrict
    access to them to specific Players.

        1. Add a "Placeables Replicator" to your scene if you don't already have one to use. This will contain the
        Prebuilt Producers. You can have multiple Replicators, so don't feel constrained to just one.

        2. Locate the "Prebuilt Producer" template and add it to the "ReplicatedCoreObjects" group in the "Placeables
        Replicator".

        3. It is recommended that you deinstance these template to avoid accidentally updating them later and making all
        of your Prebuilt Producers the same.

        4. Fill in the following Custom Properties with Ids that exist in the Database:

            a. PlaceableId

                - The Producer Base / Placeable Id. This should exist in a Database in the Placeables category.

            b. ProducerId

                - The Producer Id. This should exist in a Database in the Producers category.

        5. Repeat steps 2 - 4 as many times as you need to fill out your scene.

    Playing the game at this point should spawn your Producers if everything in the data was configured correctly.

    ----------------------------------
    ---    PLACEABLE PRODUCERS     ---
    ----------------------------------

    Placeable Producers can be placed into Placeable Replicators onto valid Placement Areas.

        1. Add a "Placeables Replicator" to your scene if you don't already have one to use. This will contain the
        Prebuilt Producers. You can have multiple Replicators, so don't feel constrained to just one.

        2. Build out a set of objects in a group that define a Placement Area. This will be an area where specific
        Producer Bases could be placed. For example, a dirt patch for planting crops.

        3. Add a "Placement Area Settings" template to the group of objects and fill in the Custom properties on it.

            a. Group

                - The group of objects that define this Placement Area.

            b. AreaType

                - The name of this Placement Area Type for use in Placeable Data.

        4. Repeat steps 2 - 3 for each different Placement Area you want.

    With the data created in the above sections and the Placement Areas you mainly have to look out for a few gotchas
    when making a Producer something a Player can place into the world.

        1. Ensure that each Producer has a valid Producer Base it can fit into. Pay attention to the "ProducerBaseType"
        on the Placeable data and the "ValidProducerBaseTypes" on the Producer.

        2. Have some way for the Player to get the Producer Base and Producer into the Players Inventory. This could be
        via Starting Items, or through some other means. See the Inventory README for details.

        3. In the Static and/or Client templates for the Producer Base, make sure that you have some sort of bounds
        objects that have "Can Overlap Triggers" checked. This will allow it to block placement of other Producer Bases.

        4. If these are being placed into Player Lots, you will want to include the "Identifier" on the "Player Lot
        Replicator Loader" in the "ValidReplicatorIdentifiers" comma separated list on the Placeable Data for the
        Producer Base. This can be used to restrict placement of objects to specific Placeables Replicators.

        5. Make sure you have set up the "ValidPlaceToolTypes" and "ValidRemoveToolTypes" on the Placeable Data. This
        will restrict placement and removal to specific Tools. You can use an invalid Tool Type like "none" if you don't
        want anything to be able to remove a Producer Base. You can also refer to Item Ids if you are using a single
        Tool with multiple Items. You can use "hand" if you want to use the default Hand Tool.

        6. Likewise, Producer Data has several "Valid" Tool interactions that should be filled out. You can use an
        invalid Tool Type like "none" if you don't want anything to be able to interact with a Producer in a certain way,
        or you can use "hand" if you want to use the default Hand Tool.

        7. Check that "PlacementAreaTypes" has a comma separated list of Placement Area Types that should allow this
        Producer Base to be placed into them.

    ----------------------------------
    ---   SAVING PRODUCER STATE    ---
    ----------------------------------

    To save the state of a Producer it must exist inside a Player Lot. See the Player Lots README for details on setting
    those up.

        1. Set up Player Lots by following the instructions in the Player Lots README.

        2. If you want Players to be able to place Producer Bases:

            a. Add a "Placeables Replicator" to each Player Lot.

            b. Add a "Player Lot Replicator Loader" and fill in the Custom Properties.

                - Replicator

                    - Loads and unloads the Replicator when the Player Lot loads and unloads. This should point to the
                    object with the "UserFunctions" and "Parent" properties.

                - SharedStorageKey

                    - An optional Shared Storage Key to save and load the replicator data from.

                - StorageKey

                    - The key to use for storing the data in Player Storage for this Replicator. This should be unique
                    across all Replicators.

                - Identifier

                    - A tag that can be used to limit what can be placed in the Replicator or allow other scripts to
                    pick out this specific Replicator.

                - Populate

                    - If true, and the Replicator has objects already existing in its Static Context folder, these
                    objects will be added to its internal state and saved.

            c. Add "Placement Area Settings" for each Placement Area you want in the Player Lot. See the "Placeable
            Producers" section above to learn how to create these.

        3. If you want to use Prebuilt Producers:

            a. Follow the above steps for placing Producer Bases.

            b. Follow the steps in the "Prebuilt Producers" section but place the "Prebuilt Producer" templates into the
            "ReplicatedCoreObjects" StaticContext in the "PlaceablesReplicator" and ensure that the "Populate" option is
            checked on the "Player Lot Replicator Loader".

    ----------------------------------
    ---    PRODUCERS AND BUFFS     ---
    ----------------------------------

    Both Producer Bases and Producers can receive and output Buffs. Buffs can affect a lot of different things like
    Producer behaviour and drops. Buffs can either be applied directly to an object or they can be output in a radius
    and "linked" to other objects.

    There are various reasons why you might want to setup Buff data on a Producer Base vs. a Producer. For example it
    would use a lot less repeated data to set up a "watered" Buff on a "Soil" Producer Base than setting that up on
    every "Crop" Producer.

    Every Buff needs an entry in the Buffs Data Table to define some basic data.

        1. If a "Buffs" category doesn't already exist, drop a "DataGroup" script into the database and name it "Buffs".

        2. If one doesn't exist, create a Data Table called "Buffs" and reference it in the "DataTable" Custom Property
        on the "Buffs" category.

        3. Add columns (if needed) and rows to the Buffs table for each Buff you want and fill in the fields.

            a. Id (String)

                - The Id of the Buff. This must be unique across all Buffs in the table. It is referenced by other
                tables.

            b. Name (String)

                - The name of the Buff. Will appear in some tooltips.

            c. UniqueStorageId (Integer)

                - Used for networking and storage. Must be a unique number for each buff. Not required for Linked buffs
                as these are not saved.

            d. Duration (Float)

                - How long this Buff will 'last'. Targets may adjust this value so this is the 'base value' of how long
                a Buff would last on a target. A duration of 0 means the Buff will be removed instantly.

            e. Permanent (Boolean)

                - Tick if you want the Buff to last forever (until something removes it)

            f. MaxStacks (Integer)

                - If a buff lasts for 2 seconds, but has a stack of 2, then it could be added twice and last for 4
                seconds.

    Next you need to add some more specific data that describes how this Buff affects your Producer.

        1. If a "ProducerBuffs" category doesn't already exist, drop a "DataGroup" script into the database and name it
        "ProducerBuffs".

        2. If one doesn't exist, create a Data Table called "Producer Buffs" and reference it in the "DataTable" Custom
        Property on the "ProducerBuffs" category.

        3. Add columns (if needed) and rows to the Producer Buffs table for each Buff you want and fill in the fields.

            --- General ---

            a. Id (String, Key Column)

                - The Id of this Producer Buff. This must be unique across all Producer Buffs. It is referenced in the
                Placeables Data Table in the "ProducerBuffIds" column.

            b. BuffId (String)

                - The Id of the Buff that this data is associated with. This should match the Id of an entry in the
                Buffs Data Table.

            --- Receiving ---

            a. CanReceive (Boolean)

                - If true, the Producer will be able to receive this Buff.

            b. OverrideBuffDuration (Boolean)

                - Tick to override the Buff duration that's in the Buff database.

            c. BuffDuration (Float)

                - If "OverrideBuffDuration" is ticked, this is the new Buff duration.

            --- Consumption ---

            a. DrainWhileEmpty (Boolean)

                - If true, the Buff duration will decrement while there is no Producer in the Producer Base. Otherwise
                it will pause.

            b. DrainWhilePlaced (Boolean)

                - If true, the Buff duration will decrement while the Producer is in the "placed" state. Otherwise it
                will pause.

            c. DrainWhileBuilding (Boolean)

                - If true, the Buff duration will decrement while the Producer is in the "building" state. Otherwise it
                will pause.

            d. DrainWhileReady (Boolean)

                - If true, the Buff duration will decrement while the Producer is in the "ready" state. Otherwise it
                will pause.

            e. DrainWhileRebuilding (Boolean)

                - If true, the Buff duration will decrement while the Producer is in the "rebuilding" state. Otherwise
                it will pause.

            f. DrainWhileExpired (Boolean)

                - If true, the Buff duration will decrement while the Producer is in the "expired" state. Otherwise it
                will pause.

            g. RemoveOnCollect (Boolean)

                - If true, the Buff will be removed when the Player collects the product from the Producer.

            h. RemoveOnProducerRemoved (Boolean)

                - If true, The Buff will be removed if the Producer is removed from the Producer Base.

            --- Building ---

            a. RequireToStartBuilding (Boolean)

                - If true, the Producer won't be able to start building until it has this Buff, and will remain in the
                placed state.

            b. RequireWhileBuilding (Boolean)

                - If true, the Producer won't be able to continue building until it has this Buff, and will remain in
                the building state without progressing.

            c. RequireWhileRebuilding (Boolean)

                - If true, the Producer won't be able to continue rebuilding until it has this Buff, and will remain in
                the building state without progressing.

            d. AffectsBuildRate (Boolean)

                - If true, this Buff will affect the build rate while the Buff is active.

            e. BuildRateMultiplierPercent (Float)

                - If "AffectsBuildRate" is true, this multiplier percentage will be applied to the build rate while this
                Buff is active. For example "100" would multiply the rate by 100% doubling the build rate.

            --- Expiry ---

            a. RequireToAllowExpiring (Boolean)

                - If the Producer is able to expire and this is true, the Producer won't expire if it doesn't have this
                Buff. Useful for debuffs.

            b. AffectsExpireRate (Boolean)

                - If true, this Buff will affect the rate a Producer expires, if it expires.

            c. ExpireRateMultiplierPercent (Float)

                - If "AffectsExpireRate" is true, this multiplier percentage will be applied to the expiry rate while
                this Buff is active.

            d. ResetsExpiry (Boolean)

                - If true, while this buff is active, the expiry time of the producer is reset back to 0.

            --- Interaction ---

            a. ValidAddBuffToolTypes (String)

                - A comma separated list of any Tool Types that are able to add this Buff. Tool types are defined on
                Equipment or in the database. You can also use Item Ids to allow specific equippable Items.

            b. ToolsConsumedWhenAdded (Integer)

                - If greater than 0, this number of the currently equipped Tool will be removed from the Players
                Inventory when this Buff is added.

            c. InteractionText (String)

                - This text will appear in some tooltips to tell the Player how to add the Buff. Something like "Add
                Coal to the Furnace" is recommended.

            d. MinAllowedBuffConsumption (Float)

                - Each time you use the Tool, it will add '1' Buff. Set this to 0 if you want to allow the Player to add
                a Buff even if there is 99% remaining, use 0.5 if the Player can add the Buff when it is 50%, use 0 if
                you want the Buff to only apply when it's gone. Useful to ensure the Player doesn't waste items for
                little or no gain.

            --- VFX ---

            a. AddBuffEffect (Asset Reference)

                - VFX that is spawned when this buff is added via a tool.

            b. AddBuffEffectOffset (Vector3)

                - This will move where the "AddBuffEffect" template spawns. It can be used to position the effect
                exactly where you need it.

            --- Drops ---

            a. DropModifierIds (String)

                - (Optional) A comma separated list of Ids that exist in the Drop Modifiers Data Table. These can be
                used to change drops on the Producer based on which Buffs are active.

            b. AdditionalDropIds (String)

                - (Optional) A comma separated list of Ids that exist in the Drops Data Table. These drops will be added
                to other drops if the Buff is active when drops are generated.

            --- Outputting ---

            a. CanOutput (Boolean)

                - If true, the Producer can output this Buff.

            b. ActiveWhileEmpty (Boolean)

                - If true, this Buff will be active when a Producer Base has no Producer in it.

            c. ActiveWhilePlaced (Boolean)

                - If true, this Buff will be active when a Producer Base is in the 'placed' state but hasn't started
                building.

            d. ActiveWhileBuilding (Boolean)

                - If true, this Buff will be active while a Producer is building and not yet ready to be collected.

            e. ActiveWhileReady (Boolean)

                - If true, this Buff will be active when a Producer has finished building and is ready to be collected.

            f. ActiveWhileExpired (Boolean)

                - If true, this Buff will be active when a Producer has expired.

            g. RequiredBuffs (String)

                - (Optional) A comma separated list of any Buff Ids you need the Producer to have for this buff to
                activate.

            h. Radius (Float)

                - When active, this Buff will be added to any Buff targets that are within this radius.

            i. AddAmount (Float)

                - The amount of the Buff to add to other targets in the radius.

    Once all of these data connections are set up, your Buff should work when applied. Some common mistakes include:

        1. Forgetting to set up a Tool that can apply the Buff. The "ValidAddBuffToolTypes" needs to include either Tool
        Types defined on the Tools, or ItemIds of equippable Items.

        For example you could have a "Watering Can" Tool with a "watering can" Tool Type on it. "ValidAddBuffToolTypes"
        would be "watering can" in this case. You could also have several watering can Items the Player could use and
        use their Item Ids in "ValidAddBuffToolTypes" like "Common Watering Can, Rare Watering Can, Epic Watering Can".

        2. Forgetting to name the Input or Output Buff Data object as the Buff Id. The BuffDatas in the "Buffs" category
        in the Database are the Buff Ids. These need to match in order to connect the two Datas.

    ----------------------------------
    ---      BUFFS COMPONENTS      ---
    ----------------------------------

    There are a few components that can be used to react to and visualize Buffs. These are scripts that can be placed
    onto any Buff target, or state template in a Buff Target, and they will run when their target Buff is applied.

        1. ChangeColorWithActiveBuff

            This component will change the color of targeted objects when a Buff is active or inactive.

            a. BuffId

                - The Id of the Buff to detect. Leave blank if you want any Buff to change the color.

            b. InactiveColor

                - The color to change to while the target Buff is not active.

            c. ActiveColor

                - The color to change to while the target Buff is active.

            d. ObjectToColor

                - The target object or group of objects to color.

            e. ColorDescendants

                - If true, all objects underneath the "ObjectToColor" will also change color.

        2. ToggleEffectsWithActiveBuff

            This component will play or stop Audio and/or Vfx objects when a Buff is active.

            a. BuffId

                - The Id of the buff to detect. Leave blank if you want any buff to play and stop effects.

            b. ObjectToPlayStop

                - The target object or group of objects to play and stop effects in. Only Audio and Vfx objects found
                will be used.

            c. IncludeDescendants

                - If true, all Audio and Vfx objects underneath the "ObjectToPlayStop" will also play and stop.

        3. ToggleVisibilityWithActiveBuff

            This component will show or hide objects when a Buff is active.

            a. BuffId

                - The Id of the buff to detect. Leave blank if you want any buff to show and hide objects.

            b. ObjectToToggle

                - The target object or group of objects to show and hide.

            c. HideWhenActive

                - If true, the target objects will be hidden while the Buff is active. Otherwise they will be visible
                while the Buff is active.

    ----------------------------------
    ---      PLACEABLE EVENTS      ---
    ----------------------------------

    There are a couple of Events specific to Placeables that can be listened for in other scripts.

        APIPlaceables.Events.PlaceablePlaced = "PBL_Placed"

            - Handler = function(instance) - Client Only

            - Sent when a Placeable object is placed into a Replicator.

            instance = {
                id
                replicatorId
                placeableId
                position
                rotation
                clientParentTemplate
                serverTime
                children
                modifiedEvent
                state
                _bitString
            }

        APIPlaceables.Events.PlaceableRemoved = "PBL_Removed"

            - Handler = function(objectId, placeableId) - Client Only

            - Sent when a Placeable object is removed from a Replicator.

    Placeables can also be removed by broadcasting your own events.

        Events.Broadcast(APIPlaceables.Events.RemovePlaceable, objectId, force)
        Events.Broadcast("PBL_Remove", objectId)

            - This will remove a Placeable object. It can be used from the client or the server.

    ----------------------------------
    ---      PRODUCER EVENTS       ---
    ----------------------------------

    Producers fire events that can be listened to.

        APIProducerBases.Events.ProducerPlaced = "PRD_Placed"

            - Handler = function(objectId, placeableId, producerId) - Client / Server

            - Sent when a Producer is placed into a Producer Base.

        APIProducerBases.Events.ProducerStartedBuilding = "PRD_StartedBuilding"

            - Handler = function(objectId, placeableId, producerId) - Client / Server (Autobuild only)

            - Sent when a Producer starts building or rebuilding.

        APIProducerBases.Events.ProducerReadyForCollect = "PRD_Ready"

            - Handler = function(objectId, placeableId, producerId) - Client / Server

            - Sent when a Producer has finished building and is ready to be collected.

        APIProducerBases.Events.ProducerCollected = "PRD_Collected"

            - Handler = function(objectId, placeableId, producerId) - Client Only

            - Sent when a Producer is collected.

        APIProducerBases.Events.ProducerRemoved = "PRD_Removed"

            - Handler = function(objectId, placeableId, oldProducerId) - Client Only

            - Sent when a Producer is removed from a Producer Base.

        APIProducerBases.Events.ProducerExpired = "PRD_Expired"

            - Handler = function(objectId, placeableId, oldProducerId) - Client / Server

            - Sent when a Producer expires.

    Producer Bases can also be manipulated by broadcasting your own events.

        Events.Broadcast(APIProducerBases.Events.PlaceProducer, objectId, producerId)
        Events.Broadcast("PRD_Place", objectId, producerId)

            - This will place a Producer onto a Producer Base object.

        Events.Broadcast(APIProducerBases.Events.RemoveProducer, objectId, player)
        Events.Broadcast("PRD_Remove", objectId, player)

            - This will remove a Producer from a Producer Base object, if available.

        Events.Broadcast(APIProducerBases.Events.BuildProducer, objectId, force, growth)
        Events.Broadcast("PRD_Build", objectId, force, growth)

            - This will cause a Producer to begin building.
            - If 'force' is true, this also sets the build progress to the 'growth' value.

        Events.Broadcast(APIProducerBases.Events.ReadyProducer, objectId, force)
        Events.Broadcast("PRD_SetReady", objectId, force)

            - This will cause a Producer to enter the Ready state if:
                a) it is currently able to be readied, or
                b) if 'force' is true.

        Events.Broadcast(APIProducerBases.Events.CollectProducer, objectId, force)
        Events.Broadcast("PRD_Collect", objectId, force)

            - This will trigger a collection of the Producer if:
                a) it is currently able to be collected, or
                b) if 'force' is true.

        Events.Broadcast(APIProducerBases.Events.ExpireProducer, objectId, force)
        Events.Broadcast("PRD_Expire", objectId, force)

            - This will cause the Producer to expire if:
                a) it is currently able to expire, or
                b) if 'force' is true.

    ----------------------------------
    ---        BUFF EVENTS         ---
    ----------------------------------

    APIBuffs.Events.BuffAdded = "BUFF_Added"

        - Handler = function(targetId, buffId) - Client / Server

        - Sent when a Buff is added to a target. This will be sent even if the Buff is immediately removed.

    APIBuffs.Events.BuffChanged = "BUFF_Changed"

        - Handler = function(targetId, buffId) - Client / Server

        - Sent when a Buff changes. This will be sent periodically, usually when other state changes.

    APIBuffs.Events.BuffRemoved = "BUFF_Removed"

        - Handler = function(targetId, buffId) - Client / Server

        - Sent when a Buff is removed.

    APIBuffs.Events.BuffFinished = "BUFF_Finished"

        - Handler = function(targetId, buffId) - Client / Server

        - Sent when a timed Buff finishes.

    APIBuffs.Events.TargetRegistered = "BUFF_Registered"

        - Handler = function(targetId) - Client / Server

        - Sent when a Buff target is registered with the system.

    APIBuffs.Events.TargetUnregistered = "BUFF_Unregistered"

        - Handler = function(targetId) - Client / Server

        - Sent when a Buff target is unregistered from the system.

    APIBuffs.Events.BuffRelinked = "BUFF_Relinked"

        - Handler = function(targetId, buffId) - Client / Server

        - Sent when a Buff is linked to another object.

    APIBuffs.Events.PrepareLinkedBuffs = "BUFF_PrepareLinking"

        - Handler = function(targetId) - Client / Server

        - Sent prior to APIBuffs.Events.HandleBuffs and before all Buffs are linked.

    APIBuffs.Events.HandleBuffs = "BUFF_Handle"

        - Handler = function() - Client / Server

        - Sent when all buffs are calculated.
--]]