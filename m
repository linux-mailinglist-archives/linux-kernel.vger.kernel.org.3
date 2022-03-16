Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8673E4DAA66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353782AbiCPGI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbiCPGIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:08:54 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1893960A9B;
        Tue, 15 Mar 2022 23:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647410861; x=1678946861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=H1PNNKUmtisypQK3aFnIm6rXbyA2hlKe1tHnsR4y0vg=;
  b=iVP/0eu8ETPwcXABGkqT33JyDG5eW19hbJg+6ACx0VvE3Iw9GtsW++SB
   CAktCdXUyHfNN7WVbkadpG9FofeHhBeGZu/YGsaFsMQ+sr+RuPodxvlYw
   oEyvIYsGrHcCLsy44N8GO1unwzYqbnMLeA/YHwNOE562Qw3K3g8Uts34/
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 23:07:41 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Mar 2022 23:07:39 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 16 Mar 2022 11:37:23 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id C59414793; Wed, 16 Mar 2022 11:37:22 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, rnayak@codeaurora.org, collinsd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 5/6] dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx65 support
Date:   Wed, 16 Mar 2022 11:37:16 +0530
Message-Id: <1647410837-22537-6-git-send-email-quic_rohiagar@quicinc.com>
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

Add support for the PMX65 GPIO support to the Qualcomm PMIC GPIO
binding.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 9400b66..15df3fc 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -52,6 +52,7 @@ properties:
           - qcom,pmr735b-gpio
           - qcom,pms405-gpio
           - qcom,pmx55-gpio
+          - qcom,pmx65-gpio
 
       - enum:
           - qcom,spmi-gpio
@@ -139,6 +140,7 @@ $defs:
                                             and gpio10)
                  - gpio1-gpio11 for pmx55 (holes on gpio3, gpio7, gpio10
                                             and gpio11)
+                 - gpio1-gpio16 for pmx65
 
         items:
           pattern: "^gpio([0-9]+)$"
-- 
2.7.4

