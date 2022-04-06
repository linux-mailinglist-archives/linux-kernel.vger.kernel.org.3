Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035464F61C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiDFOhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiDFOg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:36:56 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A5EF65C8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:22:36 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9259C2C00BE;
        Wed,  6 Apr 2022 03:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1649215353;
        bh=Gcm4gfaIDoNoCvjIWTDW+fwjFBi+drpk9T10KIGpts0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXIFDcdNV33zcEm5iVUnMgPvS1x3a9wZNTFvZHEtUpjHSG/+W2O/Cuu6TAwlSlWGa
         +NimBPD6RFD/zn48MvUflgdKh9foirZ4wt4GHDIAFIvUltU7ARcag03tDdf/8N5q/Z
         2Fw3tcvFW6SnZdAVWyuS31geApZgggXFrqQH3oO21uioWn7CJ2I/STMnKd23TnllRP
         I41H6R/j5gVr9t09fuz/suvL8HrDVx3B6sU0XDYBdVEpq5W/Ikfx5Y1jgFW9R9aMEP
         T7uH3SlDcRy+7Ej4Pt7jKzdI89QKyzaJuGqeNP4pByOz5cfyA0cqbftW8Zw0GNRLgo
         OL7OQUC1I2pHg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B624d07790001>; Wed, 06 Apr 2022 15:22:33 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 3EEC213EE8E;
        Wed,  6 Apr 2022 15:22:33 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id AB5262A003C; Wed,  6 Apr 2022 15:22:28 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/4] dt-bindings: pinctrl: mvebu: Document bindings for AC5
Date:   Wed,  6 Apr 2022 15:21:55 +1200
Message-Id: <20220406032158.1449049-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406032158.1449049-1-chris.packham@alliedtelesis.co.nz>
References: <20220406032158.1449049-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=JcrCUnCV c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=z0gMJWrwH1QA:10 a=gEfo2CItAAAA:8 a=exeuR5bTIPqabhZkPHwA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON schema for marvell,ac5-pinctrl present on the Marvell 98DX2530
SoC.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - Restore syscon and simple-mfd compatibles. These are needed by the
      pinctrl driver.
    Changes in v2:
    - Remove syscon and simple-mfd compatibles

 .../bindings/pinctrl/marvell,ac5-pinctrl.yaml | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,ac5=
-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.ya=
ml
new file mode 100644
index 000000000000..a651b2744caf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/marvell,ac5-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell AC5 pin controller
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+description:
+  Bindings for Marvell's AC5 memory-mapped pin controller.
+
+properties:
+  compatible:
+    items:
+      - const: marvell,ac5-pinctrl
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  '-pins$':
+    type: object
+    $ref: pinmux-node.yaml#
+
+    properties:
+      marvell,function:
+        $ref: "/schemas/types.yaml#/definitions/string"
+        description:
+          Indicates the function to select.
+        enum: [ dev_init_done, ge, gpio, i2c0, i2c1, int_out, led, nand,=
 pcie, ptp, sdio,
+                spi0, spi1, synce, tsen_int, uart0, uart1, uart2, uart3,=
 uartsd, wd_int, xg ]
+
+      marvell,pins:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        description:
+          Array of MPP pins to be used for the given function.
+        minItems: 1
+        items:
+          enum: [ mpp0, mpp1, mpp2, mpp3, mpp4, mpp5, mpp6, mpp7, mpp8, =
mpp9,
+                  mpp10, mpp11, mpp12, mpp13, mpp14, mpp15, mpp16, mpp17=
, mpp18, mpp19,
+                  mpp20, mpp21, mpp22, mpp23, mpp24, mpp25, mpp26, mpp27=
, mpp28, mpp29,
+                  mpp30, mpp31, mpp32, mpp33, mpp34, mpp35, mpp36, mpp37=
, mpp38, mpp39,
+                  mpp40, mpp41, mpp42, mpp43, mpp44, mpp45 ]
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl@80020100 {
+      compatible =3D "marvell,ac5-pinctrl";
+      reg =3D <0x80020100 0x20>;
+
+      i2c0_pins: i2c0-pins {
+        marvell,pins =3D "mpp26", "mpp27";
+        marvell,function =3D "i2c0";
+      };
+
+      i2c0_gpio: i2c0-gpio-pins {
+        marvell,pins =3D "mpp26", "mpp27";
+        marvell,function =3D "gpio";
+      };
+    };
--=20
2.35.1

