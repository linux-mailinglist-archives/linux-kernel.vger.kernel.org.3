Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F8C50A454
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390170AbiDUPip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390111AbiDUPio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:38:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103C546B34
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:35:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c23so5257713plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXKkwFuLNe8vNIMsnycJX9DTuR1p8Pvkhbh/7cpTl38=;
        b=dpvEDkE6wJIs0gkXt51H/VUztfKGIef2hF9OcHWLjE4hYldjWX9uNhcbEVUEKU1MxN
         Q1amNjZo4gEceFtF/P367hplKLcJud26Ll9h9ok02EGhmIvleUa2PIiFSzfRVyvTq/i+
         LgY0hgYcCdqKaT6X7JzqJTCYNsB8JRdg2iMDW8b44MwOiQUnqOoOe7qHjnG/79H46yhS
         VZuCRd1th7HBgYofi2mJ5CI/sNoVepdRFvkmvGKDstR4afpk79J8BPFYgoMf7Fz8sxA2
         wugzAVV8QA6wFEct82EWjllhAY63G2uHi2Yzcm6fNkrl9uzYRtAFMTXTT2UEBw1WY+xO
         ZO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXKkwFuLNe8vNIMsnycJX9DTuR1p8Pvkhbh/7cpTl38=;
        b=VcHxW0m17xllVvYKmyz46hQLLJaZ/XgOke+ttJ28qDgJ5ZoalASXkx6XHHEDRp6143
         aNBrMGJpN+QiPASTiJIy+fdQG2I8uUMTelT7V+x1uIXFxxHpwzPzEsjD8fLN80WOpLp7
         HVlg2KwkmUsJHwwcDV0Mw999K1qRVBf3GxS6Yv/txNQ1buUR47PA/fryV8kExcq2hTyy
         t8QiMfIDoYI8o48fE1TAHVphbxA9wyg0n3rCVMQE8CSrMAzOwyj79okszRI7zzS91H+o
         AHh8mx3aKK2zPpECjTjiXD3LwxkWbL/u5BiimWe/u26BD2zJxWKJnbNkAoYfMYZch7qn
         26oQ==
X-Gm-Message-State: AOAM532VkxH2kB4jDZwzFjJ7YG6Yn/XZNeFH/XkD7AMUpP5BpS1IpcId
        GgZuYInh9HlepZNKBc509ziXoMT9uh8Kv3hOTXpJ7tMCVa8=
X-Google-Smtp-Source: ABdhPJxuI6tMvvaUkKwVPk3D1BsHhnik0L43+MUsPxhJ1b3KXb486gEbYvr/3TsYbGXdCxYJLPzUaqH7GbrTSUwyqQ8=
X-Received: by 2002:a17:90b:3009:b0:1cb:be72:1d4f with SMTP id
 hg9-20020a17090b300900b001cbbe721d4fmr228057pjb.109.1650555353329; Thu, 21
 Apr 2022 08:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220420073717.GD16310@xsang-OptiPlex-9020> <CAHk-=wi6pJhsWLd7t9wEtq5tWh_2O61cSLk-wCgLwFrjW6+jbw@mail.gmail.com>
