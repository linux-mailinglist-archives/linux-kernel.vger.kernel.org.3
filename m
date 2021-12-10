Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66C046FDFB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbhLJJmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbhLJJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:42:09 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95A0C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:38:34 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id i63so12910337lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0fXbz31L/uAeja+1Vs+qmIjQ7kVlgqZf30R7/3Qhro=;
        b=sG6ZXK2rM8IeukfJxSqIN0Kx2Rpc65fI9Llyk1bSKPQePXtToY3Yl1pYUBPnzPTsKT
         2MZK59tryae2YiRQY2pCEEkD6egpPfvh6iGZMdlVEUN3qWb0bXePj4BUZxEqHS6bw6bN
         fKQYcrLRv30PidazfGKVQK2IYnXU1xpHwqtTY0yVKhO7fiGi5LZi7rikbbNbBPtS9SOf
         zwgsJOrGAuTsbF4Bvb8NHsHAABSFs9RXvfjaA13FDRx4vpWMCqjlB9bNVZLiLOcu0All
         F0l07SfcEcCxqLw2ywOR0qU33HxXVBN3dNh+VgCzaCj1aSkvY4QLOCia9vrdPQioCNRb
         hKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0fXbz31L/uAeja+1Vs+qmIjQ7kVlgqZf30R7/3Qhro=;
        b=TegLyPPvHrUSqMQ8ZDOFHzX9ga+p8nQXbt4aDnlvUbCDdmFLeEGOU+W2uRdDjDZYZZ
         xL6Lrz42VfEmUETcM/OWTyL8M+sqnnnNjg/+UBgna8EkwQtZbM79/UCGO/t7izvmpKi2
         CknF+uE9b+bmOQVeb2g1Pixa7K5XQF35CR0/i5eNec342p2l6lpJ4EPGzAgJh48QUcim
         gapLk4EtTruB+ARMS1KUt6vJ+eM2TcZ0mr0j7w85TO6GhTK4Y+81W++zd+yJONspYz2V
         NoBtaD7tGsLrx8nc3Ul7iUvF6aUcWTaGjxwzeu2CD66HwfpR6tujVOLSd/rqDgrIufqo
         SflA==
X-Gm-Message-State: AOAM532sJUF6z+7GumEog9NmiCX6S/dWEFW2uCzUsrqSM8viDIbtgvdd
        1tzZYfEA0Ge82fnzjt1IZv3Uv3qVCb8bMHVpD/KCiw==
X-Google-Smtp-Source: ABdhPJzXLOAaUKkp0mPoBggkdJ5k/qJi5+hzotn3vGBLn0FXL1EDaLvgWtCFp9/qwBhz0D5m742zRufwGo4+n297Mgw=
X-Received: by 2002:a05:651c:504:: with SMTP id o4mr12110769ljp.242.1639129113171;
 Fri, 10 Dec 2021 01:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com> <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org>
In-Reply-To: <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 10 Dec 2021 15:08:21 +0530
Message-ID: <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
To:     Jerome Forissier <jerome@forissier.org>
Cc:     "Wang, Xiaolei" <xiaolei.wang@windriver.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> wrote:
>
> +CC Jens, Etienne
>
> On 12/10/21 06:00, Sumit Garg wrote:
> > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
> >>
> >> -----Original Message-----
> >> From: Sumit Garg <sumit.garg@linaro.org>
> >> Sent: Thursday, December 9, 2021 7:41 PM
> >> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> >> Cc: jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org; linux-kernel@vger.kernel.org
> >> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
> >>
> >> [Please note: This e-mail is from an EXTERNAL e-mail address]
> >>
> >> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
> >>>
> >>> We observed the following kmemleak report:
> >>> unreferenced object 0xffff000007904500 (size 128):
> >>>   comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
> >>>   hex dump (first 32 bytes):
> >>>     00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
> >>>     60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
> >>>   backtrace:
> >>>     [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
> >>>     [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
> >>>     [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
> >>>     [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
> >>>     [<00000000c35884da>] optee_open_session+0x128/0x1ec
> >>>     [<000000001748f2ff>] tee_client_open_session+0x28/0x40
> >>>     [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
> >>>     [<000000003df18bf1>] optee_probe+0x674/0x6cc
> >>>     [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
> >>>     [<000000000c51ce7d>] really_probe+0xe4/0x4d0
> >>>     [<000000002f04c865>] driver_probe_device+0x58/0xc0
> >>>     [<00000000b485397d>] device_driver_attach+0xc0/0xd0
> >>>     [<00000000c835f0df>] __driver_attach+0x84/0x124
> >>>     [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
> >>>     [<000000001735e8a8>] driver_attach+0x24/0x30
> >>>     [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
> >>>
> >>> This is not a memory leak because we pass the share memory pointer to
> >>> secure world and would get it from secure world before releasing it.
> >>
> >>> How about if it's actually a memory leak caused by the secure world?
> >>> An example being secure world just allocates kernel memory via OPTEE_SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
> >>
> >>> IMO, we need to cross-check optee-os if it's responsible for leaking kernel memory.
> >>
> >> Hi sumit,
> >>
> >> You mean we need to check whether there is a real memleak,
> >> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC_ALLOC and until the end, there is no free
> >> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak, wo need to judge whether it is caused by secure os?
> >
> > Yes. AFAICT, optee-os should allocate shared memory to communicate
> > with tee-supplicant. So once the communication is done, the underlying
> > shared memory should be freed. I can't think of any scenario where
> > optee-os should keep hold-off shared memory indefinitely.
>
> I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> the config file [1] and the commit which introduced this config [2].

Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
RPC shared memory remains allocated. I guess that is done primarily
for performance reasons.

But still it doesn't feel appropriate that we term all RPC shm
allocations as not leaking memory as we might miss obvious ones.

Xiaolei,

Can you once test with CFG_PREALLOC_RPC_CACHE=n while compiling
optee-os and see if the observed memory leak disappears or not?

-Sumit

>
> [1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
> [2] https://github.com/OP-TEE/optee_os/commit/8887663248ad
>
> --
> Jerome
