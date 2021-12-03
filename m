Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34F04670E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378394AbhLCDwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378362AbhLCDwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:52:39 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3580EC06174A;
        Thu,  2 Dec 2021 19:49:16 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z6so1186920plk.6;
        Thu, 02 Dec 2021 19:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YKtQ6SncCNBAFcWPAbwHcmd4XzFO9RB7XJ7rFBG0cKg=;
        b=eWF4FI4Mzf3QLuCKMIPjFUlINNsDLCchYjhVDWVRXYfWWRJMknsBvSMGAuoDCubTlG
         WJJvxS2GFl527F4SdAFufLPzWCf4Z6oU7QBkdwztwLPegPyw3WIV60Y/ndfIGIm00lvd
         zgTFCrZIheYybBLgnQ54DyB076jMyWt6fReCQv0IioF/QW26BGu6/PcqVaKqJleDdfh9
         7DbscMHN6rQtv/B3+B91tqgNpG/H27GwCwYYeD1qAvxj8qc5OpxBrjVj4yl/dS9NqM0x
         bwm+1ynPzpTyyihgWHVb0cqHd7gma6K4PWj20kws0JPzY9sheqPtnLtz5y1i3l8rm2ka
         aoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YKtQ6SncCNBAFcWPAbwHcmd4XzFO9RB7XJ7rFBG0cKg=;
        b=UNke7kW97EYSy8t4o6IhbRllC9NaVdouM+ncTiRcWVPX6JtUlO0eBD9lfpPYNh3zpA
         Yq9KOxETt3/rqGIwPpMgOW1+/fD8svh8ibY1XN3GEtI7+VG2WmDJc9WmhWsuhphfSUhQ
         iLiRl3WHiDfx4ziUsZAGQ76xph7LpiXmbJHM4vBtXES8RFAyRUNBgAY02CgH07x73uMJ
         kWOu4i3ZCBktuyPbvpbGvz4HCwmFxfCmTT++maKyIQyndquTCTh8gDd+LKTwW0Vg5mDb
         ezCHfBIwdqWkD/92QU0oxPUS2mC1uXObdBSYKuKHpxJQH0fX/gRU+IwEC9GgtWNur2ly
         IU0Q==
X-Gm-Message-State: AOAM5308lBr+yHXegyrPuSg1x/up16AAJZJyxHUjIs4wp9FU8gA5cx7k
        mtVRxADQ7BLGO5h+La8G3v4=
X-Google-Smtp-Source: ABdhPJx2EkhgqkAuGG0pjEj6SjgVYNZ8DHCRdt/V7VMp+HTs+yk6cxo7jpMVz/017qldRzYUr5lyiA==
X-Received: by 2002:a17:90a:e7d1:: with SMTP id kb17mr10940775pjb.124.1638503355803;
        Thu, 02 Dec 2021 19:49:15 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id oj11sm4022039pjb.46.2021.12.02.19.49.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 19:49:15 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v2 1/2] dt-binding: misc: Add iop yaml file for Sunplus SP7021
Date:   Fri,  3 Dec 2021 11:48:44 +0800
Message-Id: <1921f2f6f792db155364250fc455fe8497480190.1638499659.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop yaml file for Sunplus SP7021

Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v2:
 - Added moon0 register in yaml file.

 .../devicetree/bindings/misc/sunplus-iop.yaml      | 61 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml

diff --git a/Documentation/devicetree/bindings/misc/sunplus-iop.yaml b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
new file mode 100644
index 0000000..07cdbde
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Ltd. Co. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/sunplus-iop.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus IOP(8051) controller
+
+maintainers:
+  - Tony Huang <tonyhuang.sunplus@gmail.com>
+
+description: |
+  Processor for I/O control, RTC wake-up procedure management,
+  and cooperation with CPU&PMC in power management.
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-iop
+
+  reg:
+    items:
+      - description: IOP registers regions
+      - description: PMC registers regions
+      - description: MOON0 registers regions
+
+  reg-names:
+    items:
+      - const: iop
+      - const: iop_pmc
+      - const: moon0
+
+  interrupts:
+    maxItems: 2
+
+  memory-region:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    iop: iop@9c000400 {
+        compatible = "sunplus,sp7021-iop";
+        reg = <0x9c000400 0x80>, <0x9c003100 0x80>, <0x9c000000 0x80>;
+        reg-names = "iop", "iop_pmc", "moon0";
+        interrupt-parent = <&intc>;
+        interrupts = <41 IRQ_TYPE_LEVEL_HIGH>, <42 IRQ_TYPE_LEVEL_HIGH>;
+        memory-region = <&iop_reserve>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..071b5e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS IOP DRIVER
+M:	Tony Huang <tonyhuang.sunplus@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/sunplu-iop.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

