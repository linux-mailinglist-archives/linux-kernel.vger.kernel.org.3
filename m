Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3624518DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiECUJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbiECUJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:09:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7E4B879;
        Tue,  3 May 2022 13:05:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t5so10449489edw.11;
        Tue, 03 May 2022 13:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3MWZsx6Wz0oJnhXHc5EgYRJIPgHEoxFAS+Idrf7kxw=;
        b=WTjNcPu/nddUOPrhaKacXQUTLslQDS13Knv/clKmNqWtsDC/596MjJ0MVZGLyAYD+y
         jc5lhndBakfJW89eic7hJIwBWVaoQ2E9mHjoP1mA3MeH1vthl22N3nq08iTeJI6DKake
         eHYUSPQO35eeV+xYd8Bfkark0hoELMKmtWl6p+3f53dR+LODq7HqySGfxZxR0jVVLQ1w
         qIBc7NUEx5Sd0sdVpiiQVEFg2B/kx5jdtZMy2z4aURRFuW/QA3utTi3KSgrG1/UaUT2s
         PFbdbYgvlwU6zzLBteknOcx/AiKzLQHwgJ3viGkbnMRQWXRWn+hhoyiM47FuFM3TdhSx
         F88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3MWZsx6Wz0oJnhXHc5EgYRJIPgHEoxFAS+Idrf7kxw=;
        b=KTO9Eat3H6hM/bIyb7hSPWt15tZQB7uXJhWxx8jQcioEJcpTPd6bOKFkuPqRBM/NDR
         bI3CKj/S2O4jCmwRcwUjYLchx3yqwqkj1m4XU8ZpjWRoN3kCyYGQ8AMSdJQM57+NviUq
         7ng52yO0cf03LuPt21MWu+w8yTu89U3x0KbkzAuG7ePrElJnrmOrp8Dmmw6L6xnKjkNp
         0KSJkGWdTb1q+x/HUuW82ZZuiYgX1gzT48N8hfcSDG2nZ009K3BomlHXuuDwiid5F+cL
         6mSAvTBHLTfiYDwFfOmgRMKGIICHoMUEjsI82OCHSluKuDRKPYRBKWQfszU147xyaMgo
         QLmA==
X-Gm-Message-State: AOAM530cLa/2QqTBObz0tqMgJyE7d9iPbDrpoY+LllyiHiKuW124Dw5M
        HAImNmBDxcmOMm4glbF/uBg=
X-Google-Smtp-Source: ABdhPJwt27N2VjqPhn9z7ncxzJJmn9AE4qeMODZgXlBMPH4QxsSqZSTfiMCiNmG52xN5Ml7jGvTg1A==
X-Received: by 2002:a05:6402:1450:b0:425:e43f:7ccd with SMTP id d16-20020a056402145000b00425e43f7ccdmr19898570edx.299.1651608333643;
        Tue, 03 May 2022 13:05:33 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-149.xnet.hr. [88.207.96.149])
        by smtp.googlemail.com with ESMTPSA id ee47-20020a056402292f00b0041d893ed437sm8688450edb.2.2022.05.03.13.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:05:33 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 1/5] dt-bindings: thermal: tsens: Add ipq8074 compatible
Date:   Tue,  3 May 2022 22:05:26 +0200
Message-Id: <20220503200530.4019673-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Qualcomm IPQ8074 has tsens v2.3.0 block, though unlike existing v2 IP it
only uses one IRQ, so tsens v2 compatible cannot be used as the fallback.

We also have to make sure that correct interrupts are set according to
compatibles, so populate interrupt information per compatibles.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Remove implied min/maxItem properties as pointed by Rob

Changes in v2:
* No need for a list in compatible check
* Specify minItems and maxItems for interrupt and interrupt-names
---
 .../bindings/thermal/qcom-tsens.yaml          | 76 ++++++++++++++++---
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index b6406bcc683f..23f69eead67e 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -56,6 +56,10 @@ properties:
               - qcom,sm8350-tsens
           - const: qcom,tsens-v2
 
+      - description: v2 of TSENS with combined interrupt
+        enum:
+          - qcom,ipq8074-tsens
+
   reg:
     items:
       - description: TM registers
@@ -63,15 +67,11 @@ properties:
 
   interrupts:
     minItems: 1
-    items:
-      - description: Combined interrupt if upper or lower threshold crossed
-      - description: Interrupt if critical threshold crossed
+    maxItems: 2
 
   interrupt-names:
     minItems: 1
-    items:
-      - const: uplow
-      - const: critical
+    maxItems: 2
 
   nvmem-cells:
     minItems: 1
@@ -124,22 +124,61 @@ allOf:
     then:
       properties:
         interrupts:
-          maxItems: 1
+          items:
+            - description: Combined interrupt if upper or lower threshold crossed
         interrupt-names:
-          maxItems: 1
+          items:
+            - const: uplow
 
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8953-tsens
+              - qcom,msm8996-tsens
+              - qcom,msm8998-tsens
+              - qcom,sc7180-tsens
+              - qcom,sc7280-tsens
+              - qcom,sc8180x-tsens
+              - qcom,sdm630-tsens
+              - qcom,sdm845-tsens
+              - qcom,sm8150-tsens
+              - qcom,sm8250-tsens
+              - qcom,sm8350-tsens
+              - qcom,tsens-v2
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Combined interrupt if upper or lower threshold crossed
+            - description: Interrupt if critical threshold crossed
+        interrupt-names:
+          items:
+            - const: uplow
+            - const: critical
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8074-tsens
+    then:
       properties:
         interrupts:
-          minItems: 2
+          items:
+            - description: Combined interrupt if upper, lower or critical thresholds crossed
         interrupt-names:
-          minItems: 2
+          items:
+            - const: combined
 
   - if:
       properties:
         compatible:
           contains:
             enum:
+              - qcom,ipq8074-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
               - qcom,tsens-v2
@@ -222,4 +261,19 @@ examples:
            #qcom,sensors = <13>;
            #thermal-sensor-cells = <1>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example 4 (for any IPQ8074 based SoC-s):
+    tsens4: thermal-sensor@4a9000 {
+           compatible = "qcom,ipq8074-tsens";
+           reg = <0x4a9000 0x1000>,
+                 <0x4a8000 0x1000>;
+
+           interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+           interrupt-names = "combined";
+
+           #qcom,sensors = <16>;
+           #thermal-sensor-cells = <1>;
+    };
 ...
-- 
2.35.1

