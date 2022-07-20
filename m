Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38E157B54E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiGTLWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbiGTLWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:22:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A75E52E52;
        Wed, 20 Jul 2022 04:22:44 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KAo1jZ010915;
        Wed, 20 Jul 2022 11:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/N5Ad3r6JLwed+don2w1OlltfGWtqA7z4ms2NFtDvjg=;
 b=GMQ2FYFyTc/eZjw9luuO+zrBvjLc4bBdVQbgxp2bXk/IOVnyfLnhLRePFOIzrV9LUiXf
 HrljmGOanLNy2DnHCbup6N+9f3gjdH4EibJZCOmxL/NopsvUDqNnkIb6edwSHMIF/d88
 is9rgoqnqTpowvHU54D25/8PRyxbz4vXaE82xmSZoCAdlXWlNZ67gDjFb15wZQAbGlyx
 lFYraDjUeE3/qEYDm0PUrdNRbVEpFVlXQSFqicQyt2dFO5eASxfsFe987drBUIjlsTdd
 lH3MO+gafATiscUsa87p0yb7AxGmRsRlwOVdGMbGKcbeHBcNKQ+jEUpN/Cbesm67Hb38 nQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hebfv0uvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 11:22:40 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KBMeiW027448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 11:22:40 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 04:22:39 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 04:22:36 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>
Subject: [PATCH V3 1/2] arm64: dts: qcom: sc7280: Cleanup the lpasscc node
Date:   Wed, 20 Jul 2022 16:52:23 +0530
Message-ID: <1658316144-16520-2-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658316144-16520-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1658316144-16520-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oRlZT5b-Kqx-szk_foEbPvGb9mGlX7D_
X-Proofpoint-ORIG-GUID: oRlZT5b-Kqx-szk_foEbPvGb9mGlX7D_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=817
 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=20 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200047
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "cc" regmap from lpasscc node which is overlapping
with the lpass_aon regmap.

Fixes: 422a295221bb ("arm64: dts: qcom: sc7280: Add clock controller nodes")
Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
Changes since v2:
 - Cleanup the lpasscc node to handle regmap overlap with lpass_aon
   instead of disabling the lpasscc node.
 - This patch is added in v3.

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 13d7f26..71735bb 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2168,9 +2168,8 @@
 		lpasscc: lpasscc@3000000 {
 			compatible = "qcom,sc7280-lpasscc";
 			reg = <0 0x03000000 0 0x40>,
-			      <0 0x03c04000 0 0x4>,
-			      <0 0x03389000 0 0x24>;
-			reg-names = "qdsp6ss", "top_cc", "cc";
+				  <0 0x03c04000 0 0x4>;
+			reg-names = "qdsp6ss", "top_cc";
 			clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
 			clock-names = "iface";
 			#clock-cells = <1>;
-- 
2.7.4

