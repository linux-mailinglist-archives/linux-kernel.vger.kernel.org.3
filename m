Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14602484D67
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 06:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiAEFU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 00:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiAEFUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 00:20:50 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA75C061761;
        Tue,  4 Jan 2022 21:20:50 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id x194so11379172pgx.4;
        Tue, 04 Jan 2022 21:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=e1QFnagRdWJL+lzDtGVCOjz27USBN8IHni9chogDvvs=;
        b=Jj1q4Fl5cHqIQf8alrO+5R2t/sTkYUs1Bo9oZAOSuZompt5t7thQIj7ZOuDdXGDEi5
         qTUjLJZV5etZsoQDZGaXLuDK2VKGDvmbTgBaM9ih/mILYhiPPugMBeZLKDDDkSS2Lvcb
         SVUbDzxgyvPC/OfxfYfaKiU6qFvh+Uap9idf2fTSkqAhJn7b2erfp3d40u5qhFUgaF2O
         nNk4Fx7V8HNnIXnSnHDa3cvPnphCwoeYVpFXmZJFWCq6XGmS5nNVmzHLg2AwtJMYSnr3
         A51QH9vIub2+RFgMmwe5twhfRfHNdumVpVMraMMyXRkZtWfiScmBxvKBFTNi6cUEg4HZ
         1g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=e1QFnagRdWJL+lzDtGVCOjz27USBN8IHni9chogDvvs=;
        b=zQ0L6hG2+ytYLjR6Mo8XMv5ME019+LMqHH9W8oD0zB7Wt4mEFH88mWz5GO4wKN48Ze
         Z1/LnT00g2eq8ukt1sjchHSItlTH0Vq44GgkhoUSZcK2qgyldJlCzHRPUjRaQaXnm0lO
         +y7Mb6PeYJP8euJW2P0lfgZHtOvxN8aqii02Y68S00LsO+FLM6yfHWoLge7mT+L2edbx
         /6weIrxhGWJJoPeUxQ+WcXyTok++NlOKoKZlzCzqIV7kdXWy3Tv9MNhe0RrQx1ue9knK
         +cQggQYC4N1KDGOvVmRIb85jB7eJhBNIPxilkdwuqAo3O6KqKx6cYuMtjslwf3IXlJSp
         BY7g==
X-Gm-Message-State: AOAM533wg80lYX57qJttn6EjBFFoIDLbrPTwPxkLGRxcvrs99MM6Rzu9
        wcjf2TUlzlOqQrDHCooeIOI=
X-Google-Smtp-Source: ABdhPJwSxP3BSfFud4DjznRMi7C396KLq0DwUVZcsL3iPC/RKDxH9yKZ1pF6SObLiSRPAqGuB2PGhw==
X-Received: by 2002:a63:f244:: with SMTP id d4mr47301265pgk.65.1641360050055;
        Tue, 04 Jan 2022 21:20:50 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id 6sm34427187pgc.90.2022.01.04.21.20.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jan 2022 21:20:49 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kerenl.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v2 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Wed,  5 Jan 2022 13:20:56 +0800
Message-Id: <1d946b61174adf4216c79728d56dcc1eb8a86b38.1641354285.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1641354285.git.tonyhuang.sunplus@gmail.com>
References: <cover.1641354285.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1641354285.git.tonyhuang.sunplus@gmail.com>
References: <cover.1641354285.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmc yaml file for Sunplus SP7021

Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
---
Changes in v2:
 - Modify maintainers e-mail address.

 .../devicetree/bindings/mmc/sunplus-mmc.yaml       | 60 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
new file mode 100644
index 0000000..1c39af2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
@@ -0,0 +1,60 @@
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
+
+properties:
+  compatible:
+    const: sunplus,sp7021-emmc
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
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7..01ed57a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18242,6 +18242,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS MMC DRIVER
+M:	Tony Huang <tonyhuang.sunplus@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmcc/sunplu-mmc.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

