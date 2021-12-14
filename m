Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6C0473D62
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhLNHDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLNHDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:03:22 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17BBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 23:03:21 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id v15so27035741ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 23:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uo2z+lnsfsUkOyugX5MXsqUFPWEl9Gh8r95HHTw/JI0=;
        b=jdtgwF+mmxvY59yKXeQDd19VaC3H3hgTeHhLTnm2Rw7qPIg7VgJ7YqxpstlhMf1T8/
         hi8DFyRSwGj5Oeb8HNq5GacmM9JiOQ3nKQlp4HR8G5t3Fbok2tjj/GgIJNnJ6B8S1pnu
         4EPcobG9+xi9yWBPWSvrinOxCAEpEX1HSWS4v6RjbYVQNDOd6wnJGLz54BKSK2PHgRRj
         xX8Q2ReQgrQnp74++Z0R9KIjttBotEWMNOht/sU6fyoYaOHQEqG70toIV0/M+FCDHfbC
         agYRYvyGsOvsLrcY5mE7Rr6Nd9nTd4i+Jik43pVLPO6LJQBYwmAs5av4QZXz8nCf/lFD
         /zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uo2z+lnsfsUkOyugX5MXsqUFPWEl9Gh8r95HHTw/JI0=;
        b=DyBB1n1RJuTqI3aAobzRQ8uL3Idb5kIN/Wk2FihCaDnwQOZGYOH/vlc3a/Ln7SYRFr
         h/gSf74+tBLmFLC9aa8K7ctd9q0csJ8gjK++eBHHRMPtjXfFq+7y2FgnCR4aQ//8zWOq
         Bq/TUZQc6YdAIymtWU2bpSWeQsgJSwNIHXpb6u0OUcX5+L+YLtxcxEsQnKbaQdWeSLS2
         O30UB3BS++2xbR61QBdjcP0JUBI3gCfvZaj92ZS4rTd4rxkfziBrjq0LD8e9feXdttVz
         05RJusRFYNkk7EQhT0QzJc5Tkf2mTQ/mnFVHNXJAGtA9OmbbrxH7oVgJYSJvPV+V6osO
         ubbg==
X-Gm-Message-State: AOAM530HEZBjlV8Q/VjAdz2fLZ8Jktnx4PmBUL9HPE0WiTRJh3XSH0wI
        lquPvUDbulxo5/RTI8aW6IN54NuhudVC966NzLGFKWxQo3S3DQ==
X-Google-Smtp-Source: ABdhPJwNCR5ysxQ6SoBCPh+AywrWPBSfsgkUHTdeCTMoTKG2f8FUNYI4QPwE/DonuqShNZzKano4FcwmsbpE11+OEgE=
X-Received: by 2002:a2e:5c46:: with SMTP id q67mr3302642ljb.271.1639465399784;
 Mon, 13 Dec 2021 23:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org> <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
 <20211210154915.hjbgrnvtitmwluhz@maple.lan> <CAFA6WYPd+SLT+XZgLPVjLph27P1D5RpYuLwNu4KC+2nOQH07_Q@mail.gmail.com>
 <20211213130400.npccyt36r5sysca3@maple.lan>
In-Reply-To: <20211213130400.npccyt36r5sysca3@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 14 Dec 2021 12:33:08 +0530
Message-ID: <CAFA6WYPEjQDyt4g-dftMyzd8RKkagDs3hj5ThQfvdpmmV5dF7A@mail.gmail.com>
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        "Wang, Xiaolei" <xiaolei.wang@windriver.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 at 18:34, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Dec 13, 2021 at 02:28:01PM +0530, Sumit Garg wrote:
> > On Fri, 10 Dec 2021 at 21:19, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > > On Fri, Dec 10, 2021 at 03:08:21PM +0530, Sumit Garg wrote:
> > > > On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> wrote:
> > > > > On 12/10/21 06:00, Sumit Garg wrote:
> > > > > > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
> > > > > > Yes. AFAICT, optee-os should allocate shared memory to communicate
> > > > > > with tee-supplicant. So once the communication is done, the underlying
> > > > > > shared memory should be freed. I can't think of any scenario where
> > > > > > optee-os should keep hold-off shared memory indefinitely.
> > > > >
> > > > > I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> > > > > the config file [1] and the commit which introduced this config [2].
> > > >
> > > > Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
> > > > RPC shared memory remains allocated. I guess that is done primarily
> > > > for performance reasons.
> > > >
> > > > But still it doesn't feel appropriate that we term all RPC shm
> > > > allocations as not leaking memory as we might miss obvious ones.
> > >
> > > IIUC this patch adds kmemleak_not_leak() at (pretty much) the last
> > > possible point before *ownership* of the SHM block is passed from kernel
> > > to OP-TEE.
> >
> > I wouldn't say it's a transfer of ownership from kernel to OP-TEE but
> > rather a way for OP-TEE to access kernel's memory in order to pass
> > info or execute further RPC commands.
>
> The RPC handler allocates a pointer (e.g. now the RPC handler owns the
> allocated memory). The RPC handler then passes that pointer to OP-TEE and
> forgets what it's value was.
>
> That is a transfer of ownership: the RPC handler does not hold any pointer
> to the memory and is incapable of freeing it. Moreover this situation is
> what kmemleak_no_leak() is for! Its job it to inform kmemleak that the
> pointer is owned/stored somewhere that is does not scan.
>

