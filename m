Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC386507D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346165AbiDSX0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239609AbiDSX0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:26:07 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948A3A195
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:23:22 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id r8so23141vkq.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrY5LLH066IHLez83TcalJiVLoQrKgJceeIzQF3JDbc=;
        b=cZV4V268fHlBsfDfNjkF31+TGTgAGiJx/ZamlTzEO0B6IeLQYU3x/doxYwkbgWLZU3
         NtbdlXKmz1MYL4AFIQ2iC7C06olpCiFdD5lZT5daUfP6qA7lS+svcjmuyLmZj3gRniJb
         lo0ddgASwAB7mvg90WCy6INBmOAlNaKgBC2jke6MDRvSmxIAXvxd52pj1PhGdaaak4an
         UF0uQdfqVtUQFv6aNHvS3WnKOqLUuFYOwQ8mqHrYYptGAFL17wF5YuhC6tahDLVd1GeT
         9cTvb2ARzHmU2jguicCtiHWdyZn/FgumPu0yT5CDkKSljeN3bgyPHiHRCxIzAZXyRM3d
         qhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrY5LLH066IHLez83TcalJiVLoQrKgJceeIzQF3JDbc=;
        b=arGO8ticbkjd7DC0XL1FtM8Eqz2cHgs2i8L0vrmIp2OhabSxVIcoWQAILWDdJr80Pd
         YxQm1gZxh3ZN5SJmL1OrkFbADecziSapxw6sAA+/RkExC+W1uCsc3l4GF13aE3S+7O5H
         2UKmpgEvCKw1EY4ZT//S6+Xlm4CpjmYL0pnrzQlAoDLJq2ftHLhYg+cOMqIrqWOc680p
         CUwNMD+pFNKC/R/1vxM/BF1BbgJAi7/QA8HtB1GUXFQcWGxCmaNZtpagtGxzQCmhYalH
         32/UEUpB3q3BucuX5sKIXeru5VLWDvj4WDG+x/8rWGZrj+xyNwgzgSOCFBJgf8xq8vhe
         OGGw==
X-Gm-Message-State: AOAM533bCESzKBbJFFn7nW302Ar6mmQVGzD5Aa1lYsoBJAReZFhwD0ph
        UicUc7HI/GKOHTZEbep585t58XtsEJVnzpfeslZk0I7loGEJCans
X-Google-Smtp-Source: ABdhPJxOjlK8yhrXOagazlvJl5pLMj/ZNz/gt3wx15qmOENNEfWPnOVXaHXkRDojUu7/NTa0xqW8SyfeReolknSk+jU=
X-Received: by 2002:a1f:a9cb:0:b0:33e:d145:85f0 with SMTP id
 s194-20020a1fa9cb000000b0033ed14585f0mr5479375vke.7.1650410601571; Tue, 19
 Apr 2022 16:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAOUHufaw8tZrxuc6Sfxe+ES_MFHBqU_=O+X3b4rbYYrWYJRjkg@mail.gmail.com>
 <20220414171521.bgdvrirumd4atjhs@revolver> <20220414121911.8bb89fc3681b13af1566d79c@linux-foundation.org>
 <YlkaiUopM5HKWEdX@google.com> <20220416010259.4gbz5hgvm2lgr3sj@revolver>
 <CAOUHufZ8zPnpamkkpKK6KcSLTF91Eiba+S9VTX-ivhFrPQ_Cpw@mail.gmail.com>
 <20220416151923.ig5zavuptjsufm3d@revolver> <CAOUHufZewjQyMy1pHKxRkY82J5STPbUSJor7Q2aJgrkpZvU6bw@mail.gmail.com>
 <20220419155055.qf52xpcftqb3r5nj@revolver> <CAOUHufbX_aq+aHf-EVKFLN_jw6hXJ5vtKpG0jskD6uXVKB406w@mail.gmail.com>
 <20220419231748.omnhkl43vl5ep2j5@revolver>
