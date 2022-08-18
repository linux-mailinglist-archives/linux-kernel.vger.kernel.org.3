Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3FD598500
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245601AbiHRN77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245496AbiHRN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11DF6CD38
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21EF561709
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CC0C433C1;
        Thu, 18 Aug 2022 13:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660831154;
        bh=aP1ptNyZxtG+IPw9K9Bt251TMJeD93XzJpicwNZTdj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deuWW5nhPbIFLtFxztp9eGnVVbMbDaYfYV+2cToF7JKoX669pHYKjeRQSXu8n0504
         uY+DsRtfbJAt8+pXKQ7I4PtexPzOO3KSC6fJwAhEEORSmkJd2v2BMIO2OdLnkqyc0L
         DusrA8dfxsp6RPBa7mA3ieL9tskwZyCRuMqg3KkeQRlRB1AuIH5ePGdY/nC2TcAMlr
         kbn8zeVjKKpf7zeJpt2aTODTCMp5p/cjA4keiOdo1rc8SsLSc6a87YvnVaz49S2z0h
         q1cFfjOl6FihlY8SZFlBMEK0ZLhi26pEKVRz1CH9/TTPe3F9Ou7YrXt3sz7Bht3A9W
         BZ/Ts3fgJ8+KQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        William Zhang <william.zhang@broadcom.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] ARM: defconfig: drop CONFIG_SND_SOC_FSL_SAI
Date:   Thu, 18 Aug 2022 15:57:16 +0200
Message-Id: <20220818135737.3143895-6-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818135737.3143895-1-arnd@kernel.org>
References: <20220818135522.3143514-1-arnd@kernel.org>
 <20220818135737.3143895-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is selected by CONFIG_SND_SOC_FSL_ASOC_CARD=m, so the
extra line is redundant.

Fixes: 212e3b6b8734 ("ARM: configs: Enable more audio support for i.MX")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a523591798cb..7af627a816ec 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -778,7 +778,6 @@ CONFIG_SND_ATMEL_SOC_I2S=m
 CONFIG_SND_BCM2835_SOC_I2S=m
 CONFIG_SND_IMX_SOC=m
 CONFIG_SND_SOC_FSL_ASOC_CARD=m
-CONFIG_SND_SOC_FSL_SAI=m
 CONFIG_SND_PXA_SOC_SSP=m
 CONFIG_SND_MMP_SOC_SSPA=m
 CONFIG_SND_PXA910_SOC=m
-- 
2.29.2

