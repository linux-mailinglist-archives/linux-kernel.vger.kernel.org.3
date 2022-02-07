Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792B64AB4D1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244101AbiBGGgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357495AbiBGF6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 00:58:08 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE40CC0401DE;
        Sun,  6 Feb 2022 21:57:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so12366987pjb.1;
        Sun, 06 Feb 2022 21:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gJJl6zWjnYTAK0xTlfcSjoJKSlxcelJDvZmIajlJ8+s=;
        b=IheDGIHjXcQPPBv/nVbkTyR/D69am//ID7NHIUze/VYmD+TDXndRY410ceEhgy2UBF
         XwJjIoxPg+AdOp8x4FMSFS2hIpL5tlLQcTCPklSRmlDpbLja8YrGvvg1ulPCySrv8wMf
         Q8BvWuY31Fp6/CrIjO/dQFo89V7cUdwQh4qXW0Tnt0Lw5Gke9e8Rrt2zbDsdxYVkvm5s
         tsi/FMMukXobROLoKUXXNWbIpiT9Is2aJG+Tn9OuVmfGN1OUBiVgTECAQZhk++DvG8OT
         mPOEL431lTGcnAPkYxXowNukvftPynwPGWJWDwhUOVMOvk8KeMaIcxWaPkc4sqUOdBV1
         63QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gJJl6zWjnYTAK0xTlfcSjoJKSlxcelJDvZmIajlJ8+s=;
        b=Sl8IJLXH+6R0aa71gyZgayc33hliywXYJ4NvZOb6RCd9qfeqkbiWl8hl6HmPnNWfNC
         GM567T8Blx9eGDm5DKXAPiYCi03hpJggGn1eQUhmKBhwCEZMIk/Sd3gHQ/Jypr9M+nnu
         BgKpG5ISHnhwKDAvISbVuBeR5NRFblhz6NBuS3s7/orRsKmYT6ZHWzMwMgfz8AosxXGt
         l63Az5X6GdAhhM4y4RjbRIK1vx61Vs25fyRKHcS26kKaJxMVzfrQ75IVHfUBfWkyeV/3
         dzjqxoIEyXH3pVhjrX9EW2uDvrMCFfObmKDhZR/pzWRYFyl82WYk/HL7h1aa7YynOIGM
         YkGg==
X-Gm-Message-State: AOAM531QHzGmYFlPuQHyNAHHPQByHNORG/Izt8u5jq9TrzX2HAvgLaZh
        vD8fV0lCGgMtEyWNN2HNwMI=
X-Google-Smtp-Source: ABdhPJy51aKwfjwlLv6pqXXmiwaPPRiyIWIRg8WQ+VRfoneGqhqzc2ADVgOiWcVb9BOn8P2ss7hBTQ==
X-Received: by 2002:a17:90a:2c0a:: with SMTP id m10mr16741822pjd.183.1644213472269;
        Sun, 06 Feb 2022 21:57:52 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id g17sm10529264pfj.148.2022.02.06.21.57.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Feb 2022 21:57:52 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v7 1/2] dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
Date:   Mon,  7 Feb 2022 13:58:00 +0800
Message-Id: <1644213481-20321-2-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644213481-20321-1-git-send-email-hammerh0314@gmail.com>
References: <1644213481-20321-1-git-send-email-hammerh0314@gmail.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
---
Changes in v7:
 - no change.

 .../bindings/serial/sunplus,sp7021-uart.yaml       | 56 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
new file mode 100644
index 0000000..894324c
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
+            serial0 = &uart0;
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

