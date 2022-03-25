Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64924E729B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358158AbiCYMBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358259AbiCYMAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:00:51 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF7E1C132;
        Fri, 25 Mar 2022 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648209546; x=1679745546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JtwaNwXZ5bL7lijrK+4we8GHpV2xbXksOp/b1ryh9Es=;
  b=JZoZfa2Jyl7pQjlsfnbJpQS6jt43XUiYZEiMIwcEmXmJVihdueU3aj/j
   TU2PQFrr609KNm+QUUxXCEdrsCUsaNVbpJ8YCmucQMQGt731rNnR6qBwI
   YLG3AEF8Kgh0/i/qZ58Xytswz70896Y/bKpZC/I6SDp0BVNVRQmWK4FRN
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Mar 2022 04:59:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 04:59:06 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 04:59:05 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 04:59:01 -0700
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
Subject: [PATCH V8 5/7] arm64: dts: qcom: pm8008-infra: Add base dts file for pm8008 infra
Date:   Fri, 25 Mar 2022 17:28:09 +0530
Message-ID: <1648209491-30165-6-git-send-email-quic_c_skakit@quicinc.com>
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

Add base DTS file for pm8008 infra with parent mfd node.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V8:
 - Previously added pm8008 dtsi file is split into 2 files, one for infra
   and other for regulators.

 arch/arm64/boot/dts/qcom/pm8008-infra.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8008-infra.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8008-infra.dtsi b/arch/arm64/boot/dts/qcom/pm8008-infra.dtsi
new file mode 100644
index 0000000..aeba07a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8008-infra.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2022, The Linux Foundation. All rights reserved.
+
+pm8008_infra: pmic@8 {
+	compatible = "qcom,pm8008-infra";
+	reg = <0x8>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
-- 
2.7.4

