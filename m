Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE0F46B1CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhLGEVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhLGEVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:21:17 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CF5C061746;
        Mon,  6 Dec 2021 20:17:47 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id a24so11972289qvb.5;
        Mon, 06 Dec 2021 20:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z7Gy1WQbc5cWYPZR0zK2/dPa3psomkuIdPZLCyt6OsM=;
        b=EQWUobvQfQhNZQg+rLYESoranBVbsLPAJabfS7Y1p4uM4rOqIJa+b8LBbZ4KFa0DIL
         grw4yeanVFWwjRPWbRRMCkcfjo41pbQmb2Y27Ts34dt6cgdFeiX1C+82cqazuavRy1Ey
         VXA8F38o4v0/Trsg8zukCWAtPGrVzx8STIU5TaBfOlDXWmSQ+7iYK+2wh14EiFf77wJ8
         BA1jt+05ZYC5VjWvwkJgGNke5Hp7SWAEpalQykTghPwBzW7fe18xphQ4qDO03RmmED9m
         jaiCDNzEeJqkVgr4MNnp/eEfIeDR82YR2D7PLJdjH20Qi+WVh9z+sfxBUiAjGX5ahkfD
         c7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z7Gy1WQbc5cWYPZR0zK2/dPa3psomkuIdPZLCyt6OsM=;
        b=Ay1fKK9+US0ZRLKIo2K9NnmJ44GvbkHM7xAYPGEzWXymuozla9fPYr00Y/pzTZXiBd
         7+H0POR0voxiSioNN5j7vKYcC0g1oThIMO2s0hPVwRcdnGQhIZbsmTD+PBUjdegQhdvY
         31EjCl4Ec6hIUdm7Pb9KKnHRRIHp7Z0rAYV6O3jhen4CSfWpRPuqF5uIIq/x79jgyN/g
         vh13xUsPSpicmLs+kupa5hC02HBh7azfn4QXTlFwl+Sn/6trnkNE/uitiOaMvch1UUvx
         NFkaLt7yAxDvPhVHRUNZx7EtgsB44d9bRS+YGQ0ypM3Qh5/AjIkFRZE2CTD1rN+qeYWz
         BA3Q==
X-Gm-Message-State: AOAM530g5HXcaLb041IPZNB2wF8lCIcL/9UMmp4JkBpBirbdc8Eb290b
        a591/G8OELTtNNX5GPmfV4dh0DQsBbU=
X-Google-Smtp-Source: ABdhPJyCzyNfTbvlGSqAI42UOZcnMh2ghKIWKWObr7cvZlQGZOb32pKitV36aglpTGO9yGBWq9Uy6w==
X-Received: by 2002:a05:6214:c81:: with SMTP id r1mr42989214qvr.111.1638850666526;
        Mon, 06 Dec 2021 20:17:46 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id q12sm8745004qtx.16.2021.12.06.20.17.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 20:17:46 -0800 (PST)
From:   Wells Lu <wellslutw@gmail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     wells.lu@sunplus.com, dvorkin@tibbo.com,
        Wells Lu <wellslutw@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: pinctrl: Add dt-bindings for Sunplus SP7021
Date:   Tue,  7 Dec 2021 12:17:44 +0800
Message-Id: <1638850665-9474-2-git-send-email-wellslutw@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638850665-9474-1-git-send-email-wellslutw@gmail.com>
References: <1638850665-9474-1-git-send-email-wellslutw@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings header files and documentation for Sunplus SP7021 SoC.

Signed-off-by: Wells Lu <wellslutw@gmail.com>
---
Changes in V3
  - Addressed comments of Mr. Rob Herring.

 .../bindings/pinctrl/sunplus,sp7021-pinctrl.yaml   | 293 +++++++++++++++++++++
 MAINTAINERS                                        |   9 +
 include/dt-bindings/pinctrl/sppctl-sp7021.h        | 173 ++++++++++++
 include/dt-bindings/pinctrl/sppctl.h               |  40 +++
 4 files changed, 515 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
 create mode 100644 include/dt-bindings/pinctrl/sppctl-sp7021.h
 create mode 100644 include/dt-bindings/pinctrl/sppctl.h

