Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA134B810B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiBPHIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:08:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiBPHI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:08:28 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29022557B9;
        Tue, 15 Feb 2022 23:08:00 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id r27so1535390oiw.4;
        Tue, 15 Feb 2022 23:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LwN9EA5sx0wUNLuUzhVGQjuS5ktDIOUqd6XJ09IJOkE=;
        b=gUF+e3qOBj161a7CB8jYZrJ20XMGIaDecFBxZ9aWE8fXVmDfBpi+5z5wCDBYytbzRA
         8pIamArw2sdR/JazYE8ciQTRqA65R80IdwRGJJizE9RTGoAV2kXTqLTUdWyZe8eNFfqz
         QEkt/JZBCnRqM3w2/q2SPHeG3GTBT2xX8DJUYjDQ6CGEzt/imNlqCNIjg80iTNT4SrLd
         IiptsrGujqzJ4TWwuN9KQpgZ2RbEjzZNorzVIXDG2uWpawtG652XJNtDaAdk6HuefCKr
         ggHLSvELDUiSTBAFyg69S13bIyZA1nXYzLHx79gXIV3Z8fmiJ1Rwse8yparpDHNd3Mkb
         YBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LwN9EA5sx0wUNLuUzhVGQjuS5ktDIOUqd6XJ09IJOkE=;
        b=kFhZZKYkWfIBphYk07+uU9wb9o2c+f9bV3Wl0N5Azbw17s2hz5kCN0HD+0Xwlfav/9
         TNifWGyXeGD7mfzf3edriGd+iKVPpFzrPeAsl9pX6Hwy9rzbbiybNX1U2nFkC1kjYzM+
         xyw1Hj+g/bO8Sc4kh2wPK4nqQcpOwWs3SarioqQmNuXHZriK7n86pYIirPj3CMqRvC86
         mpYnbJWJ3Z6sYJTj2djHUb8LcJxcRW5c1YLPMDvIoIP41kHoeBzjHrFfG4KkWt1P++xB
         Vv6/5TMWOK1hAl7Ey57Sw6oBkz8Z/G0S5/AOcO7xo/WyDWte/j4rJEc6dIbVBQzbiUan
         xfSQ==
X-Gm-Message-State: AOAM531YmlbuKhtZxdlOtuNNuiWiDSRp8MOeT2uJAfsw3yCfMNWh0AiN
        R7J3XIJEmdp5ZtnJ4NEyCbgDrcQSWF5tKg==
X-Google-Smtp-Source: ABdhPJwO1b0rsKESg2CQGVtlhqckt6rp3MvWtTgXr2VA2OimJzQBOoQIcbs+mcEyL8Z+74Dvr0SMYg==
X-Received: by 2002:aca:c284:0:b0:2cb:3e5:79d with SMTP id s126-20020acac284000000b002cb03e5079dmr79808oif.89.1644995244826;
        Tue, 15 Feb 2022 23:07:24 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k17sm14675997otk.80.2022.02.15.23.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 23:07:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 1/2] dt-bindings: hwmon: add tmp464.yaml
Date:   Tue, 15 Feb 2022 23:07:19 -0800
Message-Id: <20220216070720.2131761-1-linux@roeck-us.net>
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
Note:
  I had previously asked to add more detailed bindings, but concluded
  that those should be provided in a generic temperature sensor schema.
  I'll try to introduce such a schema separately.

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

