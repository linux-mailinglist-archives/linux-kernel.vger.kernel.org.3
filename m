Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CDF4E2CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349010AbiCUP4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbiCUP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:56:46 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBF65D1B6;
        Mon, 21 Mar 2022 08:55:21 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22LFt8wF012397;
        Mon, 21 Mar 2022 10:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647878108;
        bh=sa7+Ss6vASrFyvh6MsL+gfTKsjXhhhAdilRSitBRXwk=;
        h=From:To:CC:Subject:Date;
        b=eajFr1bCNK15S0Bz+WWHswcEPyTXOtBK2alJGz5d/dXaFbTBZJmx31tY0idlvXubi
         ijO8Ze6Nvwp1ftN+VDB3IDavFLLuAIH5VltMiOCZVnbPgPiSkhopic4+37TGEasmkn
         GAspHBdqTLBPGdQFeUvVJDb/d2wVNiAev0AZf7v0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22LFt8HE109210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Mar 2022 10:55:08 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 21
 Mar 2022 10:55:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 21 Mar 2022 10:55:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22LFt8tf088619;
        Mon, 21 Mar 2022 10:55:08 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [RFC] arm64: dts: ti: introduce a minimal am642 device tree
Date:   Mon, 21 Mar 2022 10:54:17 -0500
Message-ID: <20220321155417.13267-1-bb@ti.com>
X-Mailer: git-send-email 2.17.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6873; h=from:subject; bh=oanxEdU+tNjntH3wxOh1eBfuSPzLaaPbreW2/Ze55jA=; b=owEBbQGS/pANAwAKAcD4q9PiE9cMAcsmYgBiOJ+ofluqr4YYv5vWFlNjuYxtXkS4QnRrQ+yFeCWd NBjDYaOJATMEAAEKAB0WIQT86LDvkHWcjT+1Kb7A+KvT4hPXDAUCYjifqAAKCRDA+KvT4hPXDBI3B/ 4hXK0N5ac1z15Iw9Es3g3mJw8qgmQFRP2ftELRC8yhQrJ2WyRdcfQhBoeKsf7t3Ebe8b5HZsMpFPOO s5KwgufQnMN3MSAht7q1U0WD3z14Ma5T1IQAns5ebcPekOTdV1zLJZwsmzTN8TsZqlt40U3/+orwnJ HI7G3rWasyE3G+NHcsjZU5tCAZt+n6wOZ41KNBUoFH1bybBuMOooEQIv0w4vb46MmjoLMJCwye6I5+ ObftqlEiONyP+fG/9QUSogzWvaXRkhqzluMOozPHj5t7dwgkvPLlEBn6ANCTUqU18VrwqI82VUc644 rIQnVPptH3pI1S/AvQjHt8tzCDKYVo
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instrument's am642 is one of many k3 based, low cost, low power,
chips designed to work in a wide range of applications spanning an even
wider range of industries that TI is actively developing

With its pin-mux and peripheral rich designs, these chips will likely
have a multitude of custom device trees that range wildly from one
another and (hopefully) guarantee an influx of variants into the kernel
in the coming years

With overlays no longer a thing, I wanted to ask for opinions on how
we can best help integrate these dt files as they begin to be developed

I also wanted to introduce a skeletonized (nothing but uart) device tree
to give others a good starting point while developing their projects.

Let me know what you think :)

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 arch/arm64/boot/dts/ti/k3-am642-skeleton.dts  | 335 ++++++++++++++++++
 3 files changed, 337 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-skeleton.dts

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 61c6ab4f52e26..e65053d6465bd 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -55,6 +55,7 @@ properties:
       - description: K3 AM642 SoC
         items:
           - enum:
+              - ti,am642-generic
               - ti,am642-evm
               - ti,am642-sk
           - const: ti,am642
diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 02e5d80344d00..df7bdf087558c 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
 
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
 
