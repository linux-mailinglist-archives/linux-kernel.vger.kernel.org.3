Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EA34EAF78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiC2OoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbiC2OoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:44:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815F133E0B;
        Tue, 29 Mar 2022 07:42:24 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l129so6468880pga.3;
        Tue, 29 Mar 2022 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=818SG7IEtTO1VzHi9B3NbBmzpBqVubudS3ZsSfI3EDY=;
        b=ZQqPA18Vz0wdF/+iIR548FV4VWWl2yKLVC+NXyv6lbFDfPXkv4PnZxkv4L6extUTmv
         djgsj1fr823QwrULqmO4TZ4sBzsS4vnPNSpNGyymIDShV39K0yTxmZtRupFb2nKLlD74
         JDjrmcGEYPbXL/UkcZb25WHbIbtDpzdn6hX9NpDSMYahLtW4ZxqihdMo5AOKblPdL+U3
         jzVY/ejdDBsW8Q5InA3jJQtBC2ijpKz6xq/F/kg9Cf5MJjvNQ/LEB+jYF76cJM0RUWVm
         q4wZsdrgZbI/5SeEoUoADOhsGuql9Cr9go334EZjwcjG1jdU1E/wEN+9q0o77OCJYMmQ
         Mztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=818SG7IEtTO1VzHi9B3NbBmzpBqVubudS3ZsSfI3EDY=;
        b=Dyg/nHDEbVUzVjzfEGCuJfoVLWMclF4br5maQ8Eibgb2H+RDwYJimA0IfOxrCddAxb
         NJSIRzX0/HXxxp16oBxAc2JFA+ZW2AGiYy2LsMbtB60ocjEOGIKD4/67fMEeVtobuohm
         lICzsCf135tgJ5fYHx2qQyVhE89QU0r5JU1580ANUKiyUXT3AY99YrDPJi1x2Liy0w5q
         KzlQ7zcCi4GsT8iThLCIS/5JtCf8kLMxW9z9m4V8QxVZm1kqcsPp/y//kPPoc/JQgM3I
         e0yxWXXbrSaYwD9k97AJivwEKlrxruFRsu7ECpxA1b+FhVtGqZlWSxF32sQdsjDG01d0
         OT0g==
X-Gm-Message-State: AOAM5331sOJoBiO8VhnwfmLfHrwAOSxizd82TrgdFxewYO6eWB3EifHa
        nmEJe7GUTSjxNSHTdB5OgV24coIxU5w=
X-Google-Smtp-Source: ABdhPJzV3Uo2E2k0Epk4f858izYK5RO4NU5aFMZT0+Y/qX6fJmKDlSpOGoppSoUB1QHAetAafRMMrA==
X-Received: by 2002:a05:6a00:14cb:b0:4fb:2c72:1fdc with SMTP id w11-20020a056a0014cb00b004fb2c721fdcmr16774284pfu.55.1648564944003;
        Tue, 29 Mar 2022 07:42:24 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id ij17-20020a17090af81100b001c67c964d93sm4349569pjb.2.2022.03.29.07.42.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:42:23 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, lhjeff911@gmail.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com, lh.kuo@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v5 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Tue, 29 Mar 2022 22:42:03 +0800
Message-Id: <abd34a74bf56e04050868c63d030552a9af210f4.1648551070.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1648551070.git.tonyhuang.sunplus@gmail.com>
References: <cover.1648551070.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1648551070.git.tonyhuang.sunplus@gmail.com>
References: <cover.1648551070.git.tonyhuang.sunplus@gmail.com>
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
Changes in v5:
 - Addressed comments from Krzysztof.

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       | 64 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
new file mode 100644
index 0000000..92537d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Ltd. Co. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sunplus,mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus MMC Controller
+
+maintainers:
+  - Tony Huang <tonyhuang.sunplus@gmail.com>
+  - Li-hao Kuo <lhjeff911@gmail.com>
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-mmc
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
diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7..42498b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18242,6 +18242,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS MMC DRIVER
+M:	Tony Huang <tonyhuang.sunplus@gmail.com>
+M:	Li-hao Kuo <lhjeff911@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/sunplu,mmc.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

