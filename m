Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7992957AFA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbiGTDxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiGTDxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:53:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5486D548
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:53:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d7so1982945plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9DpWvCVDJd6A56HD1n6KoSQsmY3hGAJ1AiVFQE9fVY=;
        b=DhtvpLqeqFwbxgAIOlZXE81TxUYZwlPQBuSg2dwhkrch5LY1xVdruf4BeaREQ4ck6R
         SY7uMediWrlQxpPrS/F5BmswEGLwzNsdcOWUYud1H8s7qe3ofYuMpmsg7pspXUnlvWPn
         wlORUrl5Ktd//orD47Ic9z5T9rYzTf86xwUSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9DpWvCVDJd6A56HD1n6KoSQsmY3hGAJ1AiVFQE9fVY=;
        b=ZYWFushUMhZVf/B8dEc9UTxfRbHG2TRSL+TkmcV/GpPux0OghrJfqmooWmKkElk7+6
         WQ85ELUufmt9RL6Ed0ietfGgOJKmtGmpFGaznOzBmdWY1VhRxhU1wYmh3ivHtwuD/XO4
         86SE8HtWQiSfGq1My5l1DBS6S4+F1gjKwLps4/mg0yvP85PFpy07c2tYVLDoEHvP7ngL
         m1RCDXGIXpSFDrogB1RmIrAnWrvjDVUir+HQj34RxTLgK6OreFI3eB1F5hff2x96Cmfl
         dtsVtFC7do5lqxKdttrKPZ+pN5fYWmhcOQQsV58Q4idj5LWJmfAjUKZXKCHcwZ1pjgfr
         SThA==
X-Gm-Message-State: AJIora8nYVeD6M107wklKER0320bOouG7xp69sYcEUenNmPUM8Rztb5N
        WjUi1yP5nOr24sIK/d0R4p1oVA==
X-Google-Smtp-Source: AGRyM1seKYtGcJoMu0mo4YwrBiYolZ8G+Sm5dVXymDL7WJKurHjFH6MmazmKkIKY73m4wjlsnDgG4w==
X-Received: by 2002:a17:902:b28a:b0:16d:1c68:2e2 with SMTP id u10-20020a170902b28a00b0016d1c6802e2mr2595346plr.26.1658289182621;
        Tue, 19 Jul 2022 20:53:02 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902d14b00b0016648412514sm12378346plt.188.2022.07.19.20.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 20:53:02 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Add dtsi for sc7280 herobrine boards that using
Date:   Wed, 20 Jul 2022 03:52:51 +0000
Message-Id: <20220720035254.1411959-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put sound node and lpass_cpu node settings for boards that use rt5682
codec in the sc7280-herobrine-audio-rt5682.dtsi as there are different
choices of headset codec for herobrine projects. Common audio setting
for the internal speaker is in sc7280-herobrine.dtsi.

Changes Since V2:
- Fix sc7280-herobrine-audio-rt5682.dtsi syntax.

Changes Since V1:
- Not to include the herobrine-villager-r0.dts changes in this patch
  series to avoid conflict.

Judy Hsiao (3):
  arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
  arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
  arm64: dts: qcom: sc7280: include sc7280-herobrine-audio-rt5682.dtsi
    in herobrine-r1

 .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 122 ++++++++++++++++++
 .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 +
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  15 +++
 3 files changed, 138 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi

-- 
2.37.0.170.g444d1eabd0-goog

