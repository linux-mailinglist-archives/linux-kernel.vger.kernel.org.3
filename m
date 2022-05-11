Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854B752340B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbiEKNUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243738AbiEKNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:19:30 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547CA2469CF;
        Wed, 11 May 2022 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652275167; x=1683811167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=WCxOupJ7jOWivGIb7XUrdsY4tpQco+HSUEbzzGV3I7E=;
  b=fR3IcI6IGf50QhN6BvFcToaqQ1uajW6hy1xiJcIHL5bL6+NDIsL3v2oH
   FV758P7OFCfNRp9GEwvU5KhnN9//8JbGl/4nQN84TJJ3p40TSVVk+PFFw
   5PGAZn2ySAoGXAvsWYPwbB2zB4zCppJWew9AYmh5Q/v41g/JMSjcNqzyg
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 May 2022 06:19:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 06:19:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:19:26 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:19:21 -0700
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
Subject: [PATCH V12 8/9] arm64: dts: qcom: pm8008: Add base dts file
Date:   Wed, 11 May 2022 18:48:32 +0530
Message-ID: <1652275113-10277-9-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652275113-10277-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1652275113-10277-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add base DTS file for pm8008.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in V12:
 - None.

Changes in V11:
 - Remove intermediate regulators node and add the ldos under
   pm8008@8 node.
 - change the address cells as 2 for pm8008 parent mfd node.
 - add compatible to register the ldos.
 - add reg with i2c client offset and address.

Changes in V10:
 - Add regulators under pm8008@8 i.e main mfd node.

Changes in V9:
 - Add single dt file for pm8008 instead of adding files like in V8.

 arch/arm64/boot/dts/qcom/pm8008.dtsi | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8008.dtsi b/arch/arm64/boot/dts/qcom/pm8008.dtsi
new file mode 100644
index 0000000..5606344
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8008.dtsi
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2022, The Linux Foundation. All rights reserved.
+
+&pm8008_bus {
+	pm8008: pmic@8 {
+		compatible = "qcom,pm8008";
+		reg = <0x8>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		pm8008_l1: ldo1@1,4000 {
+			compatible = "qcom,pm8008-regulator";
+			reg = <0x1 0x4000>;
+			regulator-name = "pm8008_ldo1";
+		};
+
+		pm8008_l2: ldo2@1,4100 {
+			compatible = "qcom,pm8008-regulator";
+			reg = <0x1 0x4100>;
+			regulator-name = "pm8008_ldo2";
+		};
+
+		pm8008_l3: ldo3@1,4200 {
+			compatible = "qcom,pm8008-regulator";
+			reg = <0x1 0x4200>;
+			regulator-name = "pm8008_ldo3";
+		};
+
+		pm8008_l4: ldo4@1,4300 {
+			compatible = "qcom,pm8008-regulator";
+			reg = <0x1 0x4300>;
+			regulator-name = "pm8008_ldo4";
+		};
+
+		pm8008_l5: ldo5@1,4400 {
+			compatible = "qcom,pm8008-regulator";
+			reg = <0x1 0x4400>;
+			regulator-name = "pm8008_ldo5";
+		};
+
+		pm8008_l6: ldo6@1,4500 {
+			compatible = "qcom,pm8008-regulator";
+			reg = <0x1 0x4500>;
+			regulator-name = "pm8008_ldo6";
+		};
+
+		pm8008_l7: ldo7@1,4600 {
+			compatible = "qcom,pm8008-regulator";
+			reg = <0x1 0x4600>;
+			regulator-name = "pm8008_ldo7";
+		};
+	};
+};
-- 
2.7.4

