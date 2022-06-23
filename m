Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECAF55888C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiFWTVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiFWTU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:20:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B08139F8D;
        Thu, 23 Jun 2022 11:25:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ge10so11310123ejb.7;
        Thu, 23 Jun 2022 11:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oWp/75RPQ/DYmXXj7xiz5MQSPkKxnhOz0WJzQaO0/wI=;
        b=kvBNsXK8tdq4xG+6IaFGwTBz8OKE6ZqJftRg+2m44jU7bWbmrdJxDCDKWPFt6ceEC2
         pFj+bbmPAvyTkkfz6XTWTMAWbFvw0+xF7ffQsSpz8VS87NaI2776tVWe5D8x+zDbIYgF
         RQLD6DP12cw+fNcH47vQpzPUH6pW+7nhInnKGbd7EKqYY5uupeW9Nq6gjenffTn/6gpu
         9nusPEXpYmfQukJ9ESzKJhJpAQ7w9+xFxpVYKEcOEtRy1meBCVLpiVqOqMF0MeHNgwhH
         mCB6UupzdR8DVoRd5n/3JVEKhKizOJ99DyT9WFT3cCq5xsRIns4KAkk1wshy6bnG8FgJ
         34JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oWp/75RPQ/DYmXXj7xiz5MQSPkKxnhOz0WJzQaO0/wI=;
        b=h2jdrkqCvdSf/ve+j4HO/lRc4n5pECOn1nnZ0rKrbIcWIuEWjheQMuq8FuQ2cxN1Cn
         NyI6FamJVbjQLJ09P5lQUpR8QaKKxMDfYUTfYDvRR2qrEq0lpsHqojtZJHomvfky61Mj
         dbdeKi8VwiizKwmqdak5UCMS49gEjcrLgfGn4se0shZDoHddpBHWvXUQ+8LLqnHAgfz9
         qhv3Bjq1SHIKu1HP3emT9lV6y7q+273pv0zFFZtefuqxKkcViNGx0qJOCp9Ps0+YyfKC
         0+OF7FUWeS7zdMH73VoJn7Umjv4yd8ojTA01HLD95fc8cJMQbftlKqrxaRkoyKb3tfQ+
         1XvQ==
X-Gm-Message-State: AJIora91dy6q4f0C7EqbLoERNdQJioCOHsVLUObNkNEA7TWfYHreZF2C
        ZYaYz6Ck1qZdogz9vmcGt04=
X-Google-Smtp-Source: AGRyM1tX/uIkx9B1bZZxC+M6JjHVXY25YzFU4+76DWEAGvI8jqlyBSxhnuyahT+Jd3ojpCmdHSsJ4g==
X-Received: by 2002:a17:907:8c05:b0:726:2a09:c951 with SMTP id ta5-20020a1709078c0500b007262a09c951mr3198262ejc.143.1656008745280;
        Thu, 23 Jun 2022 11:25:45 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-60.xnet.hr. [88.207.98.60])
        by smtp.googlemail.com with ESMTPSA id b26-20020a170906d11a00b006f3ef214e27sm11207577ejz.141.2022.06.23.11.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:25:44 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] dt-bindings: firmware: qcom-scm: convert to dtschema
Date:   Thu, 23 Jun 2022 20:25:42 +0200
Message-Id: <20220623182542.1116677-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Convert bindings for Qualcomm SCM to dtschema.

SoC compatibles that were used, but not documented were added.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 .../devicetree/bindings/firmware/qcom,scm.txt |  57 --------
 .../bindings/firmware/qcom,scm.yaml           | 124 ++++++++++++++++++
 2 files changed, 124 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
