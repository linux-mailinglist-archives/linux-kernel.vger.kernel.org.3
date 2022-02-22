Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C104BEF02
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbiBVBsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:48:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiBVBsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:48:03 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B009824BEA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:47:37 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id e5so19444403vsg.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H78t/Tkekmq9O5Lj2Ksbs71PIv/v6BIhtnLX5Mxv/tc=;
        b=QfMTvyiwE3XGQ1znQQVazyaY8j7LOpDoxLgXasjsywlb12Uci3qRU1ZjDbs/DQksHh
         S9CjewhdqGO4rBR3DYFpHJcESh4eo60117lCdcr36OiDBNjU6VAgpoLLew5RWRXHW9GB
         m1xsEPuqNMhFg/usmYK3pEEmFu9C3uVvmOjv1vuoX+SQZ1x6SKN5SBuMLyNivWDp3jrS
         ZgylfMVMs2xuobHRidTGV30OXRrlh7FaEFFhHEru2MHPtldU4IyTMjUOT8xR9l/KEoS3
         wUQpOR2AdJSZOVPBgowDlFMTQp0NlTPFJVNAR3nGjoMQTRPjOnvnq8zyBULD6N4nvUNd
         jdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H78t/Tkekmq9O5Lj2Ksbs71PIv/v6BIhtnLX5Mxv/tc=;
        b=KkRCY6txfF10bDoUnazH+FPGpAO5HvMW3nlg0+i/kRKdns9VaFbsz3cVKbXNRXJVNZ
         2yywHmpIf6V9A9kJYAn1Xwhm0oYLpc+bTPJbi4OGbi8IO5WIYcm2N0dDHWPsIPr85p2H
         P0nVf8zJMMPEvQ94YVk0btgYMlmOgDQLCBMNhBnrf91cGUTyU6qvRtMMwA31NPtjzL/g
         dePQ507oVJcu6wZ25CZedV3OqHDdYwfAABKiqjSM3jWGQipujvoXbidRgWTnDWp07c2r
         oKL1dyHVxKhy7nI5hBR96/CWltNnIHfmwxPdbcB0r1VTGY6Q2xWjyxYOi/9w1nKJQmYL
         zXmQ==
X-Gm-Message-State: AOAM532bPa4uXGaBHzTa89GzkbDbLop0UYmviiwLl2O3syaMxz7FiPai
        pF5ppqatrGNWV24dT5nnc4clcGaOVZgy7RGGrZhgcQ==
X-Google-Smtp-Source: ABdhPJxIeyI3mYLfbDebz5kcexdOouEp1H1k6oTsKi5Lq57wRN56u1mCxv31zG/zmUgj5o8K0uV3wWd30Qc6oH/iWc4=
X-Received: by 2002:a67:edce:0:b0:31c:405:cb78 with SMTP id
 e14-20020a67edce000000b0031c0405cb78mr6901843vsp.6.1645494456603; Mon, 21 Feb
 2022 17:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com> <20220208081902.3550911-13-yuzhao@google.com>
 <Ygou6Gq79XY3mFK7@kernel.org> <Ygxt4iR9ZMYEbV78@google.com> <YhNVAUM7H7PF7j7j@kernel.org>
In-Reply-To: <YhNVAUM7H7PF7j7j@kernel.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 21 Feb 2022 18:47:25 -0700
Message-ID: <CAOUHufbZOuXtFvTULArtQjrdrzUkRw71byKQap1Cf=Mm3U7T5g@mail.gmail.com>
Subject: Re: [PATCH v7 12/12] mm: multigenerational LRU: documentation
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
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

On Mon, Feb 21, 2022 at 2:02 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Tue, Feb 15, 2022 at 08:22:10PM -0700, Yu Zhao wrote:
> > On Mon, Feb 14, 2022 at 12:28:56PM +0200, Mike Rapoport wrote:
> >
> > > > +====== ========
> > > > +Values Features
> > > > +====== ========
> > > > +0x0001 the multigenerational LRU
> > >
> > > The multigenerational LRU what?
> >
> > Itself? This depends on the POV, and I'm trying to determine what would
> > be the natural way to present it.
> >
> > MGLRU itself could be seen as an add-on atop the existing page reclaim
> > or an alternative in parallel. The latter would be similar to sl[aou]b,
> > and that's how I personally see it.
> >
> > But here I presented it more like the former because I feel this way is
> > more natural to users because they are like switches on a single panel.
>
> Than I think it should be described as "enable multigenerational LRU" or
> something like this.

