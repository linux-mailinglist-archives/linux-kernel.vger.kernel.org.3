Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B61575204
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbiGNPi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbiGNPig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:38:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F8B63925;
        Thu, 14 Jul 2022 08:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657813095;
        bh=DtJnqs/sSTnIu3XjHE2BezrZQiBgwGyZEk5B116ynNQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MZt/PuS/hLfThaTSR2wanewjwHHkJDUdJaOShzdUR80706ftTx4Ea+/bAfV91L8ud
         FUNxDmDmQ9MTnBXaDCog8iMujDeQ7A1QPwVV1JZ3NoAU4MbB5NYTYZ+vaLjtp0gnsU
         8fPxkF5v6vV5yvX8jAA+PWmypDR2/sBB8/kM4ioU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from max-esprimop556.user.selfnet.de ([141.72.241.228]) by
 mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1My36N-1nL89Z48K7-00zYLE; Thu, 14 Jul 2022 17:38:15 +0200
From:   Max Buchholz <max.buchholz@gmx.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>
Cc:     Max Buchholz <Max.Buchholz@gmx.de>,
        David Heidelberg <david@ixit.cz>,
        Max Buchholz <max.buchholz@gmx.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: nvidia,tegra20-kbc: Convert to json-schema
Date:   Thu, 14 Jul 2022 17:37:31 +0200
Message-Id: <20220714153732.48698-1-max.buchholz@gmx.de>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fIrSM4Gy1y4DV0VVUdtk9JrFSlEEZSzVRogeJi377bW5WwSVUcW
 A0GI622mXXcKHn8TFGwvftFPvCUNqx013rwmIYQPsYGae1FXE2R67znqsIIEEQ64jAcewnv
 KKD6qV1YP1O6FH3xIPwNQf6/1Q+pcvMUAy8kF4NX53RIeo8qr7n+wLLVFsXYp3ZcEqHPL+v
 pYuypIR2TT3/UT0tiWe3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JcalHAO1k7A=:8RBClnJt1vAxUzvv8Mzo6+
 UuvhGP3LrQl134WotTYrrUyTR6IGEbmNdrApGKq+ohmvLbYG3mNgHsrXiZQnr1o+a7odlglKj
 /KGtK9mQPu6ECxKhU/6h0+5XJwrnYbPolPbVNd7SiwfkbHgKV+UYb2WobOVT13W/7dC+/0+Wh
 aq4fwZC5UUtg6kdBW2VBCmCvADzd2mxcFBvDXXf0g30EnbRfoKYpWV6omT7E0CsStPyif4cMJ
 GW3Ji4BVeSBpI5qkVM6Bn6NyV+Ij/9d5P2MGJLmQGr+iXFHZXW97rJruvc9yqUHPknMUR46Ud
 rZdd+cH6HPUAto2Ph3vGQL1OFzMEd8wItzQOnqSlKu6OD7sXms+0IdCNR3XO/fdWv3i8X0oDI
 M1qnoItQg9bloPbhdMCrWiYMYR9uGD5ov8AdH7GXJzFFyz8W/nxoOor0JYb1HuuWv2pJ5pPel
 7KJzGDOtNzycosGCjkXZy0uXgYhYQgvtNIfKekbOvwmPf8FD2a7lEKbfo45g0BIbHwLHaXWqa
 TSeWXzl9pnyt18hC3mN97bPfJttZWzBeoqlykVRNuU4Pv1k2bfc/V1RUUhFs+aoY6+jWCcOLq
 iT2OyE+DDRQ2mQtrQOYqccQOWKxCPaQ++/UtPTGjzm08PFkt9uooYGqjajKXhRIiaXgPsF+dg
 T9XcuH8SG9QbEPlhlht1dB3sxDYKWZ8+072A/Veh8Dibkfym5vwUGn/zBX3seqAyjSKEi09BL
 /AXDuMOgY6RQEGodg3ICNMO5My6mbyDHBu+JCGpjgNQjaZ8IJDahTBcaazW2+5Q6p8UwZfjrT
 Qc4P6wr/5ZMOBgOA76HBlzj+rsiMxD/F7jW3F2Vdx6x28pgjHabvufCAEH0FDtJJ22SW9bqOV
 c9/cJE2AtI9zF0zyl1zf2VWEiAFkokbtJrZxPMCC/+e1gGv0EkPMiRrtE1M7IgjFr0yDJ4uzj
 93VJzX53LAdqgGK1Mkn5ZKViisLUN6PjH5a2PO4AQ0w/aXZyb40ZN3RzCTJmRJZ6mFpIo/Zdc
 Fq67SkqlthpK/HQJc2BRdPMdTgFw7reyOqZ+Gra6wcLhL+CJIA+tHlz+Q1sawUVuMaZ5kJ3EK
 BklmwK7czbn4k+y4bGq3iTN+cVCCtM2s1PBCzyC653lEdT4Vf12BodxXw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Buchholz <Max.Buchholz@gmx.de>

This converts the Nvidia Tegra keyboard controller bindings to YAML
and fix them up a bit.

Reviewed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Max Buchholz <max.buchholz@gmx.de>
=2D--
 .../bindings/input/nvidia,tegra20-kbc.txt     |  55 ---------
 .../bindings/input/nvidia,tegra20-kbc.yaml    | 109 ++++++++++++++++++
 2 files changed, 109 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/nvidia,tegra20=
