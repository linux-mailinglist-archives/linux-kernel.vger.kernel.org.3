Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7362A59CE77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiHWC2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239641AbiHWC2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:28:01 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E75B781;
        Mon, 22 Aug 2022 19:27:48 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.9; Tue, 23 Aug 2022
 10:27:45 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V4 4/6] dt-bindings: clk: meson: add S4 SoC peripheral clock controller bindings
Date:   Tue, 23 Aug 2022 10:26:28 +0800
Message-ID: <20220823022630.25007-5-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220823022630.25007-1-yu.tu@amlogic.com>
References: <20220823022630.25007-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add peripheral clock controller compatible and dt-bindings header for
the of the S4 SoC.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 .../clock/amlogic,s4-peripherals-clkc.yaml    | 105 ++++++++++++++
 .../clock/amlogic,s4-peripherals-clkc.h       | 131 ++++++++++++++++++
 2 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
new file mode 100644
index 000000000000..d1ea05ab7ec9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,s4-peripherals-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson S serials Peripherals Clock Controller
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+  - Jerome Brunet <jbrunet@baylibre.com>
+  - Yu Tu <yu.hu@amlogic.com>
+
+
+properties:
+  compatible:
+    const: amlogic,s4-peripherals-clkc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: input fixed pll div2
+      - description: input fixed pll div2p5
+      - description: input fixed pll div3
+      - description: input fixed pll div4
+      - description: input fixed pll div5
+      - description: input fixed pll div7
+      - description: input hifi pll
+      - description: input gp0 pll
+      - description: input mpll0
+      - description: input mpll1
+      - description: input mpll2
+      - description: input mpll3
+      - description: input hdmi pll
+      - description: input oscillator (usually at 24MHz)
+      - description: input external 32kHz reference (optional)
+
+  clock-names:
+    items:
+      - const: fclk_div2
+      - const: fclk_div2p5
+      - const: fclk_div3
+      - const: fclk_div4
+      - const: fclk_div5
+      - const: fclk_div7
+      - const: hifi_pll
+      - const: gp0_pll
+      - const: mpll0
+      - const: mpll1
+      - const: mpll2
+      - const: mpll3
+      - const: hdmi_pll
+      - const: xtal
+      - const: ext_32k
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
+
+    /* 32KHz reference crystal */
+    ext_32k: ref32k {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <32000>;
+    };
+
+    clkc_periphs: clock-controller@fe000000 {
+      compatible = "amlogic,s4-peripherals-clkc";
+      reg = <0xfe000000 0x49c>;
+      clocks = <&clkc_pll 3>,
+              <&clkc_pll 13>,
+              <&clkc_pll 5>,
+              <&clkc_pll 7>,
+              <&clkc_pll 9>,
+              <&clkc_pll 11>,
+              <&clkc_pll 17>,
+              <&clkc_pll 15>,
+              <&clkc_pll 25>,
+              <&clkc_pll 27>,
+              <&clkc_pll 29>,
+              <&clkc_pll 31>,
+              <&clkc_pll 20>,
+              <&xtal>,
+              <&ext_32k>;
+      clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3", "fclk_div4",
+                    "fclk_div5", "fclk_div7", "hifi_pll", "gp0_pll",
+                    "mpll0", "mpll1", "mpll2", "mpll3", "hdmi_pll", "xtal",
+                    "ext_32k";
+      #clock-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
new file mode 100644
index 000000000000..bbec5094d5c3
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
+ * Author: Yu Tu <yu.tu@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
+#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
+
+/*
+ * CLKID index values
+ */
+
+#define CLKID_RTC_CLK			4
+#define CLKID_SYS_CLK_B_GATE		7
+#define CLKID_SYS_CLK_A_GATE		10
+#define CLKID_SYS_CLK			11
+#define CLKID_CECA_32K_CLKOUT		16
+#define CLKID_CECB_32K_CLKOUT		21
+#define CLKID_SC_CLK_GATE		24
+#define CLKID_12_24M_CLK_SEL		27
+#define CLKID_VID_PLL			30
+#define CLKID_VCLK			37
+#define CLKID_VCLK2			38
+#define CLKID_VCLK_DIV1			39
+#define CLKID_VCLK2_DIV1		44
+#define CLKID_VCLK_DIV2			49
+#define CLKID_VCLK_DIV4			50
+#define CLKID_VCLK_DIV6			51
+#define CLKID_VCLK_DIV12		52
+#define CLKID_VCLK2_DIV2		53
+#define CLKID_VCLK2_DIV4		54
+#define CLKID_VCLK2_DIV6		55
+#define CLKID_VCLK2_DIV12		56
+#define CLKID_CTS_ENCI			61
+#define CLKID_CTS_ENCP			62
+#define CLKID_CTS_VDAC			63
+#define CLKID_HDMI			67
+#define CLKID_TS_CLK_GATE		69
+#define CLKID_MALI_0			72
+#define CLKID_MALI_1			75
+#define CLKID_MALI			76
+#define CLKID_VDEC_P0			79
+#define CLKID_VDEC_P1			82
+#define CLKID_VDEC_SEL			83
+#define CLKID_HEVCF_P0			86
+#define CLKID_HEVCF_P1			89
+#define CLKID_HEVCF_SEL			90
+#define CLKID_VPU_0			93
+#define CLKID_VPU_1			96
+#define CLKID_VPU			97
+#define CLKID_VPU_CLKB_TMP		100
+#define CLKID_VPU_CLKB			102
+#define CLKID_VPU_CLKC_P0		105
+#define CLKID_VPU_CLKC_P1		108
+#define CLKID_VPU_CLKC_SEL		109
+#define CLKID_VAPB_0			112
+#define CLKID_VAPB_1			115
+#define CLKID_VAPB			116
+#define CLKID_GE2D			117
+#define CLKID_VDIN_MEAS_GATE		120
+#define CLKID_SD_EMMC_C_CLK		123
+#define CLKID_SD_EMMC_A_CLK		126
+#define CLKID_SD_EMMC_B_CLK		129
+#define CLKID_SPICC0_GATE		132
+#define CLKID_PWM_A_GATE		135
+#define CLKID_PWM_B_GATE		138
+#define CLKID_PWM_C_GATE		141
+#define CLKID_PWM_D_GATE		144
+#define CLKID_PWM_E_GATE		147
+#define CLKID_PWM_F_GATE		150
+#define CLKID_PWM_G_GATE		153
+#define CLKID_PWM_H_GATE		156
+#define CLKID_PWM_I_GATE		159
+#define CLKID_PWM_J_GATE		162
+#define CLKID_SARADC_GATE		165
+#define CLKID_GEN_GATE			168
+#define CLKID_DDR			169
+#define CLKID_DOS			170
+#define CLKID_ETHPHY			171
+#define CLKID_MALI_GATE			172
+#define CLKID_AOCPU			173
+#define CLKID_AUCPU			174
+#define CLKID_CEC			175
+#define CLKID_SD_EMMC_A			176
+#define CLKID_SD_EMMC_B			177
+#define CLKID_NAND			178
+#define CLKID_SMARTCARD			179
+#define CLKID_ACODEC			180
+#define CLKID_SPIFC			181
+#define CLKID_MSR_CLK			182
+#define CLKID_IR_CTRL			183
+#define CLKID_AUDIO			184
+#define CLKID_ETH			185
+#define CLKID_UART_A			186
+#define CLKID_UART_B			187
+#define CLKID_UART_C			188
+#define CLKID_UART_D			189
+#define CLKID_UART_E			190
+#define CLKID_AIFIFO			191
+#define CLKID_TS_DDR			192
+#define CLKID_TS_PLL			193
+#define CLKID_G2D			194
+#define CLKID_SPICC0			195
+#define CLKID_SPICC1			196
+#define CLKID_USB			197
+#define CLKID_I2C_M_A			198
+#define CLKID_I2C_M_B			199
+#define CLKID_I2C_M_C			200
+#define CLKID_I2C_M_D			201
+#define CLKID_I2C_M_E			202
+#define CLKID_HDMITX_APB		203
+#define CLKID_I2C_S_A			204
+#define CLKID_USB1_TO_DDR		205
+#define CLKID_HDCP22			206
+#define CLKID_MMC_APB			207
+#define CLKID_RSA			208
+#define CLKID_CPU_DEBUG			209
+#define CLKID_VPU_INTR			210
+#define CLKID_DEMOD			211
+#define CLKID_SAR_ADC			212
+#define CLKID_GIC			213
+#define CLKID_PWM_AB			214
+#define CLKID_PWM_CD			215
+#define CLKID_PWM_EF			216
+#define CLKID_PWM_GH			217
+#define CLKID_PWM_IJ			218
+#define CLKID_HDCP22_ESMCLK_GATE	221
+#define CLKID_HDCP22_SKPCLK_GATE	224
+
+#endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H */
-- 
2.33.1