In-Reply-To: <20220419231748.omnhkl43vl5ep2j5@revolver>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 19 Apr 2022 17:22:45 -0600
Message-ID: <CAOUHufaR3Pbv_PgGpzfmzzCHLLwBkHT8G-RcDfe1bo0zESekPw@mail.gmail.com>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Apr 19, 2022 at 5:18 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Yu Zhao <yuzhao@google.com> [220419 17:59]:
> > On Tue, Apr 19, 2022 at 9:51 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> > >
> > > * Yu Zhao <yuzhao@google.com> [220416 15:30]:
> > > > On Sat, Apr 16, 2022 at 9:19 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> > > > >
> > > >
> > > > <snipped>
> > > >
> > > > > How did you hit this issue?  Just on boot?
> > > >
> > > > I was hoping this is known to you or you have something I can verify for you.
> > >
> > >
> > > Thanks, yes.  I believe that both crashes are the same root cause.  The
> > > cause is that I was not cleaning up after the kmem bulk allocation
> > > failure on my side.  Please test with this patch.
> >
> > Thanks. I applied this patch and hit a LOCKDEP and then a BUG_ON:
> >
> >   lib/maple_tree.c:847 suspicious rcu_dereference_protected() usage!
> >   Call Trace:
> >    <TASK>
> >    dump_stack_lvl+0x6c/0x9a
> >    dump_stack+0x10/0x12
> >    lockdep_rcu_suspicious+0x12c/0x140
> >    __mt_destroy+0x96/0xd0
> >    exit_mmap+0x2a0/0x360
> >    __mmput+0x34/0x100
> >    mmput+0x2f/0x40
> >    free_bprm+0x64/0xe0
> >    kernel_execve+0x129/0x330
> >    call_usermodehelper_exec_async+0xd8/0x130
> >    ? proc_cap_handler+0x210/0x210
> >    ret_from_fork+0x1f/0x30
> >    </TASK>
>
> Thanks - I'm not sure how this got through, but this should fix it.
>
> This should be added to 4236a642ad185 to avoid the LOCKDEP issue.
>
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3163,9 +3163,9 @@ void exit_mmap(struct mm_struct *mm)
>
>         BUG_ON(count != mm->map_count);
>
> -       mmap_write_unlock(mm);
>         trace_exit_mmap(mm);
>         __mt_destroy(&mm->mm_mt);
> +       mmap_write_unlock(mm);
>         vm_unacct_memory(nr_accounted);
>  }

Will try this.

> >   BUG: unable to handle page fault for address: ffffa6072aff0060
> >   RIP: 0010:mab_calc_split+0x103/0x1a0
> >   Code: 29 c1 8b 86 64 02 00 00 0f b6 80 dc 7d a7 96 39 c1 7e 05 83 c3
> > 01 eb 06 81 c3 ff 00 00 00 0f b6 c3 45 84 d2 74 3f 41 0f b6 ca <48> 83
> > bc ce 10 01 00 00 00 75 2d 41 83 c0 ff 41 39 c8 7e 20 0f b6
> >   RSP: 0018:ffffa6072afef6d0 EFLAGS: 00010286
> >   RAX: 0000000000000054 RBX: 0000000000000154 RCX: 00000000000000aa
> >   RDX: ffffa6072afef83f RSI: ffffa6072afefa00 RDI: ffffa6072afefe80
> >   RBP: ffffa6072afef6e0 R08: 0000000000000010 R09: 00000000000000ff
> >   R10: 00000000000000aa R11: 0000000000000001 R12: 00000000000000ff
> >   R13: ffffa6072afefa00 R14: ffffa6072afef9c0 R15: 0000000000000008
> >   FS:  0000000001d75340(0000) GS:ffff8a56bf980000(0000) knlGS:0000000000000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: ffffa6072aff0060 CR3: 00000004986ca002 CR4: 00000000001706e0
> >   Call Trace:
> >    <TASK>
> >    mas_spanning_rebalance+0x416/0x2060
> >    mas_wr_store_entry+0xa6d/0xa80
> >    mas_store_gfp+0xf6/0x170
> >    do_mas_align_munmap+0x32b/0x5c0
> >    do_mas_munmap+0xf3/0x110
> >    __vm_munmap+0xd4/0x180
> >    __x64_sys_munmap+0x1b/0x20
> >    do_syscall_64+0x44/0xa0
> >
> > $ ./scripts/faddr2line vmlinux mab_calc_split+0x103
> > mab_calc_split+0x103/0x1a0:
> > mab_no_null_split at lib/maple_tree.c:1787
> > (inlined by) mab_calc_split at lib/maple_tree.c:1866
>
> 1787 is "if (!b_node->slot[split]) {"  Does this line up with your code?

Yes.

> How did you trigger this?

stress-ng --class vm -a 20 -t 600s -temp-path /tmpdir/ (same test
environment as in my first report)
