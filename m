Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E454ADAD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbiFNJtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiFNJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:49:27 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D7E42EFC;
        Tue, 14 Jun 2022 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655200167; x=1686736167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XZ8/9+cQEX308pQGpU44/0IIhbv/Q9SjME2A7Ke5S3A=;
  b=Ml5FzbZM2pV+ZCGUhmcaHU0lZX4Ploppr0P36WMjX93NA1QayqRrgNQC
   FSv/V4SGlgCZkQWN27ZuR7yjjcC8+l8yioaGdO41tcqd0q0n3IJQMjcfu
   qvxhXE7ivWNHmZM5xfRP8Uh2MhDqSL5SN0payPfGYemUv+RjJ7tQSo9Xy
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 14 Jun 2022 02:49:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 02:49:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 02:49:16 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 02:49:12 -0700
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
Subject: [PATCH V15 2/9] dt-bindings: mfd: pm8008: Change the address cells
Date:   Tue, 14 Jun 2022 15:18:24 +0530
Message-ID: <1655200111-18357-3-git-send-email-quic_c_skakit@quicinc.com>
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

Change the address cells as '2' so that the first cell
describes the i2c address offset of the clients.
This helps us to define the child nodes of all
clients under the same parent mfd node, instead of
adding separate mfd DT nodes.

Change the gpios reg value accordingly.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in V15:
 - None.

Changes in V14:
 - None.

Changes in V13:
 - Fixed nit.

 Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index a89649c..a54d1ce0 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
@@ -39,7 +39,7 @@ properties:
   interrupt-controller: true
 
   "#address-cells":
-    const: 1
+    const: 2
 
   "#size-cells":
     const: 0
@@ -48,7 +48,7 @@ properties:
     maxItems: 1
 
 patternProperties:
-  "^gpio@[0-9a-f]+$":
+  "^gpio@0,[0-9a-f]+$":
     type: object
 
     description: |
@@ -61,7 +61,7 @@ patternProperties:
           - const: qcom,spmi-gpio
 
       reg:
-        description: Peripheral address of one of the two GPIO peripherals.
+        description: Peripheral offset and address of one of the two GPIO peripherals.
         maxItems: 1
 
       gpio-controller: true
@@ -110,7 +110,7 @@ examples:
       pm8008i@8 {
         compatible = "qcom,pm8008";
         reg = <0x8>;
-        #address-cells = <1>;
+        #address-cells = <2>;
         #size-cells = <0>;
         interrupt-controller;
         #interrupt-cells = <2>;
@@ -120,9 +120,9 @@ examples:
 
         reset-gpios = <&pm8350c_gpios 4 GPIO_ACTIVE_LOW>;
 
-        pm8008_gpios: gpio@c000 {
+        pm8008_gpios: gpio@0,c000 {
           compatible = "qcom,pm8008-gpio", "qcom,spmi-gpio";
-          reg = <0xc000>;
+          reg = <0x0 0xc000>;
           gpio-controller;
           gpio-ranges = <&pm8008_gpios 0 0 2>;
           #gpio-cells = <2>;
-- 
2.7.4

