Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB28479BDA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 17:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhLRQ7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 11:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhLRQ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 11:59:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0220BC061574;
        Sat, 18 Dec 2021 08:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8468460BA4;
        Sat, 18 Dec 2021 16:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE94C36AE0;
        Sat, 18 Dec 2021 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639846747;
        bh=CAh5j3clHms90SByKmuFnDJpc5RnEj/oMAS+VYGwWNM=;
        h=Date:From:To:Cc:Subject:From;
        b=d/Ik+B+ckhERjQ0NKrKNAJuXNtqLzTVbb8A7PVtgLBiLBggczBVZgnlWvdnrtJRhs
         KLO0IZRcVNFwjcLqQpLUfoLqaZw51/PPwh+HbSszVtJ4rdLx3tKaI5B7uunVYi+qLj
         +VC11oAyG6XwHKJn1BMVz0rs7+vFj0bszB8uKt+U=
Date:   Sat, 18 Dec 2021 17:58:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.16-rc6
Message-ID: <Yb4TU/m3UYg7VRJj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.16-rc6

for you to fetch changes up to 6c33ff728812aa18792afffaf2c9873b898e7512:

  serial: 8250_fintek: Fix garbled text for console (2021-12-15 21:51:07 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 5.16-rc6

Here are 2 small tty/serial fixes for 5.16-rc6.  They include:
	- n_hdlc fix for syzbot reported problem that you were
	  previously copied on.
	- 8250_fintek driver fix that resolved a console problem by
	  removing a previous change.

Both have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ji-Ze Hong (Peter Hong) (1):
      serial: 8250_fintek: Fix garbled text for console

Tetsuo Handa (1):
      tty: n_hdlc: make n_hdlc_tty_wakeup() asynchronous

 drivers/tty/n_hdlc.c                  | 23 ++++++++++++++++++++++-
 drivers/tty/serial/8250/8250_fintek.c | 20 --------------------
 2 files changed, 22 insertions(+), 21 deletions(-)
