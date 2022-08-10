Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F53C58E835
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiHJHw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiHJHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:52:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E04B7644E;
        Wed, 10 Aug 2022 00:52:17 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A7olSo026180;
        Wed, 10 Aug 2022 07:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=vWhQZqGRBkYSNRYjuN2l4W9cDAXE3v1d1zqQPcld/Yg=;
 b=HCXfW7XGvMhanr6FFQfW/Cnu5U4UXv9QAlJse3Gh0tuFaXdmjvkJHXjUulu9hzuWxrGM
 byJ3P6aOoLbltVmOpF8Pn5SWPQj+BAOAncvD2DdznfbEHL2C+LBAOuYme3W7tJePuBuJ
 GKl14XQNe5vgbyC4X+qjvZHRosrbC/YMcP8Q4a5arJIZuyWs54m4twWYXyfHhtZ/kUgL
 E8czOK11I3++d/JdH0hpWO3fEQ1jLZ7mbUfOkiaWcmHo9RFpxhMajZIP1TblSYD9FlCA
 nfC6Oy04fM0PODnXJDecIg3Yu2uzfyvdioV39moJsOvt2plKbPuQ+weOEgXp0EQIn/e4 Ng== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwqqhktp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 07:51:36 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27A7kZS9007576
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 07:46:35 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 00:46:35 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 00:46:30 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v3 2/8] dt-bindings: remoteproc: qcom: adsp: Add required bindings for SC7280
Date:   Wed, 10 Aug 2022 13:15:52 +0530
Message-ID: <1660117558-21829-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660117558-21829-1-git-send-email-quic_srivasam@quicinc.com>
References: <1660117558-21829-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dg7DDzfdiAj7zw6mNmBU_BCKpyafln6t
X-Proofpoint-ORIG-GUID: dg7DDzfdiAj7zw6mNmBU_BCKpyafln6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_03,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100022
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible name, clocks and update max reg items for SC7280
based platforms.
Add adsp-memory-regions property, required for memory sandboxing.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since V2:
	-- Add clock property.
	-- Add qcom,adsp-memory-regions property.
Changes since V1:
	-- Change reg property maxItems to minItems and update description.

 .../bindings/remoteproc/qcom,lpass-adsp-pil.yaml          | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
index 9f11332..45bc732 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
@@ -17,11 +17,13 @@ properties:
   compatible:
     enum:
       - qcom,sdm845-adsp-pil
+      - qcom,sc7280-adsp-pil
 
   reg:
-    maxItems: 1
-    description:
-      The base address and size of the qdsp6ss register
+    minItems: 1
+    items:
+      - description: qdsp6ss register
+      - description: efuse q6ss register
 
   interrupts:
     items:
@@ -48,6 +50,7 @@ properties:
       - description: QDSP XO clock
       - description: Q6SP6SS SLEEP clock
       - description: Q6SP6SS CORE clock
+      - description: GCC CFG NOC clock
 
   clock-names:
     items:
@@ -58,6 +61,7 @@ properties:
       - const: qdsp6ss_xo
       - const: qdsp6ss_sleep
       - const: qdsp6ss_core
+      - const: gcc_cfg_noc
 
   power-domains:
     items:
@@ -77,6 +81,11 @@ properties:
     maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
+  qcom,adsp-memory-regions:
+    minItems: 1
+    items:
+      - description: List of memory regions accessed by ADSP firmware.
+
   qcom,halt-regs:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description:
-- 
2.7.4

