Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E459457132B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiGLHbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiGLHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:31:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CF09A5EE;
        Tue, 12 Jul 2022 00:31:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so7135446pjf.2;
        Tue, 12 Jul 2022 00:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=t+djDSzD3Pg3sYjwMz+n3xMozdzdEx12hm2NBAhg06M=;
        b=AHGYu6Gp4981YQ2emWscw9effTHDD95yJgCNylEZIVVAoeD5Gnduuxm1p1/dAD6R4y
         7AyZJ/z0X24sG1mZWoGjPeRyjPoal/IanjU36Yxyf8/5v/63f1mJf2VkApuchXYhUxcO
         pebAxuaxoS154mTvUEO7+EQzWJojwPegdYAOcvdR8tyTDIFoltwz/TTMhOH3TEC+pX2W
         6wQXXPUBtm0Sm1SHAy+xrw977LdzqCAy4TOgBGrAXdbyqcrs/PlqwgQtwmOLYnNiNPcJ
         DEejseM+XWiNoD4SinRUXc4mC+wN+jxiIV3r3GKIt4SWdYb4znvMdQxBjJ0oZYzfK4bT
         ZywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=t+djDSzD3Pg3sYjwMz+n3xMozdzdEx12hm2NBAhg06M=;
        b=pKXrhJSe8TIUVXL7r++NxbwGgHh78+hxcy3fVrviwYJiuHnsqKra8laii0q5bdv/GW
         JBDt1sj4UAvsAKp1wBVsF7GbKTBdlGSIxjhbryhJ8O8fXHvZ9qxD1B11YnM8o5VHD/z4
         CaD+cU0PeIf/m1wtWIGVZii9MjFRoRjF3WUQ0q5d3fNmDNCILwBEzb2gVIjT+GBHtA2y
         gtJn4i4bxysCnQfHpQbMQT2Mb2xG2dYsfDbr3MUMPHcv91SLZNpAQxSDH2i+2qeyjETK
         W7lfh9f+a++Ofjx4yrffA/z3CYVvGUEcVm4QPGBxDVwT5ADTbTqMwfQ3Ji4ZagYCtIa9
         y1Pg==
X-Gm-Message-State: AJIora/PKWQF7BoEWxcQWdnlRARvZgdY/8lwsX6pP4Yng6sOOrz9MxEN
        IyqppUav47qh8jM2ig/BOJ5zzwksHn3qXg==
X-Google-Smtp-Source: AGRyM1vPG84Yxbx2MBVUwjcHnb2WnhbuneVRIBiTY5rEUdf3iqBGhy5XR1TO9UimjlZ4mu8shS5Vpw==
X-Received: by 2002:a17:902:da88:b0:16c:27f9:8762 with SMTP id j8-20020a170902da8800b0016c27f98762mr20442574plx.85.1657611099473;
        Tue, 12 Jul 2022 00:31:39 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id t18-20020a170902d29200b0016c09a0ef87sm5994557plc.255.2022.07.12.00.31.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:31:38 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v10 2/2] dt-bindings: thermal: Add Sunplus schema
Date:   Tue, 12 Jul 2022 15:30:45 +0800
Message-Id: <5d2c95959dd6efaa204bc80ca9b24a8be9293d2f.1654660009.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1654660009.git.lhjeff911@gmail.com>
References: <cover.1654660009.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1654660009.git.lhjeff911@gmail.com>
References: <cover.1654660009.git.lhjeff911@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Sunplus thermal driver

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v10:
 - Fix wrong indentation.
 - Change the setting of compatible.
 - Mosdify the setting of remove funciton.

 .../bindings/thermal/sunplus,thermal.yaml          | 43 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
new file mode 100644
index 0000000..52094da
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/sunplus,thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus Thermal controller
+
+maintainers:
+  - Li-hao Kuo <lhjeff911@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-thermal
+
+  reg:
+    maxItems: 1
+
+  nvmem-cells:
+    maxItems: 1
+
+  nvmem-cell-names:
+    const: calib
+
+required:
+  - compatible
+  - reg
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal@9c000280 {
+        compatible = "sunplus,sp7021-thermal";
+        reg = <0x9c000280 0xc>;
+        nvmem-cells = <&calib>;
+        nvmem-cell-names = "calib";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 23bde07..a8c44eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19107,6 +19107,7 @@ SUNPLUS THERMAL DRIVER
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 F:	drivers/thermal/sunplus_thermal.c
 
 SUNPLUS UART DRIVER
-- 
2.7.4

