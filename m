Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB064B8EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiBPRAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:00:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiBPRAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:00:02 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A92A5206
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:59:50 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id l125so7441599ybl.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Exph8UN21TSJr+eQwovoIrKIT7yhVfaU/3hoH0vSQhc=;
        b=bXK4Yyg77XZRew+nhTpLkT7bnUmPYIusjiEV7dXi9VxQX6ke68/oYgYHUj3lLJw5Hw
         RUkXtIH5dxHvoipiwNId+P/Lt/ArX3LnixL9C6IJzOHkHC1hLoqSP2CLa5LEAYnSVVeh
         f9BrtjnSE7ycofKnifxUKspc0WqcGflZk1y6aSmUzzSv/aEM7KYnWcAZn2OlQ5VwIEOI
         iuGHlu84BSZ6uUdWMpCIEJE2ocwFqURcNn6+Br7D3iKbDmdiHV0nK5CUWxhoZFZZseol
         ZpU3hQQE7CWp42taq03nJNxdbQ7ovWN4rNIFGfnnlzTLRgoLB87Qm3fm8hjRrOzVfSJc
         JNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Exph8UN21TSJr+eQwovoIrKIT7yhVfaU/3hoH0vSQhc=;
        b=8EVk47h1qleEmmUjODA4P8Ak/R4OEEmPsce8ahz92ZBStlB7W8Dwwf/43BPAfL8xjm
         jO0jKo5UZ0/vzZnH3yAcBmsOq2ownJEZ85LBagcx+e2yaOmZTR0nhSb5rvcPHKqQbKbu
         7Wmv3bRfqZpp8nlHkTHGkW9JtPFLQ92Ckef9Kvs9MCyKT5vUgasJaD3X4DezaYmRoFxr
         ONf+8hIT0m3Q+0tj6DWPoodrEA4IFX34xRAE0iSdzwLQdy3cKhVDpWbsGQ2wT2s9+iAy
         P75D732pIUHa5gpUOzfeSfBiC3i1HI31xhlVJQuB1UYk34LAKNm8qwdvWVo7FZD70DR/
         lVWA==
X-Gm-Message-State: AOAM530NMJeQgkLeGxVaS+hserVfH1WXIGpr0S9SBsU6Md0pswgJG2zw
        XDXQguxFnlwEuAaUCzVUAGzY+Jum4HlirbyhRF4=
X-Google-Smtp-Source: ABdhPJzgYrPUcnOA4CQUL5KailDc41T+IYE4N0QMrFi+eREFsmxkmXELoYto7dcijGC4px2jMvPZyF+OML/3Cvn/nUc=
X-Received: by 2002:a25:8289:0:b0:623:dc4d:28e5 with SMTP id
 r9-20020a258289000000b00623dc4d28e5mr2990803ybk.182.1645030789530; Wed, 16
 Feb 2022 08:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20200917112538.GD8409@ziepe.ca> <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca> <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1> <20200918173240.GY8409@ziepe.ca>
 <20200918204048.GC5962@xz-x1> <0af8c77e-ff60-cada-7d22-c7cfcf859b19@nvidia.com>
 <20200919000153.GZ8409@ziepe.ca> <20200921083505.GA5862@quack2.suse.cz> <20200921120301.GD8409@ziepe.ca>
In-Reply-To: <20200921120301.GD8409@ziepe.ca>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 16 Feb 2022 18:59:22 +0200
Message-ID: <CAFCwf10eNmwq2wD71xjUhqkvv5+_pJMR1nPug2RqNDcFT4H86Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 3:03 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Sep 21, 2020 at 10:35:05AM +0200, Jan Kara wrote:
> > > My thinking is to hit this issue you have to already be doing
> > > FOLL_LONGTERM, and if some driver hasn't been properly marked and
> > > regresses, the fix is to mark it.
> > >
> > > Remember, this use case requires the pin to extend after a system
> > > call, past another fork() system call, and still have data-coherence.
> > >
> > > IMHO that can only happen in the FOLL_LONGTERM case as it inhernetly
> > > means the lifetime of the pin is being controlled by userspace, not by
> > > the kernel. Otherwise userspace could not cause new DMA touches after
> > > fork.
> >
> > I agree that the new aggressive COW behavior is probably causing issues
> > only for FOLL_LONGTERM users. That being said it would be nice if even
> > ordinary threaded FOLL_PIN users would not have to be that careful about
> > fork(2) and possible data loss due to COW - we had certainly reports of
> > O_DIRECT IO loosing data due to fork(2) and COW exactly because it is very
> > subtle how it behaves... But as I wrote above this is not urgent since that
> > problematic behavior exists since the beginning of O_DIRECT IO in Linux.
>
> Yes, I agree - what I was thinking is to do this FOLL_LONGTERM for the
> rc and then a small patch to make it wider for the next cycle so it
> can test in linux-next for a responsible time period.
>
> Interesting to hear you confirm block has also seen subtle user
> problems with this as well.
>
> Jason
>

Hi Jason, Linus,
Sorry for waking up this thread, but I've filed a bug against this change:
https://bugzilla.kernel.org/show_bug.cgi?id=215616

In the past week, I've bisected a problem we have in one of our new
demos running on our Gaudi accelerator, and after a very long
bisection, I've come to this commit.
All the details are in the bug, but the bottom line is that somehow,
this patch causes corruption when the numa balancing feature is
enabled AND we don't use process affinity AND we use GUP to pin pages
so our accelerator can DMA to/from system memory.

Either disabling numa balancing, using process affinity to bind to
specific numa-node or reverting this patch causes the bug to
disappear.
I validated the bug and the revert on kernels 5.9, 5.11 and 5.17-rc4.

You can see our GUP code in the driver in get_user_memory() in
drivers/misc/habanalabs/common/memory.c.
It is fairly standard and I think I got that line from Daniel (cc'ed
on this email).

I would appreciate help from the mm experts here to understand how to
fix this, but it looks as if this simplification caused or exposed
some race between numa migration code and GUP.

Thanks,
Oded
