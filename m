Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402724BD564
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344337AbiBUFX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:23:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiBUFX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:23:27 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C42E2D;
        Sun, 20 Feb 2022 21:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645420986; x=1676956986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=k/SrkmNO3uWYgzq06IwevJ6gIjLamufvr/U1/0YEWR4=;
  b=ICfIgMqTSzIQNTCZmYutEFecmAHb1QYZP3RZlp9EfMSAZZU0Eq+UE7a/
   CpcQ3jFOPPoo2V7kGLaB/hmSH/TkkyRACaPaiuttErwvxJt8EjuNUVPIs
   f5Ojn6L5zpaOVTxbfW/ORGv/pE3KFehLiYTwpu3hJKxPAPqvG/Y0iMu9g
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 20 Feb 2022 21:23:05 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Feb 2022 21:23:02 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Feb 2022 10:52:53 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 1DAB546C3; Mon, 21 Feb 2022 10:52:53 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 3/7] dt-bindings: clock: Add A7 PLL binding for SDX65
Date:   Mon, 21 Feb 2022 10:52:29 +0530
Message-Id: <1645420953-21176-4-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML binding for Cortex A7 PLL clock in Qualcomm
platforms like SDX65.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,a7pll.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,a7pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a7pll.yaml
index 8666e99..b8889dc 100644
--- a/Documentation/devicetree/bindings/clock/qcom,a7pll.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,a7pll.yaml
@@ -10,13 +10,14 @@ maintainers:
   - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 
 description:
-  The A7 PLL on the Qualcomm platforms like SDX55 is used to provide high
+  The A7 PLL on the Qualcomm platforms like SDX55, SDX65 is used to provide high
   frequency clock to the CPU.
 
 properties:
   compatible:
     enum:
       - qcom,sdx55-a7pll
+      - qcom,sdx65-a7pll
 
   reg:
     maxItems: 1
-- 
2.7.4

