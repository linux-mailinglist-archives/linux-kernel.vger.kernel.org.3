Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F614481E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbhL3Qwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241400AbhL3Qwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:52:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B48BC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 08:52:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B660E61712
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 16:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837B9C36AEB;
        Thu, 30 Dec 2021 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640883164;
        bh=8IYPpJ1QL5bFSVRzKh1UXaep4jv/ir2KWjN7kKy/klE=;
        h=Date:From:To:Cc:Subject:From;
        b=lq7dlAFFaPsRL58+1zKv9RL+Ppyruwb1MjdF4ymZYKhiCgZ7n37uJU+oZJFsB5sGS
         CVvGTD0gyah76NfML8eqcBL/whQ3doz8An9ZhT55DTxVbPs82JwntJTZxbJLgRtYq2
         nbkR7QUFYzoDnmnjknPllGM7DtmHsBDYqhxYoRWQ=
Date:   Thu, 30 Dec 2021 17:52:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.16-final
Message-ID: <Yc3j2TMxxSCeuRWw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16

for you to fetch changes up to 3a0152b219523227c2a62a0a122cf99608287176:

  nitro_enclaves: Use get_user_pages_unlocked() call to handle mmap assert (2021-12-21 11:08:19 +0100)

----------------------------------------------------------------
Char/Misc fixes for 5.16-final

Here are two misc driver fixes for 5.16-final:
  - binder accounting fix to resolve reported problem
  - nitro_enclaves fix for mmap assert warning output

Both of these have been for over a week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andra Paraschiv (1):
      nitro_enclaves: Use get_user_pages_unlocked() call to handle mmap assert

Todd Kjos (1):
      binder: fix async_free_space accounting for empty parcels

 drivers/android/binder_alloc.c            | 2 +-
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)
