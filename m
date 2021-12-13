Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E177747235C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhLMI6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhLMI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:58:16 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48CAC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:58:15 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bi37so29501610lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtG+Zo9k/sSMcgG9GoukP1pZPI5oFb7+j+39WjRs7Jc=;
        b=mdQeLgsWa0IIgHOqLgFzCnfw634aNpdqEtME7cjXvxK9qwfwwZDEPh3JrWri53ZczC
         mslznkazCtViQITTc4AWYEizJZ2LpgvDU4aXzmjVVp2JIt/vTeP5eXVPST9rF1ko+x5S
         FtELrBiCPN/LQgrfb7EiYDDTtwv1W8THS7H5pivGAwVLA+UXJ3u9KgtmzMCme0rgLQFN
         G5NsPTKKbSz5Uzdv62oKD2Wm48J0t3BEjM/6WMUsAdSaqsT+b70xUEa4pYImWC8eg/1U
         XvVL6Ey/oRtCb12HIgW8w8lviFelxpmrr85Ya6Di8kD5nTe6Cr5KAN+jcE/jcApwjoCu
         pM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtG+Zo9k/sSMcgG9GoukP1pZPI5oFb7+j+39WjRs7Jc=;
        b=nuwWzktlG3Jv3/yZXDfzgjF6a8achOQM55Wm3F2wrAOkJMxx3Z8Y1Y/2lA02BIbYKJ
         HcYM0O0y8XxspIgt7QDWx/gvVYyJQGAD4jyEksRizcwbRe7S513WkUMyDDyezz82Rh+l
         aQj2+2G83XjYwFyeuXit5zSn2SkNWfA7DKgsuT/77/i4XKf4VLyWf+R77nmamoYsdnjn
         KqFooCc21FDxuJRhPhyKkP9qJTbDQTKsfauRHXmU5ByFhmICX7d8q152mFgQz0pLknp0
         ccZ1akPJ+OovtxIPGxJTGc2CWrY8lCNX08Fox/FYyoO98HbfxRMnNvOrks9WsUSxzZgB
         B6+Q==
X-Gm-Message-State: AOAM5313GotDPlzUhGrE5vYKuTwgKsZMoPshSjcG1rtmmNVSPqEQKjK0
        LM75OzJudIoutNjV2fwi7mU3s+qBgxq4W48+5ZQgRQ==
X-Google-Smtp-Source: ABdhPJxkdrKDOg/978KeH8jwVEUHP98az2YhBKVI2wonpCEhkknK1oV+E2fsHf6QnA6l8DTwD8S9O0hfVgip9/gr8ng=
X-Received: by 2002:ac2:5930:: with SMTP id v16mr27213317lfi.327.1639385893584;
 Mon, 13 Dec 2021 00:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org> <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
 <20211210154915.hjbgrnvtitmwluhz@maple.lan>
In-Reply-To: <20211210154915.hjbgrnvtitmwluhz@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 13 Dec 2021 14:28:01 +0530
Message-ID: <CAFA6WYPd+SLT+XZgLPVjLph27P1D5RpYuLwNu4KC+2nOQH07_Q@mail.gmail.com>
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

