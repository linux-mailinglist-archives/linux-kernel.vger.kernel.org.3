Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F34530A70
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiEWHq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiEWHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:46:43 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7104B18B13;
        Mon, 23 May 2022 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653292001; x=1684828001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jkdxHplSLsDnOsD55YcH0JiIDuH9zEfIVpFV2KpIO/k=;
  b=Z7YPNuz4DGKmYuWNLAjwoK6Q3JOGDSnDj0O1F1d966VBi4WVzEVgfdap
   XQra6KCcjyVPkQN722hJ90t/9TxTM5cPWH6/h/pg22xBYuEkApNRsxFvW
   TwsFqcdBvm2Ia93T2u4a9CHllSbtyHEkLOHWm6qlpDjgDWRQdDuw7yjun
   c=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 23 May 2022 00:01:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:01:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 00:01:19 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 00:01:16 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <quic_psodagud@quicinc.com>, <eberman@codeaurora.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [RFC 1/3] dt-bindings: firmware: qcom-scm: Add interconnects property
Date:   Mon, 23 May 2022 12:30:56 +0530
Message-ID: <1653289258-17699-2-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653289258-17699-1-git-send-email-quic_sibis@quicinc.com>
References: <1653289258-17699-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnects as an optional property for SM8450 SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

Since the interconnect requirements could either be specified in the
individual remoteprocs or directly in the scm interface, will perform
the yaml conversion in the next re-spin based on the consensus.

 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index 0f4e5ab26477..4de3e055bc94 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -43,6 +43,7 @@ Required properties:
   clock and "bus" for the bus clock per the requirements of the compatible.
 - qcom,dload-mode: phandle to the TCSR hardware block and offset of the
 		   download mode control register (optional)
+- interconnects: Specifies the bandwidth requirements of the SCM interface (optional)
 
 Example for MSM8916:
 
-- 
2.7.4

