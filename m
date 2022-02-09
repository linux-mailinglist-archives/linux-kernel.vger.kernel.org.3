Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA984AF389
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiBIOCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiBIOCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:02:42 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3288C0613C9;
        Wed,  9 Feb 2022 06:02:45 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v4so2224505pjh.2;
        Wed, 09 Feb 2022 06:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yJrfR7q8GnKt9qUvxZaOkHB0rvLlyhWEjJC7FUXAPFo=;
        b=Ua1vFsn/467kDPorT44ESFNPzBGrDOpJsqnliNrPnd3efhxIglmKdtBxkVZ6TEZQ+N
         2RA2xQKOpTcjZzWZC9dgXZgpopz+Mfjstaz4WanM9yil+x2SdS8+yU0ojYgWaSvnOJPJ
         N8U1yYDK3a8R5GzizqLejrX+7q7obfhNr4nS/yxxzUAUPqAbKApl9VAog2T5fCR4tS61
         scLsw1FceY+LH8t88elqLRC0YSdnIf+uBxj8P7rVc6FbIniOJu/HcLpIbbOL9FsOXkxp
         pOBQw6+xzot0S0VdvqwOY23Rf8nBtsW/wUizmbtylh18zRSHJ1W7Xhk6aAnoSCk0drw+
         T1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yJrfR7q8GnKt9qUvxZaOkHB0rvLlyhWEjJC7FUXAPFo=;
        b=T6RTWHBdpl05l7vI464tMiPVfSJ4Es6+SC8MWwuwVX3eIaX12xrJPHF1qa0rwUTn7h
         kGNRt9aHTbnY4nZ1eIDe97nLkDmX5bYn0WBUMQhy3MiSUz4F6lxtzpsOXT0Qypj/Dzqj
         j4RVnxQaUJYWu4y4tCEqo6Cmty6OsxlPZXM8YTCp0ifSMJJ9ZlLoeqFMYZW9RwySjyel
         3+Py6uRFozKPEqXsTE+gdYhGdWCH9o7OasaT3UmkbEKnIvO+/08eG6Yw22mdi23erVqI
         /0ScsRth6ysDBI21F7it4hSa4bsTVdeoCX7/O2QYM6lTJiPD/JqGW/e3AM9CX4Ercnps
         /qSw==
X-Gm-Message-State: AOAM533IwnndoqJ2CfMTXZuU0R2ktKlTdrcm69vT+QolgDh3khiAwvy2
        6DZ/78/HAvlkMAwbDNID6+s=
X-Google-Smtp-Source: ABdhPJxUIV/Ufd2HM+fZ/ih+rPk8KxbJnd72Hm2B2zg1ugI3kKiTti+FJhPPAtaOTT2SBu+gELBZ/Q==
X-Received: by 2002:a17:90b:3b48:: with SMTP id ot8mr2658547pjb.167.1644415365253;
        Wed, 09 Feb 2022 06:02:45 -0800 (PST)
Received: from localhost.localdomain (1-171-21-84.dynamic-ip.hinet.net. [1.171.21.84])
        by smtp.gmail.com with ESMTPSA id j8sm6177178pjc.11.2022.02.09.06.02.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Feb 2022 06:02:44 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, cy_huang@richtek.com,
        will_lin@richtek.com, th_chuang@richtek.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: usb: rt1719: Add binding for Richtek RT1719
Date:   Wed,  9 Feb 2022 22:02:34 +0800
Message-Id: <1644415355-24490-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644415355-24490-1-git-send-email-u0084500@gmail.com>
References: <1644415355-24490-1-git-send-email-u0084500@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

