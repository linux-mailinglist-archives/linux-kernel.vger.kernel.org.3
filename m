Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A423B495974
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348406AbiAUF0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245352AbiAUF0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:26:40 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422E7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 21:26:39 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x16so4396224pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 21:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klkC+qf7JEHVmwgaoW0cLa/wjaKIwgJ9IF7PyZlZEkQ=;
        b=Ia7/kCIvw0vBFQRVcnDkGdKqayflWZMU7tpbc2n/OXgpZ8GpzjRcEgkHWcEuMfIeGS
         h7Y2WVDBhgBWPlQMAo9dGVXVz8K+BjaM7Tgmu4yKsHTzBFlYUygxN/kLcEiayb24+9P6
         Iaek5PhX0P9FZy223IvGsOKcZbZjmkepkHm57/0IZW83eG8gt4p9bHucCNjLqRc4bDfu
         c8hGUtEAtdzL0/HBIxglYnS8Z3NYyXGz1iq4AWjvlxX4FYlSt3DgOzgR/eSsY4NThVGX
         NnIuYYR8x35jGuDT9vRHpnGlxV8y3NXTIiQSIrrRBCaCa57nbTDi6sWr7KCeGzUwPcUN
         oafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klkC+qf7JEHVmwgaoW0cLa/wjaKIwgJ9IF7PyZlZEkQ=;
        b=fR3tvFSKW8L/aTGu/hONBwo+eYms4RpZBSw/FpVphGgBWE0/iaA3jdg0yMFjgXIjYR
         MydFNsTnhhTcOsit0pd8Rp8uPz4L7RpEOGOq9IkKV0Wo4l1nY4HiX6L8Aq+NWPb6+YMN
         IUWZzop6FN0ukv1h0BkbvzVeRXyjoxZK5qATgjtiw/xUyERtvs2Rb7qBWggh39ptQMzP
         lbYiUXo9gghpE//+zw+Ekt+w9QDV3EYKcWMLsp7zHH5KVveLqlwm3+mOOo9zf/1OGYbC
         ewf3o+8gBmrBTz+ELwMilLBjDRna71FNzbV1J0K8nbDIx1KZI+/PTNaiu7dWMhT2U/Zc
         8ujg==
X-Gm-Message-State: AOAM532n6W25A6NwbSW/qDe/k+yG2umEznkWg3oOxCvoFMpl1QuzBumb
        Fkz6DTcgLdJdMv9x9gI6d8WgALlQw0PgdSA46LiBLlnAOjs=
X-Google-Smtp-Source: ABdhPJzzL8ucK4zUZvzyGVjjl0PtNvp8V0GCX9i0P7dun3fUE1/9eGVyxYyvbfzrfcIv3QLxXXmBr4oiWp1wDH5+J14=
X-Received: by 2002:a05:6a00:70d:b0:4c0:1cbf:2394 with SMTP id
 13-20020a056a00070d00b004c01cbf2394mr2200010pfl.69.1642742798582; Thu, 20 Jan
 2022 21:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20220118235244.540103-1-yury.norov@gmail.com> <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
 <Yeg79CcofyNuVLid@casper.infradead.org> <e9226eb4-4ecf-ac01-e823-ff507a354ac5@arm.com>
 <YehilqRvYLhryUk4@shell.armlinux.org.uk> <319b09bc-56a2-207f-6180-3cc7d8cd43d1@arm.com>
 <Yeldih0PHotN4/bn@shell.armlinux.org.uk> <e6fde086-16b9-430f-5510-5296ef74a4e7@arm.com>