On Fri, 10 Dec 2021 at 21:19, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Dec 10, 2021 at 03:08:21PM +0530, Sumit Garg wrote:
> > On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> wrote:
> > >
> > > +CC Jens, Etienne
> > >
> > > On 12/10/21 06:00, Sumit Garg wrote:
> > > > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
> > > >>
> > > >> -----Original Message-----
> > > >> From: Sumit Garg <sumit.garg@linaro.org>
> > > >> Sent: Thursday, December 9, 2021 7:41 PM
> > > >> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> > > >> Cc: jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org; linux-kernel@vger.kernel.org
> > > >> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
> > > >>
> > > >> [Please note: This e-mail is from an EXTERNAL e-mail address]
> > > >>
> > > >> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
> > > >>>
> > > >>> We observed the following kmemleak report:
> > > >>> unreferenced object 0xffff000007904500 (size 128):
> > > >>>   comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
> > > >>>   hex dump (first 32 bytes):
> > > >>>     00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
> > > >>>     60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
> > > >>>   backtrace:
> > > >>>     [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
> > > >>>     [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
> > > >>>     [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
> > > >>>     [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
> > > >>>     [<00000000c35884da>] optee_open_session+0x128/0x1ec
> > > >>>     [<000000001748f2ff>] tee_client_open_session+0x28/0x40
> > > >>>     [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
> > > >>>     [<000000003df18bf1>] optee_probe+0x674/0x6cc
> > > >>>     [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
> > > >>>     [<000000000c51ce7d>] really_probe+0xe4/0x4d0
> > > >>>     [<000000002f04c865>] driver_probe_device+0x58/0xc0
> > > >>>     [<00000000b485397d>] device_driver_attach+0xc0/0xd0
> > > >>>     [<00000000c835f0df>] __driver_attach+0x84/0x124
> > > >>>     [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
> > > >>>     [<000000001735e8a8>] driver_attach+0x24/0x30
> > > >>>     [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
> > > >>>
> > > >>> This is not a memory leak because we pass the share memory pointer to
> > > >>> secure world and would get it from secure world before releasing it.
> > > >>
> > > >>> How about if it's actually a memory leak caused by the secure world?
> > > >>> An example being secure world just allocates kernel memory via OPTEE_SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
> > > >>
> > > >>> IMO, we need to cross-check optee-os if it's responsible for leaking kernel memory.
> > > >>
> > > >> Hi sumit,
> > > >>
> > > >> You mean we need to check whether there is a real memleak,
> > > >> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC_ALLOC and until the end, there is no free
> > > >> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak, wo need to judge whether it is caused by secure os?
> > > >
> > > > Yes. AFAICT, optee-os should allocate shared memory to communicate
> > > > with tee-supplicant. So once the communication is done, the underlying
> > > > shared memory should be freed. I can't think of any scenario where
> > > > optee-os should keep hold-off shared memory indefinitely.
> > >
> > > I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> > > the config file [1] and the commit which introduced this config [2].
> >
> > Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
> > RPC shared memory remains allocated. I guess that is done primarily
> > for performance reasons.
> >
> > But still it doesn't feel appropriate that we term all RPC shm
> > allocations as not leaking memory as we might miss obvious ones.
>
> IIUC this patch adds kmemleak_not_leak() at (pretty much) the last
> possible point before *ownership* of the SHM block is passed from kernel
> to OP-TEE.

I wouldn't say it's a transfer of ownership from kernel to OP-TEE but
rather a way for OP-TEE to access kernel's memory in order to pass
info or execute further RPC commands.

>
> Sure, after we change ownership it could still be leaked... but it can
> no longer be leaked by the kernel because the kernel no longer owns it!
> More importantly, it makes no sense to run the kernel memory detector on the
> buffer because it simply can't work.
>
> After the RPC completes, doesn't it become impossible for kmemleak to
> scan to see if the pointer is lost[1]?

Apart from the special OP-TEE prealloc SHM cache stuff, I can't think
of any scenario where an OP-TEE thread should hold off kernel's memory
pointers for more than 5 seconds before being passed onto kernel for
further RPC commands or RPC free action. So the kmemleak should be
able to detect if a pointer is lost.

/*
 * Kmemleak configuration and common defines.
 */
<snip>
#define MSECS_MIN_AGE           5000    /* minimum object age for reporting */
<snip>

> kmemleak is essentially a tracing
> garbage collector and needs to be able to scan all memory that could
> hold a pointer to leakable memory. After the RPC completes the
> only copy of the pointer will be stored in a memory region that the
> kernel is prohibited from reading. How could kmemleak possibly give you
> a useful answer in this circumstance?
>

There is another aspect of kmemleak being the minimum age of an object
to be reported as a memory leak as described above. Also, this case
resembles where a pointer is stored on the CPU stack (see struct
optee_rpc_param param = { };).

In most of the scenarios apart from special prealloc shm cache case,
the flow should be as follows:

1) Alloc kernel memory via RPC
2) OP-TEE passes references to kernel memory for RPC action commands
3) Free kernel memory via RPC

kmemleak should be useful in case the 3rd step is skipped due to
incorrect behaviour of a particular OP-TEE thread. And I can't think
of any appropriate way in OP-TEE OS to detect this type of kernel
memory leak caused by one of its threads.

-Sumit

> In other words if there's nothing kmemleak could do to fix this
> situation then marking the memory as kmemleak_not_leak() seems entirely
> appropriate (although it should be prefaced with a big comment
> explaining the change of ownerhship and why kmemleak cannot work).
>
>
> Daniel.
>
>
> [1] Everything I've said here hinges on this being true... so if I've
>     made a mistake about where OP-TEE stores this pointer then most of
>     the rest of this post is junk ;-)
