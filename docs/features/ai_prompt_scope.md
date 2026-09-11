# AI Prompt Scope

## Overview
- **Purpose**: the purpose of this document is to describe the scope of the car, track and handling deficit metadata we share from each Working Session with the Claude LLM via the Anthropic SDK.
- **Intent**: to allow for iterative development, we will keep the intial scope of the metadata we send to Claude to the minimum needed to provide usable setup recommendations for the user.

### Intendend Constraints: User Setup Recommendations

#### Setup Recommendation Scope
To keep setup recommendations manageable for users, we will limit recommended changes Claude can suggest to the following settings:
* Brake Bias
* Rear Wing
* Front Ride Height
* Rear Ride Height
* Front Anti-Roll Bars
* Rear Anti-Roll Bars
* Tire Pressures
* Traction Control Cut
* Traction Control Slip

#### Car Metadata (Top 5 Essential Properties)
* **Engine Layout:** [Mid-Engine, Rear-Engine, Front-Engine] - Impacts weight distribution and lift-off oversteer tendencies.
* **Aero Dependency:** [High, Medium] - Tells the AI whether to fix a deficit using Rear Wing/Ride Height (Aero) or Anti-Roll Bars (Mechanical).
* **Wheelbase Type:** [Short, Long] - Dictates natural rotation capability and high-speed stability.
* **Weight Distribution:** [Rear-Biased, Neutral, Front-Biased] - Helps the AI understand trailing-brake behavior and exit traction limits.
* **TC System Type:** [Advanced/Dual-Map, Standard] - Contextualizes how granular Traction Control adjustments should be.

#### Track Metadata (Top 5 Essential Properties)
* **Aero Requirement:** [High-Downforce, Low-Drag, Balanced] - Prevents the AI from suggesting a wing change that ruins straight-line speed.
* **Dominant Corner Speed:** [Low-Speed/Mechanical, High-Speed/Aerodynamic] - Directly maps the handling deficit to either mechanical or aero setup tools.
* **Surface Bumpiness:** [Smooth, Bumpy/Severe Curbs] - Flags whether the AI can safely recommend lowering the Ride Height.
* **Tire Degradation Rate:** [High, Low] - Influences whether the AI should recommend aggressive Tire Pressure or Anti-Roll Bar changes.
* **Layout Type:** [Stop-and-Go, Flowing/Sweeping] - Helps the AI balance corner-entry stability vs. corner-exit traction needs.

