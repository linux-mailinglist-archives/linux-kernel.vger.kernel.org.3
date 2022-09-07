Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA185B0E12
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIGUW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIGUW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:22:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA0A344F;
        Wed,  7 Sep 2022 13:22:55 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287Jp78t025015;
        Wed, 7 Sep 2022 20:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=96CoWXBNWFyHqb0OoMX1vjLm7LmH0Hb9+T6/5a/VshU=;
 b=RYVm/2jSEpAR5WQBCkaGO5L2JVsB/Qg4dk5MfXFE517lkueINkZWcJC+BBkYsL9+pI6B
 IXqoeT2i2olB89I34elGWgSuFOaiGdG/ui1VuSWbiZ5fDOoeCyMLMD99YpnvhIpZyuOU
 LP5++hmdL6IwtsiP15E6b8llIL5wkqA30NUV3gNOF13TnxNfANVAqlNw+3f4ph3vnKMO
 RAyI+vfDBrYuTDB8la11OnQ6VNCQ3JAGoNEZvumC7J+Bn/EvX5O9eyS0DL7sMVh1NeoP
 qBB4ueEeJqdzwRDoMqbQ67cQbT0Hp1VKstPdVCcGhiWqfJTdSZBnWB2ddI1Une++mr7L UA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jf1swr20u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 20:22:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 287KHn3n027424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 20:17:49 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 7 Sep 2022 13:17:48 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <konrad.dybcio@somainline.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 4/4] dt-bindings: qcom-pmic-gpio: Add PM7250B and PM8450 bindings
Date:   Wed, 7 Sep 2022 13:15:33 -0700
Message-ID: <20220907201528.9351-5-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907201528.9351-1-quic_amelende@quicinc.com>
References: <20220907201528.9351-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xEaKE2eJJeGJicnRwH58VHB423nh4ghv
X-Proofpoint-ORIG-GUID: xEaKE2eJJeGJicnRwH58VHB423nh4ghv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=809
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
to include compatible strings for PM7250B and PM8450 PMICs.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 694898f382be..a548323e54f1 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,pm6150-gpio
           - qcom,pm6150l-gpio
           - qcom,pm6350-gpio
+          - qcom,pm7250b-gpio
           - qcom,pm7325-gpio
           - qcom,pm8005-gpio
           - qcom,pm8008-gpio
@@ -392,6 +393,7 @@ $defs:
                  - gpio1-gpio10 for pm6150
                  - gpio1-gpio12 for pm6150l
                  - gpio1-gpio9 for pm6350
+                 - gpio1-gpio12 for pm7250b
                  - gpio1-gpio10 for pm7325
                  - gpio1-gpio4 for pm8005
                  - gpio1-gpio2 for pm8008
@@ -407,6 +409,7 @@ $defs:
                  - gpio1-gpio10 for pm8350
                  - gpio1-gpio8 for pm8350b
                  - gpio1-gpio9 for pm8350c
+                 - gpio1-gpio4 for pm8450
                  - gpio1-gpio38 for pm8917
                  - gpio1-gpio44 for pm8921
                  - gpio1-gpio36 for pm8941
-- 
2.35.1

