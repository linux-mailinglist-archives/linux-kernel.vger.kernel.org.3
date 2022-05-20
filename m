Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39D752F01F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351437AbiETQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351423AbiETQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:10:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5FF17D3B6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:10:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x143so8119705pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hED0E7H63k3wk0xBVAxG4bpFqihFcaVUlfl6ydWvpJ8=;
        b=evwRSx8YZOl35u8n6foEoPs2cAi0EhjjrqD+NQRGZ64BD12AHU//U5xgW0a0NPM0cE
         Mo8f1GLSA5jUTvCUVgHSyEY5ZDfgBTZPJ+TSjQ975WysA3nNIJ+3I05PXLYmS5yIKfv5
         GlPIKxLVQPm0IspSNuaZJpQKS0SSzcfzkelqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hED0E7H63k3wk0xBVAxG4bpFqihFcaVUlfl6ydWvpJ8=;
        b=e2LeX3x7U+B6E0XmvalEWtwF1fhtC9B5zcm4fGT4Zs18wXda2Ezq884/IaAleX6fUT
         L3vCSAlTFK4iSmflNtqqy/dpJ3H9anBEbjUeYoovdgraUZ79A4tQfj4LoJ//IP7Z+jRc
         cvZPaAAGcnQC6+MzxC5ftknlJeiZ9zxdNjd0XRrrBoi4p0mcietIg6tLkVGNuxsZtp11
         Z8t/3KoX6oNg7vIgZeLugIqwUTUKHlLv33r4aL2CDWr5LjNdzxSAiXOVr4Zw5DiLH9T1
         /MJBqqliTj/ann6fUOWMB73JX9jdoR0Dp5jo7q8b82JSAXfzcoNb1fJVVbGpmOXNlZh3
         Mvww==
X-Gm-Message-State: AOAM533LgtNzK2T93kphAHOBYxz0f0/gcNp4AQOR2rrKYJ8iipOL3vB7
        0NXgS0ofCxTS9Q7MCnBkjb55hMjU86zFFSx8
X-Google-Smtp-Source: ABdhPJysTU+dWsY9mu0Gsp5YsI0K9ijh7gY5No1co+XMmK1YLmtz9H1SSsQKEyavfMGVze4nq0DyqA==
X-Received: by 2002:a63:2002:0:b0:3c6:ae77:1869 with SMTP id g2-20020a632002000000b003c6ae771869mr8885371pgg.71.1653063016260;
        Fri, 20 May 2022 09:10:16 -0700 (PDT)
Received: from judyhsiao0319.c.googlers.com.com (164.135.233.35.bc.googleusercontent.com. [35.233.135.164])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001619b47ae61sm5855078pld.245.2022.05.20.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:10:15 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, tzungbi@chromium.org, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [v2 1/3] arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
Date:   Fri, 20 May 2022 16:10:02 +0000
Message-Id: <20220520161004.1141554-2-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220520161004.1141554-1-judyhsiao@chromium.org>
References: <20220520161004.1141554-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add drive strength property for mi2s1 on sc7280 based platforms.
2. Disbale the pull-up mi2s1_data0, mi2s1_sclk.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 9cb1bc8ed6b5..6d8744e130b0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -612,6 +612,20 @@ &dp_hot_plug_det {
 	bias-disable;
 };
 
+&mi2s1_data0 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_sclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_ws {
+	drive-strength = <6>;
+};
+
 &pcie1_clkreq_n {
 	bias-pull-up;
 	drive-strength = <2>;
-- 
2.36.1.124.g0e6072fb45-goog

