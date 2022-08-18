Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81469598504
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244875AbiHRN6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245419AbiHRN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:58:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF370B72AA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:57:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2246761615
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6497C433C1;
        Thu, 18 Aug 2022 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660831074;
        bh=CjHA+Zh75d5rWqfjbpWtK92dqJGzZIO1E1GyDNKRaaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/0u8jaUB0Z3wK9a9YliLIj4Mq4YHp549umNwYgvzlFYCcbqRQwuqTlAGXFGrcEvA
         iqNB4WgUCPX8995eVBFx1cGoGcT2aaHhuqVyfejAMe+vf5Z8pLkm8K9LFp1tlECjfg
         96kqKlJJ1K3RxtFKbWa5DIVsdSDYopY41tlRfCi5I2Vhq8CbJdaPuOSXIsYmZt1N+f
         ZfR5TXU6zAJENYlATYTw1Rz948sy/Ym0xjDc93+IcxKGuu4vakF0v/fWwU+EvdQhHL
         XIVzsQvQKflUmCy0SK6mK+q3V+Bc6OnCLgbKGZQ9tF92CQ2/5+KWaMZl4vbgjJrVO+
         3pk4MoFYtx7dg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] ARM: defconfig: drop CONFIG_NET_VENDOR_ASIX=y
Date:   Thu, 18 Aug 2022 15:57:12 +0200
Message-Id: <20220818135737.3143895-2-arnd@kernel.org>
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

This option is 'default y' and has always been this way, the
line was added in error.

Fixes: dfe21dcabac0 ("ARM: defconfig: Enable ax88796c driver for Exynos boards")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7ac539231a90..ecf743b3409d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -254,7 +254,6 @@ CONFIG_SATA_HIGHBANK=y
 CONFIG_SATA_MV=y
 CONFIG_SATA_RCAR=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_VENDOR_ASIX=y
 CONFIG_VIRTIO_NET=y
 CONFIG_B53_SPI_DRIVER=m
 CONFIG_B53_MDIO_DRIVER=m
-- 
2.29.2

