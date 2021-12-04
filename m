Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B1C4683FD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353445AbhLDK2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:28:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344782AbhLDK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638613494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ihpAmDy0ClSxFAbH5aDgEnZl10gfqE91dXR3hMgHpnQ=;
        b=DRaRrrDvqAIPTt6nCV/Y46tgh18IAkTpDWQdCkM1XWglTI79Pu4xgIu9B9bYezmc0Az508
        gSKB/b9MUuL3CkasZVaZzut/2pnKl3tu4TbrWBuQ6XF5SEM0LmmvwGnj6AattpeXmoh67v
        bfbe4IIhjAyU2vwX0g1xIOHNxNY7Sfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-0bqTnIbmNkmi12mDrH7Bjg-1; Sat, 04 Dec 2021 05:24:52 -0500
X-MC-Unique: 0bqTnIbmNkmi12mDrH7Bjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0FC3100CD00;
        Sat,  4 Dec 2021 10:24:51 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.192.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBC855C25D;
        Sat,  4 Dec 2021 10:24:47 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes for v5.16-rc4
Date:   Sat,  4 Dec 2021 11:24:46 +0100
Message-Id: <20211204102446.19275-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes for 5.16-rc4.

Thanks,
Andreas

The following changes since commit 42eb8fdac2fc5d62392dcfcf0253753e821a97b0:

  Merge tag 'gfs2-v5.16-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2021-11-17 15:55:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.16-rc4-fixes

for you to fetch changes up to 3d36e57ff768dbb919c06ffedec4bfe4587c6254:

  gfs2: gfs2_create_inode rework (2021-12-02 12:41:10 +0100)

----------------------------------------------------------------
Fixes in gfs2:
* Since commit 486408d690e1 ("gfs2: Cancel remote delete work
  asynchronously"), inode create and lookup-by-number can overlap more
  easily and we can end up with temporary duplicate inodes.  Fix the
  code to prevent that.
* Fix a BUG demoting weak glock holders from a remote node.

----------------------------------------------------------------
Andreas Gruenbacher (4):
      gfs2: Fix remote demote of weak glock holders
      gfs2: gfs2_inode_lookup cleanup
      gfs2: gfs2_inode_lookup rework
      gfs2: gfs2_create_inode rework

 fs/gfs2/glock.c |  10 ++++--
 fs/gfs2/inode.c | 109 +++++++++++++++++++++++---------------------------------
 2 files changed, 52 insertions(+), 67 deletions(-)

