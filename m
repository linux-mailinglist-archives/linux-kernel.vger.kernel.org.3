Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE4D550A45
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiFSLc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiFSLcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86211174
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:32:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB07F61044
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 11:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C13FC34114;
        Sun, 19 Jun 2022 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655638336;
        bh=RAcrtsGTP2vqUzZO+x2hAmoE3XoTsFd+mMtVqXqJRAQ=;
        h=Date:From:To:Cc:Subject:From;
        b=h94SRTMGitoW5RKBsw4vwp4AVZfYFkxHaunelNo/mDKPpa210loVvjSQikYjOvAnP
         1/fMqyDqiRWG0Tg3Wu7lqHc9HXHWyDwrR1YpvswWASSaAhAA5ym1Aox3cIqDdEW5h+
         mu6rqdstYjsi9kSsAgJh5zJoBe5ntoAF1TPkoJ+M=
Date:   Sun, 19 Jun 2022 13:32:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes 5.19-rc3 - take 2
Message-ID: <Yq8JO6i5zqhZLqa2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's tag the proper branch this time...

---------------------

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc3-take2

for you to fetch changes up to 928ea98252ad75118950941683893cf904541da9:

  bus: fsl-mc-bus: fix KASAN use-after-free in fsl_mc_bus_remove() (2022-06-10 15:53:12 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.19-rc3 - take 2

Here are some small char/misc driver fixes for 5.19-rc3 that resolve
some reported issues.

They include:
        - mei driver fixes
        - comedi driver fix
        - rtsx build warning fix
        - fsl-mc-bus driver fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (3):
      mei: me: set internal pg flag to off on hardware reset
      mei: hbm: drop capability response on early shutdown
      mei: me: add raptor lake point S DID

Ian Abbott (1):
      comedi: vmk80xx: fix expression for tx buffer size

Nathan Chancellor (1):
      misc: rtsx: Fix clang -Wsometimes-uninitialized in rts5261_init_from_hw()

Shin'ichiro Kawasaki (1):
      bus: fsl-mc-bus: fix KASAN use-after-free in fsl_mc_bus_remove()

 drivers/bus/fsl-mc/fsl-mc-bus.c   | 6 +++---
 drivers/comedi/drivers/vmk80xx.c  | 2 +-
 drivers/misc/cardreader/rts5261.c | 2 ++
 drivers/misc/mei/hbm.c            | 3 ++-
 drivers/misc/mei/hw-me-regs.h     | 2 ++
 drivers/misc/mei/hw-me.c          | 2 ++
 drivers/misc/mei/pci-me.c         | 2 ++
 7 files changed, 14 insertions(+), 5 deletions(-)
