Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596FA4BB776
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiBRLCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:02:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiBRLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:01:55 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669CB12D09A;
        Fri, 18 Feb 2022 03:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645182097; x=1676718097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xC0tnBauPfrhyHvmFyGrK+yrVEmvEbfDV8uXMcB0bCk=;
  b=NNFGcquHsNqbzcAy0ZnXGfQjFSlQ92a9/8wWXaqMQ2+bqYdc5Dda5ppq
   kp84KQ+oGSEX9xkz/txtWB1ZG2MtV0XHFXwbru2iP9mwqKDPorHS9+y3i
   /pnY6FE+g9AUCjFKcFx3F+2aRmlnD2LmhzvgGI2HzC+Jns4YVTgyh2AoQ
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Feb 2022 03:01:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 03:01:36 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 03:01:35 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 03:01:31 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V7 1/5] dt-bindings: mfd: pm8008: Add pm8008 regulators
Date:   Fri, 18 Feb 2022 16:30:59 +0530
Message-ID: <1645182064-15843-2-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Add regulators and their supply nodes. Add separate compatible
"qcom,pm8008-regulators" to differentiate between pm8008 infra
and pm8008 regulators mfd devices.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
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

Changes in V6:
 - No changes.

Changes in V7:
 - Removed the intermediate regulators node and added ldos
   directly under mfd node.

 .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 50 +++++++++++++++++++---
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index ec3138c..6b3b53e 100644
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
@@ -44,6 +46,21 @@ properties:
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
 patternProperties:
   "^gpio@[0-9a-f]+$":
     type: object
@@ -85,13 +102,16 @@ patternProperties:
 
     additionalProperties: false
 
+  "^ldo[1-7]$":
+    type: object
+    $ref: "../regulator/regulator.yaml#"
+    description: PM8008 regulator peripherals of PM8008 regulator device
+
 required:
   - compatible
   - reg
-  - interrupts
   - "#address-cells"
   - "#size-cells"
-  - "#interrupt-cells"
 
 additionalProperties: false
 
@@ -102,13 +122,11 @@ examples:
     qupv3_se13_i2c {
       #address-cells = <1>;
       #size-cells = <0>;
-      pm8008i@8 {
+      pm8008_infra: pm8008@8 {
         compatible = "qcom,pm8008";
         reg = <0x8>;
         #address-cells = <1>;
         #size-cells = <0>;
-        interrupt-controller;
-        #interrupt-cells = <2>;
 
         interrupt-parent = <&tlmm>;
         interrupts = <32 IRQ_TYPE_EDGE_RISING>;
@@ -123,6 +141,24 @@ examples:
           #interrupt-cells = <2>;
         };
       };
-    };
 
+      pm8008_regulators: pm8008@9 {
+        compatible = "qcom,pm8008-regulators";
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
+        pm8008_l1: ldo1 {
+          regulator-name = "pm8008_l1";
+          regulator-min-microvolt = <950000>;
+          regulator-max-microvolt = <1300000>;
+        };
+      };
+    };
 ...
-- 
2.7.4