In-Reply-To: <CAHk-=wi6pJhsWLd7t9wEtq5tWh_2O61cSLk-wCgLwFrjW6+jbw@mail.gmail.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 21 Apr 2022 08:35:41 -0700
Message-ID: <CANaxB-yVLCSHAi3QKMYzsSDRYC5Wz05iWx8yrb57cbiJ__5ThA@mail.gmail.com>
Subject: Re: [fs/pipe] 5a519c8fe4: WARNING:at_mm/page_alloc.c:#__alloc_pages
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 12:07 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Apr 20, 2022 at 12:37 AM kernel test robot
> <oliver.sang@intel.com> wrote:
> >
> > commit: 5a519c8fe4d6 ("fs/pipe: use kvcalloc to allocate a pipe_buffer array")
> >
> > [   32.170781][ T3729] WARNING: The mand mount option has been deprecated and
> > [   32.170781][ T3729]          and is ignored by this kernel. Remove the mand
> > [   32.170781][ T3729]          option from the mount to silence this warning.
>
> Heh. Not that warning.
>
> This warning:
>
> > [ 224.552771][ T3730] WARNING: CPU: 1 PID: 3730 at mm/page_alloc.c:5364 __alloc_pages (mm/page_alloc.c:5364)
>
> That's just the
>
>   5363          if (unlikely(order >= MAX_ORDER)) {
>   5364                  WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
>   5365                  return NULL;
>   5366          }
>
> so somebody is doing a big allocation that will fail, and doesn't use
> __GFP_NOWARN.
>
> That someone being iter_file_splice_write():
>
> > [ 224.567299][ T3730] kmalloc_order (include/linux/gfp.h:572 include/linux/gfp.h:595 include/linux/gfp.h:609 mm/slab_common.c:944)
> > [ 224.567707][ T3730] kmalloc_order_trace (mm/slab_common.c:960)
> > [ 224.568173][ T3730] __kmalloc (include/linux/slab.h:510 mm/slub.c:4413)
> > [ 224.568571][ T3730] iter_file_splice_write (include/linux/slab.h:? include/linux/slab.h:652 fs/splice.c:628)
> > [ 224.570060][ T3730] do_splice (fs/splice.c:767 fs/splice.c:1079)
> > [ 224.572386][ T3730] __ia32_sys_splice (fs/splice.c:1144 fs/splice.c:1350 fs/splice.c:1332 fs/splice.c:1332)
>
> and that's the
>
>         int nbufs = pipe->max_usage;
>         struct bio_vec *array = kcalloc(nbufs, sizeof(struct bio_vec),
>                                         GFP_KERNEL);
>
> thing, and no, using __GFP_NOWARN here isn't what we'd want to do,
> because the code in question has no fallback (it will just return
> -ENOMEM).
>
> Now, technically, returning -ENOMEM is a "fallback", but not really.
> It just means the kernel won't crash, it doesn't mean that this is
> acceptable behavior.
>
> Basically, that commit 5a519c8fe4d6 made it possible to create a pipe
> that is effectively "too large to be used". It used to be that such a
> pipe could never be created before, because the 'pipe->bufs' resizing
> allocation used to be
>
>         bufs = kcalloc(nr_slots, sizeof(*bufs),
>                        GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>
> and 'sizeof(struct pipe_buffer)' is bigger than 'sizeof(struct
> bio_vec)', so if the resizing was successful, then the pipe buffer
> count was guaranteed to be smaller than what that file_splice code
> would use.
>
> So it really does look like this whole "allow the pipe size to grow
> almost unlimited" change was a fundamental mistake. It has these kinds
> of subtle issues.
>
> I'm inclined to revert commit 5a519c8fe4d6 - doing multiple iterations
> really shouldn't be so expensive, and this shows that the whole "try
> to do it in one big go" is fundamentally broken.
>
> Could 'iter_file_splice_write()' be changed to limit it some way? Yes.
>
> Could it be changed to use kvcalloc() too? Yes again.
>
> But I'm not convinced that some odd corner-case CRIU optimization is
> worth this kind of pain.

Sorry for the inconvenience. This change is critical for the live
(iterative) migration scenario. For this case, we have the pre-dump
operation that dumps processes memory without freezing processes. The
memory tracker is used to detect what pages have been changed from the
previous iterations. The pre-dump operation requires being able to grub
process pages with minimal process downtime. We use pipes for that. CRIU
injects a parasite code to a target process, vmsplice-s memory to pipes,
resumes the process, and dumps pages from pipes while the process
continues doing its job. Right now, we can do reliably pipes with the 3MB
capacity (1 << PAGE_ALLOC_COSTLY_ORDER) * PAGE_SIZE / sizeof(struct
kernel_pipe_buffer).
It means that 1000 pipes allow us to dump only 3GB of memory.
The operation of injecting/curing parasite code from the
process is expensive and requires freezing a process. This is why we
want to maximize the load that we can carry on for each iteration. And I
am not sure that we can solve this problem without any kernel changes.
For us, it is the optimization of the often used code path. I know CRIU itself
is an odd corner case, but anyway it would be good if we can find a solution.

We made another attempt to solve the problem by introducing
process_vmsplice https://lkml.org/lkml/2018/1/9/32. It is stuck with a
very similar explanation:

> All seems fairly straightforward.  The big question is: do we know
> that people will actually use this, and get sufficient value from it
> to justify its addition?

Thanks,
Andrei


>
>                       Linus
