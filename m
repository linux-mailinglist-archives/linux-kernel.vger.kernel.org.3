Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB5657E9E8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiGVWkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbiGVWkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:40:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E22AFB5C;
        Fri, 22 Jul 2022 15:38:41 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MMP3Z8024841;
        Fri, 22 Jul 2022 22:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=KE+Fl0ZxBTCz3b0DZd6BUNq+L+lHnmfuXs5O5UWd4b4=;
 b=YiMuaUuIzZWknGyc3kqln3xW5yr+DVvW2MFEnJghOi22UNcAHVqCUhHp/7cAj4MuhRZ2
 UPeJPk1WqAMxpKS1sPN/Of3RYoGZSdCLJfNxVPbWioj/yDYN1aSPjwVzREfKnQkMu7qp
 z14/Erx2FsxJclqc4X3SXjAH7Gms3xxCtLP8W1CmGK4yzDsEUoP6YdCkPDl1DKlvZ+Bi
 Y3kBZa+ChLPWZubCOSYWwrOmFH0WcRtiWqTSeSm2XsKHxtpdnySbFlk/jem18hFKaj7x
 nfZfLdeTUTX3YnwTxrkiVczC8c7PPsm5fpuMVabZUfqNmCW37o6oWGc/jS/f25CjTHuM xw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hfkm5agrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 22:37:27 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26MMbQkE005708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 22:37:26 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 15:37:25 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH v2 1/5] dt-bindings: firmware: qcom-scm: Add "allow-multi-call" property
Date:   Fri, 22 Jul 2022 15:37:14 -0700
Message-ID: <1658529438-9234-2-git-send-email-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658529438-9234-1-git-send-email-quic_gurus@quicinc.com>
References: <1658529438-9234-1-git-send-email-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hwYcZ1ZyuwxsYzKt85qhncwdTMsIbtXG
X-Proofpoint-ORIG-GUID: hwYcZ1ZyuwxsYzKt85qhncwdTMsIbtXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 mlxlogscore=875 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For firmware that supports it, allow multiple SCM calls to be passed
down to it by removing the serialization lock in the SCM driver.

This patch is based on this YAML conversion patch [1] that is in-flight
currently.

[1] https://lore.kernel.org/lkml/20220708090431.30437-1-david@ixit.cz/

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 9fdeee0..e279fd2 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -70,6 +70,11 @@ properties:
   '#reset-cells':
     const: 1
 
+  allow-multi-call:
+    description:
+      Specify this flag to remove SCM call serialization. Need to ensure that
+      the firmware being used supports this feature first.
+
   qcom,dload-mode:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-- 
2.7.4

