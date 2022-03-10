Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B04D3F81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbiCJDBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbiCJDBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:01:48 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32EB124C25
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 19:00:46 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C26092C0112;
        Thu, 10 Mar 2022 03:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1646881243;
        bh=KittZrwp5Pw9RGRPnfHVntlvbv0RcmOSXisJH/PSv9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtONsUI1FF6uKTSYX6rOo8hqTVaGrPgGn+E3rxIF9WEdf9NfKxTpvtEStEApFUDIG
         ed8Ew4ZrjEW02rkt/SIO9eBJPotUeBQZ5jf8fCq2YVvtSJPDyTgTuGL9KPpEgW5v00
         Uek6HjKGhxF6vkxwjSnsEGomOlw+UXScmKMWRNFGWSw2SQVitbCwIlVNkWU68gDHUP
         WKXw/Br52LatDsOjTJhuG4tM5LacA11Nwhyd85VpxU1hoHMMYzgG7V0ua41qsbh6/h
         iiM5+vdJZ4Bm57w9TwWh/I2wdXZQ2CpaF/vU0VFTvHNHQwVvyKGmOnsOiPSZeojZLz
         Yc77pr0NwrFZQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B622969db0001>; Thu, 10 Mar 2022 16:00:43 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 946FB13EE63;
        Thu, 10 Mar 2022 16:00:43 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A319A2A000C; Thu, 10 Mar 2022 16:00:41 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v1 1/4] dt-bindings: pinctrl: mvebu: Document bindings for AC5
Date:   Thu, 10 Mar 2022 16:00:36 +1300
Message-Id: <20220310030039.2833808-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
References: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=gEfo2CItAAAA:8 a=GH5P82P4OHjy_c7sCygA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON schema for marvell,ac5-pinctrl present on the Marvell 98DX2530
SoC.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../bindings/pinctrl/marvell,ac5-pinctrl.yaml | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,ac5=
-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.ya=
ml
new file mode 100644
index 000000000000..c7ab3d0e8420
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
@@ -0,0 +1,73 @@
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
+      - const: syscon
+      - const: simple-mfd
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
+        enum: [ gpio, i2c0, i2c1, nand, sdio, spi0, spi1, uart0, uart1, =
uart2, uart3 ]
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
+      compatible =3D "marvell,ac5-pinctrl",
+      "syscon", "simple-mfd";
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

