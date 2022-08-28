Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41255A3FDC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 23:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiH1Vm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 17:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH1VmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 17:42:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DCB222AB;
        Sun, 28 Aug 2022 14:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA714B80C76;
        Sun, 28 Aug 2022 21:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6FCC433D6;
        Sun, 28 Aug 2022 21:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661722940;
        bh=hTv+r7ToCEtDcjhEPsaqQedUM3CortSyZkbzjwBDXy0=;
        h=Date:From:To:Cc:Subject:From;
        b=QDFiiTq7PN2A4LGa4sC88Y+B7i70PZoW9ewMPYDpf1tNatuD26daQQj/EhiYld66z
         7DaItsrkCPL0Gz+RahFmCEZEDRgpqbXtBHsxAYsH2ewouyb/mffgeDk2rWFju+8AHu
         UezVnp1SviqCDIkT5OqXw+H9BhAS7HbImlCrqQ1c=
Date:   Sun, 28 Aug 2022 14:42:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.0-rc3
Message-Id: <20220828144219.618a26f33e0aae5407fadd88@linux-foundation.org>
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


Linus, please merge this batch of hotfixes.

The following changes since commit ec6624452e36158d0813758d837f7a2263a4109d:

  Merge branch 'linus' (2022-08-25 21:45:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-08-28

for you to fetch changes up to 0ebafe2ea879e97fef6bd97f72303a6ccf39f092:

  .mailmap: update Luca Ceresoli's e-mail address (2022-08-28 14:02:46 -0700)

----------------------------------------------------------------
Seventeen hotfixes.  Mostly memory management things.  Ten patches are
cc:stable, addressing pre-6.0 issues.

----------------------------------------------------------------
Alex Williamson (1):
      mm: re-allow pinning of zero pfns (again)

Badari Pulavarty (1):
      mm/damon/dbgfs: avoid duplicate context directory creation

Colin Ian King (1):
      mailmap: update email address for Colin King

Guilherme G. Piccoli (1):
      mailmap: update Guilherme G. Piccoli's email addresses

Heming Zhao (1):
      ocfs2: fix freeing uninitialized resource on ocfs2_dlm_shutdown

Khazhismel Kumykov (1):
      writeback: avoid use-after-free after removing device

Liam Howlett (1):
      binder_alloc: add missing mmap_lock calls when using the VMA

Liu Shixin (1):
      bootmem: remove the vmemmap pages from kmemleak in put_page_bootmem

Luca Ceresoli (1):
      .mailmap: update Luca Ceresoli's e-mail address

Matthew Wilcox (Oracle) (1):
      shmem: update folio if shmem_replace_page() updates the page

Miaohe Lin (1):
      mm/hugetlb: avoid corrupting page->mapping in hugetlb_mcopy_atomic_pte

Peter Xu (1):
      mm/mprotect: only reference swap pfn page if type match

Phillip Lougher (1):
      squashfs: don't call kmalloc in decompressors

Quanyang Wang (1):
      asm-generic: sections: refactor memory_intersects

Sergey Senozhatsky (1):
      mm/zsmalloc: do not attempt to free IS_ERR handle

Shakeel Butt (1):
      Revert "memcg: cleanup racy sum avoidance code"

Stephen Brennan (1):
      vmcoreinfo: add kallsyms_num_syms symbol

 .mailmap                       |  6 ++++--
 drivers/android/binder_alloc.c | 31 +++++++++++++++++++++----------
 fs/fs-writeback.c              | 12 ++++++------
 fs/ocfs2/dlmglue.c             |  8 +++++---
 fs/ocfs2/super.c               |  3 +--
 fs/squashfs/file.c             |  2 +-
 fs/squashfs/file_direct.c      |  2 +-
 fs/squashfs/page_actor.c       | 34 +++++++++++++++-------------------
 fs/squashfs/page_actor.h       |  5 +++++
 include/asm-generic/sections.h |  7 +++++--
 include/linux/memcontrol.h     | 15 +++++++++++++--
 include/linux/mm.h             | 13 ++++++++++---
 kernel/crash_core.c            |  1 +
 mm/backing-dev.c               | 10 +++++-----
 mm/bootmem_info.c              |  2 ++
 mm/damon/dbgfs.c               |  3 +++
 mm/hugetlb.c                   |  2 +-
 mm/mprotect.c                  |  3 ++-
 mm/page-writeback.c            |  6 +++++-
 mm/shmem.c                     |  1 +
 mm/zsmalloc.c                  |  2 +-
 21 files changed, 108 insertions(+), 60 deletions(-)

