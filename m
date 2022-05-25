Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFC25334D8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbiEYBnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbiEYBnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:43:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909575997C
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:43:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n18so17327911plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npLd/1Lsi6JSNLQFgzu2xb0z5npMHCtgiyGSryOfZ7c=;
        b=CozoGz0XGdL/mwvq821vh9q5hpnpK3zkv9TCBQWm5RetnP/rWWpkJZktWgotaMOhh6
         lvoR2rQ20CBHIVaSiskfG3GfGlos65goV2wvbcCZsci9umzFCqjCT1DMjeOScmMp/hqq
         atPt+lPnH21SZsbFXnEdYkDGDezTI+sZT6iKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npLd/1Lsi6JSNLQFgzu2xb0z5npMHCtgiyGSryOfZ7c=;
        b=BHYWqSkeFKGqUOvCGJsEqbyN1fKPvVhsjJ0PWLkzIEpHimO+X2BeDAEkm+lrR6Rmb6
         ckcUDFDc977+7sFzYU0Lctraqb4yAfpfsWMxHzjccKUNEcud5E/GlyK8h0wbKHyENl+K
         bEZstG4TcBV2oamBV1FWh1YH/DIcVtdOxBUUpW1MnPtenX/Dr+eAGvIo3aZGIJbNN4KK
         qW63ZfNxEmgj77PPBvfpdbxtYpVPIKMT8O4NflUVVmKeTou2InDho+UKnB7Cg7NIvdVO
         XLFbdqqhZtgGBEkhSianQfnNd+jZxslDn4Wb9QhfVhLFSEwvrHekBgNo9DEga5tfUgli
         Os0A==
X-Gm-Message-State: AOAM533IyGHCm8lBzCorSu9VpnkayVk3mjFLLY4yyKkCYR49wvIHOp+o
        AuWNZcsoiqD5pOFAD/Q3qQQGOA==
X-Google-Smtp-Source: ABdhPJzgjy+dhROTUTjm6cU//L1D1t41Msk0mQDiVDwBvGZZIjwh6k3hHGXKOQKh8Wuf4Soy6f5yLw==
X-Received: by 2002:a17:902:c2d8:b0:15e:fa17:56cc with SMTP id c24-20020a170902c2d800b0015efa1756ccmr30070131pla.40.1653442997893;
        Tue, 24 May 2022 18:43:17 -0700 (PDT)
Received: from judyhsiao0319.c.googlers.com.com (164.135.233.35.bc.googleusercontent.com. [35.233.135.164])
        by smtp.gmail.com with ESMTPSA id n11-20020a1709026a8b00b0015e8d4eb2bcsm7877317plk.262.2022.05.24.18.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 18:43:17 -0700 (PDT)
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
Subject: [v3 0/3] Add dtsi for sc7280 herobrine boards that using rt5682 codec
Date:   Wed, 25 May 2022 01:43:05 +0000
Message-Id: <20220525014308.1853576-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put sound node and lpass_cpu node settings for boards that use rt5682
codec in the sc7280-herobrine-audio-rt5682.dtsi as there are different
choices of headset codec for herobrine projects. Common audio setting
for the internal speaker is in sc7280-herobrine.dtsi.

This series depends on:
"Add lpass pin control support for audio on sc7280 based targets" [1]
"Add soundcard support for sc7280 based platforms" [2]

[1]
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=638776
[2]
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=643589


Changes Since V2:
    -- Add bias-disable for i2s ws line.
    -- Fix typo in the commit message.

Changes Since V1:
    -- Remove sound-dai-cells in sound node.
    -- Add dependency list.
    -- Update patch subject.

Judy Hsiao (3):
  arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
  arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
  arm64: dts: qcom: sc7280: include sc7280-herobrine-audio-rt5682.dtsi
    in villager and herobrine-r1

 .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 121 ++++++++++++++++++
 .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 +
 .../dts/qcom/sc7280-herobrine-villager-r0.dts |   1 +
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  15 +++
 4 files changed, 138 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi

-- 
2.36.1.124.g0e6072fb45-goog

