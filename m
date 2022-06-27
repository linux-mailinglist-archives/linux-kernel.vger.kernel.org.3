Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA5D55CAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbiF0To7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbiF0Tot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:44:49 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9751902E;
        Mon, 27 Jun 2022 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656359089; x=1687895089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=f4x2hY+CiCXpi7EzQz5u/6iYv9zaU/fh9x1P2F0Bsnc=;
  b=UKh9YqnM2E4YovB6i+aKgp0MHOgriglXVgtO+nfVtW9C4Q/uax9e9lQM
   oTW020IbBWG9Y/9biIqE3oaSg5qs6G/kuYgpo3cNkfLM4skvnGrRtXON1
   ECVUmngYiDOG2E9mu0C2SjessunxTAF61+55M5zWlf+q/QFq8g4Vlu9eN
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jun 2022 12:44:48 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 12:44:48 -0700
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 12:44:48 -0700
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
Subject: [PATCH 3/5] dt-bindings: firmware: qcom-scm: Add optional interrupt
Date:   Mon, 27 Jun 2022 12:44:34 -0700
Message-ID: <1656359076-13018-4-git-send-email-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656359076-13018-1-git-send-email-quic_gurus@quicinc.com>
References: <1656359076-13018-1-git-send-email-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an interrupt specification to the bindings to support the wait-queue
feature.

There's a patch already in flight [1] to convert the bindings to YAML. I
will make a patch against it when it gets accepted.

[1] https://lore.kernel.org/linux-arm-msm/20220626183247.142776-3-david@ixit.cz/

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index 8a68018..e1d746e 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -45,6 +45,8 @@ Required properties:
 		   download mode control register (optional)
 - allow-multi-call: Specify this to remove SCM call serialization. Need to
 		    ensure that the firmware being used supports this.
+- interrupts: Wait-queue interrupt that firmware raises as part of handshake
+	      procedure to handle sleeping SCM calls.
 
 Example for MSM8916:
 
-- 
2.7.4

