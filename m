Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839334ADBAA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378626AbiBHOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378647AbiBHOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:54:56 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E054C07E5C0;
        Tue,  8 Feb 2022 06:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644332094; x=1675868094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pxqBVbsJyx8rHUlwmooHV5411GrDOuELi7lTU0SiMqE=;
  b=M7Uph0Ux6F4qqQaR5XddvJyj+WaGGTiffUsBLv9Hup2+C8rwfJGYhwxx
   1FSgU+JBSKwLqEcXKtH8Wxyocw8MZZrr+wZlsrtak+RGjPReMGtxVNJ4Z
   b9rV8BTnwK1iHG0kCvoewzrC39kc6Dnb8u26+Jrb0K56ADsYar/TRXKJF
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Feb 2022 06:54:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 06:54:53 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 06:54:53 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 06:54:48 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V5 2/6] dt-bindings: mfd: pm8008: Add regulators node
Date:   Tue, 8 Feb 2022 20:22:16 +0530
Message-ID: <1644331940-18986-3-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulators node and their supply nodes. Add separate compatible
"qcom,pm8008-regulators" to differentiate between pm8008 infra
and pm8008 regulators mfd devices.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in V2:
 - As per Rob's comments changed "pm8008[a-z]?-regulator" to
   "^pm8008[a-z]?-regulators".

Changes in V3:
 - Fixed bot errors.
 - As per stephen's comments, changed "^pm8008[a-z]?-regulators$" to
   "regulators".

Changes in V4:
 - Changed compatible string to "qcom,pm8008-regulators"

Changes in V5:
 - Remove compatible for regulators node.
 - Move supply nodes of the regulators to chip level.

 .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 49 +++++++++++++++++++---
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index ec3138c..fbe84e4 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
@@ -16,7 +16,9 @@ description: |
 
 properties:
   compatible:
-    const: qcom,pm8008
+    enum:
+      - qcom,pm8008
+      - qcom,pm8008-regulators
 
   reg:
     description:
@@ -44,6 +46,25 @@ properties:
   "#size-cells":
     const: 0
 
+  vdd_l1_l2-supply:
+    description: Input supply phandle of ldo1 and ldo2 regulators.
+
+  vdd_l3_l4-supply:
+    description: Input supply phandle of ldo3 and ldo4 regulators.
+
+  vdd_l5-supply:
+    description: Input supply phandle of ldo5 regulator.
+
+  vdd_l6-supply:
+    description: Input supply phandle of ldo6 regulator.
+
+  vdd_l7-supply:
+    description: Input supply phandle of ldo7 regulator.
+
+  regulators:
+    type: object
+    $ref: "../regulator/qcom,pm8008-regulator.yaml#"
+
 patternProperties:
   "^gpio@[0-9a-f]+$":
     type: object
@@ -88,10 +109,8 @@ patternProperties:
 required:
   - compatible
   - reg
-  - interrupts
   - "#address-cells"
   - "#size-cells"
-  - "#interrupt-cells"
 
 additionalProperties: false
 
@@ -102,7 +121,7 @@ examples:
     qupv3_se13_i2c {
       #address-cells = <1>;
       #size-cells = <0>;
-      pm8008i@8 {
+      pm8008_infra: pm8008@8 {
         compatible = "qcom,pm8008";
         reg = <0x8>;
         #address-cells = <1>;
@@ -123,6 +142,26 @@ examples:
           #interrupt-cells = <2>;
         };
       };
-    };
 
+      pm8008_regulators: pm8008@9 {
+        compatible = "qcom,pm8008";
+        reg = <0x9>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vdd_l1_l2-supply = <&vreg_s8b_1p2>;
+        vdd_l3_l4-supply = <&vreg_s1b_1p8>;
+        vdd_l5-supply = <&vreg_bob>;
+        vdd_l6-supply = <&vreg_bob>;
+        vdd_l7-supply = <&vreg_bob>;
+
+        regulators {
+          pm8008_l1: LDO1 {
+            regulator-name = "pm8008_l1";
+            regulator-min-microvolt = <950000>;
+            regulator-max-microvolt = <1300000>;
+          };
+        };
+      };
+    };
 ...
-- 
2.7.4

