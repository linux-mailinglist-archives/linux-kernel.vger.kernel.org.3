Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1274DAA67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353813AbiCPGJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353772AbiCPGI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:08:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820A60AA9;
        Tue, 15 Mar 2022 23:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647410865; x=1678946865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=uvv4kbTGxkppA+t+d+Xa2thmLzw257UwAbDUaXC1GlQ=;
  b=WzfFOGEr26xDCZ9FzmULqlSxr7/fOn/dTbDDP/RLoyeAClXgprVqDP5b
   CYUGdAUWyap5j4hcRuElGeiUWX+qR0TaooH+vpeJxB3efFj080B8D6JsQ
   kzy+cFuCfFJRipBdN2Y6mwea+xFlaCb7o1+dUWJHa9DLuFgrRICHTr9VC
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 23:07:45 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Mar 2022 23:07:42 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 16 Mar 2022 11:37:21 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 9D5654793; Wed, 16 Mar 2022 11:37:20 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, rnayak@codeaurora.org, collinsd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 1/6] regulator: dt-bindings: Add PMX65 compatibles
Date:   Wed, 16 Mar 2022 11:37:12 +0530
Message-Id: <1647410837-22537-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647410837-22537-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1647410837-22537-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMX65 compatibles for PMIC found in SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 5c73d3f..e28ee9e 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -48,6 +48,7 @@ description: |
       For PMI8998, bob
       For PMR735A, smps1 - smps3, ldo1 - ldo7
       For PMX55, smps1 - smps7, ldo1 - ldo16
+      For PMX65, smps1 - smps8, ldo1 - ldo21
 
 properties:
   compatible:
@@ -70,6 +71,7 @@ properties:
       - qcom,pmm8155au-rpmh-regulators
       - qcom,pmr735a-rpmh-regulators
       - qcom,pmx55-rpmh-regulators
+      - qcom,pmx65-rpmh-regulators
 
   qcom,pmic-id:
     description: |
-- 
2.7.4

