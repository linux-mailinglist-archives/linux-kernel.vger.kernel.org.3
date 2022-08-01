Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F8E5862D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiHACwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239429AbiHACwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:52:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B8313D79;
        Sun, 31 Jul 2022 19:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=aZW1wqHmfz7XNwPKKQpc+N4pkoIsPNtk2djlN8qJmTo=; b=mCFw/G270QdzOtOjtl2vh0Pdk2
        0WsZCDH9m+4+RBgsCSsTKo1yEOR/KlfF0uz8nJ1XWziqZJkNNwAU9nfQN4XIEzF2wl3BfRKEO38uN
        nAA/dc99CKRdk7/brkcEOAfftPqKHqhzt8zJw2Ctp+xhSiwLurCyma7VnXCwc77IB6f/Y8ILpWgCn
        Oze8mgbNo7FKNWRkVfEeQbjtGlkAP447euL97ZZuxaj+zS13JNAezxjYCM0uO6ZFR6qPXWgBRycw2
        +FZOn7ntvAaYpZb0Mgm3am35kHy8zFT76RlyWjXf2WzXWc9XkXIYMAO1g/MoyFmiHf9oPfv2kdqtY
        4anECbeQ==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oILXd-006ltg-Jd; Mon, 01 Aug 2022 02:52:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] devicetree/bindings: correct possessive "its" typos
Date:   Sun, 31 Jul 2022 19:52:21 -0700
Message-Id: <20220801025221.30563-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct all uses of "it's" that are meant to be possessive "its".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/clock/st/st,flexgen.txt        |    2 +-
 Documentation/devicetree/bindings/clock/ti/dra7-atl.txt          |    2 +-
 Documentation/devicetree/bindings/hwmon/adt7475.yaml             |    2 +-
 Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt |    2 +-
 Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml     |    2 +-
 Documentation/devicetree/bindings/mips/lantiq/rcu.txt            |    2 +-
 Documentation/devicetree/bindings/net/altera_tse.txt             |    2 +-
 Documentation/devicetree/bindings/net/cpsw.txt                   |    2 +-
 Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt        |    2 +-
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml    |    2 +-
 Documentation/devicetree/bindings/sound/da9055.txt               |    2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

--- a/Documentation/devicetree/bindings/net/altera_tse.txt
+++ b/Documentation/devicetree/bindings/net/altera_tse.txt
@@ -15,7 +15,7 @@ Required properties:
   "rx_desc":      MSGDMA Rx dispatcher descriptor space region
   "rx_resp":      MSGDMA Rx dispatcher response space region
   "s1":		  SGDMA descriptor memory
-- interrupts: Should contain the TSE interrupts and it's mode.
+- interrupts: Should contain the TSE interrupts and its mode.
 - interrupt-names: Should contain the interrupt names
   "rx_irq":       xDMA Rx dispatcher interrupt
   "tx_irq":       xDMA Tx dispatcher interrupt
--- a/Documentation/devicetree/bindings/net/cpsw.txt
+++ b/Documentation/devicetree/bindings/net/cpsw.txt
@@ -20,7 +20,7 @@ Required properties:
 - active_slave		: Specifies the slave to use for time stamping,
 			  ethtool and SIOCGMIIPHY
 - cpsw-phy-sel		: Specifies the phandle to the CPSW phy mode selection
-			  device. See also cpsw-phy-sel.txt for it's binding.
+			  device. See also cpsw-phy-sel.txt for its binding.
 			  Note that in legacy cases cpsw-phy-sel may be
 			  a child device instead of a phandle
 			  (DEPRECATED, use phys property instead).
--- a/Documentation/devicetree/bindings/sound/da9055.txt
+++ b/Documentation/devicetree/bindings/sound/da9055.txt
@@ -2,7 +2,7 @@
 
 DA9055 provides Audio CODEC support (I2C only).
 
