Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64075598523
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245485AbiHROAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245488AbiHRN7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:59:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7C6581D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B992616D6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39477C433D7;
        Thu, 18 Aug 2022 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660831177;
        bh=61Oba51zV0nz21GhypXJPC6ussrVhCNLSAtE5ZokxfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQQiY+Bll8/yQiSgFoXQPf8mrQUjOYpAAV27QhJkFOYor14FNXpbr/bcstC9ZvMC+
         7aIESd7aScEu5+l0t1LtiVSkdZa89FxAuxqZ+9llSfI2GyNx1tJZmsd4wzGjL/V0ks
         ODzFK8FCx9mM6trysHTP95BRAL/jnlhKr6hw81MTbTVq7R18efui8jP0hfSH7AH0XU
         EUGhSrLrXcU9p757GGbHiIJ838IbBRBEkZ18MDGBgN2VHozm52LFIju4oUksQuKukp
         k7ay8MI9uQotdgK7/NMdoNtFEVx721fPZ3j8osHdwRcS5HgC1ULy/OfANK2wk/9+lp
         sBsibwa0j64xw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] ARM: defconfig: drop CONFIG_MICROCHIP_PIT64B
Date:   Thu, 18 Aug 2022 15:57:18 +0200
Message-Id: <20220818135737.3143895-8-arnd@kernel.org>
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

This is now default-enabled when CONFIG_SOC_SAMA7 is
used, so the defconfig entry can be dropped.

Fixes: f611af4c3bfa ("ARM: at91: Kconfig: implement PIT64B selection")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1cb293adecb1..2b564defe33e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1044,7 +1044,6 @@ CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
-CONFIG_MICROCHIP_PIT64B=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_QCOM_APCS_IPC=y
 CONFIG_QCOM_IPCC=y
-- 
2.29.2

