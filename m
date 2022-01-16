Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5953F48FD87
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 15:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiAPOwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 09:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiAPOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 09:52:12 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2099C061574;
        Sun, 16 Jan 2022 06:52:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m21so7437665pfd.3;
        Sun, 16 Jan 2022 06:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZYv2bzjfzlBd8PkvGF6igRcUgVyHYtpbPlZ/gL3EpWE=;
        b=VUMcAKRwqP/LlEgAOF03beKu+HlCzyJ/ZRs+U6sAjMXg8zMPGukpmK/Mutw6zQZxaB
         AeIO5giQ9HnDdPShC9JT0ZpPiS4zeJfwvPhLlwta9bNzoi/eV+2SBYiA8YDZ7jJGPr64
         VZWoq+yl2YLq5kzKSCT/WtjrjvT9Sv/AhwrnbqVB/TtKL8ZzyHLT+/ngKklvEwr2pIiW
         44APyFxGqLUlvbHazlMqbEZ3hhrMDuyJAuaTvWtWIbGzArfBifRUZGxNvosju8kB04hy
         FQvwA4IKwfEPBBfAt/ra+3sKo/K2sKC2cwGyL+g2wekeN8hGULE6rGjYtP5SW/Qt4f8b
         ucUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZYv2bzjfzlBd8PkvGF6igRcUgVyHYtpbPlZ/gL3EpWE=;
        b=IrOr7gTcmvenMrqiVc1svM/geSFPdwVuuT7KNu7VZroTSHyp1XxpMVrV324qj0Zcuv
         GarvP6bXdGf1wWn0z4TlFjxIs6m/W8Th6wIea7+ttkgEIFW9W6Vbke0pWEtdGUB7ynj8
         qsFvxmXx8NiY0SM2qV3hj98oQO5V542y9/2gJTHEhEQU4mkwe3NfETycFbRnReWmWVGZ
         LQyUoflN6dDAg6X0u+r+lKCFfmeDlCTD7X3Wpj08o8YI3Xg9Ses5CTn1Imj5iPywkC8X
         CR36YtZQjLDR/ZlnxUTK1DK2WA9GgkwMAFeMbwHtyIlH31H5u/jooOhpllwH+Hkxp9vg
         9CLg==
X-Gm-Message-State: AOAM531RrkQlFm+LgwQ6Su5mMRnNEGkf87L2bqGSugHVmCnp6G5pKtTh
        gwBcLgR0BijcRgaNBhk589Q=
X-Google-Smtp-Source: ABdhPJxMdl4NnA6Z7CkfCHaepMQlzSetYWyzONdSBwboVHqfnOK+aqgw86AFJuwE4y6RBYhNEPlyQw==
X-Received: by 2002:a63:81c1:: with SMTP id t184mr8253262pgd.251.1642344731127;
        Sun, 16 Jan 2022 06:52:11 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id j22sm11349891pfj.102.2022.01.16.06.52.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jan 2022 06:52:10 -0800 (PST)
From:   Wells Lu <wellslutw@gmail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     wells.lu@sunplus.com, dvorkin@tibbo.com,
        Wells Lu <wellslutw@gmail.com>
Subject: [PATCH v6 1/2] dt-bindings: pinctrl: Add dt-bindings for Sunplus SP7021
Date:   Sun, 16 Jan 2022 22:52:13 +0800
Message-Id: <1642344734-27229-2-git-send-email-wellslutw@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642344734-27229-1-git-send-email-wellslutw@gmail.com>
References: <1642344734-27229-1-git-send-email-wellslutw@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings header files and documentation for Sunplus SP7021 SoC.

Signed-off-by: Wells Lu <wellslutw@gmail.com>
---
Changes in V6
  - Addressed comments of Mr. Rob Herring.
    - Added $ref: "pinmux-node.yaml#" for patternProperties '-pins$'.
    - Changed name of vendor property: sunplus,zero_func --> sunplus,zerofunc
  - Fixed wrong comment style of multi-line in dt-binding header files.

 .../bindings/pinctrl/sunplus,sp7021-pinctrl.yaml   | 374 +++++++++++++++++++++
 MAINTAINERS                                        |   9 +
 include/dt-bindings/pinctrl/sppctl-sp7021.h        | 179 ++++++++++
 include/dt-bindings/pinctrl/sppctl.h               |  31 ++
 4 files changed, 593 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
 create mode 100644 include/dt-bindings/pinctrl/sppctl-sp7021.h
 create mode 100644 include/dt-bindings/pinctrl/sppctl.h

