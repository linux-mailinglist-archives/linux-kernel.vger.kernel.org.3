Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4754DF53
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376475AbiFPKmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376301AbiFPKme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:42:34 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F16E92;
        Thu, 16 Jun 2022 03:42:31 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 243815FD0E;
        Thu, 16 Jun 2022 13:42:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1655376150;
        bh=acb8bFjvFs4vIpvT4bDEWmEuHbG15fD1/I93Ay4Q9/Q=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=PdWCaMBPluJVzi55wsUJU4A/DGCcB+UTIMLBgW5L8cTXPa4+Mu9ZUSZgY4I0HCatP
         awGx8S+8XuwDyLbBA5bN+gHMQeBNMhSjyWNQRSpAdroIrVTqfZBOVARS4l6SZIRPBd
         DNr4XNU3F/1tv3wRh6oi8h//ivBdtkjp6I/OP8VN71lgJR3uPSDXUARla1L+RTtgNx
         V8ltCoW/IwEdtLUv4Lk7lbEoeAAbsGe7w2uv6K0P7Dsv2ABTGFVaShlFc6bzoTh6BX
         fh+5x6i2wAej28cqEusj+ug1fe0nurXs5eGxQZO39DrJRqUOgWxpxt8z71cylIdKj+
         L43HH/a7OHgPA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 16 Jun 2022 13:42:30 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v3 3/3] dt-bindings: iio: accel: add dt-binding schema for
 msa311 accel driver
Thread-Topic: [PATCH v3 3/3] dt-bindings: iio: accel: add dt-binding schema
 for msa311 accel driver
Thread-Index: AQHYgW2/WnQfCkQxXk6267GmpT0D/g==
Date:   Thu, 16 Jun 2022 10:42:17 +0000
Message-ID: <20220616104211.9257-4-ddrokosov@sberdevices.ru>
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/16 07:44:00 #19785775
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce devicetree binding json-schema for MSA311 tri-axial,
low-g accelerometer driver.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 .../bindings/iio/accel/memsensing,msa311.yaml | 52 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/memsensing,=
msa311.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.=
yaml b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
new file mode 100644
index 000000000000..072632708d42
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/iio/accel/memsensing,msa311.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MEMSensing digital 3-Axis accelerometer
+
+maintainers:
+  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
+
+description: |
+  MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
+  sensitivity consumer applications. It has dynamical user selectable full
+  scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurement=
s
+  with output data rates from 1Hz to 1000Hz.
+  Datasheet can be found at following URL
+  https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
+
+properties:
+  compatible:
+    const: memsensing,msa311
+
+  reg:
+    maxItems: 1
+    description: I2C registers address
+
+  interrupts:
+    maxItems: 1
+    description: optional I2C int pin can be freely mapped to specific fun=
c
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        accelerometer@62 {
+            compatible =3D "memsensing,msa311";
+            reg =3D <0x62>;
+            interrupt-parent =3D <&gpio_intc>;
+            interrupts =3D <29 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 55aeb25c004c..be39e5c214fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12482,6 +12482,7 @@ MEMSENSING MICROSYSTEMS MSA311 ACCELEROMETER DRIVER
 M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
 F:	drivers/iio/accel/msa311.c
=20
 MEN A21 WATCHDOG DRIVER
--=20
2.36.0
