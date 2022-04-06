Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8554F5E01
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiDFMfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiDFMc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:32:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E6A259B78;
        Wed,  6 Apr 2022 01:30:05 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n8so1362707plh.1;
        Wed, 06 Apr 2022 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TQIMUbozG9SqyvqQCldZuvLei2Xngiw+47KUkt6P5J0=;
        b=igeBBnP0Y9YvQ9bSGw5U62Q2747s9e3aKAQOBKPNqGJbB6fdgCxYlrw5iS15xm7Ww7
         8O8JkcqHW+u4kuRBjqSOIb2E83KPYe1cr1O+SEG+H3GE9Dpb4jkTYF5MkR4T84DPaovN
         YBQuyG7c52B8gbTjz2D/Q3gm4JxxFrAyQJu8CI//8TsGJ+K0HuQIRjqzqD7eXWLqNWQd
         A5kb+iCa0QkF4FUlI/bnDiAZzkXgz9ShJ7cg2xwWjcn0R+35JRiqXng8O0XPeg/2qIs1
         AK/ip0y5PpB5sd/i8/qqKNvsyhonSYEOot3Ry0RvjkNZ9ebyo245iywM7hxScWzu/ex1
         KZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TQIMUbozG9SqyvqQCldZuvLei2Xngiw+47KUkt6P5J0=;
        b=le0xs55gtf2SRzH0ftONSt+g6HVFjGnPsXl7EurIb+LAGH/rkSTv78WoLiZm1S05LB
         vjnW7xDLedgv6tiV/GAkSS+qJGNJhZyQT65WKQoKQAUAI7R7eWihmKj3H0W4J8ZUOy9X
         kOnTHWWTLhS/qzLicx7wQ/suFrcJjdYgbw+gpYlpUJuMi3frYX9EXRflvaeb5VkDjz6l
         ZVNmTcen/6S3WoFjTEzUnGZThDCRyyBAU1bC73oLxYbjq59IwfE1IJ3+0AS+wPdSQqZd
         zEGe94g0Zf3A4miQMgPrKv2o18T93JjSABty3BAob7fWM7QBHGL8QCp+8DzwF7Unmt8o
         Cj/g==
X-Gm-Message-State: AOAM532pOULxdB45Dli02sFxwzhORYhpK43XaYoCeUm6jbzNHm5++d56
        jBFSyl1qmvNBS7H831ntZQu+jUGRiWk=
X-Google-Smtp-Source: ABdhPJwM8I6TscAqthljGeo5TgV0M9U06rHbG0iHUpzu8dQ7beIIlliGOGERfhBZhYVi+7ImbO+OzQ==
X-Received: by 2002:a17:90b:4d85:b0:1c7:3933:d810 with SMTP id oj5-20020a17090b4d8500b001c73933d810mr8686532pjb.129.1649233804755;
        Wed, 06 Apr 2022 01:30:04 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id r8-20020a17090a0ac800b001c9e35d3a3asm4904977pje.24.2022.04.06.01.30.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:30:04 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        krzysztof.kozlowski@linaro.org
Cc:     wells.lu@sunplus.com, lh.Kuo@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v6 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Wed,  6 Apr 2022 16:29:48 +0800
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