-kbc.txt
 create mode 100644 Documentation/devicetree/bindings/input/nvidia,tegra20=
-kbc.yaml

diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.tx=
t b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
deleted file mode 100644
index 1faa7292e21f..000000000000
=2D-- a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-* Tegra keyboard controller
-The key controller has maximum 24 pins to make matrix keypad. Any pin
-can be configured as row or column. The maximum column pin can be 8
-and maximum row pins can be 16 for Tegra20/Tegra30.
-
-Required properties:
=2D- compatible: "nvidia,tegra20-kbc"
=2D- reg: Register base address of KBC.
=2D- interrupts: Interrupt number for the KBC.
=2D- nvidia,kbc-row-pins: The KBC pins which are configured as row. This i=
s an
-  array of pin numbers which is used as rows.
=2D- nvidia,kbc-col-pins: The KBC pins which are configured as column. Thi=
s is an
-  array of pin numbers which is used as column.
=2D- linux,keymap: The keymap for keys as described in the binding documen=
t
-  devicetree/bindings/input/matrix-keymap.txt.
=2D- clocks: Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
=2D- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
=2D- reset-names: Must include the following entries:
-  - kbc
-
-Optional properties, in addition to those specified by the shared
-matrix-keyboard bindings:
-
=2D- linux,fn-keymap: a second keymap, same specification as the
-  matrix-keyboard-controller spec but to be used when the KEY_FN modifier
-  key is pressed.
=2D- nvidia,debounce-delay-ms: delay in milliseconds per row scan for debo=
uncing
=2D- nvidia,repeat-delay-ms: delay in milliseconds before repeat starts
=2D- nvidia,ghost-filter: enable ghost filtering for this device
=2D- wakeup-source: configure keyboard as a wakeup source for suspend/resu=
me
-		 (Legacy property supported: "nvidia,wakeup-source")
-
-Example:
-
-keyboard: keyboard {
-	compatible =3D "nvidia,tegra20-kbc";
-	reg =3D <0x7000e200 0x100>;
-	interrupts =3D <0 85 0x04>;
-	clocks =3D <&tegra_car 36>;
-	resets =3D <&tegra_car 36>;
-	reset-names =3D "kbc";
-	nvidia,ghost-filter;
-	nvidia,debounce-delay-ms =3D <640>;
-	nvidia,kbc-row-pins =3D <0 1 2>;    /* pin 0, 1, 2 as rows */
-	nvidia,kbc-col-pins =3D <11 12 13>; /* pin 11, 12, 13 as columns */
-	linux,keymap =3D <0x00000074
-			0x00010067
-			0x00020066
-			0x01010068
-			0x02000069
-			0x02010070
-			0x02020071>;
-};
diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.ya=
ml b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
new file mode 100644
index 000000000000..8ecd42e02f09
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/input/nvidia,tegra20-kbc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Nvidia Tegra keyboard controller
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Sameer Pujar <spujar@nvidia.com>
+
+description: The key controller has maximum 24 pins to make matrix keypad=
. Any pin
+  can be configured as row or column.
+
+allOf:
+  - $ref: "/schemas/input/matrix-keymap.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: nvidia,tegra30-kbc
+          - const: nvidia,tegra20-kbc
+      - items:
+          - const: nvidia,tegra20-kbc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  nvidia,kbc-row-pins:
+    maxItems: 16
+    description: KBC pins which are configured as row
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  nvidia,kbc-col-pins:
+    maxItems: 8
+    description: KBC pins which are configured as column
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: kbc
+
+  linux,fn-keymap:
+    description: a secondary keymap to be used when the KEY_FN modifier k=
ey is pressed
+
+  nvidia,debounce-delay-ms:
+    description: delay in milliseconds per row scan for debouncing
+
+  nvidia,repeat-delay-ms:
+    description: delay in milliseconds before repeat starts
+
+  nvidia,ghost-filter:
+    description: enable ghost filtering for this device
+    type: boolean
+
+  wakeup-source:
+    description: configure keyboard as a wakeup source for suspend/resume
+
+  nvidia,wakeup-source:
+    description: configure keyboard as a wakeup source for suspend/resume
+    deprecated: true
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - nvidia,kbc-row-pins
+  - nvidia,kbc-col-pins
+  - linux,keymap
+  - clocks
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    kbc@7000e200 {
+        compatible =3D "nvidia,tegra20-kbc";
+        reg =3D <0x7000e200 0x100>;
+        interrupts =3D <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&tegra_car 36>;
+        resets =3D <&tegra_car 36>;
+        reset-names =3D "kbc";
+        nvidia,ghost-filter;
+        nvidia,debounce-delay-ms =3D <640>;
+        nvidia,kbc-row-pins =3D <0 1 2>;    /* pin 0, 1, 2 as rows */
+        nvidia,kbc-col-pins =3D <11 12 13>; /* pin 11, 12, 13 as columns =
*/
+        linux,keymap =3D <0x00000074
+                        0x00010067
+                        0x00020066
+                        0x01010068
+                        0x02000069
+                        0x02010070
+                        0x02020071>;
+    };
=2D-
2.37.0

