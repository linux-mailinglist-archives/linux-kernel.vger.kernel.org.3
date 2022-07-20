Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2CA57B54F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbiGTLWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbiGTLWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:22:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D002953D37;
        Wed, 20 Jul 2022 04:22:47 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KAnVXc019353;
        Wed, 20 Jul 2022 11:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4TSEcRdRMkrGcJYLT1rCWgoMhn5j5pqG4lhzkQEFWQQ=;
 b=NNc6ypdmbeMpQsDJMfuePjZ8E1Lk8dLv4NHc+mNA1QCYkCESm32t8piF8pCfrF9uwREM
 ERP4o0ag98GnIgrb+zZH83aO3AKnUofbxWicY4+pD6Y9CugqrO7zqPzQAtNn7dmMdXHb
 H+JzD0Nm1jxUFDF0hGRXMLl5R1aJp3auxVeJ53xJnZ5vRXW9UW2G4oXqnDeaHyILrW4E
 HzsQyoi1rWRc+9yL9Q0fUKn0LnzaKT3t/IQanYr3CLPWgwWxfZg4P6h0GAwJHjyHfF6Z
 j+2rObnrbGaTr4g7tzw4OJYBTuMLAxKRzpamZq7LPONVbsEOFzIAFAzTIYm0BkwbEZgp CA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hdsmu3cka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 11:22:44 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KBMiAH002323
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 11:22:44 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 04:22:43 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 04:22:40 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>
Subject: [PATCH V3 2/2] arm64: dts: qcom: sc7280: Update lpassaudio clock controller for resets
Date:   Wed, 20 Jul 2022 16:52:24 +0530
Message-ID: <1658316144-16520-3-git-send-email-quic_c_skakit@quicinc.com>
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
X-Proofpoint-GUID: wTOizOwsryM4LYlCd6pdHRI91QPI90_g
X-Proofpoint-ORIG-GUID: wTOizOwsryM4LYlCd6pdHRI91QPI90_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 mlxlogscore=963
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200047
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <quic_tdas@quicinc.com>

The lpass audio supports TX/RX/WSA block resets. Also to keep
consistency update lpasscore to lpass_core.

Fixes: 9499240d15f2 ("arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes since v3:
 - Remove the status="disabled" from lpasscc node.

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 71735bb..c641f0b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2184,6 +2184,7 @@
 			power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		lpass_aon: clock-controller@3380000 {
@@ -2191,13 +2192,13 @@
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

