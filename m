Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7F454E975
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiFPSfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiFPSfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:35:17 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7260753B66
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:35:16 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id x190so1006096vkc.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=psAM3XSoUx3a6FBqAFWlilD01aN43ceaHbI70B2BMqo=;
        b=WpuVTgzMQk8SWtLifPEPKAqGSi9WjFaQLJQAeW+3k3qtd8fMRP8TNjGacCFT8J9+BA
         NBNvxk6jjA6KAJK/Tw5YMMxE+QcciZutqNiR0xLFDfQePSU506V7I9FU2ag4IwxvPY9c
         xHbs40SSA6j6sPueSlb/cPfgNDR+aynz/1dmOZjBarp2Dys+zT4Kf9rWSe6AutkLn+To
         oyBQZWGCJbi5AWd6dsyP1W5PSM3lrtqIk9xEnIM2RwaaHucqO74dKJ8bOq9kccFASJ58
         7lMD2aS5FuuTcY+4ykf5SEh0+DkH8Tc8mCfrCPoMvE3vZ6sZFdJWL9n5F9DRe+hBuxyc
         1pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=psAM3XSoUx3a6FBqAFWlilD01aN43ceaHbI70B2BMqo=;
        b=CxH8/BIrKVY21hgwp7p3cpc0sILpC4w+zaiEz5tK+SGhBCjOoEpZcc8TyEm6R7s+M3
         eY1oRT9jibxHD1FncyP02gIeoR0WguH0Z8r+iKlrKSdtSLxOBIYfm19Igsl0gKKS0xhU
         4vx9CD4uNo4Fa4THCVmjORLVqnogHnMDWB+QVTYag5jBJn2IrBxkSSbG7s2zokQDnTBQ
         PJdNgs1oLd80UFRNk3MfZCmiSQdCSbwbdWrm305vml4/4SuxHQdSIN7mzCKGZgXV2jpd
         ItiU2XnmG6dRpahj1QGBpYr1T2PLXhSLPf6tDswN4f/nO9IOshVAvt/2sY7fXg1FeztY
         XcpQ==
X-Gm-Message-State: AJIora+s/f9fv0iGPUFRBJ9Dm0aur4lX/O5ppCLwnV6LnJ49mxv+ZSxH
        ThvtKxmA2NbvAaxs1uL/yC8B5lK6O6HW9HdKkf93plrNHJ7sDw==
X-Google-Smtp-Source: AGRyM1upxexvBL7QTAcwnwNY6O/TiaEQPLEPc1kHs9nVNcjNus3dFIRENoM6J69nD6QIlZ6tjz051qWkMiPaO+EMb6M=
X-Received: by 2002:a1f:add0:0:b0:361:1bf:7c58 with SMTP id
 w199-20020a1fadd0000000b0036101bf7c58mr3050170vke.31.1655404515367; Thu, 16
 Jun 2022 11:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAOUHufaoZ99qkBfsRWwCAx6fspL5KJYgCGe=nOVR07_2dF6URQ@mail.gmail.com>
 <20220615185500.i5bzt7srzm6q72na@revolver> <CAOUHufY5dBrNc81oDnmKSyRY2d3=e0CZJiXaOUBs=LFoUBDJUg@mail.gmail.com>
 <CAOUHufZa9G2VDHLPsNmp3yRyXqYCE-3-nT6P7+uf-gbgyOHXYQ@mail.gmail.com>
 <20220616014956.6jgxvbzh4ld3c32q@revolver> <CAOUHufZtq0PDiGXBvLV=POraK-4dfnQ9UNmsafHhJmzxAhzrfw@mail.gmail.com>
 <20220616025557.euz6z5rlh7fqewy2@revolver> <CAOUHufb04ej_R32qWgah1Oqds_KpEgL+=d0SysE=pfCM7wovxQ@mail.gmail.com>
 <CAOUHufbNR6NsYX_fd+_6WaiNkewyfWuDN-9KnPBOdxaPTks-8w@mail.gmail.com>
 <CAOUHufYd=H6un8=MHs0GE7oOjqMt6WNndEcrTJbJX_gmOHWbgQ@mail.gmail.com> <20220616182647.hlwadwzvlojbjlj5@revolver>
