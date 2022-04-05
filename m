Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201434F469E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbiDEUhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442389AbiDEPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:37:37 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734BE11176C;
        Tue,  5 Apr 2022 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649166709; x=1680702709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=3CrOD25U3ySH2uSvK1Gaz4RsMlsq+CbHlHbLLw9go20=;
  b=JljUFUuXV3jwSeCr5L3ws9/DyLSa+YFTffiph6whYqcM7I4RCAhY7SBp
   YGyRRrnKBlq3P7vnEPwESzxPim8R5WTwFjlY+0Ux9UZW92cefpz0dfdnj
   8UVn0cQBaeziusCF13lG9LX4DF5q2aIkFHUVZfjLGCM/9U1O7LiZApUOD
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Apr 2022 06:51:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 06:51:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 06:51:32 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 06:51:28 -0700
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
Subject: [PATCH V9 5/6] arm64: dts: qcom: pm8008: Add base dts file
Date:   Tue, 5 Apr 2022 19:20:32 +0530
Message-ID: <1649166633-25872-6-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
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
Changes in V9:
 - Add single dt file for pm8008 instead of adding files like in V8.

 arch/arm64/boot/dts/qcom/pm8008.dtsi | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8008.dtsi b/arch/arm64/boot/dts/qcom/pm8008.dtsi
new file mode 100644
index 0000000..24bd832
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8008.dtsi
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2022, The Linux Foundation. All rights reserved.
+
+&pm8008_bus {
+	pm8008: pm8008@8 {
+		compatible = "qcom,pm8008";
+		reg = <0x8>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	pm8008_regulators: pm8008@9 {
+		compatible = "qcom,pm8008-regulators";
+		reg = <0x9>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+
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

