Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8850C178
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiDVWHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiDVWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:06:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45848208225;
        Fri, 22 Apr 2022 13:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650660663;
        bh=Cymelfm0dfRc/xEvMKwoybWU1kDdiYfz3b2fHT5KUdI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HwCRogHH7SWrMLArbABWdkNz9fT6p7rcGoBcLx+u0005kKgylL4dxLQGgWTo1Iacv
         dRBl4e6l4+Wf4aFTLFHnE0rBn2/WY6x4yukN5yrbSoGO6sI05HEbW7VuiVmC1TBKIX
         E4htHAAfiFIpafJYnSc4LXiIirwpyR4fE0cwIzNc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.78.190.74]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1nNDlX1HTp-00WIyP; Fri, 22
 Apr 2022 20:31:54 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/7] dt-bindings: clock: Add Nuvoton WPCM450 clock/reset controller
Date:   Fri, 22 Apr 2022 20:30:09 +0200
Message-Id: <20220422183012.444674-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422183012.444674-1-j.neuschaefer@gmx.net>
References: <20220422183012.444674-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vVjrm1cK8AXlnpuGK08RSnmA6OQJ45C2q8UnLt+ebe9CliGV0GN
 Ti2LnJqA3CI0GUJriFLVzIgrC/GGhXhNMKKv5axP3W5W5BC44FV5INXkhXh9NVzreAFDXxf
 hYXaumjri/r402YVm6eqffixmakJCzbvAgc+taVHDAyxrjDdf0CQZBv5XXpMOXqvZrkmJI7
 35zbHFwBeKYBTxHW9dkrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AQbNhO89mNA=:MLaOVMQJPve9D6gl13SY/6
 x8dcmv0TrOwv0Dt9s/OHQeDH+TS4WpahFEojBRnVKjA0QTtUw9/5BS1Q+9M8eB+kl2Sjpwr91
 WfjgcDxVlCnoqeH8gdoSLC5spPNpj0y+6rlPXXRgd6aXGPCkWA2bxhs3H9UrGBEKJ3BZ02k6f
 t0fIT6LypHwcmRM/wU/N3mTMXDAGQ/KKmp8ndmWYnn2a4khJTds02H4xTy/3ELG6FVo2OaAI2
 DPMoqgGiRuURMcpM3zAAmbG6LslC0SZSikMZQeLBWxvdLG5cMWBKl9X82oaaeKvgJJd2/3qjs
 HeegIG4YCVpyVZ0B1SAAYWSE1OHspveo+GFscRINf5Mm5Y1w+INy6Sr8r8syauCif31k2ekI9
 8YUn1zACpgCsrfLfiIn6xVI+rXKtuxEyZdgUufWw+mSIO74TBzcap3W2hH5CVEU4D5duvcQOW
 fI2mqGEvWAzfAvy+Mdf/Yyl+8NvQ6jLI51cYWGVSHwdkARttm2IOR7QZg1CQRYXQSmVEFPdDh
 wDsCYwMQCrYW77UTgwE/acBO0rqBSJpf4NuY0QOKb1sjV5v+V3uM2k5Votzjcy8n2U5WMtHNf
 H/kJhGOCDr0y8Ab8k9HfW6dIWxBhUYqcfudxkAQUlrzPCdzT6oPXrK7YeXhTKON67TbUoKg3f
 u35H//9VxDbAzjxbESXvZzSWdDtp3o2excOpCWvEqFfXR8OHIudXDSgTTp5ViIevS0qbf8r1Z
 Q638FC4SAjmNt+Ulv8gWs/xPCmsiFpWKrOWtx8bXgWbWlM3LiBRza3kSAXy5jA/nPElUIe43G
 RTC3mgFDpwfOF2inXuLNEIhFw1FEe1+9nq3LycJFFrutTjSOiuOlpc1KWCl0QixV11MgkdZKs
 wJEOHUHFPnU1VhOkKE1bJH2g9fPfyV/xa+2zW2U1UAnHfOwPeQf9CsPeKHcrO+lNtXB58mGyc
 NqZ2XX7y72Twtb0TtY0P8/71imq+/JAUlwhzh4a2EWxlNEEx7jPLKL/cXtGAATPBI8gjVzszw
 xCbS8HIhZVYaGHjKRI0/g0XvN1iD2AaO8pOj1iOu8SQjOQNC0TdEJzR9IFHZRZwAtu/zH5K4m
 SCxdsoE7MH07PM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nuvoton WPCM450 SoC has a combined clock and reset controller.
Add a devicetree binding for it, as well as definitions for the bit
numbers used by it.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 .../bindings/clock/nuvoton,wpcm450-clk.yaml   | 74 +++++++++++++++++++
 .../dt-bindings/clock/nuvoton,wpcm450-clk.h   | 67 +++++++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpcm45=
