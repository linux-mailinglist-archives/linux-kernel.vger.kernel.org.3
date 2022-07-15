Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF5B5762A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiGONPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGONPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:15:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836A3DED3;
        Fri, 15 Jul 2022 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657890882;
        bh=mlnJkuI/pqDn8MWVINAL1lqJsNsNqD9rO+qAKNY1pnE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=jFoH6gzMNI/7QiQKV4Pv+9VdbQR9MdIx/AAkYmcIqd8U3p3xdmIgbUsf/jJzE4UrD
         hRV6FX9Fj+U6vpnt3vivD3dvniqmk1q3kgNhAYd1PX/M2vjNpMC+kDVH8vTGHBJCnw
         5JusVg8nMyzuicjasrOMLiAesf/BglLjYxq6/GTk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from max-esprimop556.user.selfnet.de ([141.72.241.228]) by
 mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MvsJ5-1nMzkj2vrT-00svcz; Fri, 15 Jul 2022 15:14:42 +0200
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
Subject: [PATCH v3] dt-bindings: nvidia,tegra20-kbc: Convert to json-schema
Date:   Fri, 15 Jul 2022 15:14:21 +0200
Message-Id: <20220715131422.51143-1-max.buchholz@gmx.de>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n3x4oCCTVO0hBabGdWVWg7Q+DE4k2LshQjvvt4qtCppu6cTFdFT
 9GxzUFxoebxeIodlh4tHl4n2LzQcUNxhNkH0xu79whlaN5ERMwW/I8ITmmGQ+6Ee3Zi582K
 OOkKXIhrxKQNIaQEc9DE42Mq3LCXjJ17IqXQdNdvJFb4OLlG93TfjAtwXIdKSgKpXqcxzMg
 jkBl2Q6OIwkqvLzBUs/EA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rlxgDLbS+Co=:/l/hp/b+WKG/S4WyoXLXkx
 f/Try0qCHWBIJCdHtskZQTGknPZq4VDIxv4E3suGSjWaUoY/chyfrpZ9nTudR+P7v6C4f303d
 D0tMQyD6/d0h7KY4CxZTLYyd61W0D4aI1WxcWGMMiedsmnAPFBvEGZQJP2uJkuS4FABQMeiY3
 HrWG3qsGG056t0TZJeYfQFr73Oh0m/8ERCGqw8hS7g3G0TfTC/CWhLFTHdwF36eFDYz/R8TP+
 jjOf2wSjkLvq/oIWwPkvD3jU+TCac8FwjUVRVLGIEsKJX/xL+0hWLC1mHG05hw5F8q+X2Gmbn
 189Vk3e+N2KYxWK2WmfwFQEA2/aEzdXhunQoviuLIADJxqExY+kARzQrbvSJvzsdElSuYIRCw
 t8AvZDRk3dJthE1e1n700afCzdmaRrQ9uF2B74nDxFIGdF3FImioLJBfSr3REZyoVNOWHllN5
 GiQwDDN/VGSgt3OVmUm5H45gR2SkHPHlOw1l3mrHoGuEunbizMMxP6TA8drrjR8/v/3X0b57L
 r6thvOe5afTG6Gbw7vMELfT6L4dgSCU+uQm0S/q0u91IKsVsVNHv8hSfAfyuEYkTVAbFr9yM+
 YtaRa4evg+l33j+bzWTyc5JnvzIN6CdQ82dNH63Vaep0ZF24DWt6Fh7ty+8AmAlQpMuBVBabV
 G6RQqsTwlkKvdPIiK7PPqroSyVRRblVdRAONrSPaM08T1Uw2Ldo65WeSqCjw9XAvcc53e6JlV
 Nu8CFXKSlScldv+0GPirflc/YJtb+aNx6q1b7uphHgmhwYUF5Qo/k135UPpMCH9yKuxwwQYl7
 JPEftugEBS4wfTRcGG1Kr1+2Q1kZx41+cxSVMNqWpv9pfseNeDBI4Xqoj8blDPTOX+dsKC/sU
 C42Xm/0m5t7HkXJvwhmHKLDZCCf2X39BKivuyuj8tjaQiqVSXsQ6+i5E5aZf36FAW2S8SPAFg
 k+XF0WnOEhz0m3K1Kj+cSd0orVZDFYPCcTAbFSl2rewEq8JouAukwremAM6aZbUSMumdjwLm8
 quQq+J1XaBAcouhHojgb9hDWGCcQ1NpwSbDG9PRvr2tMJwVjCGpXe9J/XpX2fL6JXSVYeR3DH
 pE/feBgJvRzBu2A6XA7yjlqrk1g/aP1SzpTGJwrr+E+GzvFImT6h5jrEA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v3:
 - fixed maxItems for array properties
v2:
 - rework the file according to the feedback

 .../bindings/input/nvidia,tegra20-kbc.txt     |  55 ---------
 .../bindings/input/nvidia,tegra20-kbc.yaml    | 111 ++++++++++++++++++
 .../bindings/power/wakeup-source.txt          |   2 +-
 3 files changed, 112 insertions(+), 56 deletions(-)
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
index 000000000000..8e1eaad2fdc1
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
@@ -0,0 +1,111 @@
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
+    minItems: 1
+    maxItems: 16
+    description: KBC pins which are configured as row
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  nvidia,kbc-col-pins:
+    minItems: 1
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
+unevaluatedProperties: false
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
diff --git a/Documentation/devicetree/bindings/power/wakeup-source.txt b/D=
ocumentation/devicetree/bindings/power/wakeup-source.txt
index cfd74659fbed..728f88de371d 100644
=2D-- a/Documentation/devicetree/bindings/power/wakeup-source.txt
+++ b/Documentation/devicetree/bindings/power/wakeup-source.txt
@@ -25,7 +25,7 @@ List of legacy properties and respective binding documen=
t
 				Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
 5. "linux,keypad-wakeup"	Documentation/devicetree/bindings/input/qcom,pm8=
xxx-keypad.txt
 6. "linux,input-wakeup"		Documentation/devicetree/bindings/input/samsung-=
keypad.txt
-7. "nvidia,wakeup-source"	Documentation/devicetree/bindings/input/nvidia,=
tegra20-kbc.txt
+7. "nvidia,wakeup-source"	Documentation/devicetree/bindings/input/nvidia,=
tegra20-kbc.yaml

 Examples
 --------
=2D-
2.37.0

