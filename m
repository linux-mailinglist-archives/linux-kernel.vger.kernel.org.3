Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFA14DAA72
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353801AbiCPGJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353722AbiCPGI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:08:56 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8030F60A9C;
        Tue, 15 Mar 2022 23:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647410864; x=1678946864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=P8IfAWTDGVPmQKmJvYEfh7oWc7C4SlN2zWmkSg/4iVk=;
  b=v/3WFfD1WfjelI8ObG0tefGTn19Grh/7MadTv3zfsq6/GGBzFLNSENWH
   KGhTsbC7vZCNg08SwuBXXgtXdJghHH4cL4+sPv4/XPeRpMlzs3otD7xVA
   I5/ZKK5wwHpo6TdCPWaC1UaJ0S7tjvwwYOMcCCZNhTY4RCTyTjQAqxk7p
   U=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 23:07:43 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Mar 2022 23:07:41 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 16 Mar 2022 11:37:24 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 702F04495; Wed, 16 Mar 2022 11:37:23 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, rnayak@codeaurora.org, collinsd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 6/6] pinctrl: qcom-pmic-gpio: Add support for pmx65
Date:   Wed, 16 Mar 2022 11:37:17 +0530
Message-Id: <1647410837-22537-7-git-send-email-quic_rohiagar@quicinc.com>
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

PMX65 pmic support gpio controller so add compatible.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index f2eac3b..5f19506 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1182,6 +1182,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pms405-gpio", .data = (void *) 12 },
 	/* pmx55 has 11 GPIOs with holes on 3, 7, 10, 11 */
 	{ .compatible = "qcom,pmx55-gpio", .data = (void *) 11 },
+	{ .compatible = "qcom,pmx65-gpio", .data = (void *) 16 },
 	{ },
 };
 
-- 
2.7.4

