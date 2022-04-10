Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EAF4FADF4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbiDJMxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 08:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiDJMxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 08:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AF163BDF;
        Sun, 10 Apr 2022 05:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6977C60FD4;
        Sun, 10 Apr 2022 12:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB92C385A4;
        Sun, 10 Apr 2022 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649595083;
        bh=K+Xm3pX6N4tIOqUaw3aVj6EhwKZMhA1GN1ShZ3oZ2jM=;
        h=Date:From:To:Cc:Subject:From;
        b=msSL5WS9g6eRcnfFj5mHj8kpRiB2Pbok1CwN82JdK2IaigadQSxmmW8VWGzh5YroU
         AOEfp7v+BH6TxRKIhsGAatpWr4nMGNePA6FiPG6b23mdNU2sOoBN/H0ZdHq7AVWID9
         hgwOZ8BPpRS0gSwO6e2S6ewo5PMqqpwFmPwVi4Kw=
Date:   Sun, 10 Apr 2022 14:51:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fix for 5.18-rc2
Message-ID: <YlLSyUv83naZO3Lz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.18-rc2

for you to fetch changes up to dbf3f09322141b6f04a33949453b7626f62d9e0b:

  tty: serial: mpc52xx_uart: make rx/tx hooks return unsigned, part II. (2022-04-04 10:33:02 +0200)

----------------------------------------------------------------
Serial driver fix for 5.18-rc2

This is a single serial driver fix for a build issue that showed up due
to changes that came in through the tty tree in 5.18-rc1 that were
missed previously.  It resolves a build error with the mpc52xx_uart
driver.

It has been in linux-next this week with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Jiri Slaby (1):
      tty: serial: mpc52xx_uart: make rx/tx hooks return unsigned, part II.

 drivers/tty/serial/mpc52xx_uart.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)
