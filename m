Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F95762D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiGONcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGONcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903A87AC06;
        Fri, 15 Jul 2022 06:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A8E362398;
        Fri, 15 Jul 2022 13:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A098C34115;
        Fri, 15 Jul 2022 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657891920;
        bh=xOaEPvfFP0dRHMcGq7RhVXk1qFrQbqyvQZ+CNpHnC68=;
        h=From:To:Cc:Subject:Date:From;
        b=cIZtgKbyr/OlSdtjKj+dHi5Ox2gx7tz2hu2Vtgz3Jvk6sXAUM+zVKshPzqnnOjGyQ
         2jV+mbSQ74uU1xkMrOsHUwZ8AX6y/QW0qDUbtIOC4gxrjumXM39D5Twgi5VDenIr/D
         PQAaHIoYV0Kht6068qt5s7nhCtF1fo03wFhM9xAyq0AP+AuuumvSjkggovG3d3X9jI
         xAzTbU9XqMmhUq1eWWQxMDYviAgw9vXMuAQddjIkoMK9Zo6Do1Y9ZCqbnE/H4WMsg1
         NDAslfaAqK06NYRE2BKwmHKQEuZGnJdEyouv73TtOybMz2cg9iwxlMmVWXqSANFOzx
         qqRnhsjeEiR7g==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.19-rc4
Date:   Fri, 15 Jul 2022 14:31:50 +0100
Message-Id: <20220715133200.2A098C34115@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 419bc8f681a0dc63588cee693b6d45e7caa6006c:

  spi: rockchip: Unmask IRQ at the final to avoid preemption (2022-06-20 11:35:43 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.19-rc4

for you to fetch changes up to 73d5fe046270281a46344e06bf986c607632f7ea:

  spi: cadence-quadspi: Remove spi_master_put() in probe failure path (2022-07-14 13:26:35 +0100)

----------------------------------------------------------------
spi: Fixes for v5.19

A few driver specific fixes, none especially remarkable, plus a
MAINTAINERS file update due to the previous maintainer for the NXP FSPI
driver having left the company.

----------------------------------------------------------------
Cristian Ciocaltea (1):
      spi: amd: Limit max transfer and message size

Cédric Le Goater (2):
      spi: aspeed: Add dev_dbg() to dump the spi-mem direct mapping descriptor
      spi: aspeed: Fix division by zero

Han Xu (1):
      MAINTAINERS: change the NXP FSPI driver maintainer.

Mark Brown (1):
      spi: Merge AMD fix

Vaishnav Achath (1):
      spi: cadence-quadspi: Remove spi_master_put() in probe failure path

 MAINTAINERS                       |  3 ++-
 drivers/spi/spi-amd.c             |  8 ++++++++
 drivers/spi/spi-aspeed-smc.c      | 12 +++++++++++-
 drivers/spi/spi-cadence-quadspi.c | 19 +++++++------------
 4 files changed, 28 insertions(+), 14 deletions(-)
