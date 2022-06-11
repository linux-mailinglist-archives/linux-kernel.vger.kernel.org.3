Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2453F547708
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 20:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiFKSHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 14:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiFKSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 14:07:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808056C55C;
        Sat, 11 Jun 2022 11:07:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 25so2533733edw.8;
        Sat, 11 Jun 2022 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TUqRlKRoE9aIbbU4h+MYAoDxFTivbQhtgPpMRCTQ/50=;
        b=Sv4NMZPVTsRK4kn4MOK4Odc/SDaRiJcfpZPetRiKBHM9aTlUzS37ZBW7z4/jAYXH3d
         ca3ISCGO+ipIbvfoNFiT3vZWE0tF8W7+cc/hS7JldJ1t8TIOzHVgxih+sOs7fKbfeL2r
         9KPYtHcZ29eHbqi2qj6XlP7NiA1V0JSPsDiCX5bNBr+loG3fW0Jqtou0Kw/HUwV1qyri
         Xoo6AgJZNxJmHHJe13QHkNhayoMIrfmDbw928I0OUC19XEfok3djwsI1Qbx2jo/vIPLF
         VbPxrBURuoCTtTZCFD+NoBzovzXcEQ95gGfSDTJMSKxk7hRQf9ruRDY4qvpU7DQEzVVc
         omUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TUqRlKRoE9aIbbU4h+MYAoDxFTivbQhtgPpMRCTQ/50=;
        b=C4k0SnYFf+OZykZPkwr8qG30qAKzA5Klbmy7yogOPqeaCc1DNrKFpORBdy+qdcMexq
         QgCq1EUqhjEU6JV/BNFWDLwpz4fS4Nq3BOJjWIbHMhkmcdcl0FKAsoWqsjxh1qeCmCl3
         jHTOw3fdAwgV2Yg4gTwCHo+yiqcl+3ZUCslsCWPe62mxS8uJx2c6SmAeWYnB9+pXFsSe
         9l11STQXPUh7XeNBw5FGxXeR5MW0nNJBp3DV2wQnpFEgFkcKgbqR3lFnsuQZZ2LC/1QD
         MUFk9brNRcqAd5VaJV7uoGFG93Y/RmC/Nk3wF8EAc15cN2vOYCeQ8ntw7dduq/Rs07iR
         C6ug==
X-Gm-Message-State: AOAM533Iyxqsh6h/s4hcISl2/0wb4RR8JVwrd7bdV+uPFNPr8D1B6/rM
        D6KgUD82j1YJ9tqh/of9Hq73At6Ek6/WWw==
X-Google-Smtp-Source: ABdhPJwO73AXLA4uNmIh/O9IIqTIq37jMZLUGyJkTeTp7kruz9HoFN6jJPoCdEBgkThPEo6HAJkcKQ==
X-Received: by 2002:a05:6402:34cc:b0:431:67ed:96a0 with SMTP id w12-20020a05640234cc00b0043167ed96a0mr34329668edc.372.1654970825959;
        Sat, 11 Jun 2022 11:07:05 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906640d00b006fee28d459csm1308455ejm.224.2022.06.11.11.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 11:07:05 -0700 (PDT)
Date:   Sat, 11 Jun 2022 20:07:03 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: interrupt-controller: Convert
 rda,8810pl-intc to YAML
Message-ID: <20220611180703.GA24988@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert RDA Micro interrupt controller bindings to DT schema format.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---

Changes in v2:
  - drop the interrupt sources header file

 .../interrupt-controller/rda,8810pl-intc.txt  | 61 -------------------
 .../interrupt-controller/rda,8810pl-intc.yaml | 43 +++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 44 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
deleted file mode 100644
index e0062aebf025..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-RDA Micro RDA8810PL Interrupt Controller
-
-The interrupt controller in RDA8810PL SoC is a custom interrupt controller
-which supports up to 32 interrupts.
-
-Required properties:
-
-- compatible: Should be "rda,8810pl-intc".
-- reg: Specifies base physical address of the registers set.
-- interrupt-controller: Identifies the node as an interrupt controller.
-- #interrupt-cells: Specifies the number of cells needed to encode an
-  interrupt source. The value shall be 2.
-
-The interrupt sources are as follows:
-
-ID	Name
-------------
-0:	PULSE_DUMMY
-1:	I2C
-2:	NAND_NFSC
-3:	SDMMC1
-4:	SDMMC2
-5:	SDMMC3
-6:	SPI1
-7:	SPI2
-8:	SPI3
-9:	UART1
-10:	UART2
-11:	UART3
-12:	GPIO1
-13:	GPIO2
-14:	GPIO3
-15:	KEYPAD
-16:	TIMER
-17:	TIMEROS
-18:	COMREG0
-19:	COMREG1
-20:	USB
-21:	DMC
-22:	DMA
-23:	CAMERA
-24:	GOUDA
-25:	GPU
-26:	VPU_JPG
-27:	VPU_HOST
-28:	VOC
-29:	AUIFC0
-30:	AUIFC1
-31:	L2CC
-
-Example:
-		apb@20800000 {
-			compatible = "simple-bus";
-			...
-			intc: interrupt-controller@0 {
-				compatible = "rda,8810pl-intc";
-				reg = <0x0 0x1000>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-		};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
new file mode 100644
index 000000000000..96d6285d0087
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/rda,8810pl-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RDA Micro RDA8810PL interrupt controller
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    const: rda,8810pl-intc
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    intc: interrupt-controller@0 {
+      compatible = "rda,8810pl-intc";
+      reg = <0x0 0x1000>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f0a90b256b26..58a35519b7c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2590,7 +2590,7 @@ L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/rda.yaml
 F:	Documentation/devicetree/bindings/gpio/gpio-rda.yaml
-F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
 F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.yaml
 F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
 F:	arch/arm/boot/dts/rda8810pl-*
-- 
2.25.1

