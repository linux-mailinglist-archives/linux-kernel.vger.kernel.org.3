Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7091C501F13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347664AbiDNXd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347634AbiDNXdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:33:51 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1DAAC913
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:31:23 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 98DC42C02EB;
        Thu, 14 Apr 2022 23:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1649979081;
        bh=1qLjk3kReSbw4aBzz1BUVRlYi7TRhYdBmgvZrX1rXLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RfGjwHLz4z5Gs0uJluD7BPteDr4r4vlKWIm+RYuE3rHKSSPUuvj6jjQlYr19nhOfi
         8t6t57bgq6BeurCjDPBYj79tdBrjE8RXQRlm9hZWDu/tkKrBciq65WA7t+D9G/coqT
         UJ0I/HjzKrKrv2rWrdbQ5Co/4ENu+iq7eygcMnOE4XQaHFVVcq+2uOzvDfecbl3lBl
         M0j2bFao12hbErvl8Tin03ChVZJCsXYF8Os+/QwTAzd+Ac1VyQTidKI52Tb+vEi5jC
         ilJ8qjRSwZSmNRLNB3eOKSfR1uefmts4wvxjegX/o3ZnGoDap01bxDAbIBkWtyeBG+
         zg8zBI7UXD6iQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6258aec90002>; Fri, 15 Apr 2022 11:31:21 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 203A213EE3F;
        Fri, 15 Apr 2022 11:31:21 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 708BC2A003C; Fri, 15 Apr 2022 11:31:16 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 1/4] dt-bindings: pinctrl: mvebu: Document bindings for AC5
Date:   Fri, 15 Apr 2022 11:30:52 +1200
Message-Id: <20220414233055.586962-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414233055.586962-1-chris.packham@alliedtelesis.co.nz>
References: <20220414233055.586962-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=L59jvNb8 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=z0gMJWrwH1QA:10 a=VwQbUJbxAAAA:8 a=gEfo2CItAAAA:8 a=fnZDTHQ_2BAKIKJdyuEA:9 a=AjGcO6oz07-iQ99wixmX:22 a=sptkURWiP4Gy88Gu7hUp:22
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v4:
    - Correct v3 changelog
    - Add review from Andrew and Rob
    Changes in v3:
    - Add more pin functions
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

