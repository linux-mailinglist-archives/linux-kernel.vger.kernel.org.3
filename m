Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB5952F012
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351359AbiETQIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351365AbiETQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:08:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A0417D384
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:07:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l14so8448703pjk.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrf0USGJflM7r6+ev6OSw+77Ui3swWmu+X4UMtW509E=;
        b=dKvOtYwieNzttXuWldodCcBrtBB6RAi9zjnnyIdYM7qP2J7gpJUj+0yRHZpMAFO5ZW
         qA3xjJZj3uZgyMpMglhCFel7fpPJ1TXbsL1x42X+S8z+kq09vjuQfClTwgc7E9SrUFCk
         mwcr1Pdl+3aOn85kMR0PTXn8bB0QWhkKkgLN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrf0USGJflM7r6+ev6OSw+77Ui3swWmu+X4UMtW509E=;
        b=DmHheO9VufAPdiHHtOEpyfaM/oOc9KRl+WwFW0M7jjE82ppaKV+z36OIAL3wVTOp0T
         hlDYaOVpr7uw3dP5gUWlovandKY7FThhJs7aDRZ+NL3fdAUdl/kz28V8Nhgq6f5PMscG
         2x8+wy3fmh2GVY3kgYt6W7eKQdsKq0qFuy3wA3zBz6m8+/+CDw1uGyAXrywzbjpuqv1N
         oTwn8FrywE7UpUVm2HX7GmfSGkSYkp+enJZZwcipFwg32f90yqsADSCVuTq9yL9xTrHs
         TQfMx3IJ77pwi8M0ByQsNen5kX5iXqUL8VWb0QyFuMrhn9VJThsTtqG3blN935Q+BrwE
         h5dQ==
X-Gm-Message-State: AOAM530NoAiKJli2ZNVD0qyjstdLtNfL5MN9jA5gBtY0nmfrc0owt5Zk
        MfshG0YaRxnn9geCbdAW3EVT8A==
X-Google-Smtp-Source: ABdhPJzH5MIeuj8j4P/ITotxTpSA/cE3BT2qltFyRWMLZXbRUekOD2TOK4N/8DsEAFpJQ2xKTrAVKg==
X-Received: by 2002:a17:90a:149:b0:1df:3da1:3549 with SMTP id z9-20020a17090a014900b001df3da13549mr11508069pje.90.1653062878968;
        Fri, 20 May 2022 09:07:58 -0700 (PDT)
Received: from judyhsiao0319.c.googlers.com.com (164.135.233.35.bc.googleusercontent.com. [35.233.135.164])
        by smtp.gmail.com with ESMTPSA id iw3-20020a170903044300b00161a2d98a8esm5856138plb.226.2022.05.20.09.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:07:58 -0700 (PDT)
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
Date:   Fri, 20 May 2022 16:07:52 +0000
Message-Id: <20220520160754.1141281-2-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220520160754.1141281-1-judyhsiao@chromium.org>
References: <20220520160754.1141281-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add drive strength property for mi2s1 on sc7280 based platforms.
2. Disbale the pull-up mi2s1_data0, mi2s1_sclk.

Change-Id: Ie227da1076a4343b88b331a937169745fe91902c
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

