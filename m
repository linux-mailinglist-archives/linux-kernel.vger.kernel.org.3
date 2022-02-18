Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361914BB78A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiBRLCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:02:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiBRLCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:02:13 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D731520F1EA;
        Fri, 18 Feb 2022 03:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645182110; x=1676718110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=gTa0ubc6wl3DTkZPwxXDqdBDqbFQUlwhlwQfqOMBJMA=;
  b=HfAs+y0fEw8EdF/+6kGRmmsg3PR5ettd93u9fckLb0TMpHg+MaAdIL8V
   TFd54JBi/8PlcvK+ZEMAXIllFwNay5kIRn2SP0z7s0c+VPzQGCtQTzLZs
   Il2Jo4uZo+vtH3qqA2eLDdpKg4qPW/QRn/quG5Zd1+qKIlcWByZTU3Brs
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Feb 2022 03:01:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 03:01:50 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 03:01:49 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 03:01:45 -0800
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
Subject: [PATCH V7 4/5] arm64: dts: qcom: pm8008: Add base dts file
Date:   Fri, 18 Feb 2022 16:31:02 +0530
Message-ID: <1645182064-15843-5-git-send-email-quic_c_skakit@quicinc.com>
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

Changes in V7:
 - Removed intermediate regulators node.

 arch/arm64/boot/dts/qcom/pm8008.dtsi | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8008.dtsi b/arch/arm64/boot/dts/qcom/pm8008.dtsi
new file mode 100644
index 0000000..0f48572
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8008.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2022, The Linux Foundation. All rights reserved.
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

