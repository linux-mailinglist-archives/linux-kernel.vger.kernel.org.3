Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E752D53FDFE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbiFGLwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243274AbiFGLvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:51:45 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6879B5264;
        Tue,  7 Jun 2022 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654602676; x=1686138676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=YIjqd2K/QdFdV9nFvZMlYpZGoOQ9537POYqX0h1sUX8=;
  b=S9zatf7Zoe9spRlDQI3R9bXDoIgGkJ3Mipw7tAZEzSlkLT4gNXiThuiy
   CouJ6DJqWRw4TMs3inFtJ5FKphj5wznUtv+FmETAlEZlx5zYxz0qKWQ8r
   jcYY2q8fZIqdgU3Dpdk5kM+m+LusMapR/VLZRaXX46oTKw7QAyAfzjDVF
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jun 2022 04:51:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 04:51:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 04:51:15 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 04:51:11 -0700
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
Subject: [PATCH V14 8/9] arm64: dts: qcom: pm8008: Add base dts file
Date:   Tue, 7 Jun 2022 17:20:14 +0530
Message-ID: <1654602615-28849-9-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654602615-28849-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1654602615-28849-1-git-send-email-quic_c_skakit@quicinc.com>
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

Add base DTS file for pm8008.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in V14:
 - None.

Changes in V13:
 - None.

Changes in V12:
 - None.

Changes in V11:
 - Remove intermediate regulators node and add the ldos under
   pm8008@8 node.
 - change the address cells as 2 for pm8008 parent mfd node.
 - add compatible to register the ldos.
 - add reg with i2c client offset and address.

 arc
 arch/arm64/boot/dts/qcom/pm8008.dtsi | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8008.dtsi b/arch/arm64/boot/dts/qcom/pm8008.dtsi
new file mode 100644
index 0000000..6f37e4d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8008.dtsi
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
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

