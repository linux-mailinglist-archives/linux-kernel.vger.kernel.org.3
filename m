Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4905598516
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbiHRN5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbiHRN5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:57:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB3C27CD1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A0BE616F8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E040AC433D6;
        Thu, 18 Aug 2022 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660831064;
        bh=HBT8UfINrkT5T200Yu/aNfJNdsPZUX+YPlGqDdCW4NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaR/c/HAatwuM2WHxeGTpn0/b1UVTWtFZBCVknQzn3Va1MEU2pk9LQYgC2p7ox0kj
         9TQ7B6aoPlS8IjBN9MTg/O7DDkJO2XWWGRdEIpbwVP6+iyXvkn+qvxlrTNeMl7ELQg
         jfOfircT/b9MRnlcWH/iHxMtmn2p4j4JK8g3zi+px7LWqwt9s/E6TLvG9joAeyUBpi
         tFdDNwy1FiUkMdXtGu7X008qFnUzZyt5Pg5LwAnss9OF9tLBZIjDFJVlOCrl0ciFc0
         dq0V8Tz3yn/YAIKjnaL8xyF3OP0Aj5v6i/rsxTied7RR70D9KPpgaW2PufzapqpjA7
         9beUusldN0Dbw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] ARM: defconfig: clean up multi_v4t and multi_v5 configs
Date:   Thu, 18 Aug 2022 15:57:11 +0200
Message-Id: <20220818135737.3143895-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818135522.3143514-1-arnd@kernel.org>
References: <20220818135522.3143514-1-arnd@kernel.org>
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

Integrator now selects the regulators and versatile selects the
reset driver, so the correspondig options can be dropped from
the defconfig files.

Fixes: d2854bbe5f5c ("ARM: integrator: Add some Kconfig selections")
Fixes: 1c6e288da6cc ("ARM: versatile: move restart to the device tree")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/multi_v4t_defconfig | 2 --
 arch/arm/configs/multi_v5_defconfig  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/arm/configs/multi_v4t_defconfig b/arch/arm/configs/multi_v4t_defconfig
index 6c3e45b71ab5..e2fd822f741a 100644
--- a/arch/arm/configs/multi_v4t_defconfig
+++ b/arch/arm/configs/multi_v4t_defconfig
@@ -71,8 +71,6 @@ CONFIG_POWER_RESET_SYSCON_POWEROFF=y
 CONFIG_WATCHDOG=y
 CONFIG_GPIO_WATCHDOG=y
 CONFIG_AT91RM9200_WATCHDOG=y
-CONFIG_REGULATOR=y
-CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_FB=y
 CONFIG_FB_CLPS711X=y
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 5f3ed81228b0..a65f32a78885 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -149,7 +149,6 @@ CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_ASPEED=m
 CONFIG_GPIO_ASPEED_SGPIO=y
 CONFIG_GPIO_MXC=y
-CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_QNAP=y
 CONFIG_SENSORS_ADT7475=y
-- 
2.29.2