In-Reply-To: <e6fde086-16b9-430f-5510-5296ef74a4e7@arm.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 20 Jan 2022 21:26:18 -0800
Message-ID: <CAAH8bW8zPpWxSG6OXoudhBo3oYZJV7dFzO6CQRSixMPxk6VQnw@mail.gmail.com>
Subject: Re: [PATCH] vmap(): don't allow invalid pages
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:37 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-01-20 13:03, Russell King (Oracle) wrote:
> > On Thu, Jan 20, 2022 at 12:22:35PM +0000, Robin Murphy wrote:
> >> On 2022-01-19 19:12, Russell King (Oracle) wrote:
> >>> On Wed, Jan 19, 2022 at 06:43:10PM +0000, Robin Murphy wrote:
> >>>> Indeed, my impression is that the only legitimate way to get hold of a page
> >>>> pointer without assumed provenance is via pfn_to_page(), which is where
> >>>> pfn_valid() comes in. Thus pfn_valid(page_to_pfn()) really *should* be a
> >>>> tautology.
> >>>
> >>> That can only be true if pfn == page_to_pfn(pfn_to_page(pfn)) for all
> >>> values of pfn.
> >>>
> >>> Given how pfn_to_page() is defined in the sparsemem case:
> >>>
> >>> #define __pfn_to_page(pfn)                              \
> >>> ({  unsigned long __pfn = (pfn);                    \
> >>>     struct mem_section *__sec = __pfn_to_section(__pfn);    \
> >>>     __section_mem_map_addr(__sec) + __pfn;          \
> >>> })
> >>> #define page_to_pfn __page_to_pfn
> >>>
> >>> that isn't the case, especially when looking at page_to_pfn():
> >>>
> >>> #define __page_to_pfn(pg)                                       \
> >>> ({      const struct page *__pg = (pg);                         \
> >>>           int __sec = page_to_section(__pg);                      \
> >>>     (unsigned long)(__pg - __section_mem_map_addr(__nr_to_section(__sec))); \
> >>> })
> >>>
> >>> Where:
> >>>
> >>> static inline unsigned long page_to_section(const struct page *page)
> >>> {
> >>>     return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
> >>> }
> >>>
> >>> So if page_to_section() returns something that is, e.g. zero for an
> >>> invalid page in a non-zero section, you're not going to end up with
> >>> the right pfn from page_to_pfn().
> >>
> >> Right, I emphasised "should" in an attempt to imply "in the absence of
> >> serious bugs that have further-reaching consequences anyway".
> >>
> >>> As I've said now a couple of times, trying to determine of a struct
> >>> page pointer is valid is the wrong question to be asking.
> >>
> >> And doing so in one single place, on the justification of avoiding an
> >> incredibly niche symptom, is even more so. Not to mention that an address
> >> size fault is one of the best possible outcomes anyway, vs. the untold
> >> damage that may stem from accesses actually going through to random parts of
> >> the physical memory map.

It's not a single place. Many exported functions check arguments this
way or another.
__vunmap() in vfree() path, for example, checks for address alignment, which is
quite similar to me. And later even makes BUG_ON(!page).

> > I don't see it as a "niche" symptom.
>
> The commit message specifically cites a Data Abort "at address
> translation later". Broadly speaking, a Data Abort due to an address
> size fault only occurs if you've been lucky enough that the bogus PA
> which got mapped is so spectacularly wrong that it's beyond the range
> configured in TCR.IPS. How many other architectures even have a
> mechanism like that?
>
> > If we start off with the struct page being invalid, then the result of
> > page_to_pfn() can not be relied upon to produce something that is
> > meaningful - which is exactly why the vmap() issue arises.
> >
> > With a pfn_valid() check, we at least know that the PFN points at
> > memory.
>
> No, we know it points to some PA space which has a struct page to
> represent it. pfn_valid() only says that pfn_to_page() will yield a
> valid result. That also includes things like reserved pages covering
> non-RAM areas, where a kernel VA mapping existing at all could
> potentially be fatal to the system even if it's never explicitly
> accessed - for all we know it might be a carveout belonging to
> overly-aggressive Secure software such that even a speculative prefetch
> might trigger an instant system reset.
>
> > However, that memory could be _anything_ in the system - it
> > could be the kernel image, and it could give userspace access to
> > change kernel code.
> >
> > So, while it is useful to do a pfn_valid() check in vmap(), as I said
> > to willy, this must _not_ be the primary check. It should IMHO use
> > WARN_ON() to make it blatently obvious that it should be something we
> > expect _not_ to trigger under normal circumstances, but is there to
> > catch programming errors elsewhere.

It actually uses WARN_ON().

> Rather, "to partially catch unrelated programming errors elsewhere,
> provided the buggy code happens to call vmap() rather than any of the
> many other functions with a struct page * argument." That's where it
> stretches my definition of "useful" just a bit too far. It's not about
> perfect being the enemy of good, it's about why vmap() should be
> special, and death by a thousand "useful" cuts - if we don't trust the
> pointer, why not check its alignment for basic plausibility first?

Because in that particular case pfn_valid() is enough. If someone else
will have a real case where IS_ALIGNED() would help - I will be all for
adding that check in vmap().

>  If it
> seems valid, why not check if the page flags look sensible to make sure?
> How many useful little checks is too many?

I'd put in 'too many' group those that test for something that never happened
to people.

> Every bit of code footprint
> and execution overhead imposed unconditionally on all end users to
> theoretically save developers' debugging time still adds up.

Not theoretically - practically!

End users will value kernel stability even when buggy drivers are installed.
They will also value developers who fix bugs quickly. It has been noticed that
DEBUG_VIRTUAL could catch this bug. But sometimes stopping the production
hardware, building a custom kernel with many debug options in the hope that
one of them will help, and running a suspicious driver for hours would take
itself for more than a day.

Thanks,
Yury

> Although on
> that note, it looks like arch/arm's pfn_valid() is still a linear scan
> of the memblock array, so the overhead of adding that for every page in
> every vmap() might not even be so small...
>
> Robin.
