Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1248C52F02F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351444AbiETQK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351018AbiETQKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:10:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1A817D39D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:10:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so11870279pjp.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnA/uZftv5ibDJtyyKJZc9HKIOvccsTGLZumziMaAAw=;
        b=lJyvX9QddpEXKjIkhDMZhg4LGP7LDci2Wb+EKpFJcueI4jmfDPFuh0pGPKIAvcZBOX
         VHQyvlvkGUJ/xpE9pOhZUo7AxSXVYvfIqGf2E0zn5R4aZnmB5z32AeRljtWqI+8/OcXn
         HxV1Z3Zq16j43d6UwtsTI5QU9zHxJIKcQPUN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnA/uZftv5ibDJtyyKJZc9HKIOvccsTGLZumziMaAAw=;
        b=jjeCAOMsihKokw2jU9j4BA2h7gOXF53WLTL3R40dTZKdDD+GholrL4dQDm3gyXM6nc
         8wJT9gx+iNM1bCjWXRo8K4N7RfdTMycfiLVtoxnidIxHubBv40Tp18D33TzsrpOw/aku
         UqsNvCGcYQCTrdgM3AJPv01QGB6SUvjE/IQOHU/FH3I5bg4g/kGgayb/Yz+1W/QVHoUJ
         NGPtpSHShETMnkQZT2bWYYADh71fY4im2347DLKoGgmlgsZBqGGabIaGcZF6NP4GHCJ7
         Y4aidJWY985F0W8LaopNE/dQLaIf79yvl/8O5upjGNoKVcofc2nkOrYFvDI1esW+lyrU
         HsVA==
X-Gm-Message-State: AOAM533osdUq6BQ0S0x5pXG5/HnGTPPB6o+GAMsx2vYtQb19d+85lgfF
        23CQmgqZ2pLBBhqHX8m4dOW7WQ==
X-Google-Smtp-Source: ABdhPJzpmib4WBgifFct8T+7yQwfer6ncR7XkIqzKsdXUkv431mLIhLQ8ioXvQOHzI8EYosDE4nTYg==
X-Received: by 2002:a17:902:bc8c:b0:15e:c103:940c with SMTP id bb12-20020a170902bc8c00b0015ec103940cmr10266301plb.154.1653063015586;
        Fri, 20 May 2022 09:10:15 -0700 (PDT)
Received: from judyhsiao0319.c.googlers.com.com (164.135.233.35.bc.googleusercontent.com. [35.233.135.164])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001619b47ae61sm5855078pld.245.2022.05.20.09.10.14
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
Subject: [v2 0/3] Add dtsi for sc7280 herobrine boards that using rt5682 codec
Date:   Fri, 20 May 2022 16:10:01 +0000
Message-Id: <20220520161004.1141554-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
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

Put sound node and lpass_cpu node settings for boards that use rt5682
codec in the sc7280-herobrine-audio-rt5682.dtsi as there are different
choices of headset codec for herobrine projects. Common audio setting
for the internal speaker is in sc7280-herobrine.dtsi.

This series depends on:
"Add lpass pin control support for audio on sc7280 based targets" [1]
"Add soundcard support for sc7280 based platforms" [2]

[1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=638776
[2] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=643589

Changes Since V1:
    -- Remove sound-dai-cells in sound node.
    -- Add dependency list.
    -- Update patch subject.

Judy Hsiao (3):
  arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
  arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
  arm64: dts: qcom: sc7280: include sc7280-herobrine-audio-rt5682.dtsi
    in villager and herobrine-r1

 .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 120 ++++++++++++++++++
 .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 +
 .../dts/qcom/sc7280-herobrine-villager-r0.dts |   1 +
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  14 ++
 4 files changed, 136 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi

-- 
2.36.1.124.g0e6072fb45-goog

