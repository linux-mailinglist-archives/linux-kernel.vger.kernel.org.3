Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8F853DDB6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 20:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346995AbiFESiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 14:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiFESiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 14:38:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1DB18E2E;
        Sun,  5 Jun 2022 11:38:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72F4D61198;
        Sun,  5 Jun 2022 18:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AA3C385A5;
        Sun,  5 Jun 2022 18:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654454289;
        bh=P2XbAbBuQZC3dLWUTa2iBPUtslT743RJJYy5Sv6Nssg=;
        h=Date:From:To:Cc:Subject:From;
        b=Ne/u1D6e72dA+EndfwD1Hxpy+RitinetGRfcjlOZYQeZFg+WG/vNXFWvTmzlBl4TZ
         /tvSAbjrJecgsq4ObAivB1pWtTnDwPIVQexsRx4O/S81f98ShG7fx8c59LbKpWYYGr
         QTmLjfDPboIE4YKjXkyK3va1B6Zp1jPwwfPfIVFk=
Date:   Sun, 5 Jun 2022 11:38:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 5.19-rc1
Message-Id: <20220605113808.2cf854614e3aff3790b7c49e@linux-foundation.org>
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


Linus, please pull these fixups for various recently-added and
longer-term issues and a few minor tweaks.


The following changes since commit 54eb8462f21fb170a05ad64620f0d8d0cf2b7fb5:

  Merge tag 'rtc-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux (2022-06-01 14:48:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-06-05

for you to fetch changes up to a19cad0691597eb79c123b8a19a9faba5ab7d90e:

  mm/oom_kill.c: fix vm_oom_kill_table[] ifdeffery (2022-06-01 15:57:16 -0700)

----------------------------------------------------------------
Hot fixes for 5.19-rc1.

- fixes for material merged during this merge window

- cc:stable fixes for more longstanding issues

- minor mailmap and MAINTAINERS updates

----------------------------------------------------------------
Andrew Morton (1):
      mm/oom_kill.c: fix vm_oom_kill_table[] ifdeffery

Baoquan He (1):
      x86/kexec: fix memory leak of elf header buffer

Josh Poimboeuf (1):
      mailmap: update Josh Poimboeuf's email

Miaohe Lin (2):
      MAINTAINERS: add maintainer information for z3fold
      mm/memremap: fix missing call to untrack_pfn() in pagemap_range()

Muchun Song (1):
      mm: hugetlb_vmemmap: fix CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON

Zi Yan (1):
      mm: page_isolation: use compound_nr() correctly in isolate_single_pageblock()

 .mailmap                           |  2 ++
 MAINTAINERS                        |  7 +++++
 arch/x86/kernel/machine_kexec_64.c | 12 ++++++--
 mm/hugetlb_vmemmap.c               |  2 +-
 mm/memremap.c                      |  2 +-
 mm/oom_kill.c                      | 58 +++++++++++++++++++-------------------
 mm/page_isolation.c                |  2 +-
 7 files changed, 50 insertions(+), 35 deletions(-)

