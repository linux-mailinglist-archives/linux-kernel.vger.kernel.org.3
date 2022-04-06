Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0744F5C7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiDFLgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238351AbiDFLeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:34:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C8157421C;
        Wed,  6 Apr 2022 01:25:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b13so1880209pfv.0;
        Wed, 06 Apr 2022 01:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TQIMUbozG9SqyvqQCldZuvLei2Xngiw+47KUkt6P5J0=;
        b=lU2TppS69sLT8swMtZyUoSSOzdKkvLNDsABQWEixlvVG6xAIYphMmCMzdxMfs+V9Iy
         DPm23DV3Du8oeFR8tLKKIYkPOCjfcOvasS0L1g7X2/2Q2pbw1uVBY/VhlZERj1+EIsIU
         qXK7fB3Za6dwEebZtghIVGqBhUj+abevIN684G+1kNWAoc4z+mUNj3e+9tkWLERc1gZo
         53hdnHj4hjQqtuZ8Qb6NT4vdcIDSnBh+BmGbkphLzS098rz0lcaGCRxsd4q47Cl8AWJA
         IcGMrFTRpIy1wORQvFldgqCzIfO9jqvsBLNeOacaoP8CZpVAujCAwszHHX5LN/iIwbNt
         JnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TQIMUbozG9SqyvqQCldZuvLei2Xngiw+47KUkt6P5J0=;
        b=1dsgrH7rMJS21VbQLYnZRiaSzGhdJXG7GGBvV+Nx62r8UzH0mzTTldHkNRyNZtlFWR
         +IQiezOAvqRdTwQE7h3VocRT6NjMCWmc6vV4KuYwmrcmHT6MhRzGHQl2uBQlzDKrkOYj
         3Z9gm+4hJW54nao4AzCT/a8Mj7LYujlVloICZ884JV1LwjHDkUXhvy3FsElCQt/fhmcF
         lC2Myy2GyVf0NTQ8MGXG6ZDNzjbXtzURZkqgktU3+kpxo0FYdJ8JL3W+MSsXunKnI0jt
         e2FktQvy6ABTd1v0Zj4Qvr3iFD6YRVaTAgz9zGiiYJ8bETed+UR+BASQZ+yYyAEBN2Nt
         JW+A==
X-Gm-Message-State: AOAM5339QHwTqpG7zXG4HM3VDl+VL3+B2n6Rxi3SMi8674jpq+jlzv6p
        fGZFNAAJR9PTr1ptjkbzGDs=
X-Google-Smtp-Source: ABdhPJzMa3GaMoxWg36T0tKFcTASNEByf4rl1V9QNTLnoe/93XJEwMzS5I/u8bVlZ76pAiqXcitLZQ==
X-Received: by 2002:a05:6a00:810:b0:4fa:e71f:7e40 with SMTP id m16-20020a056a00081000b004fae71f7e40mr7600866pfk.15.1649233546808;
        Wed, 06 Apr 2022 01:25:46 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id 68-20020a621647000000b004fa763ef1easm18052948pfw.125.2022.04.06.01.25.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:25:46 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@penguronix.de,
        krzysztof.kozlowski@linaro.org
Cc:     wells.lu@sunplus.com, lh.Kuo@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v6 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Wed,  6 Apr 2022 16:25:31 +0800
Message-Id: <9628a68b922ae9f32c6cd7ea734c436440d21e6d.1649229258.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1649229258.git.tonyhuang.sunplus@gmail.com>
References: <cover.1649229258.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1649229258.git.tonyhuang.sunplus@gmail.com>
References: <cover.1649229258.git.tonyhuang.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MMC YAML file for Sunplus SP7021.

Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v5:
 - Addressed comments from Krzysztof.
 
Changes in v6:
 - Addressed comments from Krzysztof.
 - To substitute MMC for mmc. To substitute YMAL for ymal.
 - Remove max-frequency.
 - Fixed wrong file name.

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       | 62 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
new file mode 100644
index 0000000..8ba623e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
@@ -0,0 +1,62 @@
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
+        compatible = "sunplus,mmc";
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
index fb18ce7..75746ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18242,6 +18242,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS MMC DRIVER
+M:	Tony Huang <tonyhuang.sunplus@gmail.com>
+M:	Li-hao Kuo <lhjeff911@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

