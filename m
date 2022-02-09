Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8CB4AF597
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiBIPmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbiBIPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:42:50 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163BFC0613C9;
        Wed,  9 Feb 2022 07:42:53 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso5578337pjg.0;
        Wed, 09 Feb 2022 07:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yJrfR7q8GnKt9qUvxZaOkHB0rvLlyhWEjJC7FUXAPFo=;
        b=IDPE2YMly8HBUgp9RTD23ztMUTExn80ApQBnhnBT9J6CzmsOFWlJKXQt5RwhW6J2xZ
         2VmGD8dMzqSXotODirKVCBDdgzAfHbhHJ8n75U2GYwF5FykekB7dxxLsz+n/E9hxcLTW
         KTVTD25rV/daTDjMvPOJsqp5XJgX8khw5wuLdBJtoii7RGfOI8zdW49dG9jYOrs8d6Hd
         ZWSgQB8dPV/wa3r9vJN6X+B3wjVjiyYY6XibhCwHWcvLkkFgdeCgYkAHVw7dRDArqM/C
         lz+Ifafqfk24gGFb3g3eU/SC6Ya6zQVyW3v8PHVyiZuA7kPctqARDHjHCUe4Y7k33WVu
         t+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yJrfR7q8GnKt9qUvxZaOkHB0rvLlyhWEjJC7FUXAPFo=;
        b=W4VodhcLohwr7o15RvI235QwSfiA4CTP4eLGpVVjXcyqlHRA5JfvaSa6cETNLm3FbH
         VUl04an/iVJ5A/3wKwoypJgoCPoi4+XxjestktlFg/ZpIjKzm3laBKA5LIUZ2pbmfyxP
         JTl1wmzj0g6UYdIRHyZcOdbjVzvc1e1OdKb2I8wqhqN+7zM3q9Lt4EhSZw8yZt6ew5sH
         /kxmD1pJywJZWuRJDY2e6u0KbujpFNmie/MUk6GP6X3luIOLUza58E0b5dZcNT4cJT+d
         dwbkhKBpomfyVCBGJrxtLRVdV6k5ID0LBQBmuJQbZEIUJT5hrp8aPeEZHTsgc0vvr6qb
         J7wA==
X-Gm-Message-State: AOAM531brXGAlAg1puXwCX6j1FekgWbEWdbrPArdPslKq7EDEp8v9nux
        3MHRM/vO/7N2XE8OBnMtQMs=
X-Google-Smtp-Source: ABdhPJyA8J3rHr2ynIW7zPbjUJ227dX4HmkFzRHHBV0OwpaVVWX8OuaTZkb314WY0K+mHWQQPslxJA==
X-Received: by 2002:a17:903:1250:: with SMTP id u16mr2668749plh.126.1644421372492;
        Wed, 09 Feb 2022 07:42:52 -0800 (PST)
Received: from localhost.localdomain (1-171-21-84.dynamic-ip.hinet.net. [1.171.21.84])
        by smtp.gmail.com with ESMTPSA id l2sm20929152pfc.183.2022.02.09.07.42.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Feb 2022 07:42:51 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, cy_huang@richtek.com,
        will_lin@richtek.com, th_chuang@richtek.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: usb: rt1719: Add binding for Richtek RT1719
Date:   Wed,  9 Feb 2022 23:42:41 +0800
Message-Id: <1644421362-32104-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644421362-32104-1-git-send-email-u0084500@gmail.com>
References: <1644421362-32104-1-git-send-email-u0084500@gmail.com>
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

