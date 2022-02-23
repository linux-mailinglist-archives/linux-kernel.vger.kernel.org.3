Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1219E4C1DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbiBWVWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242485AbiBWVVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:21:13 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89F94ECD0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:20:44 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id l42so172562vkd.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehiyGAnQkCy6/74Qhqw+fB9gBwX1r1I6DWeVnzE/kAc=;
        b=jXVzrQrxQTZJ8SEAB8dHg+0nEFplAWbQ+OCT9kTLrWig+hlvyzU4sTlRTAmJfueFFk
         J0f58LKClXd1aqlf9j3xrcwq2we/dKIIvb8SH+ja3KvnDMJyWus/wq5MADouqUyKhTus
         vFxMFepf4+/S2lrUKmiF23ugTzQU/Gihl/BWpZXC/x7Ngsaf3MYlQXyArXOk9GsOWO2b
         3pX+6M+1EDNI1TfrZxeapswN4+5HCdWdsC56+dP/hAf36gXos6PM53IUmqpAw6LWB5Yk
         myGy0aDP0ZqWclGd4L+i8w2LCamksx5o8kNsJnMQjshI0Gd+ZIGzp9/g39UAwXun5UBf
         td9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehiyGAnQkCy6/74Qhqw+fB9gBwX1r1I6DWeVnzE/kAc=;
        b=xE61U5vkGy/cvmvu0psc/obVp/atwIQ2fJDkod4gl2XgybpM06JjOEhMUbTxKFbW8L
         WAArtWS5Vt6APhguYwrhDyyxF1RFu/IoM42mlE4UsR4h1NDWNQvM6/ZjRW4p7Tooy2vu
         uyKw4wQPhe+/6KmGh8DJ5i5cP/a7r57dx1MwlegG6+Ed7rAZLV3o2Sk+YrICDgKh7f9g
         U45WFSD4H58Ok1PP1eqb8TUcpPlp/b79XvJy7OJ0UWL2KxRhQ+SpyPDnPQQ9xB1NcEC1
         WYJ8yglVMM8B3ZnhVUqFHlOhCaheiv2ZWfC/f1cgATHy4gxCVWUhodESJ5l6TIN+ehO0
         q2OA==
X-Gm-Message-State: AOAM531+himI6qlYwUppdGh5jG4qqV1OVBGKxOIxZQUP7dQ9f1YELOMV
        bmeu02vfP90PkuX6d13c/lT/69Kwjx6PZcWPdydvRA==
X-Google-Smtp-Source: ABdhPJycZBwQNTcE0ha+OSHu8lSiZ0cx0rPeoyTaaz0gE2xXBd0iR9Fx3cQwbQKM+yd7Al2QUCvsLv65lb2+hYpJMwU=
X-Received: by 2002:a05:6122:887:b0:332:699e:7e67 with SMTP id
 7-20020a056122088700b00332699e7e67mr717484vkf.35.1645651243803; Wed, 23 Feb
 2022 13:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com> <20220208081902.3550911-13-yuzhao@google.com>
 <Ygou6Gq79XY3mFK7@kernel.org> <Ygxt4iR9ZMYEbV78@google.com>
 <YhNVAUM7H7PF7j7j@kernel.org> <CAOUHufbZOuXtFvTULArtQjrdrzUkRw71byKQap1Cf=Mm3U7T5g@mail.gmail.com>
 <YhYTU3B7cdwV+YrW@kernel.org>
In-Reply-To: <YhYTU3B7cdwV+YrW@kernel.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 23 Feb 2022 14:20:32 -0700
Message-ID: <CAOUHufasp_to43QPi9y9rTtFKNBTjETzOiEQgm-3Hc6nzyziZA@mail.gmail.com>
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

On Wed, Feb 23, 2022 at 3:58 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Feb 21, 2022 at 06:47:25PM -0700, Yu Zhao wrote:
> > On Mon, Feb 21, 2022 at 2:02 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > On Tue, Feb 15, 2022 at 08:22:10PM -0700, Yu Zhao wrote:
> > > > > Please consider splitting "enable" and "features" attributes.
> > > >
> > > > How about s/Features/Components/?
> > >
> > > I meant to use two attributes:
> > >
> > > /sys/kernel/mm/lru_gen/enable for the main breaker, and
> > > /sys/kernel/mm/lru_gen/features (or components) for the branch breakers
> >
> > It's a bit superfluous for my taste. I generally consider multiple
> > items to fall into the same category if they can be expressed by a
> > type of array, and I usually pack an array into a single file.
> >
> > From your last review, I gauged this would be too overloaded for your
> > taste. So I'd be happy to make the change if you think two files look
> > more intuitive from user's perspective.
>
> I do think that two attributes are more user-friendly, but I don't feel
> strongly about it.
>
> > > > > As for the descriptions, what is the user-visible effect of these features?
> > > > > How different modes of clearing the access bit are reflected in, say, GUI
> > > > > responsiveness, database TPS, or probability of OOM?
> > > >
> > > > These remain to be seen :) I just added these switches in v7, per Mel's
> > > > request from the meeting we had. These were never tested in the field.
> > >
> > > I see :)
> > >
> > > It would be nice to have a description or/and examples of user-visible
> > > effects when there will be some insight on what these features do.
> >
> > How does the following sound?
> >
> > Clearing the accessed bit in large batches can theoretically cause
> > lock contention (mmap_lock), and if it happens the 0x0002 switch can
> > disable this feature. In this case the multigenerational LRU suffers a
> > minor performance degradation.
> > Clearing the accessed bit in non-leaf page table entries was only
> > verified on Intel and AMD, and if it causes problems on other x86
> > varieties the 0x0004 switch can disable this feature. In this case the
> > multigenerational LRU suffers a negligible performance degradation.
>
> LGTM
>
> > > > > > +:Debugfs interface: ``/sys/kernel/debug/lru_gen`` has the following
> > > > >
> > > > > Is debugfs interface relevant only for datacenters?
> > > >
> > > > For the moment, yes.
> > >
> > > And what will happen if somebody uses these interfaces outside
> > > datacenters? As soon as there is a sysfs intefrace, somebody will surely
> > > play with it.
> > >
> > > I think the job schedulers might be the most important user of that
> > > interface, but the documentation should not presume it is the only user.
> >
> > Other ideas are more like brainstorming than concrete use cases, e.g.,
> > for desktop users, these interface can in theory speed up hibernation
> > (suspend to disk); for VM users, they can again in theory support auto
> > ballooning. These niches are really minor and less explored compared
> > with the data center use cases which have been dominant.
> >
> > I was hoping we could focus on the essential and take one step at a
> > time. Later on, if there is additional demand and resource, then we
> > expand to cover more use cases.
>
> Apparently I was not clear :)
>
> I didn't mean that you should describe other use-cases, I rather suggested
> to make the documentation more neutral, e.g. using "a user writes to this
> file ..." instead of "job scheduler writes to a file ...". Or maybe add a
> sentence in the beginning of the "Data centers" section, for instance:
>
> Data centers
> ------------
>
> + A representative example of multigenerational LRU users are job
> schedulers.
>
> Data centers want to optimize job scheduling (bin packing) to improve
> memory utilizations. Job schedulers need to estimate whether a server

Yes, that makes sense. Will do. Thanks.
