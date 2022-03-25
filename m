Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987814E7293
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356242AbiCYMA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358360AbiCYMAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:00:54 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24E21EC5D;
        Fri, 25 Mar 2022 04:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648209551; x=1679745551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pNZ8xVDOh0Ixb6vSPTJQNHRLuQZruH5uNJAoGKrnnh4=;
  b=ERA15QkT1l1r3yybsQO3n1IiUZ7yD3ScPTXokWUbaQaXzJrS+2YC9M/Z
   Csg8vVbARHo4zZXq99D3oT6I/Tfyj5mDSrD0Csfw1zXY3rofj3DTOOpJq
   lsx6BLun3GScUstOq3ABe4H9niy+sUu6PXFaCnWmFG5akwu5Y3E+wJD0I
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Mar 2022 04:59:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 04:59:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 04:59:10 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 04:59:06 -0700
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
Subject: [PATCH V8 6/7] arm64: dts: qcom: pm8008-regulators: Add base dts file for pm8008 regulators
Date:   Fri, 25 Mar 2022 17:28:10 +0530
Message-ID: <1648209491-30165-7-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648209491-30165-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1648209491-30165-1-git-send-email-quic_c_skakit@quicinc.com>
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

Add base DTS file for pm8008 regulators with 7 ldo nodes.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V8:
 - Previously added pm8008 dtsi file is split into 2 files, one for infra
   and other for regulators.

 arch/arm64/boot/dts/qcom/pm8008-regulators.dtsi | 37 +++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008-regulators.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8008-regulators.dtsi b/arch/arm64/boot/dts/qcom/pm8008-regulators.dtsi
new file mode 100644
index 0000000..3bfdefd
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8008-regulators.dtsi
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2022, The Linux Foundation. All rights reserved.
+
+pm8008_regulators: pmic@9 {
+	compatible = "qcom,pm8008-regulators";
+	reg = <0x9>;
+	#address-cells = <0>;
+	#size-cells = <0>;
+
+	pm8008_l1: ldo1 {
+		regulator-name = "pm8008_l1";
+	};
+
+	pm8008_l2: ldo2 {
+		regulator-name = "pm8008_l2";
+	};
+
+	pm8008_l3: ldo3 {
+		regulator-name = "pm8008_l3";
+	};
+
+	pm8008_l4: ldo4 {
+		regulator-name = "pm8008_l4";
+	};
+
+	pm8008_l5: ldo5 {
+		regulator-name = "pm8008_l5";
+	};
+
+	pm8008_l6: ldo6 {
+		regulator-name = "pm8008_l6";
+	};
+
+	pm8008_l7: ldo7 {
+		regulator-name = "pm8008_l7";
+	};
+};
-- 
2.7.4