0-clk.yaml
 create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.y=
aml b/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
new file mode 100644
index 0000000000000..0fffa8a68dee4
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nuvoton,wpcm450-clk.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nuvoton,wpcm450-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton WPCM450 clock controller binding
+
+maintainers:
+  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+
+description:
+  This binding describes the clock controller of the Nuvoton WPCM450 SoC,=
 which
+  supplies clocks and resets to the rest of the chip.
+
+properties:
+  compatible:
+    const: nuvoton,wpcm450-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Reference clock oscillator (should be 48 MHz)
+
+  clock-names:
+    items:
+      - const: refclk
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    refclk: clock-48mhz {
+      /* 48 MHz reference oscillator */
+      compatible =3D "fixed-clock";
+      clock-output-names =3D "refclk";
+      clock-frequency =3D <48000000>;
+      #clock-cells =3D <0>;
+    };
+
+    clk: clock-controller@b0000200 {
+      reg =3D <0xb0000200 0x100>;
+      compatible =3D "nuvoton,wpcm450-clk";
+      clocks =3D <&refclk>;
+      clock-names =3D "refclk";
+      #clock-cells =3D <1>;
+      #reset-cells =3D <1>;
+    };
+
+    serial@b8000000 {
+      compatible =3D "nuvoton,wpcm450-uart";
+      reg =3D <0xb8000000 0x20>;
+      reg-shift =3D <2>;
+      interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH>;
+      clocks =3D <&clk WPCM450_CLK_UART0>;
+    };
diff --git a/include/dt-bindings/clock/nuvoton,wpcm450-clk.h b/include/dt-=
bindings/clock/nuvoton,wpcm450-clk.h
new file mode 100644
index 0000000000000..86e1c895921b7
=2D-- /dev/null
+++ b/include/dt-bindings/clock/nuvoton,wpcm450-clk.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H
+#define _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H
+
+/* Clocks based on CLKEN bits */
+#define WPCM450_CLK_FIU            0
+#define WPCM450_CLK_XBUS           1
+#define WPCM450_CLK_KCS            2
+#define WPCM450_CLK_SHM            4
+#define WPCM450_CLK_USB1           5
+#define WPCM450_CLK_EMC0           6
+#define WPCM450_CLK_EMC1           7
+#define WPCM450_CLK_USB0           8
+#define WPCM450_CLK_PECI           9
+#define WPCM450_CLK_AES           10
+#define WPCM450_CLK_UART0         11
+#define WPCM450_CLK_UART1         12
+#define WPCM450_CLK_SMB2          13
+#define WPCM450_CLK_SMB3          14
+#define WPCM450_CLK_SMB4          15
+#define WPCM450_CLK_SMB5          16
+#define WPCM450_CLK_HUART         17
+#define WPCM450_CLK_PWM           18
+#define WPCM450_CLK_TIMER0        19
+#define WPCM450_CLK_TIMER1        20
+#define WPCM450_CLK_TIMER2        21
+#define WPCM450_CLK_TIMER3        22
+#define WPCM450_CLK_TIMER4        23
+#define WPCM450_CLK_MFT0          24
+#define WPCM450_CLK_MFT1          25
+#define WPCM450_CLK_WDT           26
+#define WPCM450_CLK_ADC           27
+#define WPCM450_CLK_SDIO          28
+#define WPCM450_CLK_SSPI          29
+#define WPCM450_CLK_SMB0          30
+#define WPCM450_CLK_SMB1          31
+
+/* Other clocks */
+#define WPCM450_CLK_USBPHY        32
+
+#define WPCM450_NUM_CLKS          33
+
+/* Resets based on IPSRST bits */
+#define WPCM450_RESET_FIU          0
+#define WPCM450_RESET_EMC0         6
+#define WPCM450_RESET_EMC1         7
+#define WPCM450_RESET_USB0         8
+#define WPCM450_RESET_USB1         9
+#define WPCM450_RESET_AES_PECI    10
+#define WPCM450_RESET_UART        11
+#define WPCM450_RESET_MC          12
+#define WPCM450_RESET_SMB2        13
+#define WPCM450_RESET_SMB3        14
+#define WPCM450_RESET_SMB4        15
+#define WPCM450_RESET_SMB5        16
+#define WPCM450_RESET_PWM         18
+#define WPCM450_RESET_TIMER       19
+#define WPCM450_RESET_ADC         27
+#define WPCM450_RESET_SDIO        28
+#define WPCM450_RESET_SSPI        29
+#define WPCM450_RESET_SMB0        30
+#define WPCM450_RESET_SMB1        31
+
+#define WPCM450_NUM_RESETS        32
+
+#endif /* _DT_BINDINGS_CLOCK_NUVOTON_WPCM450_CLK_H */
=2D-
2.35.1

