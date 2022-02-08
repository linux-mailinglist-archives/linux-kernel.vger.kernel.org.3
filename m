Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697564ADBB8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378930AbiBHOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378711AbiBHOzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:55:15 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91978C0613CA;
        Tue,  8 Feb 2022 06:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644332109; x=1675868109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vplpyTffC6DUMauYxzTZ+heqUUZUUY+aw+95xcotik0=;
  b=wGaQy78PN2okVKr5ezaquk6ZzVjyUEkLkZP1mWtUWWPIE0uwZQNS2Jr2
   B4pq1mwCcB1s9+Gydolfy57xlBB5lV2OSrqAXA/R7eZryo90+zuy2g7Qr
   dHKvDtnlWN6ZvoTGDAxjCLNIlWDX9hg2xMTGLtRVPFI/dR/jyH9MUGwEp
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Feb 2022 06:55:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 06:55:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 06:55:08 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 06:55:03 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V5 5/6] arm64: dts: qcom: pm8008: Add base dts file
Date:   Tue, 8 Feb 2022 20:22:19 +0530
Message-ID: <1644331940-18986-6-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
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

 arch/arm64/boot/dts/qcom/pm8008.dtsi | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8008.dtsi b/arch/arm64/boot/dts/qcom/pm8008.dtsi
new file mode 100644
index 0000000..8e04983
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
+		pm8008_l1: LDO1 {
+			regulator-name = "pm8008_l1";
+		};
+
+		pm8008_l2: LDO2 {
+			regulator-name = "pm8008_l2";
+		};
+
+		pm8008_l3: LDO3 {
+			regulator-name = "pm8008_l3";
+		};
+
+		pm8008_l4: LDO4 {
+			regulator-name = "pm8008_l4";
+		};
+
+		pm8008_l5: LDO5 {
+			regulator-name = "pm8008_l5";
+		};
+
+		pm8008_l6: LDO6 {
+			regulator-name = "pm8008_l6";
+		};
+
+		pm8008_l7: LDO7 {
+			regulator-name = "pm8008_l7";
+		};
+	};
+};
-- 
2.7.4

