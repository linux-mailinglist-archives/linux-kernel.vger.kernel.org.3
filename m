Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38E34D556C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbiCJXcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiCJXcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:32:18 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B49F19CCC3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:31:16 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2dbc48104beso76490687b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ECjPK11wsuEVryWmqpR3k3ZiIuxweVEaECaw5mE+94=;
        b=GmLy3PEJ+iGbMTqEd3nft0r2e1Htire9ySKkYTK3SJdj26W8x5OK9maG0s0nrk5qai
         YYTDjp0Xk4HaMlr2adQ04baCGdz27GQ2lHKwd67QfpLyvfN68DHPad2jsJtfaR/H7b+P
         BDOCgNgNszHnF8lQ/A1NwyQ5neBC+IXQbumfcBpywcLx8UgLsdF2a6888Y6A/KYGwVTE
         IjN/F2xJ0EWsDl+V5JL6i36r35mL7cuZNK0VA5oc3yv8i9O22WIF6/2SoDisAz8KuYBM
         zLhBH00ueSytiX/8m35w65JCauLCxlI3lEObx186Q5peIpy/OkrJyaSVP6MblDcG+PlO
         9Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ECjPK11wsuEVryWmqpR3k3ZiIuxweVEaECaw5mE+94=;
        b=uLlZsz8aumsr/r19nhTbNkNG7eqV7hbGAbOQ7m7UYRy0sZhfM4I1fKxLkHoqGT+/Jd
         b4gLFQ6V4fU+Sx65A/86bUSNdAv/vGloBe+AYkjNAiBZ1i9EY9SK3NOc/DI2+ZiNJbj8
         A4npbzymsLuvAbt6PvFjp/v2AbYLps+w9QabeRE8lMNd3JTcfGRgYZUEfP9gV9I1KUOW
         fbwFxtRhl9WeYtrW/TrD1FnapqW2iqENJpSu7iG8m/5NPA3ZPREjiF291TYOT0yWRi08
         UNtRGnP1vCz6jsj4fS+PkPQsVFEREwEkBxt/fe0cbrMUR5AVqqEc3QGss1cpWF3N5/+9
         U29g==
X-Gm-Message-State: AOAM530R1WH70a9KSfKlRCGdisvdssTT9ZYR+V/7uLeinqbTQjNo+qLt
        5i8bLQimSxnhM4tC8YDr7yXndbpyVGU082ttIUrIxA==
X-Google-Smtp-Source: ABdhPJz7BxmSJCbeCL22yKsXMI9ADDC7i5QDGRPLPozbu4jocqeJRgEtOOnO2/+RU2i2pfuuSrPHsi7OTj5OCoKwwJc=
X-Received: by 2002:a0d:c847:0:b0:2d6:9010:5721 with SMTP id
 k68-20020a0dc847000000b002d690105721mr6251548ywd.380.1646955075261; Thu, 10
 Mar 2022 15:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20220215201922.1908156-1-surenb@google.com> <20220224201859.a38299b6c9d52cb51e6738ea@linux-foundation.org>
 <YhhZsv+czqQPKvvN@casper.infradead.org> <CAJuCfpEUro2jxmx-AB2A-mVcNxz6s3oAyow1sEXY5RyPP+83dA@mail.gmail.com>
 <20220310155454.g6lt54yxel3ixnp3@revolver> <CAJuCfpHk+1snrPx-_qvj=kjSOS+o=L90evAQ1gD5hj6XxB=a3g@mail.gmail.com>
 <20220310222206.dttvvlgfqysrcl2s@revolver>
In-Reply-To: <20220310222206.dttvvlgfqysrcl2s@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Mar 2022 15:31:04 -0800
Message-ID: <CAJuCfpHoMtJdJgXCs45Oi=BUFWVcw76J5Kk-6_1ZuXVvZM_vpA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "guro@fb.com" <guro@fb.com>, "riel@surriel.com" <riel@surriel.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "christian@brauner.io" <christian@brauner.io>,
        "hch@infradead.org" <hch@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "jengelh@inai.de" <jengelh@inai.de>,
        "timmurray@google.com" <timmurray@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com" 
        <syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com>
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

