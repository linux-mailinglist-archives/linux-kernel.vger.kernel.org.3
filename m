Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480545744E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiGNGMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiGNGMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:12:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3501512082
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:12:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j3so969941pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0JQX6/cIgCdb7Mg76sUFpOl71mtDqdXfnF0wcsBKWsM=;
        b=MSniBgnOLurkJBS/hE33Ycon1qF3cNBocVhNzr3LgMuamK6dYjUdoDVt336IyjBgSt
         BeY843VST6NEyYyLyhBxUdsiOMrMGUTqFNoWCydnQE5x0XOnWxYO5HWaWxOfp8NimnmZ
         wRkQenr9JHGsORs7BzTst6zb+ahj4rDAsc2L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0JQX6/cIgCdb7Mg76sUFpOl71mtDqdXfnF0wcsBKWsM=;
        b=KRqThaetqdEXHMBnpsWQISIXrwWwIW/WZXNYu6ikYD8/MaIPHn0+E4GLE8YiVsjIsC
         L7YjWdxV4WKc2XJnJj0ZyribV6OcU+cQxWZp4NhYZRvnriPNykLEsAFGFz7/bXXoBZ1h
         saZ4vRTpt/XpAA3Jsq8xjioZLlSqpK38ylcFkym0jJtpYzC/LCBG8b7+YzfB4unI9ymE
         LRD1yEQvNMlSEomz8j61G037nM9WmBO9HkwelzbOqamLMBd34n5hSgC41+BWTFddm8qX
         WHZadAK8zxCKYLMbEQ36JLbDqPf4nmFtLDJs9wJudmiMRUyB1KZev18Mjay/uTMGHTw8
         7TkA==
X-Gm-Message-State: AJIora9vtRj5Pe5m7lTfVXUg70aCjUnwrwy5gCZOlNHOL8U97WoNgRAF
        he8tveJqMn95hIOoPaPeFzMRaA==
X-Google-Smtp-Source: AGRyM1taVQ9qHJJchRWXeqZw9zn67tFuwEXQj2+SbtcE1e1jgkp3bIJq+Jc2EaYDxH5GTEm/hoPC9g==
X-Received: by 2002:a63:2a8f:0:b0:412:5278:b90 with SMTP id q137-20020a632a8f000000b0041252780b90mr6214516pgq.363.1657779124714;
        Wed, 13 Jul 2022 23:12:04 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902690a00b0016a17da4ad4sm509683plk.39.2022.07.13.23.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 23:12:04 -0700 (PDT)
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
Subject: [PATCH v1 0/3] Add dtsi for sc7280 herobrine boards that using
Date:   Thu, 14 Jul 2022 06:11:48 +0000
Message-Id: <20220714061151.2126288-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.37.0.144.g8ac04bfd2-goog

