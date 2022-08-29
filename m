Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260B05A433A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiH2G2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2G15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:27:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814414B0F6;
        Sun, 28 Aug 2022 23:27:56 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T5xJul017631;
        Mon, 29 Aug 2022 06:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=l+tIFk905R+cdNRGRHG3he8TeMJjuNU1aF1sos3nHJw=;
 b=F5REKwhNLzKp8o5jtBzM5O45VpIT9KCMIa9AkD7SjraRix+ge+OURaMwRt6S4Gu2+xpK
 STQtAp4Ut7fPNZ52eSCq+G9ingTGPGgKzZi/NLrEYZ9vf5//RR34unKgiLeLppNpbip2
 F643wKNc2QNBUuVyNXGZzZq7qz1b+NJhrFhhvIGKJpMAf9pWWG8Gz026B0nxrCy85UNG
 0lSqbj1tRHB8jOfGd08SsC6G19npumOuuycf7J7Nw9a9pui4o+dytXG2IeZqmGDhDQx2
 479Sxr3/M7L2AialkxcNV43TCi5lw1DRLNijxj7izzPLV7KIzYMC00rBQVa46iWat/cD kQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j7ceu3g8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 06:27:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27T6Mqhs031435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 06:22:52 GMT
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 28 Aug 2022 23:22:48 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <quic_c_skakit@quicinc.com>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH V8 1/5] dt-bindings: clock: Add "qcom,adsp-pil-mode" property
Date:   Mon, 29 Aug 2022 11:52:29 +0530
Message-ID: <1661754153-14813-2-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1661754153-14813-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1661754153-14813-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6CsfLkQPMSmGjfexTC3_fEkg-IoIIBc7
X-Proofpoint-ORIG-GUID: 6CsfLkQPMSmGjfexTC3_fEkg-IoIIBc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_03,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290031
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When this property is set, the remoteproc is used to boot the
LPASS and therefore lpass_q6ss_ahbm_clk and lpass_q6ss_ahbs_clk
clocks would be used to bring LPASS out of reset and the rest of
the lpass clocks would be controlled directly by the remoteproc.

This is a cleanup done to handle overlap of regmap of
lpasscc and lpass_aon blocks.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml   | 6 ++----
 .../devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml         | 7 +++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
index 47028d7..633887d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
@@ -36,13 +36,11 @@ properties:
     items:
       - description: LPASS qdsp6ss register
       - description: LPASS top-cc register
-      - description: LPASS cc register
 
   reg-names:
     items:
       - const: qdsp6ss
       - const: top_cc
-      - const: cc
 
 required:
   - compatible
@@ -59,8 +57,8 @@ examples:
     #include <dt-bindings/clock/qcom,lpass-sc7280.h>
     clock-controller@3000000 {
       compatible = "qcom,sc7280-lpasscc";
-      reg = <0x03000000 0x40>, <0x03c04000 0x4>, <0x03389000 0x24>;
-      reg-names = "qdsp6ss", "top_cc", "cc";
+      reg = <0x03000000 0x40>, <0x03c04000 0x4>;
+      reg-names = "qdsp6ss", "top_cc";
       clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
       clock-names = "iface";
       #clock-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
index bad9135..5ccfb24 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
@@ -41,6 +41,12 @@ properties:
   reg:
     maxItems: 1
 
+  qcom,adsp-pil-mode:
+    description:
+      Indicates if the LPASS would be brought out of reset using
+      peripheral loader.
+    type: boolean
+
 required:
   - compatible
   - reg
@@ -165,6 +171,7 @@ examples:
       clocks = <&rpmhcc RPMH_CXO_CLK>, <&rpmhcc RPMH_CXO_CLK_A>,
                <&lpasscore LPASS_CORE_CC_CORE_CLK>;
       clock-names = "bi_tcxo", "bi_tcxo_ao","iface";
+      qcom,adsp-pil-mode;
       #clock-cells = <1>;
       #power-domain-cells = <1>;
     };
-- 
2.7.4

