Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C65F4EA71A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiC2F0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiC2F03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:26:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0627D1C4B03;
        Mon, 28 Mar 2022 22:24:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so1732459pjm.0;
        Mon, 28 Mar 2022 22:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QZAO6Q/cCBxh5lhLGtqoqKvCAZogGFZhN5EMu51X2Ms=;
        b=AhL5rR8YHZLAcy7C+rNeDck6LTlrhJet/0icwHQFy5bLsNG/j9nSYUmwRPy7c1tUAP
         Hs6KzadqnwfiTfH1QYiczV9OmsWGyLImiDQ66HhnbaCZIjttpk1EhbcwiQOTMaemk0hG
         nnCJna1mvqG8TrE1+5+VbZSSAqTta+pxPXyiPxqsfQWDYW/ULgue2tOyVhnh0Tq0m/M9
         qFlAserGBnl7q9Jn00rtW/GFnXgHyNujq7OduC9i1Q60FO6XYMXCLXwOgcg/QoBEUXb0
         lzrsMdjCiBp7cuPSq5Rr5Wzo1DwpnC2hVhXgRwMHBtqSubQ7y/1/xtpoT3V6vEwdX0c/
         vDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QZAO6Q/cCBxh5lhLGtqoqKvCAZogGFZhN5EMu51X2Ms=;
        b=OPMBzA1mKUkud5n4SlXEZBW2FLnnH7V+j8x9AnlL6Dcmtg5TPhqgnrtZEqIBQwagJ2
         CJsRLwzkUftELECk9OTBFmhF2O3aWln5vPqEVZZdwdi1HCocdGbJgR2Sii17oSnyCAZP
         1v3JnHP16jrnPRuAurzJcfev1CZYJGrbZT4dxcS8pK+JW1uCOBAs7sdATUxHdgL6jpVQ
         yY8osaM4kcuOdoMMejJjJ4ZnNp9uhsa40oc2HFoPYOmbhwplzLrmIEHnbsE10KnqNhzU
         NX6Q2cBKWzE6Nuv3+vG1vIUO0hxNsclcM/9dvDZSm/IcteKK55+G9Gd1zXGUVYHyDQN8
         MJVw==
X-Gm-Message-State: AOAM530/lOHgW1j00+g0LDSu5AoYOcKexH0W4+mJD0RbXCN0OYSQtvH9
        hZygLhUGEQsFssp2U7qYm18=
X-Google-Smtp-Source: ABdhPJzLihzEldgrDCA1H2sVWWOLwy4OTFVzWqorbvJPPL7vwfUX4vjUIBSaV+qWKpCw0GH7Blum5Q==
X-Received: by 2002:a17:90b:4b45:b0:1c7:cc71:fdf7 with SMTP id mi5-20020a17090b4b4500b001c7cc71fdf7mr2761088pjb.33.1648531487425;
        Mon, 28 Mar 2022 22:24:47 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id cn9-20020a056a00340900b004fad845e9besm16690335pfb.57.2022.03.28.22.24.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Mar 2022 22:24:47 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzysztof.kozlowski@canonical.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v6 2/2] dt-bindings:thermal: Add Sunplus SP7021 schema
Date:   Tue, 29 Mar 2022 13:24:32 +0800
Message-Id: <5c3d0ab5baa9126b544a8f54ac5c773269ee1944.1648531197.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1648531197.git.lhjeff911@gmail.com>
References: <cover.1648531197.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1648531197.git.lhjeff911@gmail.com>
References: <cover.1648531197.git.lhjeff911@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Sunplus SP7021 thermal driver

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v6:
 - Modify yaml file.
 - Addressed comments from Mr. Krzysztof Kozlowski

 .../bindings/thermal/sunplus-thermal.yaml          | 43 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sunplus-thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus-thermal.yaml
new file mode 100644
index 0000000..80d70ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sunplus-thermal.yaml
@@ -0,0 +1,43 @@
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
+    const: therm_calib
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
+        nvmem-cell-names = "therm_calib";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 4096763..51a94c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18864,6 +18864,7 @@ SUNPLUS THERMAL DRIVER
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 F:	drivers/thermal/sunplus_thermal.c
 
 SUNPLUS UART DRIVER
-- 
2.7.4

