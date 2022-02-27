Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A584C5A53
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 10:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiB0JvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 04:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiB0JvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:51:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC1856418;
        Sun, 27 Feb 2022 01:50:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id bx5so8561552pjb.3;
        Sun, 27 Feb 2022 01:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+J0z+2VbGWbHP6rGd8wdX9Lzj2x3D8xHiqkOFulN3a4=;
        b=C2LX4/9LpjaEMnlHMc+ZvLRO7ofHJZbiPWDzMh9zP4qEadu3sDZbq151E+iHOokH/u
         sKbu+xsIFsFZA9u7LbdwzxQK4NDTuV88YmyWfD21eYD7mg237n76GGbnOLGwDc8pyZzg
         xVcvpgpfaaAd3KshP1d2ZGjC7zJdx6ILe9HCwXHIj3LV/loAt7yqFR2EOUimMIFLJ3kO
         ROUWSKzZOCSsxbwreAKsWyQ10FO9qbwMGhUkUjzcswK5OLzHUg7h23aUUdGZAOXl6IjF
         dPiy/sfvt3V+E63vLlosByJI0i7ZBRy3ZAo1AWFC261v6b1iRx/4UDvRyOqPlkXmUOB9
         vLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+J0z+2VbGWbHP6rGd8wdX9Lzj2x3D8xHiqkOFulN3a4=;
        b=O6qumyoMfTYnBTC8BLOdOzLTilruHZ9lDJBjvmEP1Q6AttphCjfZhy2+QfrMCSh4e+
         +Cfp+biBTiG6VI39lHs9NwKdd38iHokq4HCmqt9zdWw8uxC5TzBaldfu1LHLdbpwB4HZ
         3F7sAlSc571BUX5jDAVRB8JhJgK4pgVPArm5g6cpufUYB0Q+R2TNnWoxvpYF2KeiueC6
         XgjdNUrUF5oJwZMEX3g0xK7Ba3qajIXLtcSlPtLx4pRuIkt0zcIk2IXN6aB8mk/UpkMS
         S6F+7aYOqX75tmYQGUE9/WjrSsTuUBGRHPXFnVBlzIjVXMKHf5KCkKI5561Dg/LlVshK
         B85A==
X-Gm-Message-State: AOAM532zgkHL1XJ4OmQbOe7bwizTSZI0f+2RNWttGULwkMKvI1b9BEWy
        4pYMTePlUK/J0DYoeyjizyg=
X-Google-Smtp-Source: ABdhPJwIIBwDAad1HU//zf9bsa7CgrjTz7WG2aL02iMFHlsZbsI9lVG1DMV3LVsBhTReaFKa6YzrEA==
X-Received: by 2002:a17:903:32c1:b0:14f:8ba2:2326 with SMTP id i1-20020a17090332c100b0014f8ba22326mr15427622plr.34.1645955430721;
        Sun, 27 Feb 2022 01:50:30 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id o185-20020a6341c2000000b0036fb987b25fsm7473334pga.38.2022.02.27.01.50.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Feb 2022 01:50:30 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: usb: Add bindings doc for Sunplus EHCI driver
Date:   Sun, 27 Feb 2022 17:50:41 +0800
Message-Id: <1645955441-6496-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645955441-6496-1-git-send-email-vincent.sunplus@gmail.com>
References: <1645955441-6496-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus EHCI driver

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
 .../bindings/usb/sunplus,sp7021-usb-ehci.yaml      | 97 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml

diff --git a/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
new file mode 100644
index 0000000..e492f7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/sunplus,sp7021-usb-ehci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 EHCI Device Tree bindings for ehci0/ehci1
+
+maintainers:
+  - Vincent Shih <vincent.sunplus@gmail.com>
+
+allOf:
+  - $ref: usb-hcd.yaml#
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-usb-ehci0
+      - sunplus,sp7021-usb-ehci1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: usbc_clk
+      - const: uphy_clk
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: usbc_rst
+      - const: uphy_rst
+
+  reg:
+    items:
+      - description: USBC register region
+      - description: UPHY register region
+      - description: MOON4 register region
+
+  reg-names:
+    items:
+      - const: usbc
+      - const: uphy
+      - const: moon4
+
+  interrupts:
+    maxItems: 1
+
+  nvmem-cell-names:
+    description: names corresponding to the nvmem cells of disconnect voltage
+    const: disc_vol
+
+  nvmem-cells:
+    description: nvmem cell address of disconnect voltage
+    maxItems: 1
+
+  port-num:
+    description:  identify ehci0 (port0) and ehci1 (port1)
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - reg
+  - reg-names
+  - interrupts
+  - nvmem-cell-names
+  - nvmem-cells
+  - port-num
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    sp_ehci0: usb@9c102100 {
+      compatible = "sunplus,sp7021-usb-ehci";
+      clocks = <&clkc 0x3a>, <&clkc 0x3d>;
+      clock-names = "usbc_clk", "uphy_clk";
+      resets = <&rstc 0x2a>, <&rstc 0x2d>;
+      reset-names = "usbc_rst", "uphy_rst";
+      reg = <0x9c102100 0x68>, <0x9c004a80 0x80>, <0x9c000200 0x80>;
+      reg-names = "usbc", "uphy", "moon4";
+      interrupt-parent = <&intc>;
+      interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
+      nvmem-cell-names = "disc_vol";
+      nvmem-cells = <&disc_vol>;
+      port-num = <0>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6c2faf3..49702c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17951,6 +17951,7 @@ SUNPLUS USB EHCI DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
 F:	drivers/usb/host/ehci-sunplus.c
 
 SUPERH
-- 
2.7.4

