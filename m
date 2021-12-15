Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50CF47561E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbhLOKUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241594AbhLOKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:19:59 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05752C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:19:59 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i12so16218714wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ktoEeE7WMeOlsYWyT3cXq3Vx1tDnLZCpaB9rbw82iY0=;
        b=gMQsy6tLUT0AbJks62K5KfXKoExcgdx4Gmg2A/06V4eLrnKcUjRPWs0zB9EDLkhnrb
         W1ajK98Uv4BVFUy47JwoyGWk0vd8LsEYB2XUFEjok5z9mR2rlZL53ByRNtZarXK1lw5n
         Rck+TSP7BZ1rIZNC4ENzCUruHGfvX81E8SYT/9UuE41ryk5W7UXMbN0vhKc/Er/+9NYm
         dqhebMeGBznmtGODOFWdcNirgRP3BHWdTXQWNsq7aR1p/Buxonl7nYaYTpnq0yuvKmZ0
         nzEQDmxFwCfAlp7g0/LeKvcQ8tIohVtKbLQ68LfvJxrBv1sdZSK3poNfD52HiwKNX+oR
         rX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ktoEeE7WMeOlsYWyT3cXq3Vx1tDnLZCpaB9rbw82iY0=;
        b=XWwqbwp5fIIrP/Lk09t3miwEZ3JzBMl0HLaSe8iewDfgCiQ/p6XeGAX8oCVfKCkoTI
         rrpgnVc1LXQdap47PlV+6Plshxogt31pyjvmwN3LyZ+OdyjHkEM1wNNExXJJ+uISPczt
         /U48WBGDHWsZxlSbxaFkH1tLv+UnuZqUYtV9a01f4I7eKwSr5tyXHn8DbwgIN+BqGwZr
         kRQUDcDHYMh/ZLg9AG/N1AhhHQtiINN3y7/mthKhcupL81LGi4oyOiwrc9XxOT1J8eDb
         s7gEZNKB5LPX7xFGWdgtOSjEdXyELACR0/pPLAE34oBmGYK29USRACa4KrF35OTlxwii
         F/Wg==
X-Gm-Message-State: AOAM5320Xl6+Y4F1mTDk6uWmwIzQV2fX1F0xI1oAQIX4wI8qoPO9fzA1
        8twYvcRnVELfPWx/cSZSnnuOyjoaPB1W0Aog
X-Google-Smtp-Source: ABdhPJwSUwN6GeHOPJmewGizuB+uiKqdaUyPDoaq5+zgTVRmxBeu7ZTyTtnqNHIGgQubkf9eyz687g==
X-Received: by 2002:a05:600c:3ac8:: with SMTP id d8mr399487wms.72.1639563597529;
        Wed, 15 Dec 2021 02:19:57 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z11sm1356836wmf.9.2021.12.15.02.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 02:19:56 -0800 (PST)
Date:   Wed, 15 Dec 2021 10:19:54 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        "Wang, Xiaolei" <xiaolei.wang@windriver.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Message-ID: <20211215101954.oggnubww6ywz6fu7@maple.lan>
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org>
 <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
 <20211210154915.hjbgrnvtitmwluhz@maple.lan>
 <CAFA6WYPd+SLT+XZgLPVjLph27P1D5RpYuLwNu4KC+2nOQH07_Q@mail.gmail.com>
 <20211213130400.npccyt36r5sysca3@maple.lan>
 <CAFA6WYPEjQDyt4g-dftMyzd8RKkagDs3hj5ThQfvdpmmV5dF7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPEjQDyt4g-dftMyzd8RKkagDs3hj5ThQfvdpmmV5dF7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 12:33:08PM +0530, Sumit Garg wrote:
