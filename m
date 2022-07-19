Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF09F579576
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiGSIpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiGSIom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:44:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DB927FEA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:44:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id z23so25833241eju.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0eQDIZ99Zh/ZCFjyzZmywVkXeJrTVuniI0ypWpI6Sk=;
        b=QcWkfJafjUbFVe6JZpnVCbgU9KnEN/LzRR2uyalAYuJKGXZL0ScKrB5fCfoVzxkF1G
         PrgwT6GgudFYElq+R4IkJHpXzxQ0MmJxLg2OfsOBeuKZ0LpH/mohaAcrKUTPC721pXg1
         BRuNY+6uqD6+gCF6QcOfCtBuDKSw3fsBfkgxBrLf7R7Dgxtpq4J8DBrocdAMFDLyHwLs
         s8IzS+vx8c9uV62yP9AxBrXlI5BeOhbWaBbYCgLoObGFa4tVK48sWU+edI62Ujmqan9a
         LBkRjCEe8pPzJTBPk/ZgShnGhvy8a3tNCJ93NbZizoE+yY1xdQlyFfb5URjEuUPuI2tt
         n/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0eQDIZ99Zh/ZCFjyzZmywVkXeJrTVuniI0ypWpI6Sk=;
        b=SI89vTRV3DwTrTl4YN5OuPq3OSbvv2mEynFfDIjD4cUzi8XQ8kxk5QXv+QvNjcJnAI
         H50aA5KVZWKkCEYbBBcPXNZiNSyCFtwZkle8VYD4OznIoVqiqFxm82fM6JHJ+yEE7jG7
         +lM4JXIyhgERuagF8FCXvpD7ek6UkN0m++mdtJQbY+1ngrxzOcyCzhhEPJeGWunJMIdK
         JFMyZ4BGSkQFDhLrOSfUtfxiTukAAhhI0vIHY1MsXGnuLZP19MwamgvBmnL5J+S7o4Od
         TP4JHns4FH3heaTURHMY8ZjcbMvq3pS3bUwGkcw6q6I2BhfsZjlTSquEfASf1cj7QN+u
         f+Mw==
X-Gm-Message-State: AJIora8IuUhzjw3PQWZ1k7jz1dH1KaEFXfH2WWbgfRA9vXAk0lYgSVVw
        J4TFGJpDCndUYab2Ji5A0ynTLmqfaH/Dn5JeoWk=
X-Google-Smtp-Source: AGRyM1sTbWk5RtpmOeEDojLEWksP8IBD2/4GrX507pDt1nkqUVls9yFv2t4GCKwbIK6jA4vpgQJCw+0v/HHVyluQTKU=
X-Received: by 2002:a17:907:3f07:b0:72b:54b2:f57f with SMTP id
 hq7-20020a1709073f0700b0072b54b2f57fmr28877814ejc.502.1658220279737; Tue, 19
 Jul 2022 01:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220718090050.2261-1-21cnbao@gmail.com> <87mtd62apo.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4zsNNb0mbR7Sm-=Hd7+fW4rXbnivCY1cF-wyio2EeETvA@mail.gmail.com>
 <f2d6ef91-f447-ffb4-2a6e-bc95533e5167@arm.com> <87zgh5232o.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <416a06f6-ca7d-d4a9-2cda-af0ad6e28261@arm.com> <CAGsJ_4y7GyL5qtrBbhz_8bLuAGGHy7Ju0ucPjHp-ZeDHjQcTcw@mail.gmail.com>
 <CAGsJ_4z3wXK8WqubkFdPT6ObBVtvzAjbS1=r9PDCCDvwDVf3rw@mail.gmail.com>
 <87o7xl1wpb.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xECbs2Dxn8u4tCotNBZz5epFvAWANLiNg0dSzDcgORCA@mail.gmail.com>
 <87k0891uj6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4zBumnOR7eiPD=b+0dQCZctK+P=c=Mvb-24TXrzgM_Mug@mail.gmail.com>
 <875yjt1sde.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <875yjt1sde.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 19 Jul 2022 20:44:28 +1200
Message-ID: <CAGsJ_4wuaOQ7yyXUHGUa7JgjDHM8_ka3fzw2x8ttQNCpzbEpCw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] arm64: enable THP_SWAP for arm64
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?B?6YOt5YGl?= <guojian@oppo.com>,
        hanchuanhua <hanchuanhua@oppo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Barry Song <v-songbaohua@oppo.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>
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

