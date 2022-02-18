Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A954BB674
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiBRKLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:11:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiBRKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:11:24 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C2F1A3406;
        Fri, 18 Feb 2022 02:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645179029;
        bh=dQaqrY1szTQw9YJ5drdcXLw3CUwut1x5HuSIYC9iL30=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=gB6XqqEoSlrqdJyM42lAzTT7wy7q/yZHtvVLzTXcgzyD6Uh9a3eptkNSd1nNcQwjH
         RJfXeEaEteC6w5aDfYAOJmUxH5+P6Tuss79Q+abdFRrae076f4niwkTb/+bcsWZmNc
         pBiF+JcSUaIiCpDgn8QC83D/4LiziJIUh1aGEgKU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from max-esprimop556.user.selfnet.de ([141.72.241.228]) by
 mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M6DWi-1nNC4j26w4-006hyE; Fri, 18 Feb 2022 11:10:29 +0100
From:   Max Buchholz <max.buchholz@gmx.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Max Buchholz <max.buchholz@gmx.de>
Cc:     Max Buchholz <Max.Buchholz@gmx.de>,
        David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: nvidia,tegra20-kbc: Convert to json-schema
Date:   Fri, 18 Feb 2022 11:10:10 +0100
Message-Id: <20220218101011.22988-1-max.buchholz@gmx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UkGIICl6xbjoVsCCGPW/PZwIzzlt2IWnp1FVx8gSHB/6A++cTIy
 uITxyk1KCNKk6tDRl4e21GfJQ1wzqqVRLCewIdzOYlFEr8NPgumVyzqx9ufFg0ja+gVGSU3
 +QzocnU6Y9dhHb+t5kXaHBssqy47WN/rT3RjpiiTHMhJFU5ty4VsawFpo3hEmWSw6QqA8CB
 0mTiNW7ek7WUI6dOFQrmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+xjSSEDY6F4=:xYZggW/fkvD+XhqJuzQlTc
 okTjuMKHFJ/IcFNnvci3yGLge2sKr1yLfeiXtUWKdDjfmjSwWRbOsfWcRYkJ1Y8KSLQTB6Kbk
 K7/H3XrIou7qtAvgZgd0t8N43EZEhP7zHDSZlkj0Q60OsQLtgldct3mcqG/gOzkni5luy7Tex
 6Jg5KTtnymLSTxMHwpdzRc2s/DC7kuFqKVVmvHmhb0R/9LlpLDY1lGU+veMao+3xvdwSmApdb
 BVSMs5Ev2NeLc+uWWCEmuSE45WH0naMkTGUtgnGUZ+WjeYwsYfLg6lQ9vcLo1hBMmv523LwmG
 fkSVH7RdXFlsnZ7AcLw1/9T168ILepnYzfFqzbfnxUyG6VSBi/E+EleAqfytLWvC6Z51YzyKv
 7DeT73s1qMne0NialqWS/iL7MdksLU+cONJtFTDxvqvp2tZ/5csuuXWceCqucWm4Z/Uw94kUQ
 tcuHQ6HCjLjJ5RR+xhZPGYp9n8eQa0dMV/QM5vEVSY7PovDtFdoYQsDCYBv4L5I9YdbNT8WYe
 SabwFDQODkbgFEy1uXiDlXdXhvPjMy3EpjOzai2hFhONos6euJIXZt+38aPqK3kbaiDI+tw2N
 qmqYr3ucOaplSZRrxQnGL0SuOuvxbbhgmWTLLbK7I/M31ZeMDwoSaPBAnn7NXTlP4NRvTuDLc
 V/uXNBqTu7WfAQPfpgYeAFiZtLthQpjeW4tD8oXIoDmB3sCrJwapPcAtvHo3GzW/a2wEdK99m
 mgkHl+wxTjSx9FpcT5VEjF24nDc8wm+jvVAFxwW8Owd0uZffyrluGan/dOEKlcM46bgstYFxO
 OZ+Eu9fmkvlxucdDnPV07H/w6ldg/p3cPXHVcPa/tPSnKEbHLUK/Bj5tFD6Iqzqbj0hprz3Y8
 HPGESuI1rkCf9TvRt1UtBNHP0vWaMlF13N3ZpgR2v9n2isylMfZ7WqT58I+SJpoxzq6h+/Py8
 7yI6iUwpXpBiPG65vHSEeW9/k8odas+DT9POAjnoVNmKA/s7Z/O8zNUyxqzRYJIaVbFNG1bUQ
 0h6xXfauRpNci0V8E6oVG3QyBBclCsM7g3p2lwbtOuqiriV45cmm/hyU/AzMVzxUnmVffxbKd
 /SerSQg27utJ9I=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Buchholz <Max.Buchholz@gmx.de>

This converts the Nvidia Tegra keyboard controller bindings to YAML
and fix them up a bit.

Acked-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Max Buchholz <max.buchholz@gmx.de>
=2D--
 .../bindings/input/nvidia,tegra20-kbc.txt     |  55 ---------
 .../bindings/input/nvidia,tegra20-kbc.yaml    | 114 ++++++++++++++++++
 2 files changed, 114 insertions(+), 55 deletions(-)
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
index 000000000000..076b347a6f07
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/input/nvidia,tegra20-kbc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Nvidia Tegra keyboard controller
+
+maintainers:
+  - Max Buchholz <max.buchholz@gmx.de>
+
+description: >
+  The key controller has maximum 24 pins to make matrix keypad. Any pin
+  can be configured as row or column. The maximum column pin can be 8
+  and maximum row pins can be 16 for Tegra20/Tegra30.
+
+properties:
+  compatible:
+    const: nvidia,tegra20-kbc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Interrupt number for the KBC.
+
+  nvidia,kbc-row-pins:
+    description: >
+      The KBC pins which are configured as row. This is an
+      array of pin numbers which is used as rows.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  nvidia,kbc-col-pins:
+    description: >
+      The KBC pins which are configured as column. This is an
+      array of pin numbers which is used as column.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  linux,keymap:
+    description: >
+      The keymap for keys as described in the binding document
+      devicetree/bindings/input/matrix-keymap.txt.
+
+  clocks:
+    maxItems: 1
+    description: >
+      Must contain one entry, for the module clock.
+      See ../clocks/clock-bindings.txt for details.
+
+  resets:
+    description: >
+      Must contain an entry for each entry in reset-names.
+      See ../reset/reset.txt for details.
+
+  reset-names:
+    const: kbc
+
+  linux,fn-keymap:
+    description: >
+      a second keymap, same specification as the
+      matrix-keyboard-controller spec but to be used when the KEY_FN modi=
fier
+      key is pressed.
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
+    keyboard: {
+        compatible =3D "nvidia,tegra20-kbc";
+        reg =3D <0x7000e200 0x100>;
+        interrupts =3D <0 85 0x04>;
+        clocks =3D <&tegra_car 36>;
+        resets =3D <&tegra_car 36>;
+        reset-names =3D "kbc";
+        nvidia,ghost-filter;
+        nvidia,debounce-delay-ms =3D <640>;
+        nvidia,kbc-row-pins =3D <0 1 2>;    /* pin 0, 1, 2 as rows */
+        nvidia,kbc-col-pins =3D <11 12 13>; /* pin 11, 12, 13 as columns =
*/
+        linux,keymap =3D <0x00000074
+                0x00010067
+                0x00020066
+                0x01010068
+                0x02000069
+                0x02010070
+                0x02020071>;
+    };
=2D-
2.35.1

