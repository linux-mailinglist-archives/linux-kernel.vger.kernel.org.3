Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B52F4A7CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348552AbiBCA0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:26:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348564AbiBCA0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643847967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUs9xNWmt9WhjQnC9DXbjWYNlVBZzZ3mJ6n8NPsFFAE=;
        b=VPrxXGzbwu9Zi4gBPj5RbWBw+obNRn5hBg37h+LZjwIEih1LmBjd577dSjTRM7oT2zIeNN
        CVuzCMAfqrjZVlBPwG0Lj4FYD3cG+3zT7at0/NGCw6U4HcJbkrQRElhQDYBvDxjiN8xupB
        yCq1k4XORtZW9MIUPq2ZcWX1nS1Bfww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-YZkSLdrTM-KtHOl4B05_Bw-1; Wed, 02 Feb 2022 19:26:03 -0500
X-MC-Unique: YZkSLdrTM-KtHOl4B05_Bw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB674814246;
        Thu,  3 Feb 2022 00:26:01 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1233856A81;
        Thu,  3 Feb 2022 00:25:59 +0000 (UTC)
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
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH 4/6] dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
Date:   Wed,  2 Feb 2022 19:25:19 -0500
Message-Id: <20220203002521.162878-5-cmirabil@redhat.com>
In-Reply-To: <20220203002521.162878-1-cmirabil@redhat.com>
References: <20220203002521.162878-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 .../raspberrypi,sensehat-display.yaml         | 32 +++++++++
 .../input/raspberrypi,sensehat-joystick.yaml  | 37 ++++++++++
 .../bindings/mfd/raspberrypi,sensehat.yaml    | 68 +++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
 create mode 100644 Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml b/Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
new file mode 100644
index 000000000000..8937adba1c4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+  reg:
+    items:
+      - description: |
+          smb register number for the first component of the fist
+          pixel in the range.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml b/Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
new file mode 100644
index 000000000000..a6d95c903b04
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+  reg:
+    items:
+      - description: |
+          smb register number for accessing the state of the buttons
+
+  interrupts:
+    items:
+      - description: pin number for joystick interrupt
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
new file mode 100644
index 000000000000..89037be87c10
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+patternProperties:
+  "^joystick(@[0-9a-f]+)?$":
+    $ref: ../input/raspberrypi,sensehat-joystick.yaml
+
+  "^display(@[0-9a-f]+)?$":
+    $ref: ../auxdisplay/raspberrypi,sensehat-display.yaml
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
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
+        display@0 {
+          compatible = "raspberrypi,sensehat-display";
+          reg = <0x0>;
+        };
+        joystick@f2 {
+          compatible = "raspberrypi,sensehat-joystick";
+          reg = <0x0>;
+          interrupts = <23 GPIO_ACTIVE_HIGH>;
+        };
+      };
+    };
-- 
2.31.1