diff --git a/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
new file mode 100644
index 0000000..d8e75b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
@@ -0,0 +1,374 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd.
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
+  SP7021 has 99 digital GPIO pins which are numbered from GPIO 0 to 98. All
+  are multiplexed with some special function pins. SP7021 has 3 types of
+  special function pins:
+
+  (1) function-group pins:
+      Ex 1 (SPI-NOR flash):
+        If control-field SPI_FLASH_SEL is set to 1, GPIO 83, 84, 86 and 87
+        will be pins of SPI-NOR flash. If it is set to 2, GPIO 76, 78, 79
+        and 81 will be pins of SPI-NOR flash.
+
+      Ex 2 (UART_0):
+        If control-bit UA0_SEL is set to 1, GPIO 88 and 89 will be TX and
+        RX pins of UART_0 (UART channel 0).
+
+      Ex 3 (eMMC):
+        If control-bit EMMC_SEL is set to 1, GPIO 72, 73, 74, 75, 76, 77,
+        78, 79, 80, 81 will be pins of an eMMC device.
+
+      Properties "function" and "groups" are used to select function-group
+      pins.
+
+  (2) fully pin-mux (like phone exchange mux) pins:
+      GPIO 8 to 71 are 'fully pin-mux' pins. Any pins of peripherals of
+      SP7021 (ex: UART_1, UART_2, UART_3, UART_4, I2C_0, I2C_1, and etc.)
+      can be routed to any pins of fully pin-mux pins.
+
+      Ex 1 (UART channel 1):
+        If control-field UA1_TX_SEL is set to 3, TX pin of UART_1 will be
+        routed to GPIO 10 (3 - 1 + 8 = 10).
+        If control-field UA1_RX_SEL is set to 4, RX pin of UART_1 will be
+        routed to GPIO 11 (4 - 1 + 8 = 11).
+        If control-field UA1_RTS_SEL is set to 5, RTS pin of UART_1 will
+        be routed to GPIO 12 (5 - 1 + 8 = 12).
+        If control-field UA1_CTS_SEL is set to 6, CTS pin of UART_1 will
+        be routed to GPIO 13 (6 - 1 + 8 = 13).
+
+      Ex 2 (I2C channel 0):
+        If control-field I2C0_CLK_SEL is set to 20, CLK pin of I2C_0 will
+        be routed to GPIO 27 (20 - 1 + 8 = 27).
+        If control-field I2C0_DATA_SEL is set to 21, DATA pin of I2C_0
+        will be routed to GPIO 28 (21 - 1 + 9 = 28).
+
+      Totally, SP7021 has 120 peripheral pins. The peripheral pins can be
+      routed to any of 64 'fully pin-mux' pins.
+
+  (3) I/O processor pins
+      SP7021 has a built-in I/O processor.
+      Any GPIO pins (GPIO 0 to 98) can be set to pins of I/O processor.
+
+  Vendor property "sunplus,pins" is used to select "fully pin-mux" pins,
+  "I/O processor pins" and "digital GPIO" pins.
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
+      - description: the FIRST registers
+      - description: the MOON1 registers
+
+  reg-names:
+    items:
+      - const: moon2
+      - const: gpioxt
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
+    type: object
+    description: |
+      A pinctrl node should contain at least one subnodes representing the
+      pins or function-pins group available on the machine. Each subnode
+      will list the pins it needs, and how they should be configured.
+
+      Pinctrl node's client devices use subnodes for desired pin
+      configuration. Client device subnodes use below standard properties.
+    $ref: pinmux-node.yaml#
+
+    properties:
+      sunplus,pins:
+        description: |
+          Define 'sunplus,pins' which are used by pinctrl node's client
+          device.
+
+          It consists of one or more integers which represents the config
+          setting for corresponding pin. Each integer defines a individual
+          pin in which:
+
+          Bit 32~24: defines GPIO number. Its range is 0 ~ 98.
+          Bit 23~16: defines types: (1) fully pin-mux pins
+                                    (2) IO processor pins
+                                    (3) digital GPIO pins
+          Bit 15~8:  defines pins of peripherals (which are defined in
+                     'include/dt-binging/pinctrl/sppctl.h').
+          Bit 7~0:   defines types or initial-state of digital GPIO pins.
+
+          Please use macro SPPCTL_IOPAD to define the integers for pins.
+
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      function:
+        description: |
+          Define pin-function which is used by pinctrl node's client device.
+          The name should be one of string in the following enumeration.
+        $ref: "/schemas/types.yaml#/definitions/string"
+        enum: [ SPI_FLASH, SPI_FLASH_4BIT, SPI_NAND, CARD0_EMMC, SD_CARD,
+                UA0, FPGA_IFX, HDMI_TX, LCDIF, USB0_OTG, USB1_OTG ]
+
+      groups:
+        description: |
+          Define pin-group in a specified pin-function.
+          The name should be one of string in the following enumeration.
+        $ref: "/schemas/types.yaml#/definitions/string"
+        enum: [ SPI_FLASH1, SPI_FLASH2, SPI_FLASH_4BIT1, SPI_FLASH_4BIT2,
+                SPI_NAND, CARD0_EMMC, SD_CARD, UA0, FPGA_IFX, HDMI_TX1,
+                HDMI_TX2, HDMI_TX3, LCDIF, USB0_OTG, USB1_OTG ]
+
+      sunplus,zerofunc:
+        description: |
+          This is a vendor specific property. It is used to disable pins
+          which are not used by pinctrl node's client device.
+          Some pins may be enabled by boot-loader. We can use this
+          property to disable them.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+    additionalProperties: false
+
+    allOf:
+      - if:
+          properties:
+            function:
+              enum:
+                - SPI_FLASH
+        then:
+          properties:
+            groups:
+              enum:
+                - SPI_FLASH1
+                - SPI_FLASH2
+      - if:
+          properties:
+            function:
+              enum:
+                - SPI_FLASH_4BIT
+        then:
+          properties:
+            groups:
+              enum:
+                - SPI_FLASH_4BIT1
+                - SPI_FLASH_4BIT2
+      - if:
+          properties:
+            function:
+              enum:
+                - SPI_NAND
+        then:
+          properties:
+            groups:
+              enum:
+                - SPI_NAND
+      - if:
+          properties:
+            function:
+              enum:
+                - CARD0_EMMC
+        then:
+          properties:
+            groups:
+              enum:
+                - CARD0_EMMC
+      - if:
+          properties:
+            function:
+              enum:
+                - SD_CARD
+        then:
+          properties:
+            groups:
+              enum:
+                - SD_CARD
+      - if:
+          properties:
+            function:
+              enum:
+                - UA0
+        then:
+          properties:
+            groups:
+              enum:
+                - UA0
+      - if:
+          properties:
+            function:
+              enum:
+                - FPGA_IFX
+        then:
+          properties:
+            groups:
+              enum:
+                - FPGA_IFX
+      - if:
+          properties:
+            function:
+              enum:
+                - HDMI_TX
+        then:
+          properties:
+            groups:
+              enum:
+                - HDMI_TX1
+                - HDMI_TX2
+                - HDMI_TX3
+      - if:
+          properties:
+            function:
+              enum:
+                - LCDIF
+        then:
+          properties:
+            groups:
+              enum:
+                - LCDIF
+      - if:
+          properties:
+            function:
+              enum:
+                - USB0_OTG
+        then:
+          properties:
+            groups:
+              enum:
+                - USB0_OTG
+      - if:
+          properties:
+            function:
+              enum:
+                - USB1_OTG
+        then:
+          properties:
+            groups:
+              enum:
+                - USB1_OTG
+
+required:
+  - compatible
+  - reg
+  - reg-names
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
+        reg = <0x9c000100 0x100>, <0x9c000300 0x100>,
+              <0x9c0032e4 0x1c>, <0x9c000080 0x20>;
+        reg-names = "moon2", "gpioxt", "first", "moon1";
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
+            sunplus,pins = <
+                SPPCTL_IOPAD(11, SPPCTL_PCTL_G_PMUX, MUXF_UA1_TX, 0)
+                SPPCTL_IOPAD(10, SPPCTL_PCTL_G_PMUX, MUXF_UA1_RX, 0)
+            >;
+        };
+
+        uart2-pins {
+            sunplus,pins = <
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
+            sunplus,pins = < SPPCTL_IOPAD(91, SPPCTL_PCTL_G_GPIO, 0, 0) >;
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
+
+        ethernet-pins {
+            sunplus,pins = <
+                SPPCTL_IOPAD(49,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_CLK_OUT,0)
+                SPPCTL_IOPAD(44,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_MAC_SMI_MDC,0)
+                SPPCTL_IOPAD(43,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_MAC_SMI_MDIO,0)
+                SPPCTL_IOPAD(52,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_TXEN,0)
+                SPPCTL_IOPAD(50,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_TXD0,0)
+                SPPCTL_IOPAD(51,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_TXD1,0)
+                SPPCTL_IOPAD(46,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_CRSDV,0)
+                SPPCTL_IOPAD(47,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_RXD0,0)
+                SPPCTL_IOPAD(48,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_RXD1,0)
+            >;
+            sunplus,zerofunc = <
+                MUXF_L2SW_LED_FLASH0
+                MUXF_L2SW_LED_ON0
+                MUXF_L2SW_P0_MAC_RMII_RXER
+            >;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fbc29cd..3aef4ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15308,6 +15308,15 @@ M:	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
 S:	Supported
 F:	drivers/pinctrl/pinctrl-thunderbay.c
 
+PIN CONTROLLER - SUNPLUS / TIBBO
+M:	Dvorkin Dmitry <dvorkin@tibbo.com>
+M:	Wells Lu <wellslutw@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+W:	https://sunplus.atlassian.net/wiki/spaces/doc/overview
+F:	Documentation/devicetree/bindings/pinctrl/sunplus,*
+F:	include/dt-bindings/pinctrl/sppctl*.h
+
 PKTCDVD DRIVER
 M:	linux-block@vger.kernel.org
 S:	Orphan
diff --git a/include/dt-bindings/pinctrl/sppctl-sp7021.h b/include/dt-bindings/pinctrl/sppctl-sp7021.h
new file mode 100644
index 0000000..629aa9b
--- /dev/null
+++ b/include/dt-bindings/pinctrl/sppctl-sp7021.h
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Sunplus SP7021 dt-bindings Pinctrl header file
+ * Copyright (C) Sunplus Tech/Tibbo Tech.
+ * Author: Dvorkin Dmitry <dvorkin@tibbo.com>
+ */
+
+#ifndef	__DT_BINDINGS_PINCTRL_SPPCTL_SP7021_H__
+#define	__DT_BINDINGS_PINCTRL_SPPCTL_SP7021_H__
+
+#include <dt-bindings/pinctrl/sppctl.h>
+
+/*
+ * Please don't change the order of the following defines.
+ * They are based on order of 'hardware' control register
+ * defined in MOON2 ~ MOON3 registers.
+ */
+#define MUXF_GPIO                       0
+#define MUXF_IOP                        1
+#define MUXF_L2SW_CLK_OUT               2
+#define MUXF_L2SW_MAC_SMI_MDC           3
+#define MUXF_L2SW_LED_FLASH0            4
+#define MUXF_L2SW_LED_FLASH1            5
+#define MUXF_L2SW_LED_ON0               6
+#define MUXF_L2SW_LED_ON1               7
+#define MUXF_L2SW_MAC_SMI_MDIO          8
+#define MUXF_L2SW_P0_MAC_RMII_TXEN      9
+#define MUXF_L2SW_P0_MAC_RMII_TXD0      10
+#define MUXF_L2SW_P0_MAC_RMII_TXD1      11
+#define MUXF_L2SW_P0_MAC_RMII_CRSDV     12
+#define MUXF_L2SW_P0_MAC_RMII_RXD0      13
+#define MUXF_L2SW_P0_MAC_RMII_RXD1      14
+#define MUXF_L2SW_P0_MAC_RMII_RXER      15
+#define MUXF_L2SW_P1_MAC_RMII_TXEN      16
+#define MUXF_L2SW_P1_MAC_RMII_TXD0      17
+#define MUXF_L2SW_P1_MAC_RMII_TXD1      18
+#define MUXF_L2SW_P1_MAC_RMII_CRSDV     19
+#define MUXF_L2SW_P1_MAC_RMII_RXD0      20
+#define MUXF_L2SW_P1_MAC_RMII_RXD1      21
+#define MUXF_L2SW_P1_MAC_RMII_RXER      22
+#define MUXF_DAISY_MODE                 23
+#define MUXF_SDIO_CLK                   24
+#define MUXF_SDIO_CMD                   25
+#define MUXF_SDIO_D0                    26
+#define MUXF_SDIO_D1                    27
+#define MUXF_SDIO_D2                    28
+#define MUXF_SDIO_D3                    29
+#define MUXF_PWM0                       30
+#define MUXF_PWM1                       31
+#define MUXF_PWM2                       32
+#define MUXF_PWM3                       33
+#define MUXF_PWM4                       34
+#define MUXF_PWM5                       35
+#define MUXF_PWM6                       36
+#define MUXF_PWM7                       37
+#define MUXF_ICM0_D                     38
+#define MUXF_ICM1_D                     39
+#define MUXF_ICM2_D                     40
+#define MUXF_ICM3_D                     41
+#define MUXF_ICM0_CLK                   42
+#define MUXF_ICM1_CLK                   43
+#define MUXF_ICM2_CLK                   44
+#define MUXF_ICM3_CLK                   45
+#define MUXF_SPIM0_INT                  46
+#define MUXF_SPIM0_CLK                  47
+#define MUXF_SPIM0_EN                   48
+#define MUXF_SPIM0_DO                   49
+#define MUXF_SPIM0_DI                   50
+#define MUXF_SPIM1_INT                  51
+#define MUXF_SPIM1_CLK                  52
+#define MUXF_SPIM1_EN                   53
+#define MUXF_SPIM1_DO                   54
+#define MUXF_SPIM1_DI                   55
+#define MUXF_SPIM2_INT                  56
+#define MUXF_SPIM2_CLK                  57
+#define MUXF_SPIM2_EN                   58
+#define MUXF_SPIM2_DO                   59
+#define MUXF_SPIM2_DI                   60
+#define MUXF_SPIM3_INT                  61
+#define MUXF_SPIM3_CLK                  62
+#define MUXF_SPIM3_EN                   63
+#define MUXF_SPIM3_DO                   64
+#define MUXF_SPIM3_DI                   65
+#define MUXF_SPI0S_INT                  66
+#define MUXF_SPI0S_CLK                  67
+#define MUXF_SPI0S_EN                   68
+#define MUXF_SPI0S_DO                   69
+#define MUXF_SPI0S_DI                   70
+#define MUXF_SPI1S_INT                  71
+#define MUXF_SPI1S_CLK                  72
+#define MUXF_SPI1S_EN                   73
+#define MUXF_SPI1S_DO                   74
+#define MUXF_SPI1S_DI                   75
+#define MUXF_SPI2S_INT                  76
+#define MUXF_SPI2S_CLK                  77
+#define MUXF_SPI2S_EN                   78
+#define MUXF_SPI2S_DO                   79
+#define MUXF_SPI2S_DI                   80
+#define MUXF_SPI3S_INT                  81
+#define MUXF_SPI3S_CLK                  82
+#define MUXF_SPI3S_EN                   83
+#define MUXF_SPI3S_DO                   84
+#define MUXF_SPI3S_DI                   85
+#define MUXF_I2CM0_CLK                  86
+#define MUXF_I2CM0_DAT                  87
+#define MUXF_I2CM1_CLK                  88
+#define MUXF_I2CM1_DAT                  89
+#define MUXF_I2CM2_CLK                  90
+#define MUXF_I2CM2_DAT                  91
+#define MUXF_I2CM3_CLK                  92
+#define MUXF_I2CM3_DAT                  93
+#define MUXF_UA1_TX                     94
+#define MUXF_UA1_RX                     95
+#define MUXF_UA1_CTS                    96
+#define MUXF_UA1_RTS                    97
+#define MUXF_UA2_TX                     98
+#define MUXF_UA2_RX                     99
+#define MUXF_UA2_CTS                    100
+#define MUXF_UA2_RTS                    101
+#define MUXF_UA3_TX                     102
+#define MUXF_UA3_RX                     103
+#define MUXF_UA3_CTS                    104
+#define MUXF_UA3_RTS                    105
+#define MUXF_UA4_TX                     106
+#define MUXF_UA4_RX                     107
+#define MUXF_UA4_CTS                    108
+#define MUXF_UA4_RTS                    109
+#define MUXF_TIMER0_INT                 110
+#define MUXF_TIMER1_INT                 111
+#define MUXF_TIMER2_INT                 112
+#define MUXF_TIMER3_INT                 113
+#define MUXF_GPIO_INT0                  114
+#define MUXF_GPIO_INT1                  115
+#define MUXF_GPIO_INT2                  116
+#define MUXF_GPIO_INT3                  117
+#define MUXF_GPIO_INT4                  118
+#define MUXF_GPIO_INT5                  119
+#define MUXF_GPIO_INT6                  120
+#define MUXF_GPIO_INT7                  121
+
+/*
+ * Please don't change the order of the following defines.
+ * They are based on order of items in array 'sppctl_list_funcs'
+ * in Sunplus pinctrl driver.
+ */
+#define GROP_SPI_FLASH                  122
+#define GROP_SPI_FLASH_4BIT             123
+#define GROP_SPI_NAND                   124
+#define GROP_CARD0_EMMC                 125
+#define GROP_SD_CARD                    126
+#define GROP_UA0                        127
+#define GROP_ACHIP_DEBUG                128
+#define GROP_ACHIP_UA2AXI               129
+#define GROP_FPGA_IFX                   130
+#define GROP_HDMI_TX                    131
+#define GROP_AUD_EXT_ADC_IFX0           132
+#define GROP_AUD_EXT_DAC_IFX0           133
+#define GROP_SPDIF_RX                   134
+#define GROP_SPDIF_TX                   135
+#define GROP_TDMTX_IFX0                 136
+#define GROP_TDMRX_IFX0                 137
+#define GROP_PDMRX_IFX0                 138
+#define GROP_PCM_IEC_TX                 139
+#define GROP_LCDIF                      140
+#define GROP_DVD_DSP_DEBUG              141
+#define GROP_I2C_DEBUG                  142
+#define GROP_I2C_SLAVE                  143
+#define GROP_WAKEUP                     144
+#define GROP_UART2AXI                   145
+#define GROP_USB0_I2C                   146
+#define GROP_USB1_I2C                   147
+#define GROP_USB0_OTG                   148
+#define GROP_USB1_OTG                   149
+#define GROP_UPHY0_DEBUG                150
+#define GROP_UPHY1_DEBUG                151
+#define GROP_UPHY0_EXT                  152
+#define GROP_PROBE_PORT                 153
+
+#endif
diff --git a/include/dt-bindings/pinctrl/sppctl.h b/include/dt-bindings/pinctrl/sppctl.h
new file mode 100644
index 0000000..5055726
--- /dev/null
+++ b/include/dt-bindings/pinctrl/sppctl.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Sunplus dt-bindings Pinctrl header file
+ * Copyright (C) Sunplus Tech / Tibbo Tech.
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
+/*
+ * pack into 32-bit value:
+ * pin# (8bit), typ (8bit), function (8bit), flag (8bit)
+ */
+#define SPPCTL_IOPAD(pin, typ, fun, flg)	(((pin) << 24) | ((typ) << 16) | \
+						((fun) << 8) | (flg))
+
+#endif
-- 
2.7.4

