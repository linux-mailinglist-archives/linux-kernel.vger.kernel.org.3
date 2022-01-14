Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2709548ED8B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243073AbiANP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243056AbiANP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:59:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C2DC06173F;
        Fri, 14 Jan 2022 07:59:01 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id i8-20020a17090a138800b001b3936fb375so22392897pja.1;
        Fri, 14 Jan 2022 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mv9y2F1yD1R3tg/trx+ktowkw03PiJgNgeaAhqzGrdM=;
        b=SgBtwxM2VFnGmduI6PM50mcv+l4Wzjj5mA7Xigf7ArnGeuaztP9L3QlFmhxHNBUpHB
         iBQRxbh2CHIErPKFMN1v3Cv03visGxIvb/197JjfomuwCqegvdNoRdY9Z8u8YDURIYRd
         pW42hHva+gGyB2ycb4D7T9KTnTKBaSEYsqgtoIGHpRAeW+FLFDOeRUkR0nHRYzI6Wujz
         cjG3EAnshSICD1JAX1oMy7OXemjNQSI5CNM1BCbsUPiwySxT5JTquTOGVxY4xPRLkgxi
         GLRNKXMcgUyFMjNil7MvbEWCBO2DWeyOkcbePGItaxfeLEKI3ZvY9vy5HYjgVxLv6vgU
         BD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mv9y2F1yD1R3tg/trx+ktowkw03PiJgNgeaAhqzGrdM=;
        b=eaFJEJVDmJjLAw/iX/XRZwyVjqa9dj197AIUKEkElKI+TFRLtZwY2aPEaUjYnPgSHs
         Gc5i5RsDbTFPpd36bmLRpa/FTog0BHYtMkHjvNDJjOJXdPuQslIuraZqTVZs2Xamum+5
         8SngHYd56EC4eqNUd4q9Tt4Tlodcpx1aa/PyEGzM+UqcrqHCfilI0OykPJ/AqGLIk9mr
         56Ff2E9u4yQAz5aItt9imp2hCzVPTEqlJnJ2K7BoV4ppeJc1G6iwwvFcTieMod9OjlXI
         ZXxbyB7EJR0hQsxgEbW1dYro6eO28ndMBZn7j/72Zo/sN4hDZ3RF0VI92AN5l3kbvSuN
         l4hw==
X-Gm-Message-State: AOAM533G4A9cvKoqURz8PWGunGUn7n3mZQUFEossDcxSCyPrruu+hhIj
        wVhvkyxub8n5rDSCUhH6WcI=
X-Google-Smtp-Source: ABdhPJzA0oeh07ehfGqrYGlJMH5sARpBzccgCLMw25Hc3YewvsxbaEm5BYrD3fjVfBtmqh3nfxLSlw==
X-Received: by 2002:a17:902:6a88:b0:149:848f:1e8b with SMTP id n8-20020a1709026a8800b00149848f1e8bmr10367612plk.124.1642175941427;
        Fri, 14 Jan 2022 07:59:01 -0800 (PST)
Received: from localhost.localdomain (1-171-12-230.dynamic-ip.hinet.net. [1.171.12.230])
        by smtp.gmail.com with ESMTPSA id e3sm5076831pgl.59.2022.01.14.07.58.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jan 2022 07:59:00 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
Subject: [PATCH 1/2] dt-bindings: usb: rt1719: Add binding for Richtek RT1719
Date:   Fri, 14 Jan 2022 23:58:48 +0800
Message-Id: <1642175929-25337-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642175929-25337-1-git-send-email-u0084500@gmail.com>
References: <1642175929-25337-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add binding for Richtek RT1719.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../devicetree/bindings/usb/richtek,rt1719.yaml    | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1719.yaml

diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
new file mode 100644
index 00000000..65a93f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/richtek,rt1719.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Richtek RT1719 sink-only Type-C PD controller bindings
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT1719 is a sink-only USB Type-C contoller that complies with the latest
+  USB Type-C and PD standards. It does the USB Type-C detection including attach
+  and orientation. It integrates the physical layer of the USB BMC power
+  delivery protocol to allow up to 100W of power. The BMC PD block enables full
+  support for alternative interfaces of the Type-C specification.
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt1719
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source:
+    description: enable IRQ remote wakeup, see power/wakeup-source.txt
+    type: boolean
+
+  connector:
+    type: object
+    $ref: ../connector/usb-connector.yaml#
+    description:
+      Properties for usb c connector.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - connector
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt1719@43 {
+        compatible = "richtek,rt1719";
+        reg = <0x43>;
+        interrupts-extended = <&gpio26 2 IRQ_TYPE_LEVEL_LOW>;
+        wakeup-source;
+
+        connector {
+          compatible = "usb-c-connector";
+          label = "USB-C";
+
+          ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+              reg = <0>;
+              endpoint {
+                remote-endpoint = <&usb_hs>;
+              };
+            };
+            port@1 {
+              reg = <1>;
+              endpoint {
+                remote-endpoint = <&usb_ss>;
+              };
+            };
+          };
+        };
+      };
+    };
+...
-- 
2.7.4

