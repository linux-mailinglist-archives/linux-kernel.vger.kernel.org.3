Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AA64CE978
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 07:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiCFGLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 01:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiCFGLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 01:11:15 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E6447571;
        Sat,  5 Mar 2022 22:10:23 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t14so10955245pgr.3;
        Sat, 05 Mar 2022 22:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IFP0n3aR1KLrugHWvaTBlE8oeqir0qwrjSN1W4oR8A4=;
        b=LutdSF7TOGs9m0nw/abVQLroRBIkivCxvs6RTvSJbASkCA5qJ/eA67aCcCtwtTjQJx
         DX35hdPLW3DY/whBS9xo8PGCJqxym+u83naFZoF7W7dgBq4JYzh/y+keHZGnqISOI5FD
         ieAbgQRDiHj15tFxN1Q2730SAIGpme19UhzBG+hEVwADld6q/zCb/ugFLljw4401FIyG
         WS7UmejkwMMrib6R5PZGyo0hq1jYrX8TumfCSuLmnzHMGzmQPLR7mm3jDQEODvcjXmbu
         4VLRZ00c0vOloumUhVGXP/5SWnRrE2KYNUqkXf8iumu34xdm4uFrqwmIK7nv89CTXfb0
         nkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IFP0n3aR1KLrugHWvaTBlE8oeqir0qwrjSN1W4oR8A4=;
        b=vzGv2iFq9OljeM53ppkeELn4MwVMk/Yt2tHfqGnqFYNHj2RHTneEe8rvc1ybhmpW9V
         FzXzpgR4SrYBuBnbM62KJo8+50xn2nScQf2IOmHMTFBxGC9ex0/cRmxegSwl/AIvDltU
         GXBqRPuvj2YWi3elz3PaIaAf7hp6t39zj7fNFUYH7+v9gu4z2QqeDdn4TnMnv9I0YcbR
         bB8BO9mvF/wi2J8CFI4a4mD6xWpOAOIs6jYFHwOBnVDRB0g0BPVLbWyPMBb9ghiGUj39
         /rpR6CihMmMeZMpeE5YulQ3to4iwZSp/tbAMw0lzjjtiPUJK9UXoQ1ew1z4l8G5rqUsy
         Yjpg==
X-Gm-Message-State: AOAM531QpAhZWv02cQNc5oMlR9q/0nAyDgfNOp7IALY81ztsKNOIWyVA
        cgzk/FfrX1Q8q93oKp5q0Yc=
X-Google-Smtp-Source: ABdhPJxV26u+wQtug7E3G5n/M1Gwls9RdmZzpeT486WpZCawBt9nzrdidxecQW//rxYRhRK9jIvbWg==
X-Received: by 2002:a63:2c53:0:b0:373:7234:adf2 with SMTP id s80-20020a632c53000000b003737234adf2mr5141415pgs.111.1646547023418;
        Sat, 05 Mar 2022 22:10:23 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id q13-20020aa7982d000000b004cb98a2ca35sm11994907pfl.211.2022.03.05.22.10.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Mar 2022 22:10:22 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v3 2/2] dt-bindings: usb: Add bindings doc for Sunplus EHCI driver
Date:   Sun,  6 Mar 2022 14:10:36 +0800
Message-Id: <1646547036-14885-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646547036-14885-1-git-send-email-vincent.sunplus@gmail.com>
References: <1646547036-14885-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus EHCI driver

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v2:
  - Address the comments by Rob Herring.

 .../bindings/usb/sunplus,sp7021-usb-ehci.yaml      | 63 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml

diff --git a/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
new file mode 100644
index 0000000..905f68c
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/sunplus,sp7021-usb-ehci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 EHCI Controller Device Tree bindings
+
+allOf:
+  - $ref: usb-hcd.yaml#
+
+maintainers:
+  - Vincent Shih <vincent.sunplus@gmail.com>
+
+properties:
+  compatible:
+    const: sunplus,sp7021-usb2-ehci
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    minItems: 1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - resets
+  - reg
+  - interrupts
+  - phys
+  - phy-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    sp_ehci0: usb@9c102100 {
+      compatible = "sunplus,sp7021-usb-ehci";
+      clocks = <&clkc 0x3a>;
+      resets = <&rstc 0x2a>;
+      reg = <0x9c102100 0x68>;
+      interrupt-parent = <&intc>;
+      interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
+      phys = <&sp_uphy0>;
+      phy-names = "uphy";
+    };
+    ...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6c2faf3..4e66993 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17951,6 +17951,7 @@ SUNPLUS USB EHCI DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
 F:	drivers/usb/host/ehci-sunplus.c
 
 SUPERH
-- 
2.7.4