+dtb-$(CONFIG_ARCH_K3) += k3-am642-skeleton.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 
diff --git a/arch/arm64/boot/dts/ti/k3-am642-skeleton.dts b/arch/arm64/boot/dts/ti/k3-am642-skeleton.dts
new file mode 100644
index 0000000000000..2b789c9c25ced
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-skeleton.dts
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The absolute minimum DTS file needed for an AM642
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/pinctrl/k3.h>
+#include "k3-am642.dtsi"
+
+/ {
+	compatible = "ti,am642-generic", "ti,am642";
+	model = "Texas Instruments AM642 Generic";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
+	};
+
+	cpus {
+		/delete-node/ cpu@1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000 0x00000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+};
+
+/* reserved for mcu firmware */
+&mcu_gpio0 {
+	status = "reserved";
+};
+
+&mcu_i2c0 {
+	status = "disabled";
+};
+
+&mcu_i2c1 {
+	status = "disabled";
+};
+
+&mcu_gpio_intr {
+	status = "disabled";
+};
+
+&mcu_pmx0 {
+	status = "disabled";
+};
+
+&mcu_uart0 {
+	status = "disabled";
+};
+
+&mcu_uart1 {
+	status = "disabled";
+};
+
+&mcu_spi0 {
+	status = "disabled";
+};
+
+&mcu_spi1 {
+	status = "disabled";
+};
+
+/* dmss */
+
+&fss {
+	status = "disabled";
+};
+
+&main_mcan0 {
+	status = "disabled";
+};
+
+&main_mcan1 {
+	status = "disabled";
+};
+
+&usbss0 {
+	status = "disabled";
+};
+
+&cpsw3g {
+	status = "disabled";
+};
+
+&main_gpio0 {
+	status = "disabled";
+};
+
+&main_gpio1 {
+	status = "disabled";
+};
+
+&main_i2c0 {
+	status = "disabled";
+};
+
+&main_i2c1 {
+	status = "disabled";
+};
+
+&main_i2c2 {
+	status = "disabled";
+};
+
+&main_i2c3 {
+	status = "disabled";
+};
+
+&icssg0 {
+	status = "disabled";
+};
+
+&icssg1 {
+	status = "disabled";
+};
+
+/* gic500 */
+
+&main_gpio_intr {
+	status = "disabled";
+};
+
+&mailbox0_cluster2 {
+	status = "disabled";
+};
+
+&mailbox0_cluster3 {
+	status = "disabled";
+};
+
+&mailbox0_cluster4 {
+	status = "disabled";
+};
+
+&mailbox0_cluster5 {
+	status = "disabled";
+};
+
+&mailbox0_cluster6 {
+	status = "disabled";
+};
+
+&mailbox0_cluster7 {
+	status = "disabled";
+};
+
+&sdhci1 {
+	status = "disabled";
+};
+
+&sdhci0 {
+	status = "disabled";
+};
+
+&pcie0_ep {
+	status = "disabled";
+};
+
+&pcie0_rc {
+	status = "disabled";
+};
+
+&timesync_router {
+	status = "disabled";
+};
+
+&main_pmx0 {
+	/* (optional) for console */
+	main_uart0_pins_default: main-uart0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0230, PIN_INPUT, 0)  /* (D15) UART0_RXD */
+			AM64X_IOPAD(0x0234, PIN_OUTPUT, 0) /* (C16) UART0_TXD */
+		>;
+	};
+};
+
+&epwm0 {
+	status = "disabled";
+};
+
+&epwm1 {
+	status = "disabled";
+};
+
+&epwm2 {
+	status = "disabled";
+};
+
+&epwm3 {
+	status = "disabled";
+};
+
+&epwm4 {
+	status = "disabled";
+};
+
+&epwm5 {
+	status = "disabled";
+};
+
+&epwm6 {
+	status = "disabled";
+};
+
+&epwm7 {
+	status = "disabled";
+};
+
+&epwm8 {
+	status = "disabled";
+};
+
+&ecap0 {
+	status = "disabled";
+};
+
+&ecap1 {
+	status = "disabled";
+};
+
+&ecap2 {
+	status = "disabled";
+};
+
+&main_r5fss0 {
+	status = "disabled";
+};
+
+&main_r5fss1 {
+	status = "disabled";
+};
+
+/* (optional) for console */
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+};
+
+/* reserved for firmware */
+&main_uart1 {
+	status = "reserved";
+};
+
+&main_uart2 {
+	status = "disabled";
+};
+
+&main_uart3 {
+	status = "disabled";
+};
+
+&main_uart4 {
+	status = "disabled";
+};
+
+&main_uart5 {
+	status = "disabled";
+};
+
+&main_uart6 {
+	status = "disabled";
+};
+
+&main_spi0 {
+	status = "disabled";
+};
+
+&main_spi1 {
+	status = "disabled";
+};
+
+&main_spi2 {
+	status = "disabled";
+};
+
+&main_spi3 {
+	status = "disabled";
+};
+
+&main_spi4 {
+	status = "disabled";
+};
+
+&hwspinlock {
+	status = "disabled";
+};
+
+/* oc_sram */
+
+&main_conf {
+	status = "disabled";
+};
+
+/* dmsc */
+
+&tscadc0 {
+	status = "disabled";
+};
+
+&serdes_wiz0 {
+	status = "disabled";
+};
+
+/* !cbass_main */
+
+/* transceiver1 */
+/* transceiver2 */
+
+&serdes_refclk {
+	status = "disabled";
+};
+
+&cluster0 {
+	/delete-node/ core1;
+};
+
+&pmu {
+	status = "disabled";
+};
-- 
2.17.1

