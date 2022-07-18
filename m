Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5B7577D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiGRIDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiGRIDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:03:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E8186F5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:03:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so11834027pjl.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20A8d3QKuqR55DqSEaCOxZca1dq4+G/QxQSgtWMnIuY=;
        b=dF8tz5UKfYMyW4FP8lANsjwINYJruISKQD229AJrJvla8/z2uzkBddsXd6MrrabocB
         D3neIwaTAIJUK7KyNM96/DDMuCobhbfHI1VPJLIC9X9Ugl1Y6aqzz5fQtNqNvw1SaSXE
         tdq3hYhsWdqHjXNCvYF4GjgacVf+ZSk3MbqK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20A8d3QKuqR55DqSEaCOxZca1dq4+G/QxQSgtWMnIuY=;
        b=DwbBMZQNa/Ov2hJC0eXYZR7c4rpg8SuJWqcQ07DeBKCrfErbw80+KexCDTlsRpHviA
         VuopHcSazulsL7TxaFGHFum4DKq9kJDld2OY3Tj+SVP9LDt5cXkflzxhR2GFIEBMzJLb
         VLoJrzt0s9aiGuA6v47582oM5rv9+FYZLX4ScDHawNIJ4bX+ZM9X/vZ6s3y5ByL6Velp
         PjlEJ5aqO1W5tLlkUU0zGI3DEBaGgvAxTGsXqU1+4YhYPerDgz98n7U+xTh183PSAtRd
         ZUsWMTUhI7RfXN9L1HaQ0Sf6kNBrCZuXi9LGiOOa7kvXwNVTmAEcynKvDZ8vZpkPsOA/
         8NEg==
X-Gm-Message-State: AJIora/cn60PixXTsN6TyGym6mM4mk59A18kT4pPvFVyK4WEFgLq99Rt
        CqzkjVjxnkQSYR68S400AUusBA==
X-Google-Smtp-Source: AGRyM1t+/pisY8sC/UfSbD+X53uqi2JVe7JkhqJ3g74tT1ZCkP7hnoDtIv57xgtagMBE/PpZIFSvfA==
X-Received: by 2002:a17:902:db02:b0:16c:5568:d740 with SMTP id m2-20020a170902db0200b0016c5568d740mr27301256plx.100.1658131390297;
        Mon, 18 Jul 2022 01:03:10 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c10100b0015e8d4eb2cdsm8672616pli.279.2022.07.18.01.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:03:09 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v2 1/3] arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
Date:   Mon, 18 Jul 2022 08:02:50 +0000
Message-Id: <20220718080252.789585-2-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220718080252.789585-1-judyhsiao@chromium.org>
References: <20220718080252.789585-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add drive strength property for mi2s1 on sc7280 based platforms.
2. Disable the pull-up for mi2s1 lines.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 0a220e7421d9..74c451bf0d00 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -632,6 +632,21 @@ &dp_hot_plug_det {
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
+	bias-disable;
+};
+
 &pcie1_clkreq_n {
 	bias-pull-up;
 	drive-strength = <2>;
-- 
2.37.0.170.g444d1eabd0-goog