-The Audio CODEC device in DA9055 has it's own I2C address which is configurable,
+The Audio CODEC device in DA9055 has its own I2C address which is configurable,
 so the device is instantiated separately from the PMIC (MFD) device.
 
 For details on accompanying PMIC I2C device, see the following:
--- a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
@@ -78,7 +78,7 @@ Required properties:
 - #clock-cells : from common clock binding; shall be set to 1 (multiple clock
   outputs).
 
-- clocks : must be set to the parent's phandle. it's could be output clocks of
+- clocks : must be set to the parent's phandle. it could be output clocks of
   a quadsfs or/and a pll or/and clk_sysin (up to 7 clocks)
 
 - clock-output-names : List of strings used to name the clock outputs.
--- a/Documentation/devicetree/bindings/clock/ti/dra7-atl.txt
+++ b/Documentation/devicetree/bindings/clock/ti/dra7-atl.txt
@@ -6,7 +6,7 @@ functional clock but can be configured t
 ATL can maintain a clock averages to some desired frequency based on the bws/aws
 signals - can compensate the drift between the two ws signal.
 
-In order to provide the support for ATL and it's output clocks (which can be used
+In order to provide the support for ATL and its output clocks (which can be used
 internally within the SoC or external components) two sets of bindings is needed:
 
 Clock tree binding:
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -57,7 +57,7 @@ patternProperties:
       Configures bypassing the individual voltage input attenuator. If
       set to 1 the attenuator is bypassed if set to 0 the attenuator is
       not bypassed. If the property is absent then the attenuator
-      retains it's configuration from the bios/bootloader.
+      retains its configuration from the bios/bootloader.
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1]
 
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -13,7 +13,7 @@ description:
   This binding describes the hardware component responsible for side channel
   requests to the always-on subsystem (AOSS), used for certain power management
   requests that is not handled by the standard RPMh interface. Each client in the
-  SoC has it's own block of message RAM and IRQ for communication with the AOSS.
+  SoC has its own block of message RAM and IRQ for communication with the AOSS.
   The protocol used to communicate in the message RAM is known as Qualcomm
   Messaging Protocol (QMP)
 
--- a/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
@@ -6,7 +6,7 @@ Required properties:
  - interrupts		  : interrupt specification for the ektf2127 interrupt
  - power-gpios		  : GPIO specification for the pin connected to the
 			    ektf2127's wake input. This needs to be driven high
-			    to take ektf2127 out of it's low power state
+			    to take ektf2127 out of its low power state
 
 For additional optional properties see: touchscreen.txt
 
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
@@ -74,7 +74,7 @@ properties:
   rohm,enable-hidden-gpo:
     description: |
       The BD71815 has undocumented GPO at pin E5. Pin is marked as GND at the
-      data-sheet as it's location in the middle of GND pins makes it hard to
+      data-sheet as its location in the middle of GND pins makes it hard to
       use on PCB. If your board has managed to use this pin you can enable the
       second GPO by defining this property. Dont enable this if you are unsure
       about how the E5 pin is connected on your board.
--- a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
+++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
@@ -2,7 +2,7 @@ Lantiq XWAY SoC RCU binding
 ===========================
 
 This binding describes the RCU (reset controller unit) multifunction device,
-where each sub-device has it's own set of registers.
+where each sub-device has its own set of registers.
 
 The RCU register range is used for multiple purposes. Mostly one device
 uses one or multiple register exclusively, but for some registers some
--- a/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
@@ -172,7 +172,7 @@ Interrupt controller (fsl,mpc5200-pic) n
 The mpc5200 pic binding splits hardware IRQ numbers into two levels.  The
 split reflects the layout of the PIC hardware itself, which groups
 interrupts into one of three groups; CRIT, MAIN or PERP.  Also, the
-Bestcomm dma engine has it's own set of interrupt sources which are
+Bestcomm dma engine has its own set of interrupt sources which are
 cascaded off of peripheral interrupt 0, which the driver interprets as a
 fourth group, SDMA.
 
