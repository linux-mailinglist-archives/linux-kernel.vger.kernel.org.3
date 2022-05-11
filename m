Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46155233F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbiEKNTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbiEKNTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:19:05 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C1723677A;
        Wed, 11 May 2022 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652275145; x=1683811145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=U2kacXGJOPEe5GjtzLxRzXO9xMIgNAgjBN70Rg8weF4=;
  b=qWkI0n1vYp4xKpmd2u6gcRR2ZvK/0k24Ll4Mom7YR36BrLs6PbK6S7U7
   j+YBdgExFzOLbnGukij/LAswyFyRUFL0V54tyk9SIYaqA3wxyRwrjN3Ab
   XJ+neYSQScemGmqZZgm+z7ikCBkWcDoz8LyWfhvXvkHp4dvgWe/puALPg
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 May 2022 06:19:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 06:19:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:19:04 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:18:59 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V12 3/9] dt-bindings: mfd: pm8008: Add regulators for pm8008
Date:   Wed, 11 May 2022 18:48:27 +0530
Message-ID: <1652275113-10277-4-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652275113-10277-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1652275113-10277-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulators and their parent supplies along with example.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in V12:
 - None.

Changes in V11:
 - Add ldos directly under pm8008@8 node, remove the intermediate "regulators"
   node.

Changes in V10:
 - Regulators are added as a part of pm8008@8 device. Change bindings doc
   accordingly.

Changes in V9:
 - Remove description for reg and drop unused phandle from example.

Changes in V8:
 - This is split from pm8008.yaml binding.

 .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index a41618e..231aaf0 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
@@ -47,6 +47,21 @@ properties:
   reset-gpios:
     maxItems: 1
 
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
   "^gpio@[0],[0-9a-f]+$":
     type: object
@@ -88,6 +103,27 @@ patternProperties:
 
     additionalProperties: false
 
+  "^ldo[1-7]@[1],[0-9a-f]+$":
+    type: object
+
+    $ref: "/schemas/regulator/regulator.yaml#"
+
+    description: PM8008 regulator peripherals of PM8008 regulator device.
+
+    properties:
+      compatible:
+        const: qcom,pm8008-regulator
+
+      reg:
+        description: Peripheral offset and address of the ldo regulator.
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -120,6 +156,12 @@ examples:
 
         reset-gpios = <&pm8350c_gpios 4 GPIO_ACTIVE_LOW>;
 
+        vdd_l1_l2-supply = <&vreg_s8b_1p2>;
+        vdd_l3_l4-supply = <&vreg_s1b_1p8>;
+        vdd_l5-supply = <&vreg_bob>;
+        vdd_l6-supply = <&vreg_bob>;
+        vdd_l7-supply = <&vreg_bob>;
+
         pm8008_gpios: gpio@0,c000 {
           compatible = "qcom,pm8008-gpio", "qcom,spmi-gpio";
           reg = <0x0 0xc000>;
@@ -129,6 +171,14 @@ examples:
           interrupt-controller;
           #interrupt-cells = <2>;
         };
+
+        ldo1@1,4000 {
+          compatible = "qcom,pm8008-regulator";
+          reg = <0x1 0x4000>;
+          regulator-name = "pm8008_ldo1";
+          regulator-min-microvolt = <950000>;
+          regulator-max-microvolt = <1300000>;
+        };
       };
     };
 
-- 
2.7.4

