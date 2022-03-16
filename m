Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A914DA8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353441AbiCPDCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353430AbiCPDCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:02:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182AC5E151;
        Tue, 15 Mar 2022 20:00:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i11so38424plr.1;
        Tue, 15 Mar 2022 20:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TUol1yx6U2uQhjc6E23pRSVdv2Hed4TokG1wMm5Bz4E=;
        b=XxTIG1ssL7nkTkRuihWLbqDzkdccZrZBULu6TTgsCanOT3QjCuQZadpzelJ8PFFg/a
         ySqK2hheG+tdvu7V/TZEAV61J4zW5zhJtzNrPgOt0ZVEBDjhaIkQlRsZrmIDmyysvBUL
         URIW2yUj4csvzgzUgELFMbejoLe8Q+rbl9vp2T1b0wFZQfvTKJqhBZmBLIdacEBlcfSR
         M3usJezz9BXrXre16dyFDPJ6Zj+DZpBSgi9Zcah0n6PAMuUcyuss42WJCC6fz9xxsgZv
         RsRTPOv7TVvcinSG0KOfmnb1hTdj02WpaJkNiAVSpfsQ7fVxNUsoAoit0PwJiOks36iQ
         wNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TUol1yx6U2uQhjc6E23pRSVdv2Hed4TokG1wMm5Bz4E=;
        b=NyOfQIcOfDIadJlaBj1xY2iMEcFfsd+m6Ee16wZNI9R6Rk/W74Y+LdvxJQ3l/aBmFa
         x54OS4NOWggy3vlaTjM6tXZ4T1lZDvQy2iXkAJz/TznE+6vLp9NmsuNVqeXmKhDXdxq3
         71LNi1A4tFoDO+chH+09Nh/Cyb9sZ/l0i86vdhH0hNh5b+Vqw9NYBtIyMVouMnGRuItI
         4MW2DbXDEfiY+qD99XBrQ4Z6hY7qfma0UkQON7JpNI/+iB0dtS1dsRXT3PH6W14OkPr4
         IkeY784CWWiQzT2xtlyy+zdKOZNqjno50lAs4nZDuuEOfH3bxkYHm8T90D23l2c8/r4p
         Ne6A==
X-Gm-Message-State: AOAM532ONqS9MVy3Ov9Th5SiWSDY3Ebf61qFM8S9XmkLQGUQpshnNOHv
        SKY5Hf9RmK/hzSWqCcRHWR+voIsHmxXRIA==
X-Google-Smtp-Source: ABdhPJxuZFbHxFVIDqe725gysTmQhwpDnbEoEcwQj9+Pd3guLrQHvrUoRJ+bLdnDIO1M4BRf0fAsSg==
X-Received: by 2002:a17:90b:3503:b0:1bf:27c6:3b33 with SMTP id ls3-20020a17090b350300b001bf27c63b33mr7987168pjb.225.1647399651346;
        Tue, 15 Mar 2022 20:00:51 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id d16-20020a17090ad99000b001bcbc4247a0sm582329pjv.57.2022.03.15.20.00.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2022 20:00:51 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v5 2/2] dt-bindings:thermal: Add Sunplus SP7021 schema
Date:   Wed, 16 Mar 2022 11:01:06 +0800
Message-Id: <71c1b80e0083f38de71f36193e12b3cbff2ec852.1647399369.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1647399369.git.lhjeff911@gmail.com>
References: <cover.1647399369.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1647399369.git.lhjeff911@gmail.com>
References: <cover.1647399369.git.lhjeff911@gmail.com>
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
Changes in v5:
 - Modify yaml file remove reg name and change nvmem name
 - Addressed comments from Mr. Daniel Lezcano

 .../bindings/thermal/sunplus_thermal.yaml          | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
new file mode 100644
index 0000000..176bc07
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
@@ -0,0 +1,47 @@
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
+        reg = <0x9c000280 0x80>;
+        nvmem-cells = <&therm_calib>;
+        nvmem-cell-names = "therm_calib";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 96d5218..5000b8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18546,6 +18546,7 @@ SUNPLUS THERMAL DRIVER
 M:	Li-hao Kuo <lhjeff911@gmail.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 F:	drivers/thermal/sunplus_thermal.c
 
 SUPERH
-- 
2.7.4

