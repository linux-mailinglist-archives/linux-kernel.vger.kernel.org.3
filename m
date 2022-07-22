Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACF857E98D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbiGVWMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiGVWMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3DDA9B96;
        Fri, 22 Jul 2022 15:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B0A2621EC;
        Fri, 22 Jul 2022 22:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF49C341C6;
        Fri, 22 Jul 2022 22:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658527957;
        bh=w3sJKIqMYuyJEmV4ZHLE8Ym9r0qhBdmU0MUWwXsPgL8=;
        h=From:To:Cc:Subject:Date:From;
        b=SMYAG9vlcQiu8b9Jm9ymnp4ld3hsXgnK43/dNxbq7lVWLBisCfI0l6ui3xVM1CX4N
         t9ieXqU6Cmd8UyLp3OFoazSc8wVuoP2ud6jgPoa4gOLSrdn0VzRlSV3NhQGv8+lD6Y
         KwJlR3139DnkiiBlc1BYvs4PvmGpinziZ0LguC6tDcMHaE6yQicLX5Ngq05LnhULq+
         cEzrV2VevxIkUn5fw8ooDEGR0LUb2GcnrCuKHiTpZzA4ERCOym96dbHbz+pg2Lq6dC
         ic8Efo/ReT9th98VOZZYOxRBf6Or3FX0VUKwFkbf+SS8rhl/6FqmtAOONwF0UxhcvL
         QdoIsaL+iK0gg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.19-rc7
Date:   Fri, 22 Jul 2022 23:12:27 +0100
Message-Id: <20220722221236.EDF49C341C6@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 73d5fe046270281a46344e06bf986c607632f7ea:

  spi: cadence-quadspi: Remove spi_master_put() in probe failure path (2022-07-14 13:26:35 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.19-rc7

for you to fetch changes up to b620aa3a7be346f04ae7789b165937615c6ee8d3:

  spi: spi-rspi: Fix PIO fallback on RZ platforms (2022-07-21 17:21:07 +0100)

----------------------------------------------------------------
spi: Final fixes for v5.19

A few more small driver specific fixes, this is obviously rather late
and if you think it's best to leave these until the next release that
would be reasonable.

----------------------------------------------------------------
Biju Das (1):
      spi: spi-rspi: Fix PIO fallback on RZ platforms

Marc Kleine-Budde (1):
      spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer deref for non DMA transfers

Sai Krishna Potthuri (1):
      spi: spi-cadence: Fix SPI NO Slave Select macro definition

 drivers/spi/spi-bcm2835.c | 12 ++++++++----
 drivers/spi/spi-cadence.c |  2 +-
 drivers/spi/spi-rspi.c    |  4 ++++
 3 files changed, 13 insertions(+), 5 deletions(-)
