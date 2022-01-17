Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8BF490089
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 04:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbiAQD1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 22:27:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48378 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiAQD1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 22:27:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D04CB80C8B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80078C36AE3;
        Mon, 17 Jan 2022 03:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642390056;
        bh=GdLTfX9lUGWAaixcKHHob3vDx9b7y5jXsEHjYxzV4Ws=;
        h=To:Cc:From:Subject:Date:From;
        b=SQe87uyFqBEaRfoGnpU//aWF3OggeZy3arw9MO3NAiczN76qCJzlWSYcyxihSdNYR
         7r1l0Jz4i6TyQ8yjwwvo4cojSPOTUjAtfvuRS4mpdctkMH0mxn2IkGDcAIpEuA4f+A
         D3TEI3QnrRpGEnGRoGTrGQrixQv+8pUUVxef2jdzJhH35XSP3BudhOVfMFxjWk7gdE
         kSM0lFwQdrQA75VY3XAfJ+69a5Z3jCIuBmxmXklJYdGBw/h9FWtzBrI/P9mzVwaoTT
         WPX8j5Lgri0rUJh+vvp6imVVFCjMYNQATXqbsxAisNmuQiAkwWutceh0TeNIWHBwu0
         X2auQ+lO7fvZg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        abrodkin@synopsys.com, Yihao Han <hanyihao@vivo.com>,
        Kees Cook <keescook@chromium.org>, colin.i.king@googlemail.com,
        Colin Ian King <colin.i.king@gmail.com>,
        Vladimir Isaev <isaev@synopsys.com>,
        Randy Dunlap <rdunlap@infradead.org>
From:   Vineet Gupta <vgupta@kernel.org>
Subject: [GIT PULL] ARC updates for 5.17-rc1
Message-ID: <4af6c0e7-03a3-702c-f364-b0ebe0f8923a@kernel.org>
Date:   Sun, 16 Jan 2022 19:27:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

ARC fixes for 5.17. Nothing too exciting for now.

Thx,
-Vineet
------------------------------------------->
The following changes since commit fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2:

   Linux 5.16-rc7 (2021-12-26 13:17:17 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ 
tags/arc-5.17-rc1

for you to fetch changes up to 8f67f65d121cc3bbb4ffaae80e880aeb307d49f4:

   arc: use swap() to make code cleaner (2021-12-28 19:49:44 -0800)

----------------------------------------------------------------
Fixes for ARC for 5.17

----------------------------------------------------------------
Alexey Brodkin (1):
       arc: perf: Move static structs to where they're really used

Colin Ian King (1):
       ARC: perf: Remove redundant initialization of variable idx

Kees Cook (1):
       arc: Replace lkml.org links with lore

Randy Dunlap (1):
       ARC: thread_info.h: correct two typos in a comment

Vineet Gupta (1):
       ARC: perf: fix misleading comment about pmu vs counter stop

Yihao Han (1):
       arc: use swap() to make code cleaner

  arch/arc/include/asm/irqflags-compact.h |   8 +-
  arch/arc/include/asm/perf_event.h       | 162 
-------------------------------
  arch/arc/include/asm/thread_info.h      |   4 +-
  arch/arc/kernel/perf_event.c            | 166 
+++++++++++++++++++++++++++++++-
  arch/arc/kernel/unwind.c                |  11 +--
  arch/arc/mm/dma.c                       |   2 +-
  arch/arc/plat-axs10x/axs10x.c           |   2 +-
  arch/arc/plat-hsdk/platform.c           |   2 +-
  8 files changed, 178 insertions(+), 179 deletions(-)
