Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C59954AD99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242192AbiFNJtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbiFNJt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:49:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A843381;
        Tue, 14 Jun 2022 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655200168; x=1686736168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=zloDX301/+iZ5Jpjn+s5ttooRKmMJqRov6E37MQ5uf4=;
  b=MEvj2i3zVe/mWguZv6Oy058hJ9cQjZvuzkzG/+Nr32CtEWDLWynd+849
   KtOtJ5qL87NjO8Lq/6j05YPUkC/Bvei4abZ098NzSks459pr5JPCT8cSc
   Ny/dvfWkN+OikDT060WiKtos3Wi3XFl5dh1CkYBxioOwMJgR+fVemvFWM
   A=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 14 Jun 2022 02:49:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 02:49:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 02:49:21 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 02:49:16 -0700
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
Subject: [PATCH V15 3/9] dt-bindings: mfd: pm8008: Add regulators for pm8008
Date:   Tue, 14 Jun 2022 15:18:25 +0530
Message-ID: <1655200111-18357-4-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
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

Add regulators and their parent supplies along with example.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in V15:
 - None.

Changes in V14:
 - None.

Changes in V13:
 - None.

 .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index a54d1ce0..fd3c51e 100644
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
   "^gpio@0,[0-9a-f]+$":
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

