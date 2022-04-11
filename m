Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306524FB670
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343959AbiDKIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343971AbiDKIzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:55:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5923ED0D;
        Mon, 11 Apr 2022 01:52:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso3867275pjf.5;
        Mon, 11 Apr 2022 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wcUz0+UjxpMoFjbS5TXezP4XnhOgcL6C2oIJHQtQ8s0=;
        b=VnMORHXMDSLDgSWNxSAkGy9LkNM/xWuL2CcAwSnJ432jdF0YWy3QWz5Id+VTe1Kz7g
         uQRf239CBiLdx/BsdF7461Sb+ujkl9gKzQcRDfiEp0BLpCnMnpcn7EIEPQNFuv8qZCOT
         UGUFrzslmyLV4sNQONcIQbarl/e2lR5urTq4BM6y/vQ7AkUR0I8rJ4/PeTyo0yQTGj8h
         aJlM+TtynOqPK0Md9gfr2rv6z4xkUMuFMyQV1EFaOErTpur4IBQrJ10IWPbp4YD+6w/A
         N7biETA3qfe2p5X8YMxkZSi+vxwJ+rzdrLpadex7vB05x/h/cKxQ12k0EMzsCfkFvbnP
         Y1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wcUz0+UjxpMoFjbS5TXezP4XnhOgcL6C2oIJHQtQ8s0=;
        b=IFO/1vIC7zZ4mL/TwD2wFe7TpIppfZJ4e5G770QKMBMzA4jU1yitqE/TGjOyeD4afO
         xhmo8xKlZEGaQXC7a7+oH60ZgJQFuKEPRdtuP7Rt20OCc0NgdvJBlB42DkHZxVDA60gO
         /mKLDzbf9GMPlpbNTjJrF7SzRDB7pmG+grs26e2WJ9suPSWHcD0EdcgD7P10Zxv1DNG0
         VNp194Av8W7wPUc+JNyGoq+KAPYoM1eJXwRNi9d5aueDbvFjX0Gz0/FA9c/3TFZul0h1
         S7rv3KGrqcdn1dIxxheQ9m23t9sENiOIYPI5qDn7lk+6AZ0xJZbfmXv9JCggELKl2FJ4
         xT+w==
X-Gm-Message-State: AOAM531p6orhz4lHm5jiRnMYxiptAmwC9Gg+d1AOcBpf91dE9MGtvJXN
        30ysyeq9BUjEL3unaaEmjkc=
X-Google-Smtp-Source: ABdhPJxOfcCGXE2MUZsBvJIp671KetgCwyqfGw+ppcDPP4n4QfGUwIH6GmE21oorWzrcsMb5PdwLaQ==
X-Received: by 2002:a17:90a:8b8b:b0:1ca:6007:36e5 with SMTP id z11-20020a17090a8b8b00b001ca600736e5mr35553940pjn.128.1649667175689;
        Mon, 11 Apr 2022 01:52:55 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id b16-20020a17090a011000b001cb4815d135sm10054057pjb.9.2022.04.11.01.52.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Apr 2022 01:52:55 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v7 2/2] dt-bindings:thermal: Add Sunplus SP7021 schema
Date:   Mon, 11 Apr 2022 16:52:40 +0800
Message-Id: <f24781413a8a305b28a1e9c3861263975eebaee6.1649662002.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1649662002.git.lhjeff911@gmail.com>
References: <cover.1649662002.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1649662002.git.lhjeff911@gmail.com>
References: <cover.1649662002.git.lhjeff911@gmail.com>
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
Changes in v7:
 - Modify yaml file.
 - Change the filename sunplus_thermal to sunplus-thermal.
 - Change the nvmem-cell-names thermal_calib to calib.

 .../bindings/thermal/sunplus-thermal.yaml          | 43 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sunplus-thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus-thermal.yaml
new file mode 100644
index 0000000..b9d69b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sunplus-thermal.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/sunplus-thermal.yaml#
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
index 307570c..0eb22a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18889,6 +18889,7 @@ SUNPLUS THERMAL DRIVER
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 F:	drivers/thermal/sunplus_thermal.c
 
 SUNPLUS UART DRIVER
-- 
2.7.4

