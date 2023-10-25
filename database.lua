local Guns = {}

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