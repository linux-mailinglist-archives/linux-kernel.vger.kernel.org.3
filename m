Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F5855B3E7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 21:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiFZTxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 15:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiFZTxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 15:53:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D470D2DEC;
        Sun, 26 Jun 2022 12:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70D7E60F61;
        Sun, 26 Jun 2022 19:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45C2C34114;
        Sun, 26 Jun 2022 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656273191;
        bh=fQxNqVstwuBn24c+h85YTkf5W1h3U4M1Ef+uG6u/uIM=;
        h=Date:From:To:Cc:Subject:From;
        b=GtPgm4VjwOp36rF/hm4BgwW2aFUGbHejNWMiZiJvdpG/VPZD76qatnbaBOAtG7VI2
         WfrquuwSoX5eTV2VBwcZJUAmGMDZd7rM7vY+j4eQ08Os28US44vCKlk7DBUVvSCGw+
         66O2tZdbFmZ3P4omaDLgJ13fYgYcUlmB+c85tEOA=
Date:   Sun, 26 Jun 2022 12:53:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes for 5.19-rcX
Message-Id: <20220626125310.83a3f4bb1b38bf9408d7c42c@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

please merge this batch of hotfixes.

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-06-26

for you to fetch changes up to e67679cc4264cf9b318af4e8616eaa2a7565db1f:

  mailmap: add entry for Christian Marangi (2022-06-16 19:11:32 -0700)

----------------------------------------------------------------
Minor things, mainly - mailmap updates, MAINTAINERS updates, etc.

Fixes for post-5.18 changes:

- fix for a damon boot hang, from SeongJae

- fix for a kfence warning splat, from Jason Donenfeld

- fix for zero-pfn pinning, from Alex Williamson

- fix for fallocate hole punch clearing, from Mike Kravetz

Fixes pre-5.18 material:

- fix for a performance regression, from Marcelo

- fix for a hwpoisining BUG from zhenwei pi

----------------------------------------------------------------
Abel Vesa (1):
      MAINTAINERS: update Abel Vesa's email

Alex Williamson (1):
      mm: re-allow pinning of zero pfns

Andrew Morton (1):
      MAINTAINERS: update MM tree references

Christian Marangi (1):
      mailmap: add entry for Christian Marangi

David Hildenbrand (1):
      MAINTAINERS: add MEMORY HOT(UN)PLUG section and add David as reviewer

Huacai Chen (1):
      MAINTAINERS: add maillist information for LoongArch

Jarkko Sakkinen (1):
      mailmap: add alias for jarkko@profian.com

Jason A. Donenfeld (1):
      mm/kfence: select random number before taking raw lock

Marcelo Tosatti (1):
      mm: lru_cache_disable: use synchronize_rcu_expedited

Miaohe Lin (1):
      MAINTAINERS: add Miaohe Lin as a memory-failure reviewer

Mike Kravetz (1):
      hugetlbfs: zero partial pages during fallocate hole punch

Petr Mladek (1):
      kthread: make it clear that kthread_create_on_node() might be terminated by any fatal signal

SeongJae Park (1):
      mm/damon/reclaim: schedule 'damon_reclaim_timer' only after 'system_wq' is initialized

Yang Li (1):
      mm/page_isolation.c: fix one kernel-doc comment

Yang Yang (1):
      mm: memcontrol: reference to tools/cgroup/memcg_slabinfo.py

zhenwei pi (1):
      mm/memory-failure: disable unpoison once hw error happens

 .mailmap                      |  4 +++
 Documentation/vm/hwpoison.rst |  3 +-
 MAINTAINERS                   | 21 ++++++++++---
 drivers/base/memory.c         |  2 +-
 fs/hugetlbfs/inode.c          | 68 +++++++++++++++++++++++++++++++++----------
 include/linux/mm.h            |  3 +-
 kernel/kthread.c              | 14 ++++-----
 mm/damon/reclaim.c            |  8 +++++
 mm/hwpoison-inject.c          |  2 +-
 mm/kfence/core.c              |  7 +++--
 mm/madvise.c                  |  2 +-
 mm/memcontrol.c               |  2 +-
 mm/memory-failure.c           | 12 ++++++++
 mm/page_isolation.c           |  2 ++
 mm/swap.c                     |  2 +-
 15 files changed, 117 insertions(+), 35 deletions(-)

