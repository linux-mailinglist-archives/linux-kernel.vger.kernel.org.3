Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8254BD39E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbiBUCPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:15:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241988AbiBUCPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:15:08 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566653205E;
        Sun, 20 Feb 2022 18:14:46 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h125so13020054pgc.3;
        Sun, 20 Feb 2022 18:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CpQoC6BpaQ14c8xpHvHSZfO/e4PX8wXeyUZwi9sox80=;
        b=bgvNe3kQ//S7lucUEpvSPYe/st8Gtsl1WbAuYNEm2n8nYzVkHXW0q6g6AC15SqJc3E
         YcyLO/IVedq/r75R8oFOiAghWVuZLeC1oIaRz272Il1T/UrIGF8TwNXtdQvtMr9T/rDY
         k35+BHRbnK2xkz/0++t3S69bMpNpeQ9WvOU/Su2+FH4mZmtT4y43uSvr/oYnnBsdii2R
         P7kqT+2WSakl6F/dk97C481XfOqJhQB/9znqbHN8EhuKVUJM3fpgtPNhF/XuTrBhb18b
         oB3WlZNe673evBVz8FJLi5TlUrDjwl7sOKajkAQwSuA139eiD/ZvrG5oanRJQACjKs2h
         WyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CpQoC6BpaQ14c8xpHvHSZfO/e4PX8wXeyUZwi9sox80=;
        b=sxw0uSJ/AVf1uQOU7eHCJT4uHQrSEJR1LG/wa2bH6hQB9RUtTq0LfXigL1E/t0jkgn
         uukD9kU6sNc7xNK2YpZwEUL7cf0SPpzP1Wnx3EkOHHjy0viDFPImeNywKpLwfr/2kpWq
         6pZ1WX7CZLdsfCU+G+gpb3ULDzRU8EQ8u7S3Tyn7VMySUu0DaBIsnX8jvA7tdAtsuhJV
         PtjX41OWEepwUCw35FNls1nPmqTtlTEeJ1ED4n5Id2DoZs4N+c9eG94eg6E+z6H24esU
         CLVzLAlVOA657Z6MUW6wfD5aOByoKduvfKrHiAB4wHq+I6/TQwEDZvEzNp5uLkwy6UvP
         Z6pw==
X-Gm-Message-State: AOAM533unSVL9eAcgnOWNvcrUEL9o3ShzPwiuXWjn3owG68cbPfyORTW
        mZvnLD2bPHvHGvPj+Y3fBZshHnHlIqA=
X-Google-Smtp-Source: ABdhPJzhziFFGmsHdbx/3lmTyEB1y/pNhr8R449KpOvgnIvxWyg0vuZTakzdrctIMZeoRuvAvqTwQw==
X-Received: by 2002:a05:6a00:1494:b0:4f0:ece9:a01c with SMTP id v20-20020a056a00149400b004f0ece9a01cmr12721963pfu.58.1645409685888;
        Sun, 20 Feb 2022 18:14:45 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id s48sm10022908pfw.111.2022.02.20.18.14.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Feb 2022 18:14:45 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, wells.lu@sunplus.com,
        tony.huang@sunplus.com
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v9 1/2] dt-binding: misc: Add iop yaml file for Sunplus SP7021
Date:   Mon, 21 Feb 2022 10:14:54 +0800
Message-Id: <c71cd993d19db9ea7fb5f0172a8b0da5fb2a843c.1645407997.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1645407997.git.tonyhuang.sunplus@gmail.com>
References: <cover.1645407997.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1645407997.git.tonyhuang.sunplus@gmail.com>
References: <cover.1645407997.git.tonyhuang.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop yaml file for Sunplus SP7021

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v8:
 -No change

 .../devicetree/bindings/misc/sunplus-iop.yaml      | 76 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml

diff --git a/Documentation/devicetree/bindings/misc/sunplus-iop.yaml b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
new file mode 100644
index 0000000..b37e697
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
@@ -0,0 +1,76 @@
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
+    items:
+      - description: IOP_INT0. IOP to system Interrupt 0.
+                     Sent by IOP to system RISC.
+      - description: IOP_INT1. IOP to System Interrupt 1.
+                     Sent by IOP to system RISC.
+
+  memory-region:
+    maxItems: 1
+
+  wakeup-gpios:
+    description: When the linux kernel system is powered off.
+      8051 is always powered. 8051 cand receive external signals
+      according to this gpio pin. 8051 receives external signal
+      through gpio pin. 8051 can power on linux kernel system.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - memory-region
+  - wakeup-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+    iop: iop@9c000400 {
+        compatible = "sunplus,sp7021-iop";
+        reg = <0x9c000400 0x80>, <0x9c003100 0x80>, <0x9c000000 0x80>;
+        reg-names = "iop", "iop_pmc", "moon0";
+        interrupt-parent = <&intc>;
+        interrupts = <41 IRQ_TYPE_LEVEL_HIGH>, <42 IRQ_TYPE_LEVEL_HIGH>;
+        memory-region = <&iop_reserve>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&iop_pins>;
+        wakeup-gpios = <&pctl 1 GPIO_ACTIVE_HIGH>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7..6f336c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18242,6 +18242,11 @@ L:	netdev@vger.kernel.org
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