deleted file mode 100644
index 0f4e5ab26477..000000000000
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-QCOM Secure Channel Manager (SCM)
-
-Qualcomm processors include an interface to communicate to the secure firmware.
-This interface allows for clients to request different types of actions.  These
-can include CPU power up/down, HDCP requests, loading of firmware, and other
-assorted actions.
-
-Required properties:
-- compatible: must contain one of the following:
- * "qcom,scm-apq8064"
- * "qcom,scm-apq8084"
- * "qcom,scm-ipq4019"
- * "qcom,scm-ipq806x"
- * "qcom,scm-ipq8074"
- * "qcom,scm-mdm9607"
- * "qcom,scm-msm8226"
- * "qcom,scm-msm8660"
- * "qcom,scm-msm8916"
- * "qcom,scm-msm8953"
- * "qcom,scm-msm8960"
- * "qcom,scm-msm8974"
- * "qcom,scm-msm8976"
- * "qcom,scm-msm8994"
- * "qcom,scm-msm8996"
- * "qcom,scm-msm8998"
- * "qcom,scm-sc7180"
- * "qcom,scm-sc7280"
- * "qcom,scm-sdm845"
- * "qcom,scm-sdx55"
- * "qcom,scm-sm6350"
- * "qcom,scm-sm8150"
- * "qcom,scm-sm8250"
- * "qcom,scm-sm8350"
- * "qcom,scm-sm8450"
- and:
- * "qcom,scm"
-- clocks: Specifies clocks needed by the SCM interface, if any:
- * core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660" and
-   "qcom,scm-msm8960"
- * core, iface and bus clocks required for "qcom,scm-apq8084",
-   "qcom,scm-msm8916", "qcom,scm-msm8953", "qcom,scm-msm8974" and "qcom,scm-msm8976"
-- clock-names: Must contain "core" for the core clock, "iface" for the interface
-  clock and "bus" for the bus clock per the requirements of the compatible.
-- qcom,dload-mode: phandle to the TCSR hardware block and offset of the
-		   download mode control register (optional)
-
-Example for MSM8916:
-
-	firmware {
-		scm {
-			compatible = "qcom,msm8916", "qcom,scm";
-			clocks = <&gcc GCC_CRYPTO_CLK> ,
-				 <&gcc GCC_CRYPTO_AXI_CLK>,
-				 <&gcc GCC_CRYPTO_AHB_CLK>;
-			clock-names = "core", "bus", "iface";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
new file mode 100644
index 000000000000..7dd7beb39846
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/qcom,scm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM Secure Channel Manager (SCM) bindings
+
+maintainers:
+  - Robert Marko <robimarko@gmail.com>
+
+description: |
+  Qualcomm processors include an interface to communicate to the secure firmware.
+  This interface allows for clients to request different types of actions.
+  These can include CPU power up/down, HDCP requests, loading of firmware, and
+  other assorted actions.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,scm-apq8064
+              - qcom,scm-apq8084
+              - qcom,scm-ipq4019
+              - qcom,scm-ipq806x
+              - qcom,scm-ipq8074
+              - qcom,scm-mdm9607
+              - qcom,scm-msm8226
+              - qcom,scm-msm8660
+              - qcom,scm-msm8916
+              - qcom,scm-msm8953
+              - qcom,scm-msm8960
+              - qcom,scm-msm8974
+              - qcom,scm-msm8976
+              - qcom,scm-msm8994
+              - qcom,scm-msm8996
+              - qcom,scm-msm8998
+              - qcom,scm-qcs404
+              - qcom,scm-sc7180
+              - qcom,scm-sc7280
+              - qcom,scm-sdm845
+              - qcom,scm-sdx55
+              - qcom,scm-sm6125
+              - qcom,scm-sm6350
+              - qcom,scm-sm8150
+              - qcom,scm-sm8250
+              - qcom,scm-sm8350
+              - qcom,scm-sm8450
+          - const: qcom,scm
+
+  clocks: true
+
+  clock-names: true
+
+  '#reset-cells':
+    const: 1
+
+  qcom,dload-mode:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandle to the TCSR hardware block and offset of the download mode control register
+
+required:
+  - compatible
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,scm-apq8064
+              - qcom,scm-msm8660
+              - qcom,scm-msm8960
+    then:
+      properties:
+        clocks:
+          items:
+            - description: SCM core clock
+        clock-names:
+          items:
+            - const: core
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,scm-apq8084
+              - qcom,scm-mdm9607
+              - qcom,scm-msm8916
+              - qcom,scm-msm8953
+              - qcom,scm-msm8974
+              - qcom,scm-msm8976
+    then:
+      properties:
+        clocks:
+          items:
+            - description: SCM core clock
+            - description: SCM bus clock
+            - description: SCM interface clock
+        clock-names:
+          items:
+            - const: core
+            - const: bus
+            - const: iface
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8916.h>
+    firmware {
+      scm {
+        compatible = "qcom,scm-msm8916", "qcom,scm";
+
+        clocks = <&gcc GCC_CRYPTO_CLK>,
+                 <&gcc GCC_CRYPTO_AXI_CLK>,
+                 <&gcc GCC_CRYPTO_AHB_CLK>;
+        clock-names = "core", "bus", "iface";
+        qcom,dload-mode = <&tcsr 0x6100>;
+      };
+    };
-- 
2.36.1

