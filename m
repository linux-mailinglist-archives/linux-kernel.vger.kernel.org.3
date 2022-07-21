Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6375557C1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 03:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiGUBfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 21:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiGUBfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 21:35:41 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 948E813DE4;
        Wed, 20 Jul 2022 18:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ESAWJ
        /S/cXA/l1Ah8Rii0T8fNMmH+ZT8ypZAQnXsvyI=; b=RS214l1v7TSc5bi1nAiQ2
        5s2aCQ+i15MafQ0N+yqXTb3WxTDE1B59bn6mTcKQBT5kCOBGXG2QMYIlSkHBf8pu
        51TfhGEFgPeXoUe5GcfeymYTc/WnX7g2aaBfIIqmzKprUcgAIQL/lLrS5qYpQq7M
        FKWfDYV9ZiSqkPipjrj2yI=
Received: from localhost.localdomain (unknown [223.104.68.243])
        by smtp8 (Coremail) with SMTP id DMCowABXyvhSqdhi53mCOg--.10010S2;
        Thu, 21 Jul 2022 09:18:13 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        david@lechnology.com, mturquette@baylibre.com, sboyd@kernel.org,
        mdf@kernel.org, yilun.xu@intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, agross@kernel.org, bjorn.andersson@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, narmstrong@baylibre.com, khilman@baylibre.com,
        mathieu.poirier@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v2] dt-bindings: Fix typo in comment
Date:   Thu, 21 Jul 2022 09:17:46 +0800
Message-Id: <20220721011746.19663-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowABXyvhSqdhi53mCOg--.10010S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3ZF1kJw1xZw4xtF4UJFW8JFb_yoW8GF45Wo
        ZakF42yw17K3y7ArZYkwnrGF1kAry7GFn7Za17Kwn8tw4IqrZI93sxZa1jqF9rtF4xGFWf
        JryxCa18WFs8K3Wkn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTiK0P3UUUUU
X-Originating-IP: [223.104.68.243]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRxZFZFc7Yv75tAAAsN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the comment

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
v2: Add all changes in one subsystem into 1 patch
---
 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt       | 2 +-
 Documentation/devicetree/bindings/clock/ti/davinci/pll.txt    | 2 +-
 Documentation/devicetree/bindings/fpga/fpga-region.txt        | 2 +-
 Documentation/devicetree/bindings/gpio/gpio-pisosr.txt        | 2 +-
 Documentation/devicetree/bindings/net/qcom-emac.txt           | 2 +-
 .../bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml      | 2 +-
 .../devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   | 2 +-
 .../devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   | 2 +-
 .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   | 2 +-
 .../devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml      | 2 +-
 Documentation/devicetree/bindings/powerpc/fsl/cpus.txt        | 2 +-
 Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt  | 2 +-
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt    | 2 +-
 Documentation/devicetree/bindings/sound/tlv320adcx140.yaml    | 4 ++--
 .../devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml      | 2 +-
 .../devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt  | 2 +-
 Documentation/devicetree/bindings/thermal/rcar-thermal.yaml   | 2 +-
 17 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
index 94d50a949be1..c0e3c3a42bea 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
@@ -10,7 +10,7 @@ system, notifying them when a low power state is entered or exited.
 Multiple revisions of the SAW hardware are supported using these Device Nodes.
 SAW2 revisions differ in the register offset and configuration data. Also, the
 same revision of the SAW in different SoCs may have different configuration
-data due the the differences in hardware capabilities. Hence the SoC name, the
+data due the differences in hardware capabilities. Hence the SoC name, the
 version of the SAW hardware in that SoC and the distinction between cpu (big
 or Little) or cache, may be needed to uniquely identify the SAW register
 configuration and initialization data. The compatible string is used to
diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
index 36998e184821..c9894538315b 100644
--- a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
+++ b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
@@ -15,7 +15,7 @@ Required properties:
 	- for "ti,da850-pll1", shall be "clksrc"
 
 Optional properties:
-- ti,clkmode-square-wave: Indicates that the the board is supplying a square
+- ti,clkmode-square-wave: Indicates that the board is supplying a square
 	wave input on the OSCIN pin instead of using a crystal oscillator.
 	This property is only valid when compatible = "ti,da850-pll0".
 
diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 7d3515264838..6694ef29a267 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -330,7 +330,7 @@ succeeded.
 
 The Device Tree Overlay will contain:
  * "target-path" or "target"
-   The insertion point where the the contents of the overlay will go into the
+   The insertion point where the contents of the overlay will go into the
    live tree.  target-path is a full path, while target is a phandle.
  * "ranges"
     The address space mapping from processor to FPGA bus(ses).
diff --git a/Documentation/devicetree/bindings/gpio/gpio-pisosr.txt b/Documentation/devicetree/bindings/gpio/gpio-pisosr.txt
index 414a01cdf715..fba3c61f6a5b 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pisosr.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-pisosr.txt
@@ -14,7 +14,7 @@ Optional properties:
  - ngpios		: Number of used GPIO lines (0..n-1), default is 8.
  - load-gpios		: GPIO pin specifier attached to load enable, this
 			  pin is pulsed before reading from the device to
