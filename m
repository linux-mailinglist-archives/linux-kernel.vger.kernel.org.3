Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE04AC365
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359407AbiBGP36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443965AbiBGPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:16:22 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A944C0401C3;
        Mon,  7 Feb 2022 07:16:21 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y5so12541149pfe.4;
        Mon, 07 Feb 2022 07:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mv9y2F1yD1R3tg/trx+ktowkw03PiJgNgeaAhqzGrdM=;
        b=px9rtIJBp/sp3d43XjV+LbVY60RIlnbv0f98TkounsLIXGnzaJgt3czSjf/fRxGGZh
         utJTQB/5WXF+gdkixnvv77ygVzPyZjGQKHfnAMADn2sSBAq41oO4iT9y4UzM0i3qs8ZG
         v1m/JFa0ebM4oDhFvaAjdUt9jpgpNmdBCVAsGBMNAmrO4gKZDU1r2Mds5fLFxky7mt6E
         T/jRfJu3fFNrD5QSPvsCOY4WXBIYPskgsuHUp9ze2CYykNQC8xmWZhiumUVZ5UTtIvfP
         e7JxBaN0aiIkXkI9cOADKwI1gSPgd71CU1XVBlZpS7P7ce7bLKXo1mg7QoqIrNyff6mo
         c0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mv9y2F1yD1R3tg/trx+ktowkw03PiJgNgeaAhqzGrdM=;
        b=NClNRgh3I9PjlUyyo1XSbfHlCezWAnW4m0M/V0ubxgZcklGjG6KGnrF0u6GcnOyri/
         EpcIOiYrx7dekHyZUBvZ3SMlup+Te4UJTYw5QBe5Vyc+g7jml1IFwdbPcCmn6uftKtpE
         MsWVi5HqCJsVZdWn9KUtPCxdLebkAtJ36dS7OIEoZer81mAqNs1lmdscASML02LhWO1I
         YdxCRTq+9cXypZwWAxLt6LwHO+oa1X+YpIuX/4D9T+XBAqvn24mL/sQjT6BSeuinP8f4
         xZJ/SfXd8dPL490EZEmKdpcaRrd668mBUy6wkBAXvWj6I3ld9DTWPm8L2ID73KewNkS2
         ADHA==
X-Gm-Message-State: AOAM533N/xQeCAeEAVCR6K7asb2xByVFusAFZN75E5W0BOTX74h0sZp6
        WRIA8l1JnaNGKxiBZjgXCG8=
X-Google-Smtp-Source: ABdhPJzvSFN5ZKWfkzCvgR9wxE8yAclgNxt/wiDMTa6p0uG05iO2ptTTQHQ/9W48t7SOOx4zhQlFgA==
X-Received: by 2002:a63:d80b:: with SMTP id b11mr9935806pgh.189.1644246980782;
        Mon, 07 Feb 2022 07:16:20 -0800 (PST)
Received: from localhost.localdomain (1-171-11-6.dynamic-ip.hinet.net. [1.171.11.6])
        by smtp.gmail.com with ESMTPSA id f2sm11896172pfj.6.2022.02.07.07.16.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Feb 2022 07:16:20 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, will_lin@richtek.com, th_chuang@richtek.com
Subject: [PATCH v3 1/2] dt-bindings: usb: rt1719: Add binding for Richtek RT1719
Date:   Mon,  7 Feb 2022 23:16:09 +0800
Message-Id: <1644246970-18305-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644246970-18305-1-git-send-email-u0084500@gmail.com>
References: <1644246970-18305-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

