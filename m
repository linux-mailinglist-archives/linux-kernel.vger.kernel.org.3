Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AB14BF4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiBVJgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiBVJgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:36:15 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A520156C72;
        Tue, 22 Feb 2022 01:35:51 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i21so11408504pfd.13;
        Tue, 22 Feb 2022 01:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dL00Rc7i4BCQHnFJlrrkxtKzlW2CRo4/ZoNhebCJ534=;
        b=DrmWCbo/w6IhgfezkJYWyyLx8BFcZZ0KCVahJA/Zt7XUDtBGWZxmr4STcbjSWSIcuY
         86jFeolxu3DXPIa9KTZ5cvYA/K/ghAYjfk/a9CT8OnGezxIVTzIbdlFYouvd/KskiJFx
         fVb3PTWqF5JxfrKo3CCbTwOff6qETR1H4w0v4wb4AfbAA3wpOF2qn1/VJMeuPyJ45W97
         Tv6ZAdWUrspHFV4kBHx9/38Jl3JU8KasPx/6XFEod/eZvBQ19BamzLRcZHQvEClldZ5o
         +2vOfncWmsdfzPQUThfoP1ur00QCAkA4bxYSkDrvm7B0Jne9D9CtG2c8Cv4J3ZiD9OxI
         4dFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dL00Rc7i4BCQHnFJlrrkxtKzlW2CRo4/ZoNhebCJ534=;
        b=iZOND/fx9kjwq3vZBFjEywaDrNyYpLamj85XM535aar9Kzoz40eYYna7sWlAiJ7loi
         82F+xbMPwxcUOhf+mw6FOi1Tx9026xexwkhfWMPIMqBV2YtwB+Q3WeIx89f/V9g+RZ0V
         o+6PmDR9iGsOv0aRz/wvWzgoYZw6efcE3mw4zzujaP02oUL3TfpDEplDPHxOM+kBrRnN
         evpetgHZMHuhv5ZCoYaW/vf7b/mhJsiGALIgx7FZ5C5esuqNhk0Z9OaCP9Z8ymfCb/Ll
         Y1hsAl9PXMFFWVllUVvK7B4mVEUPEA06Rirt0oZ66MkbnanRurGNg+p3NLv6SMWcsnHP
         l4Ig==
X-Gm-Message-State: AOAM532fp4YOQrCOmLEC0GJQcSuzbRwu0GBeQ8I7ngCCwuOMA8UzVeuG
        vNUT5+CFBd+qrxlUPKSdzkDOgsshcRkoow==
X-Google-Smtp-Source: ABdhPJyBExwaMv9npybFo9TKd9/qTt6y4Ufn4ohzpOZZGuAZD3FLS7rs+jLQFU8JKfwBgVGEEGvZ0A==
X-Received: by 2002:aa7:88ce:0:b0:4f3:645a:5bd7 with SMTP id k14-20020aa788ce000000b004f3645a5bd7mr343869pff.57.1645522550612;
        Tue, 22 Feb 2022 01:35:50 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h20sm15390650pfq.162.2022.02.22.01.35.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Feb 2022 01:35:50 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v9 1/2] dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
Date:   Tue, 22 Feb 2022 17:36:02 +0800
Message-Id: <1645522563-17183-2-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645522563-17183-1-git-send-email-hammerh0314@gmail.com>
References: <1645522563-17183-1-git-send-email-hammerh0314@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus SoC UART Driver

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
---
Changes in v9:
 - Addressed all comments from Krzysztof Kozlowski.
   Modify incorrect indentation.

 .../bindings/serial/sunplus,sp7021-uart.yaml       | 56 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
new file mode 100644
index 0000000..2e9b64a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/sunplus,sp7021-uart.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Sunplus SoC SP7021 UART Controller Device Tree Bindings
+
+maintainers:
+  - Hammer Hsieh <hammerh0314@gmail.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: sunplus,sp7021-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    aliases {
+        serial0 = &uart0;
+    };
+
+    uart0: serial@9c000900 {
+        compatible = "sunplus,sp7021-uart";
+        reg = <0x9c000900 0x80>;
+        interrupt-parent = <&intc>;
+        interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x28>;
+        resets = <&rstc 0x18>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..3c1362e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS UART DRIVER
+M:	Hammer Hsieh <hammerh0314@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

