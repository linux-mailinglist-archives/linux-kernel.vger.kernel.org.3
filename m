Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B264E713F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358899AbiCYKc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358887AbiCYKcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:32:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6281FC55A6;
        Fri, 25 Mar 2022 03:31:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 3DF4D1F460EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648204274;
        bh=QOhkhiW0JlopjyeFTJ4GssHvgndzKVhQ426SGRnEof4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a2K2LP+Cow21V8hDTIN0kDXTaptiUhSzshQ/AS8oFEWVkh1+QS048Yogy2ffBzxID
         7sGy2S7Jsm81fe2laZdvcVR5SMHTy+194jcZdA4ib3ARvRrpb7g1+OOiYB5YP6/9Hw
         KdI8va9NuTXfEhpV259qh1TrpOTM/MYGLQ8zvtz7ZbXI540svkWfxgj+Gj+sBq1C4T
         gaEwP/d7iRzZwWliGYr5T5FO11xEQOo1PcV8q7Q7hQfwBKGtPhCTfujae44lP59wZ9
         7oT5Hpbkla5FC7HSWRR7F74Q35PFnUwp0rs5mCSBsfBxf0/tBsj4jpXFBIDZ0ujfkP
         ZT9GfHwfnt/Rg==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 2/3] dt-bindings: Document ltrf216a light sensor bindings
Date:   Fri, 25 Mar 2022 16:00:13 +0530
Message-Id: <20220325103014.6597-3-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220325103014.6597-1-shreeya.patel@collabora.com>
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for ltrf216a ambient light sensor

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 .../bindings/iio/light/liteon,ltrf216a.yaml   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
new file mode 100644
index 000000000000..275d86a0353a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/liteon,ltrf216a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LTRF216A Ambient Light Sensor
+
+maintainers:
+  - Zhigang Shi <Zhigang.Shi@liteon.com>
+
+description: |
+  Ambient sensing with an i2c interface.
+
+properties:
+  compatible:
+    enum:
+      - liteon,ltrf216a
+      - ltr,ltrf216a
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@53 {
+                compatible = "ltr,ltrf216a";
+                reg = <0x53>;
+        };
+    };
+...
-- 
2.30.2

