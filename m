Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F6F483AC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiADC6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiADC6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:58:53 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A954C061761;
        Mon,  3 Jan 2022 18:58:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id x15so26107487plg.1;
        Mon, 03 Jan 2022 18:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=peQo9mfEI8LbiIuJ56+zoCVof+PjmiwxRJq8qFCN9CM=;
        b=bNhlA/eJKIwWlRKuq8+gslPMO1SyejMAI8RfQLWtwIrKmP6bzAOSHXhJ4+INOYcjjJ
         8gL2mVnLzYxHgk5kYNB5JvM07uwaCs2qv6EVEZ3EOkYv7E2m4fJ1OC51MSZbv/ZLMuPl
         wTG3iTadRiUvXRTh1vPnL1A+UI88Wc8d2pEkkkWddoqnTt9di97D5pnSs9X08LZk/15Z
         6VzYtuchpxeJkYcFSxLAgz0ogi1Tj9koCf+gstMnnVy7jOjvUJpeRVR8SP0gj1BoHDuo
         uZ8GYhZZdnidwccn+BMSypz+b8+Bsf6uwdA/Kq70ipUHKPy4rQCQUpfUvh2v8allyuTk
         jSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=peQo9mfEI8LbiIuJ56+zoCVof+PjmiwxRJq8qFCN9CM=;
        b=ZODuj2Mh0feASmZX5+vN88chX/2KFcPB36yiET5ELHCnXdcB3fdKkOxqlddDbDuzVy
         h36kTSAMfpfw5WsZSiYI1GY+fSh1qDKlvGO1ya093qguP7yaYJzlm6wJA9Dzoce06Q7J
         gG37dTijXaf4g7tk33sFCLPM1hwM/mMA1hxVfAzK9yFX9Bx9JL+XN/148n2Z28ngiRL8
         E9JGZ4dhLoM2esPIwe0c3BFzUOgC5hGlxOzt0MNUdilf4QEM6vPf4aDnSEGOUDv40H6q
         VhZX2kf4NOlgqIJpMnoszaJXGdfXQzOtf+f0cjvEnInWk1hfa4oy6k8om4ak2/IXzbKs
         uluQ==
X-Gm-Message-State: AOAM532F49+xZmCQiTdYv33RXFHUCkHnbbyWOlaJlG01x9JmacSNHx1G
        qlehxXLzuuZtX4YjmcIG0FY=
X-Google-Smtp-Source: ABdhPJwdklqN6Izfmzx234+bveNvR2DBMrrqeVodsXey+8bzSqZMosKX/Wyqj/+HC1YQkIl1b31HGA==
X-Received: by 2002:a17:902:ced2:b0:149:2f04:e00c with SMTP id d18-20020a170902ced200b001492f04e00cmr46829134plg.13.1641265132860;
        Mon, 03 Jan 2022 18:58:52 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id k23sm573142pji.3.2022.01.03.18.58.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jan 2022 18:58:52 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v3 2/2] devicetree: bindings THERMAL Add bindings doc for Sunplus SP7021
Date:   Tue,  4 Jan 2022 10:58:57 +0800
Message-Id: <e1466d52cd4c3971292ec8230df27faf372c2044.1641264908.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1641264908.git.lhjeff911@gmail.com>
References: <cover.1641264908.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1641264908.git.lhjeff911@gmail.com>
References: <cover.1641264908.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings THERMAL Add bindings doc for Sunplus SP7021

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v3:
 - Modify Theraml driver

 .../bindings/thermal/sunplus_thermal.yaml          | 49 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
new file mode 100644
index 0000000..e0290fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/sunplus_thermal.yaml#
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
+  reg-names:
+    items:
+      - const: reg
+      - const: moon4
+
+  nvmem-cells:
+    maxItems: 1
+
+  nvmem-cell-names:
+    const: therm_calib
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal@9c000280 {
+        compatible = "sunplus,sp7021-thermal";
+        reg = <0x9c000280 0x80>;
+        nvmem-cells = <&therm_calib>;
+        nvmem-cell-names = "therm_calib";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 4b02628..dd1b7bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18246,6 +18246,7 @@ SUNPLUS THERMAL DRIVER
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 F:	drivers/thermal/sunplus_thermal.c
 
 SUPERH
-- 
2.7.4

