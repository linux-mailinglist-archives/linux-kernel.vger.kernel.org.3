Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6838517BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiECCRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiECCQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:16:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA9919C1C;
        Mon,  2 May 2022 19:13:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso889255pjj.2;
        Mon, 02 May 2022 19:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kroCv5wFfG4D8h1vV8y+rzckalafJWA5JkCIOK0Xo04=;
        b=BypF4TJ4EemmoX/WCVnl6k6XqlvvIFw5BsFZOPt8pbGAHvLAYKEQUQekKIekqAobrs
         wLvfcSH42pTjv14XAYH7GLljpZYky2foiml4O7tDKyqlQD3adCpMvM2TPVsNL8ukyDNx
         LfhlXU3c2CZQz/9KKq5z40YNcD7Kn/7eu90HubNFmC6xt40lXh+64aX1HCHRlq+stnBu
         bidDCA811PwdiC+x4f9TyQjS0BVGRA4/Wy9CaME7zAn9eEEblgLgyloJjrNLx5Xj6U5Q
         csEcD6bGTwjR2XBPZvL9DaFwSL40vStnGpzMjjMEZ3hmoAGs46IrtUlxXyu2/6nZNBS3
         yCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kroCv5wFfG4D8h1vV8y+rzckalafJWA5JkCIOK0Xo04=;
        b=wP5Ws6Q8b07jscNIJId7aB248QpHcQkZuPesAN30GYy+4yFEY1rYqfKF3tEc8sfrqv
         eOICTA/yxub4ftzP5LFqYjiUtFyxAsfIYiBN0E6mj+uKHJoECCXx7xK3sZsGLDqPhcbp
         YTr5EmNOjVah+OgcJ4qj3AemUpU0+GUgTXaPUyv0ue9h7ShcdcWN0cL6vSPDWC2rUHXt
         wj5HKeDkExTA6gwWv845ez3JW8Py+7yPMSP31+J7brLpdYvzWLYMASuNLBAA5zDcH9yA
         8mm9Mcn4x4LULApvJNaKPb+TPoRCXDNFRZL0TeRvIulWWARQOmXbUC74gzLitMjAj3bv
         YO+A==
X-Gm-Message-State: AOAM531zeMcljbfwlewnTs6ypWcbbLiLhVFoUBNCcZZAh2wFUiQRG6FS
        X9PQ/Q2j3XkEggGUqNwfZUKvCfGmjKX0CA==
X-Google-Smtp-Source: ABdhPJyP407Izy5nrZ7E00j0YMUWq9HxXA5WmFZNnYpz9jN0rPQ9hceDIXsP8t5BZmZ1y+1EpArCMw==
X-Received: by 2002:a17:90b:4a02:b0:1dc:4710:c1fe with SMTP id kk2-20020a17090b4a0200b001dc4710c1femr2327200pjb.208.1651544004832;
        Mon, 02 May 2022 19:13:24 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id j22-20020a17090a7e9600b001d903861194sm365805pjl.30.2022.05.02.19.13.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 19:13:24 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v8 2/2] dt-bindings:thermal: Add Sunplus schema
Date:   Tue,  3 May 2022 10:13:08 +0800
Message-Id: <e9f65ca9a2b3205b91210398d743415f6c799d90.1651543731.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1651543731.git.lhjeff911@gmail.com>
References: <cover.1651543731.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1651543731.git.lhjeff911@gmail.com>
References: <cover.1651543731.git.lhjeff911@gmail.com>
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
Changes in v8:
 - Modify yaml file.
   modify the setting compatible
 - Change yaml file name.
 - Modify driver.
   mosdify and simply the nvmem setting and remove valiable

 .../bindings/thermal/sunplus,thermal.yaml          | 43 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
new file mode 100644
index 0000000..1ecf6f6
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
+      - sunplus,thermal
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
+        compatible = "sunplus,thermal";
+        reg = <0x9c000280 0xc>;
+        nvmem-cells = <&calib>;
+        nvmem-cell-names = "calib";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 82143ff..ff49023 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18900,6 +18900,7 @@ SUNPLUS THERMAL DRIVER
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
 F:	drivers/thermal/sunplus_thermal.c
 
 SUNPLUS UART DRIVER
-- 
2.7.4