On Thu, Mar 10, 2022 at 2:22 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [220310 11:28]:
> > On Thu, Mar 10, 2022 at 7:55 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> > >
> > > * Suren Baghdasaryan <surenb@google.com> [220225 00:51]:
> > > > On Thu, Feb 24, 2022 at 8:23 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Thu, Feb 24, 2022 at 08:18:59PM -0800, Andrew Morton wrote:
> > > > > > On Tue, 15 Feb 2022 12:19:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > >
> > > > > > > After exit_mmap frees all vmas in the mm, mm->mmap needs to be reset,
> > > > > > > otherwise it points to a vma that was freed and when reused leads to
> > > > > > > a use-after-free bug.
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > --- a/mm/mmap.c
> > > > > > > +++ b/mm/mmap.c
> > > > > > > @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
> > > > > > >             vma = remove_vma(vma);
> > > > > > >             cond_resched();
> > > > > > >     }
> > > > > > > +   mm->mmap = NULL;
> > > > > > >     mmap_write_unlock(mm);
> > > > > > >     vm_unacct_memory(nr_accounted);
> > > > > > >  }
> > > > > >
> > > > > > After the Maple tree patches, mm_struct.mmap doesn't exist.  So I'll
> > > > > > revert this fix as part of merging the maple-tree parts of linux-next.
> > > > > > I'll be sending this fix to Linus this week.
> > > > > >
> > > > > > All of which means that the thusly-resolved Maple tree patches might
> > > > > > reintroduce this use-after-free bug.
> > > > >
> > > > > I don't think so?  The problem is that VMAs are (currently) part of
> > > > > two data structures -- the rbtree and the linked list.  remove_vma()
> > > > > only removes VMAs from the rbtree; it doesn't set mm->mmap to NULL.
> > > > >
> > > > > With maple tree, the linked list goes away.  remove_vma() removes VMAs
> > > > > from the maple tree.  So anyone looking to iterate over all VMAs has to
> > > > > go and look in the maple tree for them ... and there's nothing there.
> > > >
> > > > Yes, I think you are right. With maple trees we don't need this fix.
> > >
> > >
> > > Yes, this is correct.  The maple tree removes the entire linked list...
> > > but since the mm is unstable in the exit_mmap(), I had added the
> > > destruction of the maple tree there.  Maybe this is the wrong place to
> > > be destroying the tree tracking the VMAs (althought this patch partially
> > > destroys the VMA tracking linked list), but it brought my attention to
> > > the race that this patch solves and the process_mrelease() function.
> > > Couldn't this be avoided by using mmget_not_zero() instead of mmgrab()
> > > in process_mrelease()?
> >
> > That's what we were doing before [1]. That unfortunately has a problem
> > of process_mrelease possibly calling the last mmput and being blocked
> > on IO completion in exit_aio.
>
> Oh, I see. Thanks.
>
>
> > The race between exit_mmap and
> > process_mrelease is solved by using mmap_lock.
>
> I think an important part of the race fix isn't just the lock holding
> but the setting of the start of the linked list to NULL above.  That
> means the code in __oom_reap_task_mm() via process_mrelease() will
> continue to execute but iterate for zero VMAs.
>
> > I think by destroying the maple tree in exit_mmap before the
> > mmap_write_unlock call, you keep things working and functionality
> > intact. Is there any reason this can't be done?
>
> Yes, unfortunately.  If MMF_OOM_SKIP is not set, then process_mrelease()
> will call __oom_reap_task_mm() which will get a null pointer dereference
> or a use after free in the vma iterator as it tries to iterate the maple
> tree.  I think the best plan is to set MMF_OOM_SKIP unconditionally
> when the mmap_write_lock() is acquired.  Doing so will ensure nothing
> will try to gain memory by reaping a task that no longer has memory to
> yield - or at least won't shortly.  If we do use MMF_OOM_SKIP in such a
> way, then I think it is safe to quickly drop the lock?

That technically would work but it changes the semantics of
MMF_OOM_SKIP flag from "mm is of no interest for the OOM killer" to
something like "mm is empty" akin to mm->mmap == NULL.
So, there is no way for maple tree to indicate that it is empty?

>
> Also, should process_mrelease() be setting MMF_OOM_VICTIM on this mm?
> It would enable the fast path on a race with exit_mmap() - thought that
> may not be desirable?

Michal does not like that approach because again, process_mrelease is
not oom-killer to set MMF_OOM_VICTIM flag. Besides, we want to get rid
of that special mm_is_oom_victim(mm) branch inside exit_mmap. Which
reminds me to look into it again.

>
> >
> > [1] ba535c1caf3ee78a ("mm/oom_kill: allow process_mrelease to run
> > under mmap_lock protection")
> >
> > > That would ensure we aren't stepping on an
> > > exit_mmap() and potentially the locking change in exit_mmap() wouldn't
> > > be needed either?  Logically, I view this as process_mrelease() having
> > > issue with the fact that the mmaps are no longer stable in tear down
> > > regardless of the data structure that is used.
> > >
> > > Thanks,
> > > Liam
> > >
> > > --
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> > >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
