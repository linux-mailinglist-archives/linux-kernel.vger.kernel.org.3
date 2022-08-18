Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BC5598527
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbiHROBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245508AbiHROAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:00:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722225756B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 108FFB82197
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3B9C433C1;
        Thu, 18 Aug 2022 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660831188;
        bh=iZdCvpq6klP65xsk0NEvlBhn7btsT3f1Nqu32XzvKvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4b8FqCOfvm2yUHXDxTpD75aPTrN0e7BoWekb33I0YqDfpbxT+rP2YO2qAIKyl5rx
         xnZi8LGk4DRbjLjtbgMA0bDajwYphTDFsXu8jP+QhynNakUOIcaRT6UY1BxaHG22Tb
         /sD8iwWxiIco9hygUnv/JXCXMzvxlGGQCwJr0XI1exbMBoh7ySUlLq74hboW5STu4l
         9/SHDqSOh8knREx27AZPRZJYbnOgPzZ3diuME/bPfNler5yBWSXHrp2sQoFxd/l29v
         vP3AGbvsuFlDFRegFCODBFuv1E4gFdHpA866IENqHaXkSldDb27n9SpoOBob2rOSfl
         N+AH0+ijyIOoA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc:     Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        William Zhang <william.zhang@broadcom.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] ARM: defconfig: fix CONFIG_SND_SOC_AC97_CODEC name
Date:   Thu, 18 Aug 2022 15:57:19 +0200
Message-Id: <20220818135737.3143895-9-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818135737.3143895-1-arnd@kernel.org>
References: <20220818135522.3143514-1-arnd@kernel.org>
 <20220818135737.3143895-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The CONFIG_SND_SOC_AC97 symbol was recently enabled but does not
actually exist. From the patch description, I assume that this
was meant to be CONFIG_SND_SOC_AC97_CODEC, which is used in
imx_v6_v7_defconfig.

Fixes: 2cc1cd26e913 ("ARM: configs: Enable ASoC AC'97 glue")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2b564defe33e..af79b21e2000 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -814,7 +814,7 @@ CONFIG_SND_SOC_TEGRA_TRIMSLICE=m
 CONFIG_SND_SOC_TEGRA_ALC5632=m
 CONFIG_SND_SOC_TEGRA_MAX98090=m
 CONFIG_SND_SOC_DAVINCI_MCASP=m
-CONFIG_SND_SOC_AC97=m
+CONFIG_SND_SOC_AC97_CODEC=m
 CONFIG_SND_SOC_AK4642=m
 CONFIG_SND_SOC_CPCAP=m
 CONFIG_SND_SOC_CS42L51_I2C=m
-- 
2.29.2

