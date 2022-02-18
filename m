Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9893E4BB2C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiBRG7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:59:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiBRG7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:59:19 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3718211A0F;
        Thu, 17 Feb 2022 22:59:02 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id a28so13049966qvb.10;
        Thu, 17 Feb 2022 22:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+BWgWH5dYT+gWKpYqNkWfCo9hVCk5w2Ofm7CYrSQ2HU=;
        b=kt6dd+ZJ8WLbp3UpHDIAZlwoqKoTpiV1tSDMEmD0B/jbwq7qNbo/6tqQe9TOlEQeNt
         7qPG3UZvI7D4pilWUzWUlYXaw3Wm0XzkqF/37GeLhjyfhfErbNib89F53Fr1CprAsjjm
         ps4l8UP1WvS/+SyL8nxp5zSbex0+y6t5qpBzPSs2IgL53IGGeW5KbjOjpWAWWBOBCNBZ
         l8XXnlKFNvRV2mx9/C1o/SmLLQV5o05XSTtFNT8VVfMoWci0C350oHyl0BsqXi1q3zN3
         6rRNmhvR3kDAyRd9P98vp1Tn1nU4w64drdNpZbXLGCP0UoQ2NRaKvGCgzS7elnTHmqI3
         W6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+BWgWH5dYT+gWKpYqNkWfCo9hVCk5w2Ofm7CYrSQ2HU=;
        b=4PItb7R9Y1foI6FZpba5PJ+14QNLBX10ocCsLrpr63fP2fd/R+IZQuRT3D8GIALcxC
         7HZ4BHGwp/XGJf2biwlFpLVB1+7EE/KZG107LcdTnjo1KRi17CXxLOX2dZfUMtyKnA/y
         K+6nyozqJHkYNHk8TLgcgdYsf7UW7Q6L4k5uW2TJojrU6NUz2MlVTOOaLkyHORdR6wDq
         bU5ged+ScVYBqs/xbseqRLc7rN1irTc4bD6gxHd+yQXzjuH1cayJsBJeTZ+D43zyoStp
         usrycV9xZnzxJcGeJMh/eCJ59VsPCwakFkOYHqDJ4QlVbJnHMQ33qrfCzQIUNvo9ULiK
         yEUg==
X-Gm-Message-State: AOAM533QF6790/besF036VT5xxFmRsUHTYVF+rOUfWgl71dRGKm/k+OR
        WH0WeM2v3a0Hwbw/AsxtfiyBHsf3h+uKzA==
X-Google-Smtp-Source: ABdhPJz+eloodc474+YH8Uw+1ycBEm5D/h0z4YoMOVEhxbJwqetM2At1asxTASax47wZBRr7/IRq7w==
X-Received: by 2002:ad4:552d:0:b0:42c:b915:692 with SMTP id ba13-20020ad4552d000000b0042cb9150692mr4712043qvb.3.1645167541029;
        Thu, 17 Feb 2022 22:59:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q8sm21411723qkl.65.2022.02.17.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 22:59:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 1/2] dt-bindings: hwmon: add tmp464.yaml
Date:   Thu, 17 Feb 2022 22:58:55 -0800
Message-Id: <20220218065856.1899086-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Agathe Porte <agathe.porte@nokia.com>

Add basic description of the tmp464 driver DT bindings.

Signed-off-by: Agathe Porte <agathe.porte@nokia.com>
Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4:
- No changes

v3:
- Addedd support for TMP468.
- Changed number of channels from 0..3 (which was wrong anyway) to 0..8.
- Changed value range for ti,n-factor to int8, with an example for
  a negative value.
- Added myself as driver maintainer.

 .../devicetree/bindings/hwmon/ti,tmp464.yaml  | 109 ++++++++++++++++++
 MAINTAINERS                                   |   7 ++
 2 files changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
new file mode 100644
index 000000000000..8ce4be729494
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ti,tmp464.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TMP464 and TMP468 temperature sensors
+
+maintainers:
+  - Agathe Porte <agathe.porte@nokia.com>
+
+description: |
+  ±0.0625°C Remote and Local temperature sensor
+  https://www.ti.com/lit/ds/symlink/tmp464.pdf
+  https://www.ti.com/lit/ds/symlink/tmp468.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,tmp464
+      - ti,tmp468
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+patternProperties:
+  "^channel@([0-8])$":
+    type: object
+    description: |
+      Represents channels of the device and their specific configuration.
+
+    properties:
+      reg:
+        description: |
+          The channel number. 0 is local channel, 1-8 are remote channels.
+        items:
+          minimum: 0
+          maximum: 8
+
+      label:
+        description: |
+          A descriptive name for this channel, like "ambient" or "psu".
+
+      ti,n-factor:
+        description: |
+          The value (two's complement) to be programmed in the channel specific N correction register.
+          For remote channels only.
+        $ref: /schemas/types.yaml#/definitions/int8
+        items:
+          minimum: -128
+          maximum: 127
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      sensor@4b {
+        compatible = "ti,tmp464";
+        reg = <0x4b>;
+      };
+    };
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      sensor@4b {
+        compatible = "ti,tmp464";
+        reg = <0x4b>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+          reg = <0x0>;
+          ti,n-factor = /bits/ 8 <(-10)>;
+          label = "local";
+        };
+
+        channel@1 {
+          reg = <0x1>;
+          ti,n-factor = /bits/ 8 <0x0>;
+          label = "somelabel";
+        };
+
+        channel@2 {
+          reg = <0x2>;
+          status = "disabled";
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fca970a46e77..f51bc7c7e439 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19489,6 +19489,13 @@ S:	Maintained
 F:	Documentation/hwmon/tmp401.rst
 F:	drivers/hwmon/tmp401.c
 
+TMP464 HARDWARE MONITOR DRIVER
+M:	Agathe Porte <agathe.porte@nokia.com>
+M:	Guenter Roeck <linux@roeck-us.net>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
+
 TMP513 HARDWARE MONITOR DRIVER
 M:	Eric Tremblay <etremblay@distech-controls.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.35.1

