Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B715E47EBF4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351486AbhLXGFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351456AbhLXGFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:05:37 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215FC061401;
        Thu, 23 Dec 2021 22:05:37 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f125so6991206pgc.0;
        Thu, 23 Dec 2021 22:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RigX7Ns/+Snrt8UrcXUuA0iJDA0F661A3lbO8ib7J24=;
        b=l5Th39v8L5CbG7sXwIziiK522KwUbSaFEiYIdVHoOfyPxFqw7VyPnhCtKWioILYdxF
         VGqqhYMBhCycrm8JehpNwgEN7yb5RIIZI5hVc72lCsyqw8g2beN8oIf1CBbc8np1kc/M
         UwQmzd8Vl2Of5nRFCenH0L6qXh4A5XzyZ0D6gUkIbIFBMyrTGLfULnR1SF3/ZUQFIVbO
         HqyRcy6ngC5qahw39OiIpupezHrRASoBwI7InSQeNwAED/tCxKceMUknXNk1vb9u//6l
         asCrEw/G2LeQaSWDmR2iNVt5ilCkx2Iu2BlrLR5EoivYmvtruTamYbpAXGoia2GFkGSR
         xeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RigX7Ns/+Snrt8UrcXUuA0iJDA0F661A3lbO8ib7J24=;
        b=4pO5jL3pexaR2dE/2lB8ibLHH+ihzb2Pw34BW/pweOegnkAgFT0gsDyu7qv/XJA3GY
         Iro9bxym4g+vYLo6GTW2Vp8s6q5dbu9E2549FsFEfa1pnzP9xmB5f5W19KvGdx5ygPM9
         k2l1Blmh9Vqv8ztVhy9lWZHhbakDaVDzfVBQoRJn5FDpt0haEgXklpQeA+9eeVqADEsV
         g3YIZTs5pCGQqd2tO6JWV3y2SCmSZ0Ouo/JF0DUM2u5Y1oC+my8HbHzYN8wOaHCldCkY
         KH9+uPQj4AyvDEeLUK9/yAShrZI8uN4bTAjrWSDUPtji4oIojswOiOF3iDmqY8A+eHvf
         z2Zw==
X-Gm-Message-State: AOAM533UXXuBSfotgbDLFa7Sw/bHQk+aaXSVtMq81mS/74pM+hyLTLhG
        x3roqzZLk1nfC84COUPLfIA=
X-Google-Smtp-Source: ABdhPJyVFtvywx4KAl6kX7WiOwHtvzIbuBrIlYHVSmfp72GYA4CHhLkhJvTjYuH1APzCZMzXpFZRWQ==
X-Received: by 2002:a63:c009:: with SMTP id h9mr4906351pgg.36.1640325936383;
        Thu, 23 Dec 2021 22:05:36 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id y128sm8234736pfb.24.2021.12.23.22.05.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 22:05:36 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     p.zabel@pengutronix.de, daniel.thompson@linaro.org,
        lee.jones@linaro.org, u.kleine-koenig@pengutronix.de,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lh.kuo@sunplus.com, wells.lu@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v3 2/2] devicetree bindings mmc Add bindings doc for Sunplus SP7021
Date:   Fri, 24 Dec 2021 14:05:39 +0800
Message-Id: <9da84bfbb6d4d086a8f905dd0d80fb81720987f7.1640325539.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1640325539.git.lhjeff911@gmail.com>
References: <cover.1640325539.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1640325539.git.lhjeff911@gmail.com>
References: <cover.1640325539.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings mmc Add bindings doc for Sunplus SP7021

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v3:
 - Addressed all comments from Mr. Rob Herring
 - Modified SD/SDIO driver.

 .../devicetree/bindings/mmc/sunplus-sd2.yaml       | 73 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml b/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
new file mode 100644
index 0000000..2f96e35
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sunplus-sd2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SD/SDIO controller
+
+maintainers:
+  - Li-hao Kuo <lhjeff911@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-card
+      - sunplus,sp7021-sdio
+
+  reg:
+    items:
+      - description: Base address and length of the SD/SDIO registers
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
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - pinctrl-names
+  - pinctrl-0
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sp-sp7021.h>
+    #include <dt-bindings/reset/sp-sp7021.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    sdcard: sdcard@9c003e80 {
+       compatible = "sunplus,sp7021-card";
+       reg = <0x9c003e80 0x280>;
+       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
+       clocks = <&clkc CARD_CTL1>;
+       resets = <&rstc RST_CARD_CTL1>;
+       pinctrl-names = "default";
+       pinctrl-0 = <&mmc1_mux &mmc1_mux_cd>;
+       max-frequency = <52000000>;
+    };
+    sdio: mmc@9c008400 {
+       compatible = "sunplus,sp7021-sdio";
+       reg = <0x9c008400 0x280>;
+       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
+       clocks = <&clkc CARD_CTL1>;
+       resets = <&rstc RST_CARD_CTL1>;
+       pinctrl-names = "default";
+       pinctrl-0 = <&pins_sdio>;
+       max-frequency = <52000000>;
+    };
+...
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index 2c1d9e8..297d512 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18246,6 +18246,7 @@ SUNPLUS SD/SDIO HOST CONTROLLER INTERFACE DRIVER
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
 F:	drivers/mmc/host/sunplus_sd2.c
 
 SUPERH
-- 
2.7.4