Let me put this another way. If the memory allocator belongs to the
kernel then how does OP-TEE get to know which memory is currently
allocated and it is to be scanned?

I think the complete solution would be to extend kmemleak to support
OP-TEE memory scanning via OP-TEE invocation to check if it's holding
any kernel memory references.

>
> > > Sure, after we change ownership it could still be leaked... but it can
> > > no longer be leaked by the kernel because the kernel no longer owns it!
> > > More importantly, it makes no sense to run the kernel memory detector on the
> > > buffer because it simply can't work.
> > >
> > > After the RPC completes, doesn't it become impossible for kmemleak to
> > > scan to see if the pointer is lost[1]?
> >
> > Apart from the special OP-TEE prealloc SHM cache stuff, I can't think
> > of any scenario where an OP-TEE thread should hold off kernel's memory
> > pointers for more than 5 seconds before being passed onto kernel for
> > further RPC commands or RPC free action. So the kmemleak should be
> > able to detect if a pointer is lost.
>
> Or putting this a different way: there is known to be firmware in the
> field that allocates pointers for more then five seconds!
>

If it's known that upstream OP-TEE doesn't hold any kernel memory
references for more than 5 seconds then IMO we should be fine to not
disable kmemleak until we have a future kmemleak extension. Otherwise
it would be very hard to keep track of kernel memory lost in this way.

>
> > /*
> >  * Kmemleak configuration and common defines.
> >  */
> > <snip>
> > #define MSECS_MIN_AGE           5000    /* minimum object age for reporting */
> > <snip>
> >
> > > kmemleak is essentially a tracing
> > > garbage collector and needs to be able to scan all memory that could
> > > hold a pointer to leakable memory. After the RPC completes the
> > > only copy of the pointer will be stored in a memory region that the
> > > kernel is prohibited from reading. How could kmemleak possibly give you
> > > a useful answer in this circumstance?
> > >
> >
> > There is another aspect of kmemleak being the minimum age of an object
> > to be reported as a memory leak as described above. Also, this case
> > resembles where a pointer is stored on the CPU stack (see struct
> > optee_rpc_param param = { };).
>
> I can't see how this resembles pointers stored on the stack.
>
> Firstly, stack memory is scanned by kmemleak meaning a thread is
> permitted to own memory for more than five seconds without provoking a
> warning. OP-TEE memory cannot be scanned like this.
>
> Secondly, stacks don't have any concept of sessions. It is *really*
> buggy behaviour for a TA to allocate SHM memory during a session open so
> it can avoid critical path RPC round trips when operational?
>

That's one optimization case for prealloc SHM we have currently. Jens
is already working on an update for SMC ABI to avoid such allocations.

BTW, that could be disabled with CFG_PREALLOC_RPC_CACHE=n in upstream OP-TEE.

>
> > In most of the scenarios apart from special prealloc shm cache case,
> > the flow should be as follows:
> >
> > 1) Alloc kernel memory via RPC
> > 2) OP-TEE passes references to kernel memory for RPC action commands
> > 3) Free kernel memory via RPC
> >
> > kmemleak should be useful in case the 3rd step is skipped due to
> > incorrect behaviour of a particular OP-TEE thread. And I can't think
> > of any appropriate way in OP-TEE OS to detect this type of kernel
> > memory leak caused by one of its threads.
>
> If OP-TEE is the only place the pointer is held and you can't think of
> any way for OP-TEE OS to detect if it has leaked the pointer then how
> can you expect the kernel to give a correct verdict when it has even
> less visibility than OP-TEE OS.

Let me try to elaborate here. Since the nature of shared memory under
consideration here are:

1) Allocated by kernel.
2) OP-TEE holds reference to it.

In order to detect its leakage, the memory leakage detector should be
invoked by the kernel and OP-TEE should support that detector to say
if it holds any references to the memory being scanned.

Also, as you may know OP-TEE is a passive firmware entity without any
threads of its own and is scheduled by the Linux kernel. So it won't
be possible to have an independent memory leak detector thread within
OP-TEE.

>
> Note that, if you think OP-TEE routinely leaks memory,

How can we be sure about any piece of complex software (lots of
platform specific code) that it will leak memory or not? I guess that
is the reason why the kernel has this runtime kmemleak debugging tool.

-Sumit

> then there are
> ways that the corresponding kernel driver could track what memory it has
> handed to OP-TEE. However this should be described as a list of
> *allocations* rather than a list of *leaks* because the driver cannot
> distinguish the two.
>
>
> Daniel.
