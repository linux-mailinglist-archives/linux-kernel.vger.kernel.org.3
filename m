Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D874753C892
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243506AbiFCKWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243513AbiFCKWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:22:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2095FDAE;
        Fri,  3 Jun 2022 03:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C50366023F;
        Fri,  3 Jun 2022 10:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00DFC385A9;
        Fri,  3 Jun 2022 10:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654251714;
        bh=QeDzNRPW1tNWWOZmvZKyjn4+KA8Ysf35znGfXNo0dmY=;
        h=Date:From:To:Cc:Subject:From;
        b=OaqPw31GYezab1KGhD/ZuAWrvyqKyrTKAV9+dB0PMKaD7G9OIP5YmJCfBQ0Vf6BZA
         DHYIAiyL8j6MrJE2zSlqjj6Wm128TzOhIWDtiXgOdhzWDh0jX85Bgw6BzeUKuVwO67
         w4fnkDRp4ePgTpw87PfLWhHcTsN8rsKdt9QOlP1k=
Date:   Fri, 3 Jun 2022 12:21:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: [GIT PULL] SPDX update for 5.19-rc1
Message-ID: <Ypngv8MIQ/Syj1Js@kroah.com>
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

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.19-rc1

for you to fetch changes up to 53c83d6d8e399fad3d3d25df0ea0d54eb0f94f88:

  siphash: add SPDX tags as sole licensing authority (2022-05-19 18:54:22 +0200)

----------------------------------------------------------------
SPDX changes for 5.19-rc1

Here are some SPDX (i.e. licensing) changes for 5.19-rc1

The SPDX-labeling effort has started to pick up again, so here are some
changes for various parts of the tree that are related to this effort.

Included in here are:
	- freevxfs license updates
	- spihash.c license cleanups
	- spdxcheck script updates to make things easier to work with
	  going forward

All of the license updates came from the original authors/copyright
holders of the code involved.

All of these have been in linux-next for weeks with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christoph Hellwig (1):
      freevxfs: relicense to GPLv2 only

Jason A. Donenfeld (1):
      siphash: add SPDX tags as sole licensing authority

Thomas Gleixner (8):
      scripts/spdxcheck: Add percentage to statistics
      scripts/spdxcheck: Add directory statistics
      scripts/spdxcheck: Add [sub]directory statistics
      scripts/spdxcheck: Add option to display files without SPDX
      scripts/spdxcheck: Put excluded files and directories into a separate file
      scripts/spdxcheck: Exclude config directories
      scripts/spdxcheck: Exclude MAINTAINERS/CREDITS
      scripts/spdxcheck: Exclude top-level README

 fs/freevxfs/vxfs.h        |  27 +------
 fs/freevxfs/vxfs_bmap.c   |  26 +------
 fs/freevxfs/vxfs_dir.h    |  27 +------
 fs/freevxfs/vxfs_extern.h |  27 +------
 fs/freevxfs/vxfs_fshead.c |  26 +------
 fs/freevxfs/vxfs_fshead.h |  27 +------
 fs/freevxfs/vxfs_immed.c  |  26 +------
 fs/freevxfs/vxfs_inode.c  |  26 +------
 fs/freevxfs/vxfs_inode.h  |  27 +------
 fs/freevxfs/vxfs_lookup.c |  26 +------
 fs/freevxfs/vxfs_olt.c    |  26 +------
 fs/freevxfs/vxfs_olt.h    |  27 +------
 fs/freevxfs/vxfs_subr.c   |  26 +------
 fs/freevxfs/vxfs_super.c  |  26 +------
 include/linux/siphash.h   |   5 +-
 lib/siphash.c             |   5 +-
 lib/test_siphash.c        |   7 +-
 scripts/spdxcheck.py      | 175 ++++++++++++++++++++++++++++++++++++++++++----
 scripts/spdxexclude       |  18 +++++
 19 files changed, 202 insertions(+), 378 deletions(-)
 create mode 100644 scripts/spdxexclude
