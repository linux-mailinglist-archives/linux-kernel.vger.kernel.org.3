Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557275128A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbiD1BRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240582AbiD1BQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:16:45 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E356B369F7;
        Wed, 27 Apr 2022 18:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651108406; x=1682644406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ETtu/JXolCZgtw04vL8fJdMG86c05ohO0c9rbBE7X5M=;
  b=KdzZUkFdBxROAfeG3AaksGZfHgJEG4qu3805h1V7bl+bI5Oo9aRwUbDn
   Br1QKgIRxSqop+2T+D01p0y4zAyql1h6J+MrEiL3d0xIf8j18YOws0DV/
   sGysklpzW0IeDQcWjW8MnsXv7QzodorSfENSCCv769ruikF0pfxHNvWMh
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2022 18:13:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 18:13:24 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 18:13:24 -0700
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 18:13:21 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>,
        <maz@kernel.org>, "David Collins" <collinsd@codeaurora.org>
Subject: [RESEND PATCH V6 08/10] dt-bindings: spmi: spmi-pmic-arb: make interrupt properties as optional
Date:   Thu, 28 Apr 2022 09:12:47 +0800
Message-ID: <1651108369-11059-9-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651108369-11059-1-git-send-email-quic_fenglinw@quicinc.com>
References: <1651108369-11059-1-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

Make all interrupt related properties as optional instead of
required.  Some boards do not required PMIC IRQ support and it
isn't needed to handle SPMI bus transactions, so specify it as
optional.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
index 55d379c..fee4f0e 100644
--- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
+++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
@@ -88,9 +88,6 @@ properties:
 required:
   - compatible
   - reg-names
-  - interrupts
-  - interrupt-names
-  - '#interrupt-cells'
   - qcom,ee
   - qcom,channel
 
-- 
2.7.4