diff --git a/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
new file mode 100644
index 0000000..fe2ab1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
@@ -0,0 +1,293 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/sunplus,sp7021-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 Pin Controller Device Tree Bindings
+
+maintainers:
+  - Dvorkin Dmitry <dvorkin@tibbo.com>
+  - Wells Lu <wellslutw@gmail.com>
+
+description: |
+  The Sunplus SP7021 pin controller is used to control SoC pins. Please
+  refer to pinctrl-bindings.txt in this directory for details of the common
+  pinctrl bindings used by client devices.
+
+  The device node of pin controller of Sunplus SP7021 has following
+  properties.
+
+properties:
+  compatible:
+    const: sunplus,sp7021-pctl
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  reg:
+    items:
+      - description: the MOON2 registers
+      - description: the GPIOXT registers
+      - description: the GPIOXT2 registers
+      - description: the FIRST registers
+      - description: the MOON1 registers
+
+  reg-names:
+    items:
+      - const: moon2
+      - const: gpioxt
+      - const: gpioxt2
+      - const: first
+      - const: moon1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+patternProperties:
+  '-pins$':
+    if:
+      type: object
+    then:
+      description: |
+        A pinctrl node should contain at least one subnodes representing the
+        pins or function-pins group available on the machine. Each subnode
+        will list the pins it needs, and how they should be configured.
+
+        Pinctrl node's client devices use subnodes for desired pin
+        configuration. Client device subnodes use below standard properties.
+
+      properties:
+        pins:
+          description: |
+            Define pins which are used by pinctrl node's client device.
+
+            It consists of one or more integers which represents the config
+            setting for corresponding pin. Please use macro SPPCTL_IOPAD to
+            define the integers for pins.
+
+            The first argument of the macro is pin number, the second is pin
+            type, the third is type of GPIO, the last is default output state
+            of GPIO.
+          $ref: /schemas/types.yaml#/definitions/uint32-array
+
+        function:
+          description: |
+            Define pin-function which is used by pinctrl node's client device.
+            The name should be one of string in the following enumeration.
+          $ref: "/schemas/types.yaml#/definitions/string"
+          enum: [ SPI_FLASH, SPI_FLASH_4BIT, SPI_NAND, CARD0_EMMC, SD_CARD,
+                  UA0, FPGA_IFX, HDMI_TX, LCDIF, USB0_OTG, USB1_OTG ]
+
+        groups:
+          description: |
+            Define pin-group in a specified pin-function.
+            The name should be one of string in the following enumeration.
+          $ref: "/schemas/types.yaml#/definitions/string"
+          enum: [ SPI_FLASH1, SPI_FLASH2, SPI_FLASH_4BIT1, SPI_FLASH_4BIT2,
+                  SPI_NAND, CARD0_EMMC, SD_CARD, UA0, FPGA_IFX, HDMI_TX1,
+                  HDMI_TX2, HDMI_TX3, LCDIF, USB0_OTG, USB1_OTG ]
+
+        zero_func:
+          description: |
+            Disabled pins which are not used by pinctrl node's client device.
+          $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      additionalProperties: false
+
+      allOf:
+        - if:
+            properties:
+              function:
+                enum:
+                  - SPI_FLASH
+          then:
+            properties:
+              groups:
+                enum:
+                  - SPI_FLASH1
+                  - SPI_FLASH2
+        - if:
+            properties:
+              function:
+                enum:
+                  - SPI_FLASH_4BIT
+          then:
+            properties:
+              groups:
+                enum:
+                  - SPI_FLASH_4BIT1
+                  - SPI_FLASH_4BIT2
+        - if:
+            properties:
+              function:
+                enum:
+                  - SPI_NAND
+          then:
+            properties:
+              groups:
+                enum:
+                  - SPI_NAND
+        - if:
+            properties:
+              function:
+                enum:
+                  - CARD0_EMMC
+          then:
+            properties:
+              groups:
+                enum:
+                  - CARD0_EMMC
+        - if:
+            properties:
+              function:
+                enum:
+                  - SD_CARD
+          then:
+            properties:
+              groups:
+                enum:
+                  - SD_CARD
+        - if:
+            properties:
+              function:
+                enum:
+                  - UA0
+          then:
+            properties:
+              groups:
+                enum:
+                  - UA0
+        - if:
+            properties:
+              function:
+                enum:
+                  - FPGA_IFX
+          then:
+            properties:
+              groups:
+                enum:
+                  - FPGA_IFX
+        - if:
+            properties:
+              function:
+                enum:
+                  - HDMI_TX
+          then:
+            properties:
+              groups:
+                enum:
+                  - HDMI_TX1
+                  - HDMI_TX2
+                  - HDMI_TX3
+        - if:
+            properties:
+              function:
+                enum:
+                  - LCDIF
+          then:
+            properties:
+              groups:
+                enum:
+                  - LCDIF
+        - if:
+            properties:
+              function:
+                enum:
+                  - USB0_OTG
+          then:
+            properties:
+              groups:
+                enum:
+                  - USB0_OTG
+        - if:
+            properties:
+              function:
+                enum:
+                  - USB1_OTG
+          then:
+            properties:
+              groups:
+                enum:
+                  - USB1_OTG
+
+required:
+  - compatible
+  - reg
+  - "#gpio-cells"
+  - gpio-controller
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/sppctl-sp7021.h>
+
+    pinctl@9c000100 {
+        compatible = "sunplus,sp7021-pctl";
+        reg = <0x9c000100 0x100>, <0x9c000300 0x80>, <0x9c000380 0x80>,
+              <0x9c0032e4 0x1c>, <0x9c000080 0x20>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        clocks = <&clkc 0x83>;
+        resets = <&rstc 0x73>;
+
+        uart0-pins {
+            function = "UA0";
+            groups = "UA0";
+        };
+
+        spinand0-pins {
+            function = "SPI_NAND";
+            groups = "SPI_NAND";
+        };
+
+        uart1-pins {
+            pins = <
+                SPPCTL_IOPAD(11, SPPCTL_PCTL_G_PMUX, MUXF_UA1_TX, 0)
+                SPPCTL_IOPAD(10, SPPCTL_PCTL_G_PMUX, MUXF_UA1_RX, 0)
+            >;
+        };
+
+        uart2-pins {
+            pins = <
+                SPPCTL_IOPAD(20, SPPCTL_PCTL_G_PMUX, MUXF_UA1_TX, 0)
+                SPPCTL_IOPAD(21, SPPCTL_PCTL_G_PMUX, MUXF_UA1_RX, 0)
+                SPPCTL_IOPAD(22, SPPCTL_PCTL_G_PMUX, MUXF_UA1_RTS, 0)
+                SPPCTL_IOPAD(23, SPPCTL_PCTL_G_PMUX, MUXF_UA1_CTS, 0)
+            >;
+        };
+
+        emmc-pins {
+            function = "CARD0_EMMC";
+            groups = "CARD0_EMMC";
+        };
+
+        sdcard-pins {
+            function = "SD_CARD";
+            groups = "SD_CARD";
+            pins = < SPPCTL_IOPAD(91, SPPCTL_PCTL_G_GPIO, 0, 0) >;
+        };
+
+        hdmi_A_tx1-pins {
+            function = "HDMI_TX";
+            groups = "HDMI_TX1";
+        };
+        hdmi_A_tx2-pins {
+            function = "HDMI_TX";
+            groups = "HDMI_TX2";
+        };
+        hdmi_A_tx3-pins {
+            function = "HDMI_TX";
+            groups = "HDMI_TX3";
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index faa9c34..723bbe3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15128,6 +15128,15 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	drivers/pinctrl/pinctrl-single.c
 
+PIN CONTROLLER - SUNPLUS / TIBBO
+M:	Dvorkin Dmitry <dvorkin@tibbo.com>
+M:	Wells Lu <wellslutw@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
+F:	Documentation/devicetree/bindings/pinctrl/sunplus,*
+F:	include/dt-bindings/pinctrl/sppctl*
+
 PKTCDVD DRIVER
 M:	linux-block@vger.kernel.org
 S:	Orphan
diff --git a/include/dt-bindings/pinctrl/sppctl-sp7021.h b/include/dt-bindings/pinctrl/sppctl-sp7021.h
new file mode 100644
index 0000000..c9e6a07
--- /dev/null
+++ b/include/dt-bindings/pinctrl/sppctl-sp7021.h
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Sunplus SP7021 dt-bindings Pinctrl header file
+ * Copyright (C) Sunplus Tech/Tibbo Tech. 2020
+ * Author: Dvorkin Dmitry <dvorkin@tibbo.com>
+ */
+
+#ifndef	__DT_BINDINGS_PINCTRL_SPPCTL_SP7021_H__
+#define	__DT_BINDINGS_PINCTRL_SPPCTL_SP7021_H__
+
+#include <dt-bindings/pinctrl/sppctl.h>
+
+/* Please don't change the order of the
+ * following defines. They are based on
+ * order of control register define of
+ * MOON2 and MOON4 registers.
+ */
+#define MUXF_GPIO			0
+#define MUXF_IOP			1
+#define MUXF_L2SW_CLK_OUT		2
+#define MUXF_L2SW_MAC_SMI_MDC		3
+#define MUXF_L2SW_LED_FLASH0		4
+#define MUXF_L2SW_LED_FLASH1		5
+#define MUXF_L2SW_LED_ON0		6
+#define MUXF_L2SW_LED_ON1		7
+#define MUXF_L2SW_MAC_SMI_MDIO		8
+#define MUXF_L2SW_P0_MAC_RMII_TXEN	9
+#define MUXF_L2SW_P0_MAC_RMII_TXD0	10
+#define MUXF_L2SW_P0_MAC_RMII_TXD1	11
+#define MUXF_L2SW_P0_MAC_RMII_CRSDV	12
+#define MUXF_L2SW_P0_MAC_RMII_RXD0	13
+#define MUXF_L2SW_P0_MAC_RMII_RXD1	14
+#define MUXF_L2SW_P0_MAC_RMII_RXER	15
+#define MUXF_L2SW_P1_MAC_RMII_TXEN	16
+#define MUXF_L2SW_P1_MAC_RMII_TXD0	17
+#define MUXF_L2SW_P1_MAC_RMII_TXD1	18
+#define MUXF_L2SW_P1_MAC_RMII_CRSDV	19
+#define MUXF_L2SW_P1_MAC_RMII_RXD0	20
+#define MUXF_L2SW_P1_MAC_RMII_RXD1	21
+#define MUXF_L2SW_P1_MAC_RMII_RXER	22
+#define MUXF_DAISY_MODE			23
+#define MUXF_SDIO_CLK			24
+#define MUXF_SDIO_CMD			25
+#define MUXF_SDIO_D0			26
+#define MUXF_SDIO_D1			27
+#define MUXF_SDIO_D2			28
+#define MUXF_SDIO_D3			29
+#define MUXF_PWM0			30
+#define MUXF_PWM1			31
+#define MUXF_PWM2			32
+#define MUXF_PWM3			33
+#define MUXF_PWM4			34
+#define MUXF_PWM5			35
+#define MUXF_PWM6			36
+#define MUXF_PWM7			37
+#define MUXF_ICM0_D			38
+#define MUXF_ICM1_D			39
+#define MUXF_ICM2_D			40
+#define MUXF_ICM3_D			41
+#define MUXF_ICM0_CLK			42
+#define MUXF_ICM1_CLK			43
+#define MUXF_ICM2_CLK			44
+#define MUXF_ICM3_CLK			45
+#define MUXF_SPIM0_INT			46
+#define MUXF_SPIM0_CLK			47
+#define MUXF_SPIM0_EN			48
+#define MUXF_SPIM0_DO			49
+#define MUXF_SPIM0_DI			50
+#define MUXF_SPIM1_INT			51
+#define MUXF_SPIM1_CLK			52
+#define MUXF_SPIM1_EN			53
+#define MUXF_SPIM1_DO			54
+#define MUXF_SPIM1_DI			55
+#define MUXF_SPIM2_INT			56
+#define MUXF_SPIM2_CLK			57
+#define MUXF_SPIM2_EN			58
+#define MUXF_SPIM2_DO			59
+#define MUXF_SPIM2_DI			60
+#define MUXF_SPIM3_INT			61
+#define MUXF_SPIM3_CLK			62
+#define MUXF_SPIM3_EN			63
+#define MUXF_SPIM3_DO			64
+#define MUXF_SPIM3_DI			65
+#define MUXF_SPI0S_INT			66
+#define MUXF_SPI0S_CLK			67
+#define MUXF_SPI0S_EN			68
+#define MUXF_SPI0S_DO			69
+#define MUXF_SPI0S_DI			70
+#define MUXF_SPI1S_INT			71
+#define MUXF_SPI1S_CLK			72
+#define MUXF_SPI1S_EN			73
+#define MUXF_SPI1S_DO			74
+#define MUXF_SPI1S_DI			75
+#define MUXF_SPI2S_INT			76
+#define MUXF_SPI2S_CLK			77
+#define MUXF_SPI2S_EN			78
+#define MUXF_SPI2S_DO			79
+#define MUXF_SPI2S_DI			80
+#define MUXF_SPI3S_INT			81
+#define MUXF_SPI3S_CLK			82
+#define MUXF_SPI3S_EN			83
+#define MUXF_SPI3S_DO			84
+#define MUXF_SPI3S_DI			85
+#define MUXF_I2CM0_CLK			86
+#define MUXF_I2CM0_DAT			87
+#define MUXF_I2CM1_CLK			88
+#define MUXF_I2CM1_DAT			89
+#define MUXF_I2CM2_CLK			90
+#define MUXF_I2CM2_DAT			91
+#define MUXF_I2CM3_CLK			92
+#define MUXF_I2CM3_DAT			93
+#define MUXF_UA1_TX			94
+#define MUXF_UA1_RX			95
+#define MUXF_UA1_CTS			96
+#define MUXF_UA1_RTS			97
+#define MUXF_UA2_TX			98
+#define MUXF_UA2_RX			99
+#define MUXF_UA2_CTS			100
+#define MUXF_UA2_RTS			101
+#define MUXF_UA3_TX			102
+#define MUXF_UA3_RX			103
+#define MUXF_UA3_CTS			104
+#define MUXF_UA3_RTS			105
+#define MUXF_UA4_TX			106
+#define MUXF_UA4_RX			107
+#define MUXF_UA4_CTS			108
+#define MUXF_UA4_RTS			109
+#define MUXF_TIMER0_INT			110
+#define MUXF_TIMER1_INT			111
+#define MUXF_TIMER2_INT			112
+#define MUXF_TIMER3_INT			113
+#define MUXF_GPIO_INT0			114
+#define MUXF_GPIO_INT1			115
+#define MUXF_GPIO_INT2			116
+#define MUXF_GPIO_INT3			117
+#define MUXF_GPIO_INT4			118
+#define MUXF_GPIO_INT5			119
+#define MUXF_GPIO_INT6			120
+#define MUXF_GPIO_INT7			121
+
+#define GROP_SPI_FLASH			122
+#define GROP_SPI_FLASH_4BIT		123
+#define GROP_SPI_NAND			124
+#define GROP_CARD0_EMMC			125
+#define GROP_SD_CARD			126
+#define GROP_UA0			127
+#define GROP_ACHIP_DEBUG		128
+#define GROP_ACHIP_UA2AXI		129
+#define GROP_FPGA_IFX			130
+#define GROP_HDMI_TX			131
+#define GROP_AUD_EXT_ADC_IFX0		132
+#define GROP_AUD_EXT_DAC_IFX0		133
+#define GROP_SPDIF_RX			134
+#define GROP_SPDIF_TX			135
+#define GROP_TDMTX_IFX0			136
+#define GROP_TDMRX_IFX0			137
+#define GROP_PDMRX_IFX0			138
+#define GROP_PCM_IEC_TX			139
+#define GROP_LCDIF			140
+#define GROP_DVD_DSP_DEBUG		141
+#define GROP_I2C_DEBUG			142
+#define GROP_I2C_SLAVE			143
+#define GROP_WAKEUP			144
+#define GROP_UART2AXI			145
+#define GROP_USB0_I2C			146
+#define GROP_USB1_I2C			147
+#define GROP_USB0_OTG			148
+#define GROP_USB1_OTG			149
+#define GROP_UPHY0_DEBUG		150
+#define GROP_UPHY1_DEBUG		151
+#define GROP_UPHY0_EXT			152
+#define GROP_PROBE_PORT			153
+
+#endif
diff --git a/include/dt-bindings/pinctrl/sppctl.h b/include/dt-bindings/pinctrl/sppctl.h
new file mode 100644
index 0000000..7e5c7a6
--- /dev/null
+++ b/include/dt-bindings/pinctrl/sppctl.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Sunplus dt-bindings Pinctrl header file
+ * Copyright (C) Sunplus Tech/Tibbo Tech. 2020
+ * Author: Dvorkin Dmitry <dvorkin@tibbo.com>
+ */
+
+#ifndef __DT_BINDINGS_PINCTRL_SPPCTL_H__
+#define __DT_BINDINGS_PINCTRL_SPPCTL_H__
+
+#define IOP_G_MASTE		(0x01 << 0)
+#define IOP_G_FIRST		(0x01 << 1)
+
+#define SPPCTL_PCTL_G_PMUX	(0x00        | IOP_G_MASTE)
+#define SPPCTL_PCTL_G_GPIO	(IOP_G_FIRST | IOP_G_MASTE)
+#define SPPCTL_PCTL_G_IOPP	(IOP_G_FIRST | 0x00)
+
+#define SPPCTL_PCTL_L_OUT	(0x01 << 0)	/* Output LOW        */
+#define SPPCTL_PCTL_L_OU1	(0x01 << 1)	/* Output HIGH       */
+#define SPPCTL_PCTL_L_INV	(0x01 << 2)	/* Input Invert      */
+#define SPPCTL_PCTL_L_ONV	(0x01 << 3)	/* Output Invert     */
+#define SPPCTL_PCTL_L_ODR	(0x01 << 4)	/* Output Open Drain */
+
+#define SPPCTL_PCTLE_P(v)	((v) << 24)
+#define SPPCTL_PCTLE_G(v)	((v) << 16)
+#define SPPCTL_PCTLE_F(v)	((v) << 8)
+#define SPPCTL_PCTLE_L(v)	((v) << 0)
+
+#define SPPCTL_PCTLD_P(v)	(((v) >> 24) & 0xff)
+#define SPPCTL_PCTLD_G(v)	(((v) >> 16) & 0xff)
+#define SPPCTL_PCTLD_F(v)	(((v) >>  8) & 0xff)
+#define SPPCTL_PCTLD_L(v)	(((v) >>  0) & 0xff)
+
+/*
+ * pack into 32-bit value:
+ * pin#(8bit), typ(8bit), function(8bit), flag(8bit)
+ */
+#define SPPCTL_IOPAD(pin, typ, fun, flg)	(((pin) << 24) | ((typ) << 16) | \
+						((fun) << 8) | (flg))
+
+#endif
-- 
2.7.4