In-Reply-To: <20220616182647.hlwadwzvlojbjlj5@revolver>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 16 Jun 2022 12:34:39 -0600
Message-ID: <CAOUHufaEg6d8iwPapbp8MjeMUVbLf9Pfp-pL1yiOA6Km_j45FQ@mail.gmail.com>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:27 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Yu Zhao <yuzhao@google.com> [220616 01:56]:
> > On Wed, Jun 15, 2022 at 11:45 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Wed, Jun 15, 2022 at 9:02 PM Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > On Wed, Jun 15, 2022 at 8:56 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> > > > >
> > > > > * Yu Zhao <yuzhao@google.com> [220615 21:59]:
> > > > > > On Wed, Jun 15, 2022 at 7:50 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> > > > > > >
> > > > > > > * Yu Zhao <yuzhao@google.com> [220615 17:17]:
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > > > Yes, I used the same parameters with 512GB of RAM, and the kernel with
> > > > > > > > > KASAN and other debug options.
> > > > > > > >
> > > > > > > > Sorry, Liam. I got the same crash :(
> > > > > > >
> > > > > > > Thanks for running this promptly.  I am trying to get my own server
> > > > > > > setup now.
> > > > > > >
> > > > > > > >
> > > > > > > > 9d27f2f1487a (tag: mm-everything-2022-06-14-19-05, akpm/mm-everything)
> > > > > > > > 00d4d7b519d6 fs/userfaultfd: Fix vma iteration in mas_for_each() loop
> > > > > > > > 55140693394d maple_tree: Make mas_prealloc() error checking more generic
> > > > > > > > 2d7e7c2fcf16 maple_tree: Fix mt_destroy_walk() on full non-leaf non-alloc nodes
> > > > > > > > 4d4472148ccd maple_tree: Change spanning store to work on larger trees
> > > > > > > > ea36bcc14c00 test_maple_tree: Add tests for preallocations and large
> > > > > > > > spanning writes
> > > > > > > > 0d2aa86ead4f mm/mlock: Drop dead code in count_mm_mlocked_page_nr()
> > > > > > > >
> > > > > > > > ==================================================================
> > > > > > > > BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> > > > > > > > Write of size 136 at addr ffff88c35a3b9e80 by task stress-ng/19303
> > > > > > > >
> > > > > > > > CPU: 66 PID: 19303 Comm: stress-ng Tainted: G S        I       5.19.0-smp-DEV #1
> > > > > > > > Call Trace:
> > > > > > > >  <TASK>
> > > > > > > >  dump_stack_lvl+0xc5/0xf4
> > > > > > > >  print_address_description+0x7f/0x460
> > > > > > > >  print_report+0x10b/0x240
> > > > > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > > > > >  kasan_report+0xe6/0x110
> > > > > > > >  ? mast_spanning_rebalance+0x2634/0x29b0
> > > > > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > > > > >  kasan_check_range+0x2ef/0x310
> > > > > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > > > > >  memcpy+0x44/0x70
> > > > > > > >  mab_mas_cp+0x2d9/0x6c0
> > > > > > > >  mas_spanning_rebalance+0x1a3e/0x4f90
> > > > > > >
> > > > > > > Does this translate to an inline around line 2997?
> > > > > > > And then probably around 2808?
> > > > > >
> > > > > > $ ./scripts/faddr2line vmlinux mab_mas_cp+0x2d9
> > > > > > mab_mas_cp+0x2d9/0x6c0:
> > > > > > mab_mas_cp at lib/maple_tree.c:1988
> > > > > > $ ./scripts/faddr2line vmlinux mas_spanning_rebalance+0x1a3e
> > > > > > mas_spanning_rebalance+0x1a3e/0x4f90:
> > > > > > mast_cp_to_nodes at lib/maple_tree.c:?
> > > > > > (inlined by) mas_spanning_rebalance at lib/maple_tree.c:2997
> > > > > > $ ./scripts/faddr2line vmlinux mas_wr_spanning_store+0x16c5
> > > > > > mas_wr_spanning_store+0x16c5/0x1b80:
> > > > > > mas_wr_spanning_store at lib/maple_tree.c:?
> > > > > >
> > > > > > No idea why faddr2line didn't work for the last two addresses. GDB
> > > > > > seems more reliable.
> > > > > >
> > > > > > (gdb) li *(mab_mas_cp+0x2d9)
> > > > > > 0xffffffff8226b049 is in mab_mas_cp (lib/maple_tree.c:1988).
> > > > > > (gdb) li *(mas_spanning_rebalance+0x1a3e)
> > > > > > 0xffffffff822633ce is in mas_spanning_rebalance (lib/maple_tree.c:2801).
> > > > > > quit)
> > > > > > (gdb) li *(mas_wr_spanning_store+0x16c5)
> > > > > > 0xffffffff8225cfb5 is in mas_wr_spanning_store (lib/maple_tree.c:4030).
> > > > >
> > > > >
> > > > > Thanks.  I am not having luck recreating it.  I am hitting what looks
> > > > > like an unrelated issue in the unstable mm, "scheduling while atomic".
> > > > > I will try the git commit you indicate above.
> > > >
> > > > Fix here:
> > > > https://lore.kernel.org/linux-mm/20220615160446.be1f75fd256d67e57b27a9fc@linux-foundation.org/
> > >
> > > A seemingly new crash on arm64:
> > >
> > > KASAN: null-ptr-deref in range [0x0000000000000000-0x000000000000000f]
> > > Call trace:
> > >  __hwasan_check_x2_67043363+0x4/0x34
> > >  mas_wr_store_entry+0x178/0x5c0
> > >  mas_store+0x88/0xc8
> > >  dup_mmap+0x4bc/0x6d8
> > >  dup_mm+0x8c/0x17c
> > >  copy_mm+0xb0/0x12c
> > >  copy_process+0xa44/0x17d4
> > >  kernel_clone+0x100/0x2cc
> > >  __arm64_sys_clone+0xf4/0x120
> > >  el0_svc_common+0xfc/0x1cc
> > >  do_el0_svc_compat+0x38/0x5c
> > >  el0_svc_compat+0x68/0xf4
> > >  el0t_32_sync_handler+0xc0/0xf0
> > >  el0t_32_sync+0x190/0x194
> > > Code: aa0203e0 d2800441 141e931d 9344dc50 (38706930)
> >
> > And bad rss counters from another arm64 machine:
> >
> > BUG: Bad rss-counter state mm:a6ffff80895ff840 type:MM_ANONPAGES val:4
> > Call trace:
> >  __mmdrop+0x1f0/0x208
> >  __mmput+0x194/0x198
> >  mmput+0x5c/0x80
> >  exit_mm+0x108/0x190
> >  do_exit+0x244/0xc98
> >  __arm64_sys_exit_group+0x0/0x30
> >  __wake_up_parent+0x0/0x48
> >  el0_svc_common+0xfc/0x1cc
> >  do_el0_svc_compat+0x38/0x5c
> >  el0_svc_compat+0x68/0xf4
> >  el0t_32_sync_handler+0xc0/0xf0
> >  el0t_32_sync+0x190/0x194
> > Code: b000b520 91259c00 aa1303e1 94482015 (d4210000)
> >
>
> What was the setup for these two?  I'm running trinity, but I suspect
> you are using stress-ng?

That's correct.

> If so, what are the arguments?  My arm64 vm is
> even lower memory than my x86_64 vm so I will probably have to adjust
> accordingly.

I usually lower the N for `-a N`.
