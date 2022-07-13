Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CFB573D42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiGMTeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbiGMTen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:34:43 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D2C27160;
        Wed, 13 Jul 2022 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657740882; x=1689276882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jd8Hi43evaBgn191EKvHjKni5pg8aaEABaiuOpMfmpY=;
  b=JiVmJGECVs/BaVSojXgdlEvL35abqJgfdHtfLbnuqbhnRcqhGp1Z5vVX
   r6Ja+MI3gSfDge+nPrINcJZSJ+RjXcQ/63yjmYnWyIIEs1hONdUfdNLH9
   y7B1KhX9jt9kV/cTBbp+0Qy8ivh7VOgWNnlVF6Zz5Ib9DAJ1EIqQpRNqV
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jul 2022 12:34:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 12:34:40 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Jul 2022 12:34:39 -0700
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Jul 2022 12:34:39 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <corbet@lwn.net>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Collins <quic_collinsd@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v3 1/2] dt-bindings: power: reset: qcom-pon: update "reg" property details
Date:   Wed, 13 Jul 2022 12:33:50 -0700
Message-ID: <20220713193350.29796-2-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713193350.29796-1-quic_amelende@quicinc.com>
References: <20220713193350.29796-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
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

From: David Collins <quic_collinsd@quicinc.com>

Update the description of "reg" property to add the PON_PBS base
address along with PON_HLOS base address.  Also add "reg-names"
property description.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 73 ++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 353f155d..562fe308 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -15,18 +15,26 @@ description: |
 
   This DT node has pwrkey and resin as sub nodes.
 
-allOf:
-  - $ref: reboot-mode.yaml#
-
 properties:
   compatible:
     enum:
       - qcom,pm8916-pon
       - qcom,pms405-pon
       - qcom,pm8998-pon
+      - qcom,pmk8350-pon
 
   reg:
-    maxItems: 1
+    description: |
+      Specifies the SPMI base address for the PON (power-on) peripheral.  For
+      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
+      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
+      peripherals.  In that case, the PON_PBS address needs to be specified to
+      facilitate software debouncing on some PMIC.
+
+  reg-names:
+    description: |
+      For PON GEN1 and GEN2, it should be "pon". For PON GEN3 it should include
+      "hlos" and optionally "pbs".
 
   pwrkey:
     type: object
@@ -42,6 +50,63 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: reboot-mode.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,pm8916-pon
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names:
+          items:
+            - const: pon
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,pms405-pon
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names:
+          items:
+            - const: pon
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,pm8998-pon
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names:
+          items:
+            - const: pon
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,pmk8350-pon
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 2
+        reg-names:
+          minItems: 1
+          items:
+            - const: hlos
+            - const: pbs
+
 examples:
   - |
    #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.35.1

