Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E15A9751
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiIAMss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiIAMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:48:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6054C3DF30;
        Thu,  1 Sep 2022 05:48:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281AJ4r8006896;
        Thu, 1 Sep 2022 12:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=05x7D+R7WOxi5Sz+XrpfweGrXywMPlTTWxDngUkRLag=;
 b=SOpf3rKPvh8PWH+3KEWR8C+Q2cpMNQmjGSx+xjoJKwCSZC/CTV8J0vyCWrPU5o23Dhgu
 5+fn9i8631CYmVnTvDyn8E1svzOt04rpXxm4hfj8eCCoMokQ8aHpU+sh0/yt86YtiDpK
 9D8zIDPDgK3Xie1NylYDQprFjjxtAsDYyn+4Gho7mmaM6M+ioKPnGhAsFGD+97/xYOm5
 AsCqG+8eUFfxCj4xjXAA+4n26/p8z+4GbkTcZae7qHC3JnXrJzLyy/3eb+1/LDis87NH
 i4RmwVAKIXPWikH7ipbvZOxZAAcmfW1Dt7KQd7N+xXIAMSZ4e7ygfwZO8EG76sJnLPss 7A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jaeb4tfdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 12:48:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 281CmXVv011311
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 12:48:33 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 05:48:30 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 1/4] dt-bindings: interconnect: qcom,msm8998-bwmon: Add support for sc7280 BWMONs
Date:   Thu, 1 Sep 2022 18:17:27 +0530
Message-ID: <20220901124730.19460-2-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901124730.19460-1-quic_rjendra@quicinc.com>
References: <20220901124730.19460-1-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kczql5KR9Ue-IgLcAGzjj2CyINIkKvnJ
X-Proofpoint-ORIG-GUID: kczql5KR9Ue-IgLcAGzjj2CyINIkKvnJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for the cpu BWMON (version 4) instance and one
for the llcc BWMON (version 5) found in sc7280 SoC.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 32e2892d736b..cac915c5c2aa 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -25,8 +25,10 @@ properties:
       - items:
           - enum:
               - qcom,sdm845-bwmon
+              - qcom,sc7280-bwmon
           - const: qcom,msm8998-bwmon
       - const: qcom,msm8998-bwmon       # BWMON v4
+      - const: qcom,sc7280-llcc-bwmon   # BWMON v5
       - const: qcom,sdm845-llcc-bwmon   # BWMON v5
 
   interconnects:
-- 
2.17.1

