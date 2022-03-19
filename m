Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5C34DE509
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 02:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbiCSBvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 21:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241755AbiCSBvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 21:51:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E0820D50F;
        Fri, 18 Mar 2022 18:49:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w8so8424506pll.10;
        Fri, 18 Mar 2022 18:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=moxQH/5GYRIbsc/8AKQx2qh3I5bIs+nakr/Ejmr6/S4=;
        b=Hf4V4O0nyrxaWwXn1JcsFtzCsKPTj0+gV/PEPizRUnE3VMkEGoMfA8ucK5J7yQxtJA
         DqAg27FJjuTivtU8BtlYWlupMAZYxNMArUgxH16Huup+EiXICCduCcW6g3nCbuZnj6UA
         Dbr9w6r3xa1N9LVopuPYixgO5FRP3wMvBDjCiTFiPypn+vf7KNkLOGzKEyCwPDyo+DoY
         HybfatMG1NJhpqAng/DvB6BfUYTUjJH2bAGScEi96wddZzq/dbg4xCIMvCoaZXSHBeA0
         lHzD4YfnM3B6GJYLNRyVZIXCggU78jhjOyin6sVSwggntrlZPWWT/x9ted8kd9sy0YBF
         yMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=moxQH/5GYRIbsc/8AKQx2qh3I5bIs+nakr/Ejmr6/S4=;
        b=tAUct71BZnHgv7naXfj8c0XmvDL5clBecL1pAXHgh3gABvCgmGobh/P7g8xlVnCKdJ
         QvEci4djx18skzr/C6kNdooorr9VNEOX+Odf/4QPjkam81xyjXeJWlNEJzaRx6GadAbG
         p6UI7iiAPnXyg/f1BrWvf4Rm2Anm4vG1wjL7lLFPbQjYejYdblDWmi2W8Fr5OCpNpsxg
         uru9fJEXDVKfEMJiV1auwveo0VZA564uiLz+94b8vTGa09+gAQbM5gaBzHErMJ4ZGToV
         IbL5w0b5IGrktfetGQxo/oARJqZyoyRyBFIXQyXn+L0aku/FHOEPMCsenBwtt38Yh3ra
         q+sA==
X-Gm-Message-State: AOAM532RVVOrC8R9XqWteFS9vR7WfjIAMlVa58OohNAUGlkuLTc1oC1l
        IL99jRHhoU88Izt5q3j8ZoI=
X-Google-Smtp-Source: ABdhPJzyquBLWtjH8pTsVs/SPV2w1lxKDSoC6D+AHieVfkszD6+etipAsicj+AVQwJHTKQGGYH//ng==
X-Received: by 2002:a17:903:1206:b0:151:7d67:2924 with SMTP id l6-20020a170903120600b001517d672924mr2329770plh.45.1647654596547;
        Fri, 18 Mar 2022 18:49:56 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h13-20020a056a00230d00b004f427ffd485sm11738659pfh.143.2022.03.18.18.49.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2022 18:49:56 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, lhjeff911@gmail.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v4 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Sat, 19 Mar 2022 09:50:11 +0800
Message-Id: <27dba330ec0c1cd7edbcec53083f78169713a42e.1647652688.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
References: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
References: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmc yaml file for Sunplus SP7021

Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v4:
 - Addressed comments from Ulf Hansson.

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       | 79 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
new file mode 100644
index 0000000..13ed07c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Ltd. Co. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sunplus,mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: sunplus MMC controller
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+maintainers:
+  - Tony Huang <tonyhuang.sunplus@gmail.com>
+  - Li-hao Kuo <lhjeff911@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sunplus,mmc-v1
+      - sunplus,mmc-v2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  resets:
+    maxItems: 1
+
+  max-frequency: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mmc0: mmc@9c003b00 {
+        compatible = "sunplus,mmc-v2";
+        reg = <0x9c003b00 0x180>;
+        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x4e>;
+        resets = <&rstc 0x3e>;
+        bus-width = <8>;
+        max-frequency = <52000000>;
+        non-removable;
+        disable-wp;
+        cap-mmc-highspeed;
+        mmc-ddr-3_3v;
+        no-sdio;
+        no-sd;
+    };
+
+    mmc1: mmc@9c003e80 {
+       compatible = "sunplus,mmc-v1";
+       reg = <0x9c003e80 0x280>;
+       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
+       clocks = <&clkc 0x4f>;
+       resets = <&rstc 0x3f>;
+       pinctrl-names = "default";
+       pinctrl-0 = <&mmc1_mux &mmc1_mux_cd>;
+       max-frequency = <52000000>;
+       disable-wp;
+       cap-sd-highspeed;
+       no-sdio;
+       no-mmc;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7..2d91431 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18242,6 +18242,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS MMC DRIVER
+M:	Tony Huang <tonyhuang.sunplus@gmail.com>
+M: Li-hao Kuo <lhjeff911@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/sunplu,mmc.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