-			  load input pin values into the the device.
+			  load input pin values into the device.
 
 For other required and optional properties of SPI slave
 nodes please refer to ../spi/spi-bus.txt.
diff --git a/Documentation/devicetree/bindings/net/qcom-emac.txt b/Documentation/devicetree/bindings/net/qcom-emac.txt
index 346e6c7f47b7..e6cb2291471c 100644
--- a/Documentation/devicetree/bindings/net/qcom-emac.txt
+++ b/Documentation/devicetree/bindings/net/qcom-emac.txt
@@ -14,7 +14,7 @@ MAC node:
 - mac-address : The 6-byte MAC address. If present, it is the default
 	MAC address.
 - internal-phy : phandle to the internal PHY node
-- phy-handle : phandle the the external PHY node
+- phy-handle : phandle the external PHY node
 
 Internal PHY node:
 - compatible : Should be "qcom,fsm9900-emac-sgmii" or "qcom,qdf2432-emac-sgmii".
diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
index 4d01f3124e1c..a90fa1baadab 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
@@ -16,7 +16,7 @@ description: |+
   - compatible: Should be the following:
                 "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
 
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
index c689bea7ce6e..d3a8911728d0 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
@@ -16,7 +16,7 @@ description: |+
   - compatible:     Should be one of the following:
                     "aspeed,ast2400-scu", "syscon", "simple-mfd"
 
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index 9db904a528ee..5d2c1b1fb7fd 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -17,7 +17,7 @@ description: |+
   			"aspeed,ast2500-scu", "syscon", "simple-mfd"
   			"aspeed,g5-scu", "syscon", "simple-mfd"
 
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
index 3666ac5b6518..e92686d2f062 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -16,7 +16,7 @@ description: |+
   - compatible: Should be one of the following:
                 "aspeed,ast2600-scu", "syscon", "simple-mfd"
 
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
index f005abac7079..4e52ef33a986 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
@@ -17,7 +17,7 @@ description: |+
   - compatible: Should be the following:
                 "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
 
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
index d63ab1dec16d..801c66069121 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
@@ -5,7 +5,7 @@ Copyright 2013 Freescale Semiconductor Inc.
 Power Architecture CPUs in Freescale SOCs are represented in device trees as
 per the definition in the Devicetree Specification.
 
-In addition to the the Devicetree Specification definitions, the properties
+In addition to the Devicetree Specification definitions, the properties
 defined below may be present on CPU nodes.
 
 PROPERTIES
diff --git a/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt b/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
index 9d619e955576..d6658d3dd15e 100644
--- a/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
+++ b/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
@@ -39,7 +39,7 @@ otherwise. The length of all the property arrays must be the same.
 
 - ibm,cpu-idle-state-flags:
 	Array of unsigned 32-bit values containing the values of the
-	flags associated with the the aforementioned idle-states. The
+	flags associated with the aforementioned idle-states. The
 	flag bits are as follows:
 		0x00000001 /* Decrementer would stop */
 		0x00000002 /* Needs timebase restore */
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index f861862b9770..526e8f110d5c 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -37,7 +37,7 @@ on the Qualcomm Hexagon core.
 - interrupt-names:
 	Usage: required
 	Value type: <stringlist>
-	Definition: The interrupts needed depends on the the compatible
+	Definition: The interrupts needed depends on the compatible
 		    string:
 	qcom,q6v5-pil:
 	qcom,ipq8074-wcss-pil:
diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index 2ad17b361db0..bc2fb1a80ed7 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -68,9 +68,9 @@ properties:
        array is defined as <PDMIN1 PDMIN2 PDMIN3 PDMIN4>.
 
        0 - (default) Odd channel is latched on the negative edge and even
-       channel is latched on the the positive edge.
+       channel is latched on the positive edge.
        1 - Odd channel is latched on the positive edge and even channel is
-       latched on the the negative edge.
+       latched on the negative edge.
 
        PDMIN1 - PDMCLK latching edge used for channel 1 and 2 data
        PDMIN2 - PDMCLK latching edge used for channel 3 and 4 data
diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
index 1ab5070c751d..89a2c32c0ab2 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
@@ -16,7 +16,7 @@ description: |+
   - compatible: Should be one of the following:
                 "brcm,bcm2711-avs-monitor", "syscon", "simple-mfd"
 
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
index db880e7ed713..aea4a2a178b9 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
@@ -96,7 +96,7 @@ critical trip point is reported back to the thermal framework to implement
 software shutdown.
 
 - the "hot" type trip points will be set to SOC_THERM hardware as the throttle
-temperature. Once the the temperature of this thermal zone is higher
+temperature. Once the temperature of this thermal zone is higher
 than it, it will trigger the HW throttle event.
 
 Example :
diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
index 927de79ab4b5..00dcbdd36144 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
@@ -42,7 +42,7 @@ properties:
     description:
       Address ranges of the thermal registers. If more then one range is given
       the first one must be the common registers followed by each sensor
-      according the the datasheet.
+      according the datasheet.
     minItems: 1
     maxItems: 4
 
-- 
2.25.1

