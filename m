Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8630F4AA71D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 07:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359864AbiBEG2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 01:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiBEG22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 01:28:28 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BA9C061346
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 22:28:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s6so6941394plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 22:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVpC9PDwXUgsCngWduHMP99RJquh0omEvenOUF9ne5g=;
        b=UHdJdmZIRse0TM3cgsRWq1C7nDJqosae+csuKI6x2gFlRngvloyNu5dAdCwEWvpak6
         CEvDnqiZ6DBwJ3sOH3uVymgy9X8kLj3DQfGzYBAx254zPtGQ0xcBPwl/4yceMgJdTbXs
         1MKOPCwSxlYIP1YhUZR5j4XsaME19heBomRocv66DcqMFb6BgCTLp+hk81HLvgaFh5IV
         sQEAYgm9mkcJOHpfnBnZFHg6p37cOEErsg7d72Fb4dtVdZz4I/1Uzs/MAFINPfVcUogV
         KxRTezdNixf58VNjT8n7cRsVtF7Rv/qXxxA156J3sOUIq/yjw+uM5GFIl4AkekiG6wMf
         xplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVpC9PDwXUgsCngWduHMP99RJquh0omEvenOUF9ne5g=;
        b=KEZw3vT+AZyTC/s9StrjTiWu6sZnDSkL/gz2DncpX5aahiKevWcedCwPoIO0gH3eUq
         g8M8Q5qLAGlxmw5gcBBge/u92MmyV+13iv0Wg7cyE2ToItcARt7InkiTHM4JptdtCq0w
         aRrT4QaO3CR8UMjHZXlWOh90yOUSFttLKwmXmqimURZ2duSMXe5wz9g6O11b8su8tnd5
         TwEGxKZBqUYv1sik0/JLTICoMr96al0UPRCrFI3PBV8HHhigfXXsOOwELOjjQYLjYGZl
         Voxj8Djsjre2VSCqpvaZlYMxf12G0shIzErG1UJq9+c0wXWx621as6ifT/Gn14L7T7Ac
         EYug==
X-Gm-Message-State: AOAM530syYv73aO6w0dXFrNV4HffC1eJzmNtMASuncjmfcCaOmuZlMS2
        IKkAbbokAJhyZB5IhhwWB33zUo9ADQvm2AfIVryaY79EUJg=
X-Google-Smtp-Source: ABdhPJw9zXQos9Wk/wFw/F2UO3Nx7hXcH4PNXQ0BtdcQwJsUaVx5wMoyLGYwaFOTnDgicFBe8iKB/VLQbhKQPFsGFq0=
X-Received: by 2002:a17:90b:3ece:: with SMTP id rm14mr2884577pjb.220.1644042506168;
 Fri, 04 Feb 2022 22:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-39-ira.weiny@intel.com>
 <CAPcyv4iYOGD2XpmO3RH+wViuXx8EYrq-BK7vuKv6we+KR60YCg@mail.gmail.com>
 <20220205000953.GD785175@iweiny-DESK2.sc.intel.com> <CAPcyv4jmnUbywDcXOAL9DwKxGaUf9cw9iDYbDcz6_CHyYPtytw@mail.gmail.com>
 <CAPcyv4iLVh_BesJLcZb=Pktd-h5x6-xuos5Cj4TzuWYC=Q-vLg@mail.gmail.com>
 <CAPcyv4gUSDwvOysAMM59yVsERtYpA_kY6s4=xunkjc2eJ8Mi1w@mail.gmail.com> <20220205055559.GF785175@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20220205055559.GF785175@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 22:28:15 -0800
Message-ID: <CAPcyv4i3aVnmbVGuunT421dP5LK3mwQofBWngOe-t+ax82KYcg@mail.gmail.com>
Subject: Re: [PATCH V8 38/44] memremap_pages: Define pgmap_mk_{readwrite|noaccess}()
 calls
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 9:56 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Feb 04, 2022 at 04:27:38PM -0800, Dan Williams wrote:
> > On Fri, Feb 4, 2022 at 4:25 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Fri, Feb 4, 2022 at 4:19 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > On Fri, Feb 4, 2022 at 4:10 PM Ira Weiny <ira.weiny@intel.com> wrote:
> > > > >
> > > > > On Fri, Feb 04, 2022 at 10:35:59AM -0800, Dan Williams wrote:
> > > > > > On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> > > > > > >
> > > > >
> > > > > [snip]
> > > > >
> > > > > I'll address the other comments later but wanted to address the idea below.
> > > > >
> > > > > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > > > > index f5b2be39a78c..5020ed7e67b7 100644
> > > > > > > --- a/include/linux/sched.h
> > > > > > > +++ b/include/linux/sched.h
> > > > > > > @@ -1492,6 +1492,13 @@ struct task_struct {
> > > > > > >         struct callback_head            l1d_flush_kill;
> > > > > > >  #endif
> > > > > > >
> > > > > > > +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> > > > > > > +       /*
> > > > > > > +        * NOTE: pgmap_prot_count is modified within a single thread of
> > > > > > > +        * execution.  So it does not need to be atomic_t.
> > > > > > > +        */
> > > > > > > +       u32                             pgmap_prot_count;
> > > > > > > +#endif
> > > > > >
> > > > > > It's not at all clear why the task struct needs to be burdened with
> > > > > > this accounting. Given that a devmap instance is needed to manage page
> > > > > > protections, why not move the nested protection tracking to a percpu
> > > > > > variable relative to an @pgmap arg? Something like:
> > > > > >
> > > > > > void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
> > > > > > {
> > > > > >        migrate_disable();
> > > > > >        preempt_disable();
> > > > >
> > > > > Why burden threads like this?  kmap_local_page() is perfectly able to migrate
> > > > > or be preempted?
> > > > >
> > > > > I think this is way to restrictive.
> > > >
> > > > kmap_local_page() holds migrate_disable() over the entire mapping, so
> > > > we're only talking about preempt_disable(). I tend to think that
> > > > bloating task_struct for something that is rarely used "kmap on dax
> > > > pmem pages" is not the right tradeoff.
> > >
> > > Now, I can see an argument that promoting kmap_local_page() to
> > > preempt_disable() could cause problems, but I'd like help confirming
> > > that before committing to extending task_struct.
> >
> > ...as I say that it occurs to me that the whole point of
> > kmap_local_page() is to be better than kmap_atomic() and this undoes
> > that. I'd at least like that documented as the reason that task_struct
> > needs to carry a new field.
>
> I'll try and update the commit message but kmap_local_page() only disables
> migrate on a highmem system.

Right, but that still means that the code in question is prepared for
migrate_disable(). Instead I would justify the task_struct expansion
on the observation that moving the enable tracker to percpu would
require pre-empt disable and promote kmap_local_page() to
kmap_atomic() level of restriction. Otherwise if there was a way to
avoid task_struct expansion with only migrate_disable() and not
preempt_disable I think it would be worth it, but nothing comes to
mind at the moment.

> The devmap/PKS use case is specifically not
> supported on highmem systems.  Mainly because on highmem systems
> kmap_local_page() actually creates a new mapping which is not covered by PKS
> anyway.
>
> So for the devmap/PKS use case kmap_local_page() is defined as:
>
>  static inline void *kmap_local_page(struct page *page)
>  {
> +       pgmap_mk_readwrite(page);
>         return page_address(page);
>  }
>
> ...for the linear mapping.  I'll try and update the commit message with this
> detail.

Yeah, add the kmap_atomic() observation, not the !highmem note.
