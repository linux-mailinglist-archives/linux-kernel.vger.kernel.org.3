Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE675358DD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 07:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbiE0FqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 01:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiE0FqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 01:46:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F49B227C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 22:46:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z11so3685607pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 22:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mozilla.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TV4cLvLliZyUFWuu++qsb6ozSYsC3CFcOL302EzldKM=;
        b=b/6tsNoqVdssxcLzlUb+DhPQWYoJj5K0FoGn+lRDCOZ7Kv6EHPCj0R+lzYY5I/Jrsk
         /598PK6B3EIC+tchsAzP064ZXMSXQC20gTlD1WM4x73H5RsdiZiTRe3dyM0b7J/ir3IE
         VW3Kr0O92MKAlVfw+1/V7orDJoyxrKBY1OGY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TV4cLvLliZyUFWuu++qsb6ozSYsC3CFcOL302EzldKM=;
        b=zi8cqFHoUY2WWcgd469VBe0Hlur9wGbqLGqKq2qtxefyhFuA96tBYTuc/aJrOIVQzh
         y0J6RF94F0m57AChlZqh662DuMPMFREO2dkQwdA6O4ewuc5lAuyN6SSvWflPZGHb+ePQ
         j4/h/geICD1Dpr2zAatzS7oug2cw4VhUWX1uJiT99D3glQMMhfW1CqMOyPlJL0M4Ed5w
         3E8T2C/VcR1ZSn2cnTh33NffHG0Wzxyob8NU7p80oycfXtPWlT6I+N1JN8Q7gYYfE2j9
         QhlSh3cpOyapiyTpqqfQCK2Q4dCKFqkoLsR5Uf1Ms4eL4JyhavknVymc5AYvBVT3oAGK
         HNZA==
X-Gm-Message-State: AOAM532I4fJozhOn/hGdDPm5YkIPBUiOWxD1rP6o8cntQBm2TSyYDSfH
        vwbqb8qufQB0Anwwr5WvZsPiv/J5yQ7Mrw==
X-Google-Smtp-Source: ABdhPJwdv0IMGoWEjVjDQLoyyoCtfVCEFCxZmNTUV9aa5qlhdCT+tdSmA8AOyC9iNMlvkbwask4BLw==
X-Received: by 2002:a17:903:124b:b0:15e:84d0:ded6 with SMTP id u11-20020a170903124b00b0015e84d0ded6mr40797610plh.141.1653630361661;
        Thu, 26 May 2022 22:46:01 -0700 (PDT)
Received: from aluminium ([159.196.16.104])
        by smtp.gmail.com with ESMTPSA id bg3-20020a1709028e8300b001616723b8ddsm2615191plb.45.2022.05.26.22.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 22:46:00 -0700 (PDT)
Date:   Fri, 27 May 2022 15:45:56 +1000
From:   Paul Bone <pbone@mozilla.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Scheduling for heterogeneous computers
Message-ID: <20220527054556.GA2350963@aluminium>
References: <20220308092141.GF748856@aluminium>
 <20220321121611.ssa7o2npy3ahdofk@wubuntu>
 <CANdLaqA6aHr3K0apZLsXVbx1_zZvK6iMvX+HVcu7888HOeEjhg@mail.gmail.com>
 <20220525152956.5oz2chfwlgevvaul@wubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525152956.5oz2chfwlgevvaul@wubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 04:29:56PM +0100, Qais Yousef wrote:
> Hi Paul
> 
> On 05/24/22 15:23, Paul Bone wrote:
> > Hi Qais,
> > 
> > That's excellent.
> > 
> > I'll definitely check out those links.  This could be very interesting for
> > people using firefox on a phone/tablet, where we can run background tasks with
> > a lower UCLAMP_MAX
> 
> If you're running on Android, you might find that you won't have permission to
> use uclamp directly. Android restricts access and requires you to use higher
> level APIs sometimes.
> 
> And I'm not sure if they have API to allow you to do what you want. I've seen
> they have the concept of creating Foreground and Background jobs in one of
> their Google IO presentations. But not sure if this will be tied to uclamp_max.
> It might give you similar results still though regardless of the underlying
> mechanism.

We want to support both desktop and android.  I have been assuming there's
an API for android already, I vaguely remember hearing about it before.  We
might already be using it (at least for processes but not yet for individual
threads).

I was searching online now, but not for very long, and didn't find something
like this, so maybe Android doesn't expose it, or at least not in one of the
APIs they encourage you to use.

What I'd really like is an API where I can choose one of:

 * This task is user-interactive, as-quick-as-possible please.
 * This task is not user-interactive, but does have a deadline.
 * This task doesn't have a deadline.

Rather than choosing a suitable UCLAMP_MAX, I'll expriment with the numbers
but choosing "400" on one system might mean something different from "400"
on another system.  But I guess that's the problem, there are gray areas
between my discrete options above.  A deadline could be "finish doing GC
before we run out of memory" (which can have feedback from the GC about if
it's on target), or "Finish encoding this video before the client wants to
publish it", or "finish rendering this frame of a video game before the next
VBLANK".  Depending on how on-target any of these are we could decrese or
increase clock speed, because decreasing will always save power as long as
things get done by their deadline.

> If you're running on mainline kernel, then the biggest issue you might
> encounter is that sched_setattr() syscall is not part of any libc yet. So you
> need to create your own wrapper - look at uclampset for an example.

Okay thanks.

> Laptops can still benefit from this by the way. Hopefully everyone is moving to
> schedutil by default which is a pre-requisite to using uclamp. It can also help
> in SMP environments to avoid driving frequency high for tasks that don't really
> care about performance but otherwise busy.

Indeed, servers too.

> You can also use UCLAMP_MIN to boost bursty tasks that are not busy but require
> to get work done within a certain amount of time and DVFS delays can prevent
> them from running at adequate frequency. UCLAMP_MIN will ensure they always
> perceive a performance point specified by UCLAMP_MIN at a minimum when they
> wakeup.

That could be very useful for something on a UI deadline.

> RT tasks respect uclamp values too. You can opt-in to run at a different
> frequency than MAX frequency which leads to high power consumption on battery
> powered devices. RT tasks always run at constant frequency, so need to be
> controlled with UCLAMP_MIN only.
> 
> Happy hacking ;-)

Thank you.


