## Baseline BSP

Baseline instructions for setting up a BSP for a Xilinx devices.  Specific instructions will target the ZCU102 Evaluation Kit, but generically this works for all Xilinx SoC devices.

Primarily following the guide from [Xilinx](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2018_3/ug1209-embedded-design-tutorial.pdf).

### Setup

You'll need a [Xilinx Account](https://www.xilinx.com/registration/create-account.html) to install the required software.

For the ZCU102 Evaluation Kit, a license voucher should be included on the back of your Quick Start Guide.  You'll want to generate a Node-Locked license, or whatever meets your organization's license requirements.

#### Install Vivado

Install [Vivado Design Suite 2020.2](https://www.xilinx.com/products/design-tools/vivado.html)

Make sure to install support for Zynq Ultrascale+ boards

When prompted, load the license file downloaded from Xilinx.

Select the following options when stepping through the installer:

* Product: Vivado
* Edition: Vivado HL System Edition
* Devices: Zynq Ultrascale+ MPSoC
![Device Installation](image/vivado-devices.png)

### Create Baseline Vivado Project

Start by opening Vivado and clicking `Quick Start -> Create Project`:

![Vivado Create Project](image/vivado-create-project.png)

Use the following settings when creating your project:

* Project name: `zcu102_demo`
* Project Type: `RTL Project` (leave the checkboxes underneath RTL project unchecked)
* Add Sources: Make no changes
* Add Constraints: Make no changes
* Select "Boards"
    * Select "ZCU102 Evaluation Board"
    ![Board Selection](image/zcu102-selection.png)
