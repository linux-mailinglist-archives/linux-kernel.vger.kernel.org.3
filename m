Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82CD58E68C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 07:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiHJFGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 01:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiHJFFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 01:05:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928B217A9C;
        Tue,  9 Aug 2022 22:05:39 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A2NCdm007964;
        Wed, 10 Aug 2022 05:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=d2zL0+vPYoY83eHFWOpk8iGA/oCIsL6rEcPi6amsHiU=;
 b=GE30WMHVE3oS2V0zHJWBEgyIwxMU3haNHhaNCMbVZllrq8eQSPz3wdznW9PX30u7FnSd
 E5qfbx/LMHRoFZw5pLIEdD6Lq46Z+NrK5SJyvpMMsyCUhneRRDCDfEzUhL1ympCUgF/Z
 SlVwfDAd275eSy4RxUupib9tn51cP1OHx0wjle5OQxX23EBhQJTSQ/0lkvYxzD4kKNii
 aM85TnXE3uwwF8J/qDvgZL485VeONkrsFJJCR3HMDmCGC5OFBlHkAUScP+GjdQfdXFdF
 LyAtWBDYPKe9QmpraC/3oPFjwvxku+mRIBu3uxsMEhseXxBH89WNcaWOioAbYB/RfOLj Pg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwqm96ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 05:05:36 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27A55Zv0019830
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 05:05:36 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 22:05:35 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 22:05:32 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>
Subject: [RESEND PATCH V4 3/3] arm64: dts: qcom: sc7280: Update lpasscore node
Date:   Wed, 10 Aug 2022 10:35:09 +0530
Message-ID: <1660107909-27947-4-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660107909-27947-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1660107909-27947-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b1UHrMbHD8LrzPL4U7Z28Ed_xT21R98y
X-Proofpoint-ORIG-GUID: b1UHrMbHD8LrzPL4U7Z28Ed_xT21R98y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_01,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=737 bulkscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100015
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To maintain consistency with other lpass nodes(lpass_audiocc,
lpass_aon and lpass_hm), update lpasscore to lpass_core.

Fixes: 9499240d15f2 ("arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes since v4:
 - None.

Changes since v3:
 - This is newly added in v4, inorder to update the lpasscore node in a
   separate patch.

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 4652f28..880217c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2192,13 +2192,13 @@
 			reg = <0 0x03380000 0 0x30000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 			       <&rpmhcc RPMH_CXO_CLK_A>,
-			       <&lpasscore LPASS_CORE_CC_CORE_CLK>;
+			       <&lpass_core LPASS_CORE_CC_CORE_CLK>;
 			clock-names = "bi_tcxo", "bi_tcxo_ao", "iface";
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
 		};
 
-		lpasscore: clock-controller@3900000 {
+		lpass_core: clock-controller@3900000 {
 			compatible = "qcom,sc7280-lpasscorecc";
 			reg = <0 0x03900000 0 0x50000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
-- 
2.7.4

