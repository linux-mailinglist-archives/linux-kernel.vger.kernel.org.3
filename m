Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022844AF01C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiBILuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiBILuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:50:21 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69896E01C887;
        Wed,  9 Feb 2022 02:40:55 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x15so1101692pfr.5;
        Wed, 09 Feb 2022 02:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PBYp/H546dN40WXOvI+fy6E8A6zPMNF3D1e5BSqN7l4=;
        b=F62m2g8Rv3hBwIiOmWgTSg4T/GdV1Wp1QpLnfjoATaz38K4nJej0dxqCU5qystxEux
         APui8N2j6fVVTTzY7AAMjKDKlqTSUV9TML8GBXFfhPfQqAUB+E2DENV8bvBCSPzpbkEm
         fKTWi7X8FUacjgdbNpLIMLY357TNcjpTOlH0CB8KquEpcn3KxLeOsc35XY/bOTdrzfb2
         UfOLWegR7o44zEzvstdq8BwrLWqV/fBVRJk/AH4PCCPfTCabkzBJBLQYMdULwy09mnBn
         tmi1uQceNy6avVyFq3f/ts6CMfPi3IInUg2+SaX26ZWunMis1jw9T63iKKWPGdJbJ4xC
         lDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PBYp/H546dN40WXOvI+fy6E8A6zPMNF3D1e5BSqN7l4=;
        b=3f0/LT+VLOHGIvguOqCuBc5K5hPBUjVsMGrC2N2K7FvUXvW2llV2aO9OjNJ7wRfbzD
         qc0gKiq6vffQvo5peFqg7hMvq7a10KlX19rV9S4PgVOte6aNiwII3lo7kKjqm4sgeZKJ
         OFSLfAYhbWWbBXwFdfI3zJ6FYwByxoCh8etJINQdBJNRuBHioSDR7U77CHDahuUiO+ok
         1gQxRJ57R4Mf0ooVaVRXPADN9YqJJVfJSswBLYplcsSWtTOT00MceCTUCvcoAUJ4VK/v
         2zqHps8QRlH5BJqT9XNGI4fLqTzyOugCA99AqHrvdpBC5Pitya+vj6EiRceHlPuelilP
         f1vg==
X-Gm-Message-State: AOAM531NQAagZ9av9t4zh6+/HIeS5Ju5clLbwpR1ulWgPX2K+sBKh7gr
        EzYiUNgz4eSvWb8hHnB8Wkc=
X-Google-Smtp-Source: ABdhPJxcUnKyFvTQrMSYNHr2dJaQXQjIbwpZ6tXLMV4qIBH46R27V2AlbzO30Lf1ALajsqOs6ceEPQ==
X-Received: by 2002:aa7:938c:: with SMTP id t12mr1605861pfe.51.1644403254963;
        Wed, 09 Feb 2022 02:40:54 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id m23sm18223272pff.201.2022.02.09.02.40.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Feb 2022 02:40:54 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, lhjeff911@gmail.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        tony.huang@sunplus.com, wells.lu@sunplus.com, lh.kuo@sunplus.com
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v3 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Wed,  9 Feb 2022 18:41:06 +0800
Message-Id: <f8b89f9981e17c023ce530afedb1f2b599edec0f.1644398657.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1644398657.git.tonyhuang.sunplus@gmail.com>
References: <cover.1644398657.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1644398657.git.tonyhuang.sunplus@gmail.com>
References: <cover.1644398657.git.tonyhuang.sunplus@gmail.com>
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
Changes in v3:
 - combine sdcard and eMMC into one driver.

 .../devicetree/bindings/mmc/sunplus-mmc.yaml       | 76 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
new file mode 100644
index 0000000..8f44d13
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Ltd. Co. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sunplus-mmc.yaml#
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
+      - sunplus,sp7021-emmc
+      - sunplus,sp7021-sdhci
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
+        compatible = "sunplus,sp7021-emmc";
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
+       compatible = "sunplus,sp7021-sdhci";
+       reg = <0x9c003e80 0x280>;
+       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
+       clocks = <&clkc 0x4f>;
+       resets = <&rstc 0x3f>;
+       pinctrl-names = "default";
+       pinctrl-0 = <&mmc1_mux &mmc1_mux_cd>;
+       max-frequency = <52000000>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7..cb46a55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18242,6 +18242,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS MMC DRIVER
+M:	Tony Huang <tonyhuang.sunplus@gmail.com>
+M:	Li-hao Kuo <lhjeff911@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/sunplu-mmc.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

