Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05541571C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiGLOTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiGLOTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:19:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51E131911;
        Tue, 12 Jul 2022 07:19:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n18so12486662lfq.1;
        Tue, 12 Jul 2022 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VsO6tc/YsVbF80WJSJzqnQTnc6HnCKzY/cXXDocNJaY=;
        b=BfmTtrk/48Kk+yqzkW9j+U4MSt0/lflRxm5hS5cvBzgQFAHMbu5h3gJNyRdvH+C5NO
         im4Yj04Ttnr0eUS1DvBPR+2qBckzonn6M1bChJbYSD9KFMdtqhmX5X31X+o2YKMjuajC
         GPWV8at4i7nbc8FfrMKEsXj9kpAYp9xWEPeHm3LbKgwXHo1YO/uxGQvuxf5sG0a7w2rW
         3FgzR9t0lD5ASxgp6/h6Scp6JMVUFKCOP0/A7HHtVtF38Gt4gzaoMlB3Gsjbb3JXjNOC
         lMdQcWzXLIwjBOCEN5DV2g7rMY+AZHOeZd12I2z0q3R91M4t+N/+vZAPTGYJqGD36GrC
         wJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VsO6tc/YsVbF80WJSJzqnQTnc6HnCKzY/cXXDocNJaY=;
        b=twQfvONiMVSkEBTFpkeVa8cchIeSYHVm6nB/Ib1kv6YkTiM23nvCxbr0CdEqP3pMqT
         M8BQRdv+ilGhlaK9JkELoaVOcbXQrdawDhilNg/i4beEXjmPG2NoVrL9zriu2LXgmqoI
         OgssgXpXT3FWZ/8ONPR350JhONyRAcGS9f0xk3z7umR639I8Pgk8C2RsQZAWFaBdKmzE
         J0J4n+ALn+/Bt5L3GDJsUzS0BwzggnsFI98uJxtybaRu9i0xB8TD6+v8oAQe0nAiXtg2
         vPXF98WJ2R6+9ZkihJwHxO1+L3rpBgCia6jEClWA8jMgX41GsKTb2F4k4QX0sIcdpcIi
         JKBg==
X-Gm-Message-State: AJIora/3/ORWURlPQdI18UO7mDhXJ+KcQeg6BtoqdXb2lxGnL2IvPYEl
        OaQyH4ma6OPvGsjeTdbYQhk=
X-Google-Smtp-Source: AGRyM1t9yAuUwo3D0XhVEAeaPNKlepz3s781JeQPEf4HZY9tg4u1S15w4+kmtGtqc0IBIQzIJ1IBGA==
X-Received: by 2002:a05:6512:1149:b0:480:77ae:cdbe with SMTP id m9-20020a056512114900b0048077aecdbemr14837503lfg.604.1657635576306;
        Tue, 12 Jul 2022 07:19:36 -0700 (PDT)
Received: from localhost (95-31-189-152.broadband.corbina.ru. [95.31.189.152])
        by smtp.gmail.com with ESMTPSA id s16-20020ac24650000000b00489ca4e297csm2199515lfo.226.2022.07.12.07.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:19:35 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: dt-bindings: media: i2c: document OV4689 DT bindings
Date:   Tue, 12 Jul 2022 17:19:09 +0300
Message-Id: <20220712141925.678595-2-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712141925.678595-1-mike.rudenko@gmail.com>
References: <20220712141925.678595-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation for OV4689 image sensor driver,
and the relevant MAINTAINERS entries.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 .../bindings/media/i2c/ovti,ov4689.yaml       | 122 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
new file mode 100644
index 000000000000..6bdebe5862b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov4689.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Omnivision OV4689 CMOS Sensor Device Tree Bindings
+
+maintainers:
+  - Mikhail Rudenko <mike.rudenko@gmail.com>
+
+description: |-
+  The Omnivision OV4689 is a high performance, 1/3-inch, 4 megapixel
+  image sensor. Ihis chip supports high frame rate speeds up to 90 fps
+  at 2688x1520 resolution. It is programmable through an I2C
+  interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
+  connection.
+
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
+properties:
+  compatible:
+    const: ovti,ov4689
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description:
+      External clock for the sensor.
+    items:
+      - const: xclk
+
+  dovdd-supply:
+    description:
+      Definition of the regulator used as Digital I/O voltage supply.
+
+  avdd-supply:
+    description:
+      Definition of the regulator used as Analog voltage supply.
+
+  dvdd-supply:
+    description:
+      Definition of the regulator used as Digital core voltage supply.
+
+  powerdown-gpios:
+    maxItems: 1
+    description:
+      Reference to the GPIO connected to the powerdown pin (active low).
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      Reference to the GPIO connected to the reset pin (active low).
+
+  orientation: true
+
+  rotation: true
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+    description:
+      Output port node, single endpoint describing the CSI-2 transmitter.
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - dovdd-supply
+  - avdd-supply
+  - dvdd-supply
+  - powerdown-gpios
+  - reset-gpios
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ov4689: camera@36 {
+            compatible = "ovti,ov4689";
+            reg = <0x36>;
+
+            clocks = <&ov4689_clk>;
+            clock-names = "xclk";
+
+            avdd-supply = <&ov4689_avdd>;
+            dovdd-supply = <&ov4689_dovdd>;
+            dvdd-supply = <&ov4689_dvdd>;
+
+            powerdown-gpios = <&pio 107 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&pio 109 GPIO_ACTIVE_LOW>;
+
+            orientation = <2>;
+            rotation = <0>;
+
+            port {
+                wcam_out: endpoint {
+                    remote-endpoint = <&mipi_in_wcam>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f468864fd268..63c4844f26e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14523,6 +14523,13 @@ S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/i2c/ov2740.c
 
+OMNIVISION OV4689 SENSOR DRIVER
+M:	Mikhail Rudenko <mike.rudenko@gmail.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
+
 OMNIVISION OV5640 SENSOR DRIVER
 M:	Steve Longerbeam <slongerbeam@gmail.com>
 L:	linux-media@vger.kernel.org
-- 
2.37.0

