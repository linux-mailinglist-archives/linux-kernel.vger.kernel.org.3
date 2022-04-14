Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B73500D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbiDNMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243342AbiDNMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:33:22 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE39D275E3;
        Thu, 14 Apr 2022 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649939458; x=1681475458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Aq8HvzHRB/MIc27qf/VrkpAgx3k8PjsQkDRQBQeNTR4=;
  b=AIl3Fjl5xSc3jv124aJpQ0kjchL+jn6Hf23jhZ8atckPP/qJT6+00rTa
   fxAPUCV9iADC5vs8gyCXmX3AeRvNIoTUFv3osk8i5DYgiJyKKt0piT3QR
   E/u+UCHaJq+YsQFD8S64degaP9TmBXJspkn2f1wtHlrLFR/ITGZ8xAWl0
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 14 Apr 2022 05:30:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:30:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 05:30:57 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 05:30:52 -0700
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
Subject: [PATCH V10 1/9] dt-bindings: mfd: pm8008: Add reset-gpios
Date:   Thu, 14 Apr 2022 18:00:10 +0530
Message-ID: <1649939418-19861-2-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset-gpios property for pm8008.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in V10:
 - None.

Changes in V9:
 - Undo the changes from V8 and only add reset-gpios. Leave interrupts
   as required properties and do not change compatible.

 Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index ec3138c..3312784 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
@@ -44,6 +44,9 @@ properties:
   "#size-cells":
     const: 0
 
+  reset-gpios:
+    maxItems: 1
+
 patternProperties:
   "^gpio@[0-9a-f]+$":
     type: object
@@ -92,6 +95,7 @@ required:
   - "#address-cells"
   - "#size-cells"
   - "#interrupt-cells"
+  - reset-gpios
 
 additionalProperties: false
 
@@ -99,6 +103,7 @@ examples:
   - |
     #include <dt-bindings/mfd/qcom-pm8008.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
     qupv3_se13_i2c {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -113,6 +118,8 @@ examples:
         interrupt-parent = <&tlmm>;
         interrupts = <32 IRQ_TYPE_EDGE_RISING>;
 
+        reset-gpios = <&pm8350c_gpios 4 GPIO_ACTIVE_HIGH>;
+
         pm8008_gpios: gpio@c000 {
           compatible = "qcom,pm8008-gpio", "qcom,spmi-gpio";
           reg = <0xc000>;
-- 
2.7.4

