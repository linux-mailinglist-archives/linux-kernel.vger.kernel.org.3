Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B628948E2A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbiANCqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbiANCqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:46:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A62C061574;
        Thu, 13 Jan 2022 18:46:22 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z3so12090015plg.8;
        Thu, 13 Jan 2022 18:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tAg0aOWT6qUXJhh102lj4I3o58muZwZ2cL/V85USSRQ=;
        b=axVlk6hnPLLNHfNf0xUBfpqj9ie9vbTMhqrCQGXOj5p5lm/6iTI8QSq/BtM+31/uxP
         H+YsFp8YV39IiYo1v/ERgnadwXrxnt8iX25cYJGq2Phn9qzespW2uq/ZoMm4K/PLPL/f
         vL1UVJYjR8/n0xeH6Dk3GX4vQ0LHPLZr+8h1YyM6eBJAzKEwnhw93S8fdfEX5UMH/LUo
         E5TvUxMF4ue9mydL4u2aFnOvMW9Gyx/HF67WZWwvvB256lzkPuiX+tSG48PdzgiwDIYd
         jG3IaRa8EX2H4WdvW1KOFbJM2qZT9R76jjK/nA4wD2kijfmKwq54dtRi/iV2kSVojObq
         r/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tAg0aOWT6qUXJhh102lj4I3o58muZwZ2cL/V85USSRQ=;
        b=lSg3Sckzork91H0S4/hZPJHMez8xul5e7gOTSJJPHA+6gkO2trtr0ay8LVa97QbxWj
         O4jwYfG3Xw5QXqxtE8MoxttOvE/dU3mNcHZx3019wnvN8tfpaR8b0xrO2L+X9f0pRv2o
         2a8SE0WsWLLTmlI8jRvgCztFrKPW3vUcLREflMHXyDD1GKjJAyoPwcKQ4/fxzj67v3h9
         98RWYMvJnVsKnJ4s7HZfllPyLdNPVFvsNCTqlGNyjRPB66DimkTUf0JmAPiD7XOcfuDB
         2YA97d3wq5NCVfoedCTNo1uSCLsQBz0YwkB6eWIEZmOBQLYKwXMlKUdQPGya5gh36jmO
         dNjw==
X-Gm-Message-State: AOAM531ARJS+/Scq/aBLKmirpnaOsdJ/4+3XnE6mPapPJNWGT4ia6HJt
        XPupq0IlFyBa0gcDSSH2VsI=
X-Google-Smtp-Source: ABdhPJzPM8MtzY37L+Bl4OtSUJid/jXU3blIOMvSEAwvndGh+VLndvy04Z9Q1/JajOa02XBI5iuy2w==
X-Received: by 2002:a17:902:8549:b0:149:5d2f:a0a0 with SMTP id d9-20020a170902854900b001495d2fa0a0mr7704682plo.22.1642128381704;
        Thu, 13 Jan 2022 18:46:21 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id u11sm3939149pfi.10.2022.01.13.18.46.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jan 2022 18:46:21 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v4 2/2] dt-bindings:thermal: Add Sunplus SP7021 schema
Date:   Fri, 14 Jan 2022 10:46:27 +0800
Message-Id: <3667a4d5f55699c344c6c114a2a5575fb896dd9e.1642127137.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1642127137.git.lhjeff911@gmail.com>
References: <cover.1642127137.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1642127137.git.lhjeff911@gmail.com>
References: <cover.1642127137.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Sunplus SP7021 thermal driver

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v4:
 - Modify yaml file remove reg name and change nvmem name

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
+        reg = <0x9c000280 0x80>;
+        nvmem-cells = <&therm_calib>;
+        nvmem-cell-names = "calib";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e41b265..5428385 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18427,6 +18427,7 @@ SUNPLUS THERMAL DRIVER
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 F:	drivers/thermal/sunplus_thermal.c
 
 SUPERH
-- 
2.7.4

