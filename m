Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA21455A49B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 01:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiFXXDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 19:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiFXXDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 19:03:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA578828BA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:03:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mf9so7656014ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJe+xcZ3/D6PBSynO0jW7/Eqhilgv6gNqpZ8p3aGXd0=;
        b=MnE6HFKeJE96PcaRLagx5/+3ziVOcE+1hsvFY5sY/Cdn8gEfANbQZhJr3yWzr0DNyP
         cro1ywge4Mq9rwcGE7j2QM9hpm+qkHMKIJ4pyk3i2OioePxvc1btkQSHwEaekZnjwoT5
         UXFwfiwVrYlb6RLk8vuzINxhNcravsga2+dD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJe+xcZ3/D6PBSynO0jW7/Eqhilgv6gNqpZ8p3aGXd0=;
        b=j0Hrz4jUMq808OmWKWYEdkWFDp8g5DbY/bMB8u3ho4cYn+wpHehF+0TTZd6inx6Eoo
         rqcDPO6Xf6k2P0nvLJ5bc1gLX8naFHSgSu4lwGJL0txkKfkh5kSnde7Pa8Uu+ZS36QfC
         Zaw9Zd3lNwTIvHFyUDyQoiCOPuRKLHAdTUuz4OBaf5E77sw9hydh+ROU3jhue3Vnt60d
         pTDOctWaCo/EeqOWq3ojO6ZO5tSyEcyJhtSKwG8ofWrNQ5eYliMOH8bwvl5//XkZ5X0/
         s7WGrQ033U3zmDUcQw91yd1zy5z/FPv0rNwvHYrbUSxxARToeePRb55RfckqNW2HTAuP
         lE6g==
X-Gm-Message-State: AJIora92luEd6TXQ1bO0QwESU5BLrKGlgh56fssq602zDTj4XDzAbbfd
        bOYQ04+KntblCv/uP7jLdQeLVg==
X-Google-Smtp-Source: AGRyM1u9OrGaQ3FO3H0QgxOTsvLQiGp1ni6Lj1KBxemuMVOZbqVG6TzVRElD9/a1D3MJ77tfYQcEng==
X-Received: by 2002:a17:906:9c84:b0:6e0:7c75:6f01 with SMTP id fj4-20020a1709069c8400b006e07c756f01mr1328997ejc.103.1656111819427;
        Fri, 24 Jun 2022 16:03:39 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id w1-20020aa7da41000000b004356a647d08sm2880291eds.94.2022.06.24.16.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:03:39 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] media: dt-bindings: ov5693: document YAML binding
Date:   Sat, 25 Jun 2022 01:03:07 +0200
Message-Id: <20220624230307.3066530-8-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624230307.3066530-1-tommaso.merciai@amarulasolutions.com>
References: <20220624230307.3066530-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of device tree in YAML schema for the
OV5693 CMOS image sensor from Omnivision

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 .../bindings/media/i2c/ovti,ov5693.yaml       | 123 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
new file mode 100644
index 000000000000..1ee70af40000
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2022 Amarulasolutions
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov5693.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Omnivision OV5693 CMOS Sensor
+
+maintainers:
+  - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
+
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
+description: |
+  The Omnivision OV5693 is a high performance, 1/4-inch, 5 megapixel, CMOS
+  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
+  sub-sampled, and windowed 10-bit MIPI images in various formats via the
+  Serial Camera Control Bus (SCCB) interface.
+
+  Supports images sizes: 5 Mpixel, EIS1080p, 1080p, 720p, VGA, QVGA
+
+  OV5693 is programmable through I2C and two-wire Serial Camera Control Bus (SCCB).
+  The sensor output is available via CSI-2 serial data output (up to 2-lane).
+
+properties:
+  compatible:
+    const: ovti,ov5693
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      System input clock (aka XVCLK). From 6 to 27 MHz.
+    maxItems: 1
+
+  dovdd-supply:
+    description:
+      Digital I/O voltage supply, 1.8V.
+
+  avdd-supply:
+    description:
+      Analog voltage supply, 2.8V.
+
+  dvdd-supply:
+    description:
+      Digital core voltage supply, 1.2V.
+
+  reset-gpios:
+    description:
+      The phandle and specifier for the GPIO that controls sensor reset.
+      This corresponds to the hardware pin XSHUTDN which is physically
+      active low.
+    maxItems: 1
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            minItems: 1
+            maxItems: 2
+
+          # Supports max data transfer of 900 Mbps per lane
+          link-frequencies: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - dovdd-supply
+  - avdd-supply
+  - dvdd-supply
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/px30-cru.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/pinctrl/rockchip.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ov5693: camera@36 {
+            compatible = "ovti,ov5693";
+            reg = <0x36>;
+
+            reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&cif_clkout_m0>;
+
+            clocks = <&cru SCLK_CIF_OUT>;
+            assigned-clocks = <&cru SCLK_CIF_OUT>;
+            assigned-clock-rates = <19200000>;
+
+            avdd-supply = <&vcc_1v8>;
+            dvdd-supply = <&vcc_1v2>;
+            dovdd-supply = <&vcc_2v8>;
+
+            rotation = <90>;
+            orientation = <0>;
+
+            port {
+                ucam_out: endpoint {
+                    remote-endpoint = <&mipi_in_ucam>;
+                    data-lanes = <1 2>;
+                    link-frequencies = /bits/ 64 <450000000>;
+                };
+            };
+        };
+    };
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index 1fc9ead83d2a..844307cb20c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14719,6 +14719,7 @@ M:	Daniel Scally <djrscally@gmail.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
 F:	drivers/media/i2c/ov5693.c
 
 OMNIVISION OV5695 SENSOR DRIVER
-- 
2.25.1

