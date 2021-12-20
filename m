Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286A147B1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbhLTRSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbhLTRSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:18:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46848C061574;
        Mon, 20 Dec 2021 09:18:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21AD7B81032;
        Mon, 20 Dec 2021 17:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63617C36AE2;
        Mon, 20 Dec 2021 17:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640020727;
        bh=esoKJwod6Tm/yy8Oq298aSkhk4zw305MKSe4jClNvO4=;
        h=From:To:Cc:Subject:Date:From;
        b=vH7J7OwwMkL05uNNpyhc9MqyV9UC/1gRu9F6tYTs5g7IQQ6pvCsJbhGWWumb5bgPU
         dCOQWBSppx17owda2WP08YE21FeZbVkvTXNA08ofCH8pHC+QnH0vE+phCMe70fXsjc
         wlFjcJTOyVfkga0bl3OhB52Dx86umfThe0RDTiZYpcfqdKmddxf1x1XPCSWw9si1L5
         b9y4AxQv8VIQ3puQfgPDWtkIudG1jzn0YaB90ebEmhr+IgR0mOiGTbVjiN0blQMt5b
         UtccyWZhjiqgCzbDsbg5kkJN4IpglhkcokGd2khkCvEYA0nNfVcEtrljvKSuQLeZsX
         +I2V6ybq4yfow==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.16-rc6
Date:   Mon, 20 Dec 2021 17:18:33 +0000
Message-Id: <20211220171847.63617C36AE2@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 07fb78a78de4e67b5d6d5407aeee1250a327a698:

  spi: spi-rockchip: Add rk3568-spi compatible (2021-11-29 12:19:32 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.16-rc6

for you to fetch changes up to db6689b643d8653092f5853751ea2cdbc299f8d3:

  spi: change clk_disable_unprepare to clk_unprepare (2021-12-06 13:49:40 +0000)

----------------------------------------------------------------
spi: Fix for v5.16

One small fix for a long standing issue with error handling on probe in
the Armada driver.

----------------------------------------------------------------
Dongliang Mu (1):
      spi: change clk_disable_unprepare to clk_unprepare

 drivers/spi/spi-armada-3700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
