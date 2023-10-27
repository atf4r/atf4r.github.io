local Guns = {}

Guns.FORMAT = {
    simulateChamber = "(boolean) Simulates a closed bolt chamber, allowing for one additional bullet to be loaded irrespective of the magazine.",
    ammoCapacity = "(integer) Amount of bullets the magazine can store. [1, inf)",
    rpm = "(number) Rate of fire expressed in rounds per minute. (0, ~900]",

    description = "(string) A brief but rich description of the gun, its capabilities, and personality.",

    TrajectoryProfile = {
        InitialSpeed = "(number) Muzzle velocity magnitude in studs per second (0, inf)",
        MaxRebounds = "(integer) Amount of possible ricochets, lower values = higher performance. [0, ~5)",
        MaxDistance = "(number) Maximum travel distance, lower values = higher performance. (0, inf)",
        DragInfluence = "(number) [unused] amount of acceleration against the bullet in st/s^2",
        DropInfluence = "(number) Bullet gravity multiplier, (-inf, inf)",
        WindInfluence = "(number) Amount of acceleration in st/s multiplied by normal vector wind [0, inf)",

        PierceFriction = "(number) Multiplier to penetration speed deficit upon piercing a part [0, inf)",
        PierceDeviation = "(number) Multiplier to directional influence of the normal vector upon piercing [0, inf)"
    }
}


Guns["M1911"] = {
    simulateChamber = true,
    ammoCapacity = 8,
    rpm = 400,

    description = "Reliable pistol that endured (some fanatics would argue it even won) both world wars. It's known to hold up to abuse, and get the job done. The powerful .45 ACP caliber is also known to be quite a potent threat.",

    TrajectoryProfile = {
        InitialSpeed = 1500,
        MaxRebounds = 1,
        MaxDistance = 250,
        DragInfluence = nil,
        DropInfluence = 2.5,
        WindInfluence = 0.0,

        PierceFriction = 2.5,
        PierceDeviation = 1.0
    }
}

Guns["M1911A1"] = {
    simulateChamber = true,
    ammoCapacity = 8,
    rpm = 400,

    description = "A follow up to the all mighty M1911. The powerful .45 ACP caliber is known to be quite a potent threat.",

    TrajectoryProfile = {
        InitialSpeed = 1500,
        MaxRebounds = 1,
        MaxDistance = 250,
        DragInfluence = nil,
        DropInfluence = 2.5,
        WindInfluence = 0.0,

        PierceFriction = 2.5,
        PierceDeviation = 1.0
    }
}

Guns["Makarov"] = {
    simulateChamber = true,
    ammoCapacity = 8,
    rpm = 600,

    description = "A cheap russian pistol chambered in 9x18mm Makarov. It has janky, harsh recoil thanks to its no-frills direct blowback system.",

    TrajectoryProfile = {
        InitialSpeed = 800,
        MaxRebounds = 0,
        MaxDistance = 250,
        DragInfluence = nil,
        DropInfluence = 1.5,
        WindInfluence = 0.0,

        PierceFriction = 2.5,
        PierceDeviation = 1.0
    }
}

return Guns