> On Mon, 13 Dec 2021 at 18:34, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > On Mon, Dec 13, 2021 at 02:28:01PM +0530, Sumit Garg wrote:
> > > On Fri, 10 Dec 2021 at 21:19, Daniel Thompson
> > > <daniel.thompson@linaro.org> wrote:
> > > > On Fri, Dec 10, 2021 at 03:08:21PM +0530, Sumit Garg wrote:
> > > > > On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> wrote:
> > > > > > On 12/10/21 06:00, Sumit Garg wrote:
> > > > > > > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
> > > > IIUC this patch adds kmemleak_not_leak() at (pretty much) the last
> > > > possible point before *ownership* of the SHM block is passed from kernel
> > > > to OP-TEE.
> > >
> > > I wouldn't say it's a transfer of ownership from kernel to OP-TEE but
> > > rather a way for OP-TEE to access kernel's memory in order to pass
> > > info or execute further RPC commands.
> >
> > The RPC handler allocates a pointer (e.g. now the RPC handler owns the
> > allocated memory). The RPC handler then passes that pointer to OP-TEE and
> > forgets what it's value was.
> >
> > That is a transfer of ownership: the RPC handler does not hold any pointer
> > to the memory and is incapable of freeing it. Moreover this situation is
> > what kmemleak_no_leak() is for! Its job it to inform kmemleak that the
> > pointer is owned/stored somewhere that is does not scan.
> 
> Let me put this another way. If the memory allocator belongs to the
> kernel then how does OP-TEE get to know which memory is currently
> allocated and it is to be scanned?

OP-TEE explicitly requested that the be allocated and responsible for
figuring out where to store the pointer. How could it *not* know this
information? More specifically OP-TEE is perfectly capable of recording
what memory it has allocated and where to scan to find out if it has
been lost.


> I think the complete solution would be to extend kmemleak to support
> OP-TEE memory scanning via OP-TEE invocation to check if it's holding
> any kernel memory references.

This is the part I get stuck on... and the reason I'm still posting on
the thread.

I struggle to see any value in using kmemleak to identify this type of
leak. That is the fundamental issue. False positives from kmemleak are
damaging to user confidence in the tool and are especially harmful when
it is complex and time consuming to verify that is actually is a false
positive (which would certainly be the case for OP-TEE false positives).
In short it is *not* always the case failure-to-detect is worse than
false-positive.

As discussed already the firmware/kernel contract prevents kmemleak from
working as it is designed to and I am unconvinced that relying on
fragile timeouts is sufficient.

Extending kmemleak to support OP-TEE memory scanning is also, IMHO,
pointless. The reason for this is that OP-TEE cannot perform any scan on
behalf of kmemleak without first validating the information provided to
it by the kernel (to avoid information leaks). However if OP-TEE tracks
enough state to validate the kernel input than it already has enough
state to do a scan for leaks independently anyway (apart from being
donated an execution context). Therefore it follows that any OP-TEE
extension to handle leaks should be independent of kmemleak because it
would still be useful to be able to ask OP-TEE to run a self-consistency
check even if kmemleak is disabled.

Or, in short, even if you implement improved leak detection for OP-TEE
(whether that is based on timers or scanning) then kmemleak_not_leak()
is still the right thing to do with pointers whose ownership we have
transferred to OP-TEE.


> > > > Sure, after we change ownership it could still be leaked... but it can
> > > > no longer be leaked by the kernel because the kernel no longer owns it!
> > > > More importantly, it makes no sense to run the kernel memory detector on the
> > > > buffer because it simply can't work.
> > > >
> > > > After the RPC completes, doesn't it become impossible for kmemleak to
> > > > scan to see if the pointer is lost[1]?
> > >
> > > Apart from the special OP-TEE prealloc SHM cache stuff, I can't think
> > > of any scenario where an OP-TEE thread should hold off kernel's memory
> > > pointers for more than 5 seconds before being passed onto kernel for
> > > further RPC commands or RPC free action. So the kmemleak should be
> > > able to detect if a pointer is lost.
> >
> > Or putting this a different way: there is known to be firmware in the
> > field that allocates pointers for more then five seconds!
> 
> If it's known that upstream OP-TEE doesn't hold any kernel memory
> references for more than 5 seconds then IMO we should be fine to not
> disable kmemleak until we have a future kmemleak extension. Otherwise
> it would be very hard to keep track of kernel memory lost in this way.

In essence I am arguing for using the right tool for the right job (and
against turning down a correct patch because the right tool isn't yet
implemented). A memory scanning leak detector is the wrong tool to
search for leaks in memory that cannot be scanned.

For me having to rely on fragile implied contracts and undocumented
assumptions about timing further reinforces my view that kmemleak is not
the wrong tool. Especially so when we know that those assumptions are
not met by existing firmware.


Daniel.
