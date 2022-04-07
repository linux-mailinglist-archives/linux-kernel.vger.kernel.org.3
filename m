Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DBD4F798B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbiDGIYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbiDGIYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:24:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1465522C;
        Thu,  7 Apr 2022 01:22:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m12-20020a17090b068c00b001cabe30a98dso8210372pjz.4;
        Thu, 07 Apr 2022 01:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rj6brym2wzFnRYMRpLIYtrzZ8S8ix3viMP+RDS64nN0=;
        b=D+ysKmcZujFnG49dY1LvgQoCLmNBUt0JoUIsGHlKRJo/hon1b3WOrtwrQ62CpYi2IJ
         AD/vlBiDzHQImVSEy1XwbHypWy+n6MT0NvAVPVvpJoxLJxkFZHIc89HXBa3Dzz4Ok1nC
         +U6HJD+ihas87Sci4fHtJbzNocRzWC/ZT8zQR1+gBmWuPXkERq+oV6raN/RGy58t05AL
         3jhoUumafoFgl9Yoxgzn8g0JnBc1L2wQsTQOVGrwjBhy8FyEWeNx2vOsBD+/iS8Hovtq
         UH3vQmmR90+e3frM3a/ZeAVYdB31ijyDt8Hn9p9L2xf3tNEwyEuXkamDWMyTYRUvOBw7
         Mw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rj6brym2wzFnRYMRpLIYtrzZ8S8ix3viMP+RDS64nN0=;
        b=0YrJocnEusEhf07fQUkzdkQ3FIn22eF3FylET+SJsrrd8bA/jWPLQ7TNO5zUAqZgZ8
         TeP2o0KdWugS1wmp7Yhr10mhosstXEaBGTZ8GT77SGaoSjsmwl1ZE6Bhz1ZE5XLsDelK
         gG4JENjGgdLqHy87D3fwayJKrKT0NLwjrQ24WjsLidekJZ4pqFjIKwV49/uv4deVYW4M
         djqMMPfZLeKx5qgYkonil5LqTrVNARiGdxtPZE1iCWXgtEwVx0nUOdgLjMqEYaGUXsDI
         BO4IoiKP9DmOM5l4ix5r43LDezTMShW5PXl6R10OwXL4ImylTtd+Y+UpAoVu+qTTA5L+
         b05g==
X-Gm-Message-State: AOAM531qAT6mXAQf+sTxlMN/YUuVZObOE+91QKwtMOrV2HwzArBQg0Qx
        HhuuTwbugWHW8Df31ygKQuc=
X-Google-Smtp-Source: ABdhPJxJKhEYCUlsqTUreeoA5xS3g/q9X2YZ2V1tZKtHt5xY8T9Seo4DwkfXYKpq/AMzuCNn+qX1UQ==
X-Received: by 2002:a17:90b:1b52:b0:1c6:b689:813d with SMTP id nv18-20020a17090b1b5200b001c6b689813dmr14364842pjb.186.1649319732123;
        Thu, 07 Apr 2022 01:22:12 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm22248098pfx.34.2022.04.07.01.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:22:11 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc dt-binding
Date:   Thu,  7 Apr 2022 16:21:42 +0800
Message-Id: <20220407082148.571442-2-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407082148.571442-1-gengcixi@gmail.com>
References: <20220407082148.571442-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

sprd,ump9620-adc is one variant of sc27xx series, add ump9620
description and sample in dt-bindings.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 57 +++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
index caa3ee0b4b8c..0d0f317b75c5 100644
--- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
@@ -20,6 +20,7 @@ properties:
       - sprd,sc2723-adc
       - sprd,sc2730-adc
       - sprd,sc2731-adc
+      - sprd,ump9620-adc
 
   reg:
     maxItems: 1
@@ -34,12 +35,39 @@ properties:
     maxItems: 1
 
   nvmem-cells:
-    maxItems: 2
+    description: nvmem-cells.
 
   nvmem-cell-names:
-    items:
-      - const: big_scale_calib
-      - const: small_scale_calib
+    description: Names for each nvmem-cells specified.
+
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          enum:
+            - sprd,ump9620-adc
+then:
+  properties:
+    nvmem-cells:
+      maxItems: 2
+    nvmem-cell-names:
+      items:
+        - const: big_scale_calib
+        - const: small_scale_calib
+
+else:
+  properties:
+    nvmem-cells:
+      maxItems: 6
+    nvmem-cell-names:
+      items:
+        - const: big_scale_calib1
+        - const: big_scale_calib2
+        - const: small_scale_calib1
+        - const: small_scale_calib2
+        - const: vbat_det_cal1
+        - const: vbat_det_cal2
 
 required:
   - compatible
@@ -69,4 +97,25 @@ examples:
             nvmem-cell-names = "big_scale_calib", "small_scale_calib";
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@504 {
+            compatible = "sprd,ump9620-adc";
+            reg = <0x504>;
+            interrupt-parent = <&ump9620_pmic>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            #io-channel-cells = <1>;
+            hwlocks = <&hwlock 4>;
+            nvmem-cells = <&adc_bcal1>, <&adc_bcal2>,
+                          <&adc_scal1>, <&adc_scal2>,
+                          <&vbat_det_cal1>, <&vbat_det_cal2>;
+            nvmem-cell-names = "big_scale_calib1", "big_scale_calib2",
+                               "small_scale_calib1", "small_scale_calib2",
+                               "vbat_det_cal1", "vbat_det_cal2";
+        };
+    };
 ...
-- 
2.25.1

