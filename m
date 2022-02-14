Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA5A4B40F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbiBNEep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:34:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbiBNEeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:34:37 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812AF4F9E2;
        Sun, 13 Feb 2022 20:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644813270; x=1676349270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/XTb3JNfm/poX2YWAD4/clsHJQq6pxlQIHEn7nyn4jQ=;
  b=laHQvKnFjd0hGv6dss6UZo7r7HqpXZmbGFSNMr7rbIzwRtKhmGMURFP8
   XAbH2d3X/rqD7xNLeg0bbT0fl6NDU+ecRVq7EsCpPfnB0yTOnTLQ5ajfy
   4TZaOafRp3hpwz5OsTJRUvL+In2YqKLlZaC8l5Pit7IkSkJhkYASyIRjM
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Feb 2022 20:34:30 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 20:34:29 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 13 Feb 2022 20:34:29 -0800
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 13 Feb 2022 20:34:25 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>
CC:     <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <evgreen@chromium.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>, <mka@chromium.org>,
        <krzysztof.kozlowski@canonical.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 1/3] dt-bindings: remoteproc: qcom: Add interconnects property
Date:   Mon, 14 Feb 2022 10:04:10 +0530
Message-ID: <1644813252-12897-2-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644813252-12897-1-git-send-email-quic_sibis@quicinc.com>
References: <1644813252-12897-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnects property to support the bandwidth requirements
during modem bootup on SC7280 SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 8f1507052afd..a533dfa7d62c 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -183,6 +183,29 @@ For the compatible string below the following supplies are required:
 	qcom,sdm845-mss-pil:
 		    must be "cx", "mx", "mss"
 
+- interconnects:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the source and destination nodes of the interconnect paths
+		    that match the interconnect-names. See also interconnect/interconnect.txt
+
+- interconnect-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: The interconnects needed depend on the compatible string:
+	qcom,ipq8074-wcss-pil:
+	qcom,qcs404-wcss-pil:
+	qcom,q6v5-pil:
+	qcom,msm8916-mss-pil:
+	qcom,msm8974-mss-pil:
+	qcom,msm8996-mss-pil:
+	qcom,msm8998-mss-pil:
+	qcom,sc7180-mss-pil:
+	qcom,sdm845-mss-pil:
+		    no interconnect names required
+	qcom,sc7280-mss-pil:
+		    must be "imem"
+
 - qcom,qmp:
 	Usage: optional
 	Value type: <phandle>
-- 
2.7.4

