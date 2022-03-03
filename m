Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058634CC42B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiCCRlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbiCCRlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:41:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AE511A1293
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646329218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+ent/yy95aJOm6DnI9kx/1sJTBsC05TLsSw4BZBHzs=;
        b=hMDv5rKbeCT7D2SIRMpiySYtxKQL77Y4jyJwIxw3s1vqjkmgp4iYYUx/tg2v/xz4FQNL8D
        LIBADd74SZMPOAWqzDEWnWQK/4NudNdiqBR0lCnlHlwPJeTkG4IsDiSTEsm9KRgw0kaEZ+
        Ny+mnzYyIvM9wmeg+I5AjG8m6KrDomg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-oB6EAaFCP6aixmlLUJNTsQ-1; Thu, 03 Mar 2022 12:40:15 -0500
X-MC-Unique: oB6EAaFCP6aixmlLUJNTsQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 577EC5EF;
        Thu,  3 Mar 2022 17:40:13 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.9.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B3D280FC3;
        Thu,  3 Mar 2022 17:40:11 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Miguel Ojeda <ojeda@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH v7 4/6] dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
Date:   Thu,  3 Mar 2022 12:39:33 -0500
Message-Id: <20220303173935.100622-5-cmirabil@redhat.com>
In-Reply-To: <20220303173935.100622-1-cmirabil@redhat.com>
References: <20220303173935.100622-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device tree bindings for the Sense HAT
and each of its children devices in yaml form.

Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 .../raspberrypi,sensehat-display.yaml         | 27 ++++++++
 .../input/raspberrypi,sensehat-joystick.yaml  | 33 +++++++++
 .../bindings/mfd/raspberrypi,sensehat.yaml    | 69 +++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
 create mode 100644 Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml b/Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
new file mode 100644
index 000000000000..5e41d6b7817d
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/raspberrypi,sensehat-display.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi Sensehat Display
+
+maintainers:
+  - Charles Mirabile <cmirabil@redhat.com>
+  - Mwesigwa Guma <mguma@redhat.com>
+  - Joel Savitz <jsavitz@redhat.com>
+
+description:
+  This device is part of the sensehat multi function device.
+  For more information see ../mfd/raspberrypi,sensehat.yaml.
+
+  This device features a programmable 8x8 RGB LED matrix.
+
+properties:
+  compatible:
+    const: raspberrypi,sensehat-display
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml b/Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
new file mode 100644
index 000000000000..c97cd1d8eac6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/raspberrypi,sensehat-joystick.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi Sensehat Joystick
+
+maintainers:
+  - Charles Mirabile <cmirabil@redhat.com>
+  - Mwesigwa Guma <mguma@redhat.com>
+  - Joel Savitz <jsavitz@redhat.com>
+
+description:
+  This device is part of the sensehat multi function device.
+  For more information see ../mfd/raspberrypi,sensehat.yaml.
+
+  This device features a five button joystick (up, down,left,
+  right, click)
+
+properties:
+  compatible:
+    const: raspberrypi,sensehat-joystick
+
+  interrupts:
+    items:
+      - description: pin number for joystick interrupt
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
new file mode 100644
index 000000000000..2484ec91b430
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/raspberrypi,sensehat.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi Sensehat
+
+maintainers:
+  - Charles Mirabile <cmirabil@redhat.com>
+  - Mwesigwa Guma <mguma@redhat.com>
+  - Joel Savitz <jsavitz@redhat.com>
+
+description:
+  The Raspberry Pi Sensehat is an addon board originally developed
+  for the Raspberry Pi that has a joystick and an 8x8 RGB LED display
+  as well as several environmental sensors. It connects via i2c and
+  a gpio for irq.
+
+properties:
+  compatible:
+    const: raspberrypi,sensehat
+
+  reg:
+    items:
+      - description: i2c device address
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "joystick":
+    $ref: ../input/raspberrypi,sensehat-joystick.yaml
+
+  "display":
+    $ref: ../auxdisplay/raspberrypi,sensehat-display.yaml
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - joystick
+  - display
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      sensehat@46 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "raspberrypi,sensehat";
+        reg = <0x46>;
+        display {
+          compatible = "raspberrypi,sensehat-display";
+        };
+        joystick {
+          compatible = "raspberrypi,sensehat-joystick";
+          interrupts = <23 GPIO_ACTIVE_HIGH>;
+        };
+      };
+    };
-- 
2.31.1

