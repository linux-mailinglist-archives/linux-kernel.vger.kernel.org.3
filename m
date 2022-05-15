Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF40527816
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbiEOO22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbiEOO2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 10:28:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451372AC48
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF6A4B80D08
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 14:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507F2C385B8;
        Sun, 15 May 2022 14:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652624881;
        bh=PTFsAPgdHcjs1vaN3uNIZpYYNzclVaVhB4nJRvR2yQM=;
        h=Date:From:To:Cc:Subject:From;
        b=XORMGLkJLq6xibVcgbjW9LxALF086/fdNUav6lcpfkvKVRm16cFe2I+equFd4C3mH
         fGSEcDSs09m8J6zetj29DMKAyPrNeVzu+YkkmNJmZmI9PjhilXufz/+Iw8prcUvyqn
         C4O25TzlDPjk0hDBbOU2WEn0hjsSAXT3Q/Ouvgd4=
Date:   Sun, 15 May 2022 16:27:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes 5.18-rc7
Message-ID: <YoEN7x8ZU9JAX1SC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.18-rc7

for you to fetch changes up to d83ea024091e11d384f983f389a7853312c33c5d:

  Merge tag 'icc-5.18-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus (2022-05-13 16:15:28 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.18-rc7

Here are 2 small driver fixes for 5.18-rc7 that resolve reported
problems:
	- slimbus driver irq bugfix
	- interconnect sync state bugfix

Both of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Merge tag 'icc-5.18-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus

Miaoqian Lin (1):
      slimbus: qcom: Fix IRQ check in qcom_slim_probe

Stephen Boyd (1):
      interconnect: Restore sync state by ignoring ipa-virt in provider count

 drivers/interconnect/core.c | 8 +++++++-
 drivers/slimbus/qcom-ctrl.c | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)
