Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA74C31D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiBXQtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiBXQtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:15 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AF51AAA74;
        Thu, 24 Feb 2022 08:48:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d3so622994wrf.1;
        Thu, 24 Feb 2022 08:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mAOvshMr08XsZxt+H1XQ8klQjF4e79mb0IKg6lqiZk0=;
        b=X5EjNOInZP2TjblGq7lzdWbIsSDEG8xivZOoo/j+rXqomxL3/Rbu2F96u4PM6cVjHZ
         /v2WUQo6AjwerKAc0s5AScwwIJaAd/JeHmnTcNA3qWHsa0Gv0Q5b5X1WYY+Ftqceuypl
         M3IVRfDR5KtprlyBdiND/CSxGrAhpO2cH3IYWEQzEr54duOIRY7HyPAz7ZIa5FCxrZhJ
         d+0/STDG1tNt0wwk5FuKVUCikBHa3kr4nBKepnkFBT0Nsb7IMxvPnczpWxCMQLqZ1Pzd
         iYyqsvOfCSy0r/OSEpUNoagYGGF+F0bhMrfvpHhSBtsjHiUlUEHm669295p4vbCs5Gp3
         2eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAOvshMr08XsZxt+H1XQ8klQjF4e79mb0IKg6lqiZk0=;
        b=tAdpm9c2dMNdp1dmwWr0LMod0Y70Ff9pPSd7xdjr/sbR/akCBRiNO7hu1oeLS7psmk
         otcbRmJJTw/QmLwnsZPQEm74isRyrX2JDoMz5JFhGaAeM1vPeNO1RdfAvtwKEqiugZzy
         oLbYAtU5tnr8O5hcC0CDe0RKbqNWJ/WL/tpfWSpo1+V9zfT556ppdNG4CRVGDVhaFQXq
         ffiolie6MrVd5E+bMcfpd3U5VWO13XSwnA4i3tPt3H6ijzNXBcqZNwEcif303EyYtWV8
         ZlDKMCx5WWMinBp11cg77fA4s9FdWFrD5D50bOAQ/i12Kx/QP94Z6N849dIJ5+sq7v7X
         vwnQ==
X-Gm-Message-State: AOAM531y1Wth611QLk2yis8OPw4+QUZ6lO6cjM1o4h1GTOXkVZfkg+kZ
        t6oc0Y71XBwwZXb8Z0T1krs=
X-Google-Smtp-Source: ABdhPJygauHryTai+uKZ0vQMfYSaQ5JWWC9PFrT/37D2RwvWRc8jT11okVhSjO/kvRgz8NckJ2qirA==
X-Received: by 2002:a5d:648b:0:b0:1e2:181:96cb with SMTP id o11-20020a5d648b000000b001e2018196cbmr2922368wri.508.1645721320239;
        Thu, 24 Feb 2022 08:48:40 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:48:39 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/15] dt-bindings: clock: document qcom,gcc-ipq8064 binding
Date:   Thu, 24 Feb 2022 17:48:19 +0100
Message-Id: <20220224164831.21475-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224164831.21475-1-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
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

Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
clocks. The gcc node is also used by the tsens driver, already documented,
to get the calib nvmem cells and the base reg from gcc. Use
qcom,gcc.yaml as a template and remove the compatible from
generic qcom,gcc-other.yaml

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,gcc-ipq8064.yaml      | 76 +++++++++++++++++++
 .../bindings/clock/qcom,gcc-other.yaml        |  3 -
 2 files changed, 76 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
new file mode 100644
index 000000000000..9eb91dd22557
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq8064.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding for IPQ8064
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  Qualcomm global clock control module which supports the clocks, resets and
+  power domains on IPQ8064.
+
+  See also:
+  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
+  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
+
+properties:
+  compatible:
+    items:
+      - const: qcom,gcc-ipq8064
+      - const: syscon
+
+  clocks:
+    items:
+      - description: PXO source
+      - description: CXO source
+
+  clock-names:
+    items:
+      - const: pxo
+      - const: cxo
+
+  thermal-sensor:
+    type: object
+
+    allOf:
+      - $ref: /schemas/thermal/qcom-tsens.yaml#
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gcc: clock-controller@900000 {
+      compatible = "qcom,gcc-ipq8064", "syscon";
+      reg = <0x00900000 0x4000>;
+      clocks = <&pxo_board>, <&cxo_board>;
+      clock-names = "pxo", "cxo";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+
+      tsens: thermal-sensor {
+        compatible = "qcom,ipq8064-tsens";
+
+        nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
+        nvmem-cell-names = "calib", "calib_backup";
+        interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "uplow";
+
+        #qcom,sensors = <11>;
+        #thermal-sensor-cells = <1>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
index 47e1c5332d76..4dc0274dbd6b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -18,8 +18,6 @@ description:
   - dt-bindings/clock/qcom,gcc-ipq4019.h
   - dt-bindings/clock/qcom,gcc-ipq6018.h
   - dt-bindings/reset/qcom,gcc-ipq6018.h
-  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
-  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
   - dt-bindings/clock/qcom,gcc-msm8939.h
   - dt-bindings/clock/qcom,gcc-msm8953.h
   - dt-bindings/reset/qcom,gcc-msm8939.h
@@ -40,7 +38,6 @@ properties:
     enum:
       - qcom,gcc-ipq4019
       - qcom,gcc-ipq6018
-      - qcom,gcc-ipq8064
       - qcom,gcc-mdm9607
       - qcom,gcc-msm8226
       - qcom,gcc-msm8660
-- 
2.34.1

