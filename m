Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663A447DE78
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 06:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhLWFG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 00:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhLWFGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:06:24 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C78C061401;
        Wed, 22 Dec 2021 21:06:23 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id j13so3469501plx.4;
        Wed, 22 Dec 2021 21:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MyD24FNyOTXZ6y6NJg0xU97g9tQ5vVAI4e4gfsSyX8I=;
        b=RQ+QnDl8ig7aT5l2ZErU1sJvwbgOlN8RlqENXg1pmGgYAhyHUREZ37OAKnRoMGb6Tt
         czraqNgZpiv0BIEE02uj9+aJQrDdn9edPYsLpvKMdyvdwdQj/059BY18vPZg1aMWH2B1
         YgiocTdTksbTxjlgESHWrR62VEcBjlTem2s8pYOTs2qoDg1i//Ia/lO2H4ekW52PrJuG
         EUftBbUNRfKzkTh+LywPxx7DxopDt0VpvT5lhmD0BsNQy8YEfPfjCisaBkXDFbgs6wo1
         Bms8EAQN3enYmMzlJw/aV0zDNdTYUFmXPW1s23i9WZp8XHpsLVs++F3njj+WGe5C7u43
         GLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MyD24FNyOTXZ6y6NJg0xU97g9tQ5vVAI4e4gfsSyX8I=;
        b=ySYQlizcANqqbVTOlwKPoxF7LQ33gPldCViY21hoCuerVdAMmDfq6oYjU8S5nowNMd
         iGHwR+7ygovPUU6dHpqZU38f/GcEODommW+TFEMG6wDYlHdFBoAcVL75PTE8K4s5idQs
         PjSWaNDMsUZqm8u/TPEBdbM78IssLm8mcIYfR7pvbOgbElzHIW9GhOpdFf9phdsvF0F+
         i4UGdCAWUL8mNY0KgRi0XYCuNlGJTUS1dCdeVI6kGzuw/1yQqxPvRweF++FjyAya3lRk
         pJ9m7juquTe/MuvJ2cSTuEQl+ZINKdXmr+5KIfkYP920NOwbErizHLCABDJ6ZwjMXUO0
         Wodg==
X-Gm-Message-State: AOAM532vwr5T5RsmYk3avdcy2VnoRPIkftONWEE0TVe3U8Ewg3+enN9l
        /ZOix7hB8WUFyeVKvUlptIo=
X-Google-Smtp-Source: ABdhPJy7amt41DT3NqaSEXbPnwcszzTczZoQnmoKtjzbYzDvu/N82HqBI3WPVfzqr/STwuUvSPPrLw==
X-Received: by 2002:a17:90a:fb83:: with SMTP id cp3mr1200518pjb.111.1640235983218;
        Wed, 22 Dec 2021 21:06:23 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id oo13sm4170936pjb.25.2021.12.22.21.06.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Dec 2021 21:06:22 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v2 2/2] devicetree: bindings THERMAL Add bindings doc for Sunplus SP7021
Date:   Thu, 23 Dec 2021 13:06:26 +0800
Message-Id: <297b69fbd49ac68e082ea43bbfd4e42bebdf5b77.1640235724.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1640235724.git.lhjeff911@gmail.com>
References: <cover.1640235724.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1640235724.git.lhjeff911@gmail.com>
References: <cover.1640235724.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings THERMAL Add bindings doc for Sunplus SP7021

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v2:
 - Addressed all comments from Mr. Rob Herring
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
index 5f1fa6d..17035b5 100644
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