On Tue, Jul 19, 2022 at 7:20 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Tue, Jul 19, 2022 at 6:33 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Tue, Jul 19, 2022 at 5:47 PM Huang, Ying <ying.huang@intel.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Tue, Jul 19, 2022 at 3:59 PM Barry Song <21cnbao@gmail.com> wrote:
> >> >> >>
> >> >> >> On Tue, Jul 19, 2022 at 3:35 PM Anshuman Khandual
> >> >> >> <anshuman.khandual@arm.com> wrote:
> >> >> >> >
> >> >> >> >
> >> >> >> >
> >> >> >> > On 7/19/22 08:58, Huang, Ying wrote:
> >> >> >> > > Anshuman Khandual <anshuman.khandual@arm.com> writes:
> >> >> >> > >
> >> >> >> > >> On 7/19/22 06:53, Barry Song wrote:
> >> >> >> > >>> On Tue, Jul 19, 2022 at 12:44 PM Huang, Ying <ying.huang@intel.com> wrote:
> >> >> >> > >>>>
> >> >> >> > >>>> Barry Song <21cnbao@gmail.com> writes:
> >> >> >> > >>>>
> >> >> >> > >>>>> From: Barry Song <v-songbaohua@oppo.com>
> >> >> >> > >>>>>
> >> >> >> > >>>>> THP_SWAP has been proven to improve the swap throughput significantly
> >> >> >> > >>>>> on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
> >> >> >> > >>>>> splitting THP after swapped out").
> >> >> >> > >>>>> As long as arm64 uses 4K page size, it is quite similar with x86_64
> >> >> >> > >>>>> by having 2MB PMD THP. THP_SWAP is architecture-independent, thus,
> >> >> >> > >>>>> enabling it on arm64 will benefit arm64 as well.
> >> >> >> > >>>>> A corner case is that MTE has an assumption that only base pages
> >> >> >> > >>>>> can be swapped. We won't enable THP_SWAP for ARM64 hardware with
> >> >> >> > >>>>> MTE support until MTE is reworked to coexist with THP_SWAP.
> >> >> >> > >>>>>
> >> >> >> > >>>>> A micro-benchmark is written to measure thp swapout throughput as
> >> >> >> > >>>>> below,
> >> >> >> > >>>>>
> >> >> >> > >>>>>  unsigned long long tv_to_ms(struct timeval tv)
> >> >> >> > >>>>>  {
> >> >> >> > >>>>>       return tv.tv_sec * 1000 + tv.tv_usec / 1000;
> >> >> >> > >>>>>  }
> >> >> >> > >>>>>
> >> >> >> > >>>>>  main()
> >> >> >> > >>>>>  {
> >> >> >> > >>>>>       struct timeval tv_b, tv_e;;
> >> >> >> > >>>>>  #define SIZE 400*1024*1024
> >> >> >> > >>>>>       volatile void *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
> >> >> >> > >>>>>                               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> >> >> >> > >>>>>       if (!p) {
> >> >> >> > >>>>>               perror("fail to get memory");
> >> >> >> > >>>>>               exit(-1);
> >> >> >> > >>>>>       }
> >> >> >> > >>>>>
> >> >> >> > >>>>>       madvise(p, SIZE, MADV_HUGEPAGE);
> >> >> >> > >>>>>       memset(p, 0x11, SIZE); /* write to get mem */
> >> >> >> > >>>>>
> >> >> >> > >>>>>       gettimeofday(&tv_b, NULL);
> >> >> >> > >>>>>       madvise(p, SIZE, MADV_PAGEOUT);
> >> >> >> > >>>>>       gettimeofday(&tv_e, NULL);
> >> >> >> > >>>>>
> >> >> >> > >>>>>       printf("swp out bandwidth: %ld bytes/ms\n",
> >> >> >> > >>>>>                       SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
> >> >> >> > >>>>>  }
> >> >> >> > >>>>>
> >> >> >> > >>>>> Testing is done on rk3568 64bit quad core processor Quad Core
> >> >> >> > >>>>> Cortex-A55 platform - ROCK 3A.
> >> >> >> > >>>>> thp swp throughput w/o patch: 2734bytes/ms (mean of 10 tests)
> >> >> >> > >>>>> thp swp throughput w/  patch: 3331bytes/ms (mean of 10 tests)
> >> >> >> > >>>>>
> >> >> >> > >>>>> Cc: "Huang, Ying" <ying.huang@intel.com>
> >> >> >> > >>>>> Cc: Minchan Kim <minchan@kernel.org>
> >> >> >> > >>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >> >> >> > >>>>> Cc: Hugh Dickins <hughd@google.com>
> >> >> >> > >>>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
> >> >> >> > >>>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> >> >> >> > >>>>> Cc: Steven Price <steven.price@arm.com>
> >> >> >> > >>>>> Cc: Yang Shi <shy828301@gmail.com>
> >> >> >> > >>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> >> >> > >>>>> ---
> >> >> >> > >>>>>  -v3:
> >> >> >> > >>>>>  * refine the commit log;
> >> >> >> > >>>>>  * add a benchmark result;
> >> >> >> > >>>>>  * refine the macro of arch_thp_swp_supported
> >> >> >> > >>>>>  Thanks to the comments of Anshuman, Andrew, Steven
> >> >> >> > >>>>>
> >> >> >> > >>>>>  arch/arm64/Kconfig               |  1 +
> >> >> >> > >>>>>  arch/arm64/include/asm/pgtable.h |  6 ++++++
> >> >> >> > >>>>>  include/linux/huge_mm.h          | 12 ++++++++++++
> >> >> >> > >>>>>  mm/swap_slots.c                  |  2 +-
> >> >> >> > >>>>>  4 files changed, 20 insertions(+), 1 deletion(-)
> >> >> >> > >>>>>
> >> >> >> > >>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> >> >> > >>>>> index 1652a9800ebe..e1c540e80eec 100644
> >> >> >> > >>>>> --- a/arch/arm64/Kconfig
> >> >> >> > >>>>> +++ b/arch/arm64/Kconfig
> >> >> >> > >>>>> @@ -101,6 +101,7 @@ config ARM64
> >> >> >> > >>>>>       select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> >> >> >> > >>>>>       select ARCH_WANT_LD_ORPHAN_WARN
> >> >> >> > >>>>>       select ARCH_WANTS_NO_INSTR
> >> >> >> > >>>>> +     select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
> >> >> >> > >>>>>       select ARCH_HAS_UBSAN_SANITIZE_ALL
> >> >> >> > >>>>>       select ARM_AMBA
> >> >> >> > >>>>>       select ARM_ARCH_TIMER
> >> >> >> > >>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >> >> >> > >>>>> index 0b6632f18364..78d6f6014bfb 100644
> >> >> >> > >>>>> --- a/arch/arm64/include/asm/pgtable.h
> >> >> >> > >>>>> +++ b/arch/arm64/include/asm/pgtable.h
> >> >> >> > >>>>> @@ -45,6 +45,12 @@
> >> >> >> > >>>>>       __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
> >> >> >> > >>>>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >> >> >> > >>>>>
> >> >> >> > >>>>> +static inline bool arch_thp_swp_supported(void)
> >> >> >> > >>>>> +{
> >> >> >> > >>>>> +     return !system_supports_mte();
> >> >> >> > >>>>> +}
> >> >> >> > >>>>> +#define arch_thp_swp_supported arch_thp_swp_supported
> >> >> >> > >>>>> +
> >> >> >> > >>>>>  /*
> >> >> >> > >>>>>   * Outside of a few very special situations (e.g. hibernation), we always
> >> >> >> > >>>>>   * use broadcast TLB invalidation instructions, therefore a spurious page
> >> >> >> > >>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> >> >> > >>>>> index de29821231c9..4ddaf6ad73ef 100644
> >> >> >> > >>>>> --- a/include/linux/huge_mm.h
> >> >> >> > >>>>> +++ b/include/linux/huge_mm.h
> >> >> >> > >>>>> @@ -461,4 +461,16 @@ static inline int split_folio_to_list(struct folio *folio,
> >> >> >> > >>>>>       return split_huge_page_to_list(&folio->page, list);
> >> >> >> > >>>>>  }
> >> >> >> > >>>>>
> >> >> >> > >>>>> +/*
> >> >> >> > >>>>> + * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
> >> >> >> > >>>>> + * limitations in the implementation like arm64 MTE can override this to
> >> >> >> > >>>>> + * false
> >> >> >> > >>>>> + */
> >> >> >> > >>>>> +#ifndef arch_thp_swp_supported
> >> >> >> > >>>>> +static inline bool arch_thp_swp_supported(void)
> >> >> >> > >>>>> +{
> >> >> >> > >>>>> +     return true;
> >> >> >> > >>>>> +}
> >> >> >> > >>>>
> >> >> >> > >>>> How about the following?
> >> >> >> > >>>>
> >> >> >> > >>>> static inline bool arch_wants_thp_swap(void)
> >> >> >> > >>>> {
> >> >> >> > >>>>      return IS_ENABLED(ARCH_WANTS_THP_SWAP);
> >> >> >> > >>>> }
> >> >> >> > >>>
> >> >> >> > >>> This looks good. then i'll need to change arm64 to
> >> >> >> > >>>
> >> >> >> > >>>  +static inline bool arch_thp_swp_supported(void)
> >> >> >> > >>>  +{
> >> >> >> > >>>  +     return IS_ENABLED(ARCH_WANTS_THP_SWAP) &&  !system_supports_mte();
> >> >> >> > >>>  +}
> >> >> >> > >>
> >> >> >> > >> Why ? CONFIG_THP_SWAP depends on ARCH_WANTS_THP_SWAP. In folio_alloc_swap(),
> >> >> >> > >> IS_ENABLED(CONFIG_THP_SWAP) enabled, will also imply ARCH_WANTS_THP_SWAP too
> >> >> >> > >> is enabled. Hence checking for ARCH_WANTS_THP_SWAP again does not make sense
> >> >> >> > >> either in the generic fallback stub, or in arm64 platform override. Because
> >> >> >> > >> without ARCH_WANTS_THP_SWAP enabled, arch_thp_swp_supported() should never
> >> >> >> > >> be called in the first place.
> >> >> >> > >
> >> >> >> > > For the only caller now, the checking looks redundant.  But the original
> >> >> >> > > proposed implementation as follows,
> >> >> >> > >
> >> >> >> > > static inline bool arch_thp_swp_supported(void)
> >> >> >> > > {
> >> >> >> > >      return true;
> >> >> >> > > }
> >> >> >> > >
> >> >> >> > > will return true even on architectures that don't support/want THP swap.
> >> >> >> >
> >> >> >> > But the function will never be called on for those platforms.
> >> >> >> >
> >> >> >> > > That will confuse people too.
> >> >> >> >
> >> >> >> > I dont see how.
> >> >> >> >
> >> >> >> > >
> >> >> >> > > And the "redundant" checking has no run time overhead, because compiler
> >> >> >> > > will do the trick.
> >> >> >> > I understand that, but dont think this indirection is necessary.
> >> >> >>
> >> >> >> Hi Anshuman, Hi Ying,
> >> >> >> Thanks for the comments of both of you. Does the below look ok?
> >> >> >>
> >> >> >> generic,
> >> >> >>
> >> >> >>  static inline bool arch_wants_thp_swap(void)
> >> >> >>   {
> >> >> >>       return IS_ENABLED(CONFIG_THP_SWAP);
> >> >> >>  }
> >> >> >>
> >> >> >
> >> >> > sorry, i actually meant arch_thp_swp_supported() but not
> >> >> > arch_wants_thp_swap() in generic code,
> >> >> >
> >> >> >  static inline bool arch_thp_swp_supported(void)
> >> >> >  {
> >> >> >       return IS_ENABLED(CONFIG_THP_SWAP);
> >> >> >  }
> >> >>
> >> >> IS_ENABLED(CONFIG_THP_SWAP) doesn't match the name too.  It's an option
> >> >> selected by users.  arch_thp_swp_supported() is to report the
> >> >> capability.
> >> >
> >> > Hi Ying,
> >> > CONFIG_THP_SWAP implicitly includes ARCH_WANTS_THP_SWAP. So it seems
> >> > a bit odd to have still another arch_wants_thp_swap().
> >> > if the name of arch_thp_swp_supported is not sensible to you, will
> >> > thp_swp_supported()
> >> > without arch_ make more sense? a similar example is,
> >> >
> >> > static inline bool gigantic_page_runtime_supported(void)
> >> > {
> >> >         return IS_ENABLED(CONFIG_ARCH_HAS_GIGANTIC_PAGE);
> >> > }
> >>
> >> Here, the capability of the architecture is reported.  But
> >> CONFIG_THP_SWAP is a user option.
> >>
> >> I'm OK with the function name "arch_thp_swp_supported()".  I just think
> >> that we should implement the function in a way that is consistent with
> >> the function name as much as possible.  That is, don't return true on
> >> architectures that THP swap isn't supported in fact.
> >
> > My point is that having a generic thp_swp_supported() which can combine
> > both IS_ENABLED(CONFIG_THP_SWP) && arch_thp_swp_thing().
> > then we can always only call this rather than checking two conditions.
> > Although there is only one caller for this moment, we might get more
> > later. So always calling this single function might make our life easier.
> >
> > we can treat
> >
> > static inline bool arch_thp_swp_supported(void)
> > {
> >        return IS_ENABLED(CONFIG_THP_SWAP);
> > }
>
> The issue is that IS_ENABLED(CONFIG_THP_SWAP) reports that whether THP
> swap is selected by the user, not just whether THP swap is supported by
> the architecture.

Your point is absolutely correct. but does it really matter given that
even huge_mm.h
being changed is doing this?

static inline bool thp_migration_supported(void)
{
        return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
}

Personally I would prefer we enjoy the convenience of calling single one
thp_swp_supported() in the existing caller and more potential callers by
trading off the accuracy of the name.

But since it is hard for all of us to be on the same page, I'll have to keep
the code as is :-)

Thanks
Barry
