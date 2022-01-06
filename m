Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4110E485E5E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344556AbiAFCAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344510AbiAFCAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:00:03 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D76AC061245;
        Wed,  5 Jan 2022 18:00:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u16so1435505plg.9;
        Wed, 05 Jan 2022 18:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hL7IKzjnESchBQgm8zSVn/jyoNPqIc3Tv9HTgc0aqRw=;
        b=crSvGdYjmT/znnpxYUC+Fc76jBTAtvUndO6CFSqwIdAMbmdaUvwsHwL5j9DDxEThNW
         KcaSNE4DA4Vxrh6XvrlGQ2+7DQb0JWy+FrUge8kMAtu/H6TcE6Y0FZ1zePalppC+cchs
         lC/phOcSU1K2N5PM4f0FvfneLWJ+cgBxfga9itL0JtlXysjvD0PuBfbsGfQbmEHwtWk4
         siz4MWwHtUFR8glGHHLOUmCMoeDwlHgVVKvcVpdM3XK3dK7OFj7aDtfTRCce08AGtD2X
         MHw5cpRD/atINH8c3nLXizNbwl4sTMRN5/kMtLHUWZUw6cRJdEdSoCp1Z9hAERhTch00
         4Y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hL7IKzjnESchBQgm8zSVn/jyoNPqIc3Tv9HTgc0aqRw=;
        b=f9fsYDZ2bzol7B2CgOH+jk9varrq9uXk69cZ1EXnz861+oOBPKfR/pp05U1pCW8xwJ
         CaIHh45aQhKwqpPoqEJXdgMBE1Q+DJpW0P1zZr1Ci32PE/pSvKfsVyKGOrD6ae02uZ26
         Xm7a9KjrWHLE7ipmjdZ0/bZBOjwuZP9wRzDVQiy8gX4oFdA92skFpMhIQr5nhTstujo4
         tUPw0AIAs15PdN7gWzr2Sz9+Ythe8MpgeBUlyDd5X4alPryp5Cp0Xf5zOsWF4GpXhAm9
         58Zf0VEpeEmwHUCAZtnu/KdvoA5C70OJVMO4L+7hlPMGS5TXhRIQWSv0WvI8+ZvZOUmX
         xeXQ==
X-Gm-Message-State: AOAM533n+wCuL1bWBs2hACsa/WNvi8/n9uBk6+soIuci35AflWCyQXjZ
        HhI+nUul89EVwYQsgGFQ/kc=
X-Google-Smtp-Source: ABdhPJyMDNtbmmVwat/GVA/LPlGMCM/QsYno7kQemzgfKZuWqw7zIrxzx6tOnaiFMtC/FpH7eYVHBg==
X-Received: by 2002:a17:902:6b4a:b0:149:7c73:bd6f with SMTP id g10-20020a1709026b4a00b001497c73bd6fmr43978247plt.46.1641434403112;
        Wed, 05 Jan 2022 18:00:03 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id t21sm256600pgn.28.2022.01.05.18.00.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 18:00:02 -0800 (PST)
From:   Edwin Chiu <edwinchiu0505tw@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc:     Edwin Chiu <edwinchiu0505tw@gmail.com>
Subject: [PATCH v3 1/2] dt-bingings:arm:sunplus:add sp7021 compatible string to sunplus,idle-state.yaml
Date:   Thu,  6 Jan 2022 10:00:07 +0800
Message-Id: <317c55864546698b02c39b16b082812c2ac9400c.1641432983.git.edwinchiu0505tw@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1641432983.git.edwinchiu0505tw@gmail.com>
References: <cover.1641432983.git.edwinchiu0505tw@gmail.com>
In-Reply-To: <cover.1641432983.git.edwinchiu0505tw@gmail.com>
References: <cover.1641432983.git.edwinchiu0505tw@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string for cpuidle state on sp7021

Signed-off-by: Edwin Chiu <edwinchiu0505tw@gmail.com>
---
Changes in v3
 - Align email address of sob and sender
 - Added sp7021 compatible string

 .../bindings/arm/sunplus/sunplus,idle-state.yaml   | 59 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml

diff --git a/Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml b/Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
new file mode 100644
index 0000000..64281ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sunplus/sunplus,idle-state.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SOC cpuidle state
+
+maintainers:
+  - Edwin Chiu<edwinchiu0505tw@gmail.com>
+
+description: |
+  Sunplus SOC cpuidle state
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sunplus,sp7021-idle-state
+
+  entry-latency-us:
+    description:
+      Worst case latency in microseconds required to enter the idle state.
+
+  exit-latency-us:
+    description:
+      Worst case latency in microseconds required to exit the idle state.
+      The exit-latency-us duration may be guaranteed only after
+      entry-latency-us has passed.
+
+  min-residency-us:
+    description:
+      Minimum residency duration in microseconds, inclusive of preparation
+      and entry, for this idle state to be considered worthwhile energy wise
+      (refer to section 2 of this document for a complete description).
+
+required:
+  - compatible
+  - entry-latency-us
+  - exit-latency-us
+  - min-residency-us
+
+additionalProperties: true
+
+examples:
+  - |
+
+    idle-state {
+      CPU_IDLE: cpu_idle {
+        compatible = "sunplus,sp7021-idle-state";
+        entry-latency-us = <8000>;
+        exit-latency-us = <700>;
+        min-residency-us = <9000>;
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e0dca8f..22cfafe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18252,6 +18252,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS CPUIDLE DRIVER
+M:	Edwin Chiu <edwinchiu0505tw@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

