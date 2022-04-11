Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B214FC6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350224AbiDKVjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiDKVjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:39:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D339832ECE;
        Mon, 11 Apr 2022 14:37:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68F84B818C6;
        Mon, 11 Apr 2022 21:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CC0C385A4;
        Mon, 11 Apr 2022 21:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649713039;
        bh=022Pdl8bgH9YOV5BTA1AtvEqyI7aK5FrWcVXPrFuHDw=;
        h=Date:From:To:Cc:Subject:From;
        b=Ym/aPKjnE1pkniOEDD2n1XkPIfTH+Wr2OXyb3cjs+8PA+nXe5Y+Fh3TD/m9xbir0+
         lRQ0aACXzy0StgrOCv0JbUbPvkCtm0NL7XetHze6jGCZvPk5+L66Sgv1Oe8vfBApM/
         rweR6XU+Smn84fxP8kIpE6VbjGvYVTmoqvLTnVeiO4gbN8cu8BNd4GpJT7wIImvAQU
         kWlaMQy7TI96G4HYemRf7LcMHdzl8WUlIpNnjp1V6yiG4C9mFeuxLpMgIG9MYfbLTY
         P2ajEeNcTY3F91uJH7xavTlo16kHyuSLNkhThdMP+ZkAhYDOPW3MabBsuQi08KTaiJ
         38H3vc1zepAyg==
Date:   Mon, 11 Apr 2022 23:37:14 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v5.18-rc2] media fixes
Message-ID: <20220411233714.448cdc01@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.18-2

For:

- a regression fix at si2157 driver;
- a Kconfig dependency fix at imx-mipi-csis driver;
- a fix at the rockchip/rga driver probing logic.

Thanks,
Mauro


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.18-2

for you to fetch changes up to 3ae87d2f25c0e998da2721ce332e2b80d3d53c39:

  media: si2157: unknown chip version Si2147-A30 ROM 0x50 (2022-04-09 17:45:49 +0200)

----------------------------------------------------------------
media fixes for v5.18-rc2

----------------------------------------------------------------
Kyle Copperfield (1):
      media: rockchip/rga: do proper error checking in probe

Laurent Pinchart (1):
      media: platform: imx-mipi-csis: Add dependency on VIDEO_DEV

Piotr Chmura (1):
      media: si2157: unknown chip version Si2147-A30 ROM 0x50

 drivers/media/platform/nxp/Kconfig        |  1 +
 drivers/media/platform/rockchip/rga/rga.c |  2 +-
 drivers/media/tuners/si2157.c             | 22 +++++++++++-----------
 3 files changed, 13 insertions(+), 12 deletions(-)

