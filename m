Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2975A70CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiH3W1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiH3W05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:26:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BB767C93;
        Tue, 30 Aug 2022 15:25:31 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UJAgYk004621;
        Tue, 30 Aug 2022 22:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YHfq26Jki1OpoFOt7dvhlzhQTdKm3YYxb/Io14yx4fo=;
 b=BVmIDYd+myLqbxO4JtGnYs4UCkf+MXg8Hi98qo6FX83sp7sr/7Y8EsmjWE4nqN9KpaAz
 HqtM3vKfDe1tA2hzM3EA2LyQ2UPfsNpqJnarIYSJcvjL8ePvjTPD0be14CvBkXVaKrls
 ovGihV+39M/Q+2o9mw+7o5Bsie0qeI4JNZzsbPgyo7UWPxwkUrHYwpryAsJvyUxRW82+
 ObdkV3+G1zl2Kr3d9t/AHHNwrMZZDBzN6b5vo/5WPqbifua7Q/ZiFZ2IhwbwVusLaXj6
 ClusJCleaNmdjewYD+eBaBcnYPDWnamW25dirlLnKBNnw0+4jmRK3PhQGpXEO2g8HaBy kw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j9n861cfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 22:25:20 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27UMPJbm010687
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 22:25:19 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 30 Aug 2022 15:25:19 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [RESEND PATCH v2 3/5] dt-bindings: firmware: qcom-scm: Add optional interrupt
Date:   Tue, 30 Aug 2022 15:25:09 -0700
Message-ID: <1661898311-30126-4-git-send-email-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
References: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DIKGDZpMiUu2u6MAiV3vD0dIIxA6PxVb
X-Proofpoint-ORIG-GUID: DIKGDZpMiUu2u6MAiV3vD0dIIxA6PxVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 mlxlogscore=532 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an interrupt specification to the bindings to support the wait-queue
feature.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index e279fd2..4d6c89f 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -75,6 +75,11 @@ properties:
       Specify this flag to remove SCM call serialization. Need to ensure that
       the firmware being used supports this feature first.
 
+  interrupts:
+    description:
+      The wait-queue interrupt that firmware raises as part of handshake
+      protocol to handle sleeping SCM calls.
+
   qcom,dload-mode:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-- 
2.7.4

