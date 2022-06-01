Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DA853A31C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352319AbiFAKqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352306AbiFAKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:45:50 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD6813CE;
        Wed,  1 Jun 2022 03:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654080347; x=1685616347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1KO48kSNd8dE9dmSt1F5DQWcK7M2M5PR925qVblWSA8=;
  b=Ihq3vQ8EjwLKkZHJxplMWESs/mEJXtL/hFHX+3j1leiFsPA37PPUrPtJ
   96cbC7eg7HWdaDyh8i3IQk5YetISH9vrVxKScD0+SFALfiBJhtVYpYekW
   /BXbN+eY8jYuxaP2nmrd8yDcFu7+h93wnqqWTpd/xvj+u0N/qf4u0PrPW
   0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 01 Jun 2022 03:45:47 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Jun 2022 03:45:45 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 01 Jun 2022 16:15:23 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id E511D3FDB; Wed,  1 Jun 2022 16:15:22 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        manivannan.sadhasivam@linaro.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 09/11] dt-bindings: watchdog: Add binding for Qcom SDX65
Date:   Wed,  1 Jun 2022 16:15:10 +0530
Message-Id: <1654080312-5408-10-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for watchdog present in Qcom SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 16c6f82..e0acbc1 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -20,6 +20,7 @@ properties:
       - qcom,apss-wdt-sc7280
       - qcom,apss-wdt-sdm845
       - qcom,apss-wdt-sdx55
+      - qcom,apss-wdt-sdx65
       - qcom,apss-wdt-sm6350
       - qcom,apss-wdt-sm8150
       - qcom,apss-wdt-sm8250
-- 
2.7.4

