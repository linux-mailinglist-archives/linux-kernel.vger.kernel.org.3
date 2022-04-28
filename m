Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5680F512B68
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243754AbiD1GWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbiD1GWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:22:36 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8561F5C678;
        Wed, 27 Apr 2022 23:19:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-62-197.pa.nsw.optusnet.com.au [49.195.62.197])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 8DCBF10E5E61;
        Thu, 28 Apr 2022 16:19:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1njxUn-005RdR-4c; Thu, 28 Apr 2022 16:19:21 +1000
Date:   Thu, 28 Apr 2022 16:19:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-xfs@vger.kernel.org, djwong@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] xfs: fixes for 5.18-rc5
Message-ID: <20220428061921.GS1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=626a31ea
        a=KhGSFSjofVlN3/cgq4AT7A==:117 a=KhGSFSjofVlN3/cgq4AT7A==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=FJbNMBb9u8YzGCm4c0gA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you please pull the XFS fixes in the request attached below?
It's all minor stuff;  a 5.18 build regession fix, a deadlock fix
and an update to remove redundant fields from the XFS entry in the
MAINTAINERS file.

I just did a test merge against your current master branch and
didn't see any unexpected issues. It's been a while since I sent you
one of these things, so there's every chance I've missed something
I'm supposed to do now. If there's anything you notice that is even
slightly dodgy please let me know and I'll make sure it doesn't
happen next time.

-Dave.

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.18-fixes-1

for you to fetch changes up to 9a5280b312e2e7898b6397b2ca3cfd03f67d7be1:

  xfs: reorder iunlink remove operation in xfs_ifree (2022-04-21 08:45:16 +1000)

----------------------------------------------------------------
xfs: fixes for v5.18-rc5

XFS changes for v5.18-rc5:
- define buffer bit flags as unsigned to fix gcc-5 + c11 warnings
- remove redundant XFS fields from MAINTAINERS
- fix inode buffer locking order regression

----------------------------------------------------------------
Dave Chinner (2):
      xfs: convert buffer flags to unsigned.
      xfs: reorder iunlink remove operation in xfs_ifree

Tiezhu Yang (1):
      MAINTAINERS: update IOMAP FILESYSTEM LIBRARY and XFS FILESYSTEM

 MAINTAINERS        |  3 ---
 fs/xfs/xfs_buf.c   |  6 +++---
 fs/xfs/xfs_buf.h   | 42 +++++++++++++++++++++---------------------
 fs/xfs/xfs_inode.c | 24 +++++++++++++-----------
 fs/xfs/xfs_trans.h |  2 +-
 5 files changed, 38 insertions(+), 39 deletions(-)

-- 
Dave Chinner
david@fromorbit.com
