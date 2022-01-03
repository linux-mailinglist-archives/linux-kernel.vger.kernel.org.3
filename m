Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F8D483168
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiACNcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:32:06 -0500
Received: from ni.piap.pl ([195.187.100.5]:40176 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbiACNcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:32:06 -0500
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 78263C3F3ED9;
        Mon,  3 Jan 2022 14:32:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 78263C3F3ED9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1641216724; bh=3xEAksF42GqvPyIo5udWzXK97YqUun/mk0Ov9K3jQR4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GrwQJBKV3WQV07gvU3YJG/uaCfNk8E5y8C3VGALy14v7pABzwAKzglkoLanDga8D4
         LJNVFC8N7D8jUJnVIHaB3UQHstn34QSQqfbiPHpcsskGNxgWr1ANhRBs28J9HwuViy
         UjBYUJJ8neXV8+p5qrtaOFxUiR+2d4vDmnoiF59g=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v7 1/2] dt-binding: media: document ON Semi AR0521 sensor
 bindings
References: <m3czl9eylt.fsf@t19.piap.pl>
Sender: khalasa@piap.pl
Date:   Mon, 03 Jan 2022 14:32:04 +0100
In-Reply-To: <m3czl9eylt.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of
        "Mon, 03 Jan 2022 14:29:50 +0100")
Message-ID: <m38rvxeyi3.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file documents DT bindings for the AR0521 camera sensor driver.

Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>

diff --git
a/Documentation/devicetree/bindings/media/i2c/onnn,ar0521.yaml
b/Documentation/devicetree/bindings/media/i2c/onnn,ar0521.yaml
new file mode 100644
index 000000000000..b617cc5c6a9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/onnn,ar0521.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/onnn,ar0521.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ON Semiconductor AR0521 MIPI CSI-2 sensor
+
+maintainers:
+  - Krzysztof Ha=C5=82asa <khalasa@piap.pl>
+
+description: |-
+  The AR0521 is a raw CMOS image sensor with MIPI CSI-2 and
+  I2C-compatible control interface.
+
+properties:
+  compatible:
+    const: onnn,ar0521
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: extclk
+
+  vaa-supply:
+    description:
+      Definition of the regulator used as analog (2.7 V) voltage supply.
+
+  vdd-supply:
+    description:
+      Definition of the regulator used as digital core (1.2 V) voltage sup=
ply.
+
+  vdd_io-supply:
+    description:
+      Definition of the regulator used as digital I/O (1.8 V) voltage supp=
ly.
+
+  reset-gpios:
+    description: reset GPIO, usually active low
+    maxItems: 1
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
+    description: |
+      Video output port.
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          bus-type:
+            const: 4
+          data-lanes:
+            anyOf:
+              - items:
+                  - const: 1
+              - items:
+                  - const: 1
+                  - const: 2
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - vaa-supply
+  - vdd-supply
+  - vdd_io-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+
+    i2c {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            ar0521: camera-sensor@36 {
+                    compatible =3D "onnn,ar0521";
+                    reg =3D <0x36>;
+                    pinctrl-names =3D "default";
+                    pinctrl-0 =3D <&pinctrl_mipi_camera>;
+                    clocks =3D <&clks IMX6QDL_CLK_CKO>;
+                    clock-names =3D "extclk";
+                    reset-gpios =3D <&gpio1 7 GPIO_ACTIVE_LOW>;
+                    vaa-supply =3D <&reg_2p7v>;
+                    vdd-supply =3D <&reg_1p2v>;
+                    vdd_io-supply =3D <&reg_1p8v>;
+
+                    port {
+                           mipi_camera_to_mipi_csi2: endpoint {
+                                    remote-endpoint =3D <&mipi_csi2_in>;
+                                    data-lanes =3D <1 2 3 4>;
+                            };
+                    };
+            };
+    };
