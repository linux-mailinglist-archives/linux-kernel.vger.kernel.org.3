Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1F4B66B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiBOIyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:54:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiBOIys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:54:48 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4295F114761;
        Tue, 15 Feb 2022 00:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644915279; x=1676451279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qzbNOTl31AnU0Y9ugc9YX5fm6nhjs7o9n7p7DdjxhS0=;
  b=s8GGC0PaeWkys7JkEx/MC1wtE3E10ee5wBrR2Ged4tXdtdLRPyGqm/4o
   8h/y+0m7YYqpGP05QFytyonB4dyApH7ZJfXKLTIHtyuOtGARicc4KVBnX
   FuX86i+rNzIl3UXpALdkt8CocF9NrG0g2lXZzv0lJu1crw02Fyd3PuT7C
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Feb 2022 00:54:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:54:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 00:54:38 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 00:54:33 -0800
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
Subject: [PATCH V6 5/6] arm64: dts: qcom: pm8008: Add base dts file
Date:   Tue, 15 Feb 2022 14:23:50 +0530
Message-ID: <1644915231-7308-6-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
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

Add base DTS file for pm8008 with infra and regulator nodes.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V4:
 - This is newly added in V4, to add all the pm8008 common stuff.

Changes in V5:
 - Changed the mfd node names from pm8008_chip to pm8008_infra and
   pm8008_ldo to pm8008_regulators as they re more appropriate.
 - Changed the compatible for pm8008@9 mfd node to differentiate from
   pm8008@8 node in driver.
 - Removed compatible for regulators node.
 - Removed reg property for LDOs and added in driver.

Changes in V6:
 - Changed node names to small letters.

 arch/arm64/boot/dts/qcom/pm8008.dtsi | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8008.dtsi b/arch/arm64/boot/dts/qcom/pm8008.dtsi
new file mode 100644
index 0000000..8193d11
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8008.dtsi
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2021, The Linux Foundation. All rights reserved.
+
+pm8008_infra: pm8008@8 {
+	compatible = "qcom,pm8008";
+	reg = <0x8>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
+
+pm8008_regulators: pm8008@9 {
+	compatible = "qcom,pm8008-regulators";
+	reg = <0x9>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	regulators {
+		pm8008_l1: ldo1 {
+			regulator-name = "pm8008_l1";
+		};
+
+		pm8008_l2: ldo2 {
+			regulator-name = "pm8008_l2";
+		};
+
+		pm8008_l3: ldo3 {
+			regulator-name = "pm8008_l3";
+		};
+
+		pm8008_l4: ldo4 {
+			regulator-name = "pm8008_l4";
+		};
+
+		pm8008_l5: ldo5 {
+			regulator-name = "pm8008_l5";
+		};
+
+		pm8008_l6: ldo6 {
+			regulator-name = "pm8008_l6";
+		};
+
+		pm8008_l7: ldo7 {
+			regulator-name = "pm8008_l7";
+		};
+	};
+};
-- 
2.7.4

