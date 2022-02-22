Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA484BF1CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiBVF4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:56:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiBVF4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:56:08 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FC82B26F;
        Mon, 21 Feb 2022 21:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645509342; x=1677045342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9d618VuAFcZLjSxXSiO48GqmOlIllscxot2/zXxFAzs=;
  b=UYbCVeI/n/+Tkh6xcxd1c2a5YT6eZIF+Em/CZT1biNYH8eK2Ohpj1nlO
   JGkce54QDH1l3ovYB5dD6pWoKezzb2JjIGZDrmwtNcboHQK8mQiL3hGIB
   OCudBVBd7InkvwVIc7ZHUN+Iqh9gserWkZs/KZFqqD5DyfutHThdZS0ks
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Feb 2022 21:55:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 21:55:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Feb 2022 21:55:41 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Feb 2022 21:55:37 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V4 1/4] dt-bindings: leds: Add pm8350c pmic support
Date:   Tue, 22 Feb 2022 11:25:06 +0530
Message-ID: <1645509309-16142-2-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com>
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

Add pm8350c pmic pwm support.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in V2:
 - No changes.

Changes in V3:
 - No changes.

Changes in V4:
 - No changes.

 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 336bd8e..409a4c7 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - qcom,pm8150b-lpg
       - qcom,pm8150l-lpg
+      - qcom,pm8350c-pwm
       - qcom,pm8916-pwm
       - qcom,pm8941-lpg
       - qcom,pm8994-lpg
-- 
2.7.4

