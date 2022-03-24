Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EC34E6ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355424AbiCXWfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355411AbiCXWfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:35:06 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80B1BA321
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:33:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id z128so4964107pgz.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2pYm8aApoPFKoF55U544w3PRwb5diq93TVUhqMH0Vc=;
        b=kSpmI1qM7012KHpYseWnAyAG85NCt2KnqBnW35QcMho5vpZuWUXxh+tCWR6hS0eU1t
         OqCZ8Oo9hMLDhddl5WadGmEul2dE9Zb6ol27nfoAYw3llyrixs0WImY/zDopMz2Slx4P
         jGM/QDa39fGSXgKWeHN5TgwyNRLDxBcmx4wJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2pYm8aApoPFKoF55U544w3PRwb5diq93TVUhqMH0Vc=;
        b=SE0i8hyRdhN4F/u3MX0saHzM+v5sG9CfHIVEU+KnbHQVqDVF7r8pSED1v2t3DCZR/Z
         i0wPNh5vtHJkykYQin9N7GMpeCw6189fnA59F8f6IDDMOKXao9cyLKOGc4nRSpuvmIy/
         incfPB/SwiOQtacZW1L2Is0vIg2XBXS4LAgKlBRW3w6kB6x6Up7S/prNJdxekNhw6Erk
         o0DC1JPQ1UPTlHz2rdE0FI2vSc47eWvAAELLJfKZqvwuDF7/nCiBK8iaEbGGwFZbTNhe
         tafpFQxg/wbz81P1kFPSkfD6k/CXkOhZxUTFc6jQzMoHXFGjLnu06D8aSdIF6dg93nx/
         toOQ==
X-Gm-Message-State: AOAM530h45tJWjdTaPvk5C2NuXk8xv2TYyTiC0eNbO6sYiM8hBYsPLq8
        vjHdDvb8xmnOCIvC3Hh9nHF1vA==
X-Google-Smtp-Source: ABdhPJzbPuTn6vHPZUxavIevej+kAH7usj2aL3PJJ2lnr1WYu5P+ggAeQMuA19KBeSL18Ib/kqnFyA==
X-Received: by 2002:a63:d916:0:b0:385:fe06:a1db with SMTP id r22-20020a63d916000000b00385fe06a1dbmr5563124pgg.446.1648161213361;
        Thu, 24 Mar 2022 15:33:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:8832:9ce1:9692:fe4])
        by smtp.gmail.com with ESMTPSA id bw17-20020a056a00409100b004fadad3b93esm4403297pfb.142.2022.03.24.15.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 15:33:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7280: Fix sar1_irq_odl node name
Date:   Thu, 24 Mar 2022 15:33:31 -0700
Message-Id: <20220324223331.876199-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This node should be named sar1-irq-odl, not sar0-irq-odl. Otherwise
we'll overwrite the settings for sar0 with what is intended for sar1,
leading to probe failures for sar1 that are quite confusing.

Fixes: 116f7cc43d28 ("arm64: dts: qcom: sc7280: Add herobrine-r1")
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 7c22f0b062be..4d91909af325 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -741,7 +741,7 @@ sar0_irq_odl: sar0-irq-odl {
 		bias-pull-up;
 	};
 
-	sar1_irq_odl: sar0-irq-odl {
+	sar1_irq_odl: sar1-irq-odl {
 		pins = "gpio140";
 		function = "gpio";
 		bias-pull-up;

base-commit: 116f7cc43d28ccd621ff1fecc9526c65dde28dcd
-- 
https://chromeos.dev

