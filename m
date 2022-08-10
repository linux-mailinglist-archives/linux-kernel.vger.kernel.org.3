Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2268558E68A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 07:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiHJFF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 01:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiHJFFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 01:05:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89517A9C;
        Tue,  9 Aug 2022 22:05:33 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A4T0bp006618;
        Wed, 10 Aug 2022 05:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=1PmDl2MAGzaFsWcPNb/80KG0Ofe8DNu4dejKXX7cTfw=;
 b=eLdUrQAAX4Ks9qQz9e3DhS8BmkjvNzgsdqIiq+AjyMcSzT/PNwsfVczv8j+y9ASa41Jf
 e3U2OUz2fvqnbXeZiNt8dCAj05O5OUG5Ql75UfEpF+fW6mRb/C6C+L/Nxv7JXAUobweH
 g5P+a5t7uGBiXAXTagD4LBbEcdySAukAGr+UOxcDvP8+9gM/pC/2nyRSLBqfi5qOA1gn
 FAigH0ytOw6bHSK4G5fsp+2IO0TfmwWiQeElmyjq2KDbgh3z0p9vNC6vIZGgVPtl2San
 MxmE/+mRzLmgJXgMrAsDi5Sh2YO1HZ3UvWE6K4xoxUD6wDXhPGnkwTjHz5X/3FjOMJSL 2Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwr9h8tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 05:05:29 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27A55SZo009979
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 05:05:28 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 22:05:28 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 22:05:25 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>
Subject: [RESEND PATCH V4 1/3] arm64: dts: qcom: sc7280: Cleanup the lpasscc node
Date:   Wed, 10 Aug 2022 10:35:07 +0530
Message-ID: <1660107909-27947-2-git-send-email-quic_c_skakit@quicinc.com>
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
X-Proofpoint-ORIG-GUID: C2ZN6iy3C4X_OtAJbLqPL780Ds7B_MuP
X-Proofpoint-GUID: C2ZN6iy3C4X_OtAJbLqPL780Ds7B_MuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_01,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=808 lowpriorityscore=0 adultscore=32 phishscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes since v4:
 - Fix tabbing.

Changes since v3:
 - None.

Changes since v2:
 - Cleanup the lpasscc node to handle regmap overlap with lpass_aon
   instead of disabling the lpasscc node.
 - This patch is added in v3.

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 13d7f26..ca76310 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2168,9 +2168,8 @@
 		lpasscc: lpasscc@3000000 {
 			compatible = "qcom,sc7280-lpasscc";
 			reg = <0 0x03000000 0 0x40>,
-			      <0 0x03c04000 0 0x4>,
-			      <0 0x03389000 0 0x24>;
-			reg-names = "qdsp6ss", "top_cc", "cc";
+			      <0 0x03c04000 0 0x4>;
+			reg-names = "qdsp6ss", "top_cc";
 			clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
 			clock-names = "iface";
 			#clock-cells = <1>;
-- 
2.7.4