Will do.

> > > What will happen if I write 0x2 to this file?
> >
> > Just like turning on a branch breaker while leaving the main breaker
> > off in a circuit breaker box. This is how I see it, and I'm totally
> > fine with changing it to whatever you'd recommend.
>
> That was my guess that when bit 0 is clear the rest do not matter :)
> What's important, IMO, is that it is stated explicitly in the description.

Will do.

> > > Please consider splitting "enable" and "features" attributes.
> >
> > How about s/Features/Components/?
>
> I meant to use two attributes:
>
> /sys/kernel/mm/lru_gen/enable for the main breaker, and
> /sys/kernel/mm/lru_gen/features (or components) for the branch breakers

It's a bit superfluous for my taste. I generally consider multiple
items to fall into the same category if they can be expressed by a
type of array, and I usually pack an array into a single file.

From your last review, I gauged this would be too overloaded for your
taste. So I'd be happy to make the change if you think two files look
more intuitive from user's perspective.

> > > > +0x0002 clear the accessed bit in leaf page table entries **in large
> > > > +       batches**, when MMU sets it (e.g., on x86)
> > >
> > > Is extra markup really needed here...
> > >
> > > > +0x0004 clear the accessed bit in non-leaf page table entries **as
> > > > +       well**, when MMU sets it (e.g., on x86)
> > >
> > > ... and here?
> >
> > Will do.
> >
> > > As for the descriptions, what is the user-visible effect of these features?
> > > How different modes of clearing the access bit are reflected in, say, GUI
> > > responsiveness, database TPS, or probability of OOM?
> >
> > These remain to be seen :) I just added these switches in v7, per Mel's
> > request from the meeting we had. These were never tested in the field.
>
> I see :)
>
> It would be nice to have a description or/and examples of user-visible
> effects when there will be some insight on what these features do.

How does the following sound?

Clearing the accessed bit in large batches can theoretically cause
lock contention (mmap_lock), and if it happens the 0x0002 switch can
disable this feature. In this case the multigenerational LRU suffers a
minor performance degradation.
Clearing the accessed bit in non-leaf page table entries was only
verified on Intel and AMD, and if it causes problems on other x86
varieties the 0x0004 switch can disable this feature. In this case the
multigenerational LRU suffers a negligible performance degradation.

> > > > +:Debugfs interface: ``/sys/kernel/debug/lru_gen`` has the following
> > >
> > > Is debugfs interface relevant only for datacenters?
> >
> > For the moment, yes.
>
> And what will happen if somebody uses these interfaces outside
> datacenters? As soon as there is a sysfs intefrace, somebody will surely
> play with it.
>
> I think the job schedulers might be the most important user of that
> interface, but the documentation should not presume it is the only user.

Other ideas are more like brainstorming than concrete use cases, e.g.,
for desktop users, these interface can in theory speed up hibernation
(suspend to disk); for VM users, they can again in theory support auto
ballooning. These niches are really minor and less explored compared
with the data center use cases which have been dominant.

I was hoping we could focus on the essential and take one step at a
time. Later on, if there is additional demand and resource, then we
expand to cover more use cases.

> > > > + job scheduler writes to this file at a certain time interval to
> > > > + create new generations, and it ranks available servers based on the
> > > > + sizes of their cold memory defined by this time interval. For
> > > > + proactive reclaim, a job scheduler writes to this file before it
> > > > + tries to land a new job, and if it fails to materialize the cold
> > > > + memory without impacting the existing jobs, it retries on the next
> > > > + server according to the ranking result.
> > >
> > > Is this knob only relevant for a job scheduler? Or it can be used in other
> > > use-cases as well?
> >
> > There are other concrete use cases but I'm not ready to discuss them
> > yet.
>
> Here as well, as soon as there is an interface it's not necessarily "job
> scheduler" that will "write to this file", anybody can write to that file.
> Please adjust the documentation to be more neutral regarding the use-cases.

Will do.
