Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB6591467
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbiHLQ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbiHLQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:56:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908427B797;
        Fri, 12 Aug 2022 09:55:59 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CD08om020318;
        Fri, 12 Aug 2022 16:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=aF18twS7VGuz2bqTI0NaEtnaxlrXc4avcvX9CQEJn5Q=;
 b=pRGNuzb3M0VL1FGmh+xqYqiK/pJVYRms7SvebHHsMNTss2ITuFAD7sElMUiIRPj6S9th
 SLaILB76Damur3XVFEREcCJVSasnSv07Kqqm1IHMDUOYU1qWN8ucvdH95QirXNkrCnZO
 R2SSuomGnVjHqLJtXX3A8BbU32Y/8emSFQ7McQUGa2Qc8LGjFccJDSCk1mWwyFtYcBw5
 kltNi4DKiI164Q8xhZKSJY9LzjXKvj611ytzy+27V9Uko3i2jD7U+Q/qYopaGf11TntW
 tztj8Wwh/YmX7PDfMBuwsLWnLRPsf6noW8REcKsLslL6OrPKUkqDzKQ6bgwyYNxqajBd Kg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hw3a6vd77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 16:55:53 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27CGtqMs027343;
        Fri, 12 Aug 2022 16:55:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3hshcke1fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 16:55:52 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27CGtpcF027338;
        Fri, 12 Aug 2022 16:55:51 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 27CGtpEA027337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 16:55:51 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 12 Aug 2022 09:55:48 -0700
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Parikshit Pareek <quic_ppareek@quicinc.com>
Subject: [PATCH v3 1/3] dt-bindings: arm: qcom: Document additional sa8540p device
Date:   Fri, 12 Aug 2022 22:24:51 +0530
Message-ID: <20220812165453.11608-2-quic_ppareek@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220812165453.11608-1-quic_ppareek@quicinc.com>
References: <20220812165453.11608-1-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SrN4uLkFEpmtNq5RYDVjpY7Ns4Y-e0fu
X-Proofpoint-ORIG-GUID: SrN4uLkFEpmtNq5RYDVjpY7Ns4Y-e0fu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=879
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ADP ride device to the valid device compatibles found on the
sa8540p platform.

Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..2834119ee939 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -650,6 +650,7 @@ properties:
       - items:
           - enum:
               - qcom,sa8295p-adp
+              - qcom,sa8540p-adp-ride
           - const: qcom,sa8540p
 
       - items:
-- 
2.17.1

