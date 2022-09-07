Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7D5B0B14
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiIGRJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiIGRJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:09:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63C0BCC19
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:09:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f24so15251728plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pxt/RFuMQbA6Ym259IAf87KLR2eKCHM0qyYhrgeqdgA=;
        b=RH5Xt/EXEeMIUdrasR8CVGu699IQA3OH5oCU34EUOIzU4cFynQd+8PwbmyWMTpdNZr
         VUk9Iq+PwuQnYlEBKlp43w1CtVd76Zh9gO2Imotc9PNcxjS2p+PeGUUvRioyma/cfR2C
         0Mr9DXIhWGKYOn5R26udEbpItwfTtEBljecSg3fzIn1BbCfIzoEOgJ0SEhXOD766St3m
         z/ATN+6+qTe9DQz0PEm+wec1p9GCTnIssCjpkmtYYSwzytezexuJB9FNa87M6Dl0rBmM
         FJBjE5/ScIQSit4HJar4QZjulf0xShEWVPfssUrN83ne+muNDMIfT7kiBw3tUo+WbkNR
         s8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pxt/RFuMQbA6Ym259IAf87KLR2eKCHM0qyYhrgeqdgA=;
        b=U+Or5Gmx6pPmvfNmhyHj35gcrIvgoYGmwex7gVNgrqqdsj7JoIHQkcyqdJlaqy/Tm6
         UO7RwFX6Y5hBqkeTxky16FNI4hd+Vo2j3AgP7vlkWjLyCLxVJsDjnU0n18PllWsg4kpa
         AObeZyNPXVp7jxzy8Iuuk0Lmr26jJUasIhcKYqx/Xqcxlo50kfjZUt8UvfNxmWq6ybGa
         uq32+mUVRUfpTIhh6QGc5FJ/VPAM7L6EjhfwpTs7HMHiTA/PBRVFUk++HDhZotiJcd+C
         2bfmfALYNe3/MakCak+NdNzNQKLzCTiGDVKA9nL4SKsYGZsc/GJyP4ID2Pzi0lTQFU/W
         71Lw==
X-Gm-Message-State: ACgBeo0SN2bNmAXshO2YsghYo+kSlANN9lQVIIvzhdAovDYND+2uE7LX
        zR0CW+9PZykxJT/OZTO9vfrJb7Mid5RkCtHyu+s=
X-Google-Smtp-Source: AA6agR60kaYZTbk+Nbqosr/4E9psZ74b5dkLnw8fsaR0M8g6PFBg55BuXU2N/m4LGKhTLP/1ygrx1JLOQPafb5Lv3nE=
X-Received: by 2002:a17:902:be03:b0:175:6397:9425 with SMTP id
 r3-20020a170902be0300b0017563979425mr4688038pls.26.1662570540204; Wed, 07 Sep
 2022 10:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220901222707.477402-1-shy828301@gmail.com> <YxE/vuQlWJCJMuG2@xz-m1.local>
 <CAHbLzkqjZ_UhUbJ_f9Br7WCAgQvjrm5bMPRsKYvaFc2bzSuzrw@mail.gmail.com>
 <YxIofPiI8jvGzcjC@xz-m1.local> <CAHbLzkqGdnwY4P8jKQR0ojm6QV6b3dBi5pwrC1UJ4dqi3EqS4w@mail.gmail.com>
 <87ilm2jj4t.fsf@linux.ibm.com> <CAHbLzkohKvOFyfsVr=ry8Goi6kgxh9ig84FX0+pY4qzL4i0xWg@mail.gmail.com>
 <92fe7b10-cbcf-6fdb-af23-4cb2f314e612@linux.ibm.com>
In-Reply-To: <92fe7b10-cbcf-6fdb-af23-4cb2f314e612@linux.ibm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 7 Sep 2022 10:08:47 -0700
Message-ID: <CAHbLzkqmEdZq30nm7o9itq_3HSWtjoaSrg2HjVPdaEUbVdqcfA@mail.gmail.com>
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Peter Xu <peterx@redhat.com>, david@redhat.com,
        kirill.shutemov@linux.intel.com, jhubbard@nvidia.com,
        jgg@nvidia.com, hughd@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 9:51 PM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 9/7/22 12:37 AM, Yang Shi wrote:
> > On Mon, Sep 5, 2022 at 1:56 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> Yang Shi <shy828301@gmail.com> writes:
> >>
> >>>
> >>> On Fri, Sep 2, 2022 at 9:00 AM Peter Xu <peterx@redhat.com> wrote:
> >>>>
> >>>> On Thu, Sep 01, 2022 at 04:50:45PM -0700, Yang Shi wrote:
> >>>>> On Thu, Sep 1, 2022 at 4:26 PM Peter Xu <peterx@redhat.com> wrote:
> >>>>>>
> >>>>>> Hi, Yang,
> >>>>>>
> >>>>>> On Thu, Sep 01, 2022 at 03:27:07PM -0700, Yang Shi wrote:
> >>>>>>> Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
> >>>>>>> introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
> >>>>>>> sufficient to handle concurrent GUP-fast in all cases, it only handles
> >>>>>>> traditional IPI-based GUP-fast correctly.
> >>>>>>
> >>>>>> If TLB flush (or, IPI broadcasts) used to work to protect against gup-fast,
> >>>>>> I'm kind of confused why it's not sufficient even if with RCU gup?  Isn't
> >>>>>> that'll keep working as long as interrupt disabled (which current fast-gup
> >>>>>> will still do)?
> >>>>>
> >>>>> Actually the wording was copied from David's commit log for his
> >>>>> PageAnonExclusive fix. My understanding is the IPI broadcast still
> >>>>> works, but it may not be supported by all architectures and not
> >>>>> preferred anymore. So we should avoid depending on IPI broadcast IIUC.
> >>>>>
> >>>>>>
> >>>>>> IIUC the issue is you suspect not all archs correctly implemented
> >>>>>> pmdp_collapse_flush(), or am I wrong?
> >>>>>
> >>>>> This is a possible fix, please see below for details.
> >>>>>
> >>>>>>
> >>>>>>> On architectures that send
> >>>>>>> an IPI broadcast on TLB flush, it works as expected.  But on the
> >>>>>>> architectures that do not use IPI to broadcast TLB flush, it may have
> >>>>>>> the below race:
> >>>>>>>
> >>>>>>>    CPU A                                          CPU B
> >>>>>>> THP collapse                                     fast GUP
> >>>>>>>                                               gup_pmd_range() <-- see valid pmd
> >>>>>>>                                                   gup_pte_range() <-- work on pte
> >>>>>>> pmdp_collapse_flush() <-- clear pmd and flush
> >>>>>>> __collapse_huge_page_isolate()
> >>>>>>>     check page pinned <-- before GUP bump refcount
> >>>>>>>                                                       pin the page
> >>>>>>>                                                       check PTE <-- no change
> >>>>>>> __collapse_huge_page_copy()
> >>>>>>>     copy data to huge page
> >>>>>>>     ptep_clear()
> >>>>>>> install huge pmd for the huge page
> >>>>>>>                                                       return the stale page
> >>>>>>> discard the stale page
> >>>>>>>
> >>>>>>> The race could be fixed by checking whether PMD is changed or not after
> >>>>>>> taking the page pin in fast GUP, just like what it does for PTE.  If the
> >>>>>>> PMD is changed it means there may be parallel THP collapse, so GUP
> >>>>>>> should back off.
> >>>>>>
> >>>>>> Could the race also be fixed by impl pmdp_collapse_flush() correctly for
> >>>>>> the archs that are missing? Do you know which arch(s) is broken with it?
> >>>>>
> >>>>> Yes, and this was suggested by me in the first place, but per the
> >>>>> suggestion from John and David, this is not the preferred way. I think
> >>>>> it is because:
> >>>>>
> >>>>> Firstly, using IPI to serialize against fast GUP is not recommended
> >>>>> anymore since fast GUP does check PTE then back off so we should avoid
> >>>>> it.
> >>>>> Secondly, if checking PMD then backing off could solve the problem,
> >>>>> why do we still need broadcast IPI? It doesn't sound performant.
> >>>>>
> >>>>>>
> >>>>>> It's just not clear to me whether this patch is an optimization or a fix,
> >>>>>> if it's a fix whether the IPI broadcast in ppc pmdp_collapse_flush() would
> >>>>>> still be needed.
> >>>>>
> >>>>> It is a fix and the fix will make IPI broadcast not useful anymore.
> >>>>
> >>>> How about another patch to remove the ppc impl too?  Then it can be a two
> >>>> patches series.
> >>>
> >>> BTW, I don't think we could remove the ppc implementation since it is
> >>> different from the generic pmdp_collapse_flush(), particularly for the
> >>> hash part IIUC.
> >>>
> >>> The generic version calls flush_tlb_range() -> hash__flush_tlb_range()
> >>> for hash, but the hash call is actually no-op. The ppc version calls
> >>> hash__pmdp_collapse_flush() -> flush_tlb_pmd_range(), which does
> >>> something useful.
> >>>
> >>
> >> We should actually rename flush_tlb_pmd_range(). It actually flush the
> >> hash page table entries.
> >>
> >> I will do the below patch for ppc64 to clarify this better
> >
> > Thanks, Aneesh. It looks more readable. A follow-up question, I think
> > we could remove serialize_against_pte_lookup(), which just issues IPI
> > broadcast to run a dummy function. This IPI should not be needed
> > anymore with my patch. Of course, we need to keep the memory barrier.
> >
>
>
> For radix translation yes. For hash we still need that. W.r.t memory barrier,
> radix do use radix__flush_tlb_collapsed_pmd() which does a tlb invalidate.
> IIUC that will enfocre the required memory barrier there. So you should be able
> to just remove
>
> modified   arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -937,15 +937,6 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
>         pmd = *pmdp;
>         pmd_clear(pmdp);
>
> -       /*
> -        * pmdp collapse_flush need to ensure that there are no parallel gup
> -        * walk after this call. This is needed so that we can have stable
> -        * page ref count when collapsing a page. We don't allow a collapse page
> -        * if we have gup taken on the page. We can ensure that by sending IPI
> -        * because gup walk happens with IRQ disabled.
> -        */
> -       serialize_against_pte_lookup(vma->vm_mm);
> -
>         radix__flush_tlb_collapsed_pmd(vma->vm_mm, address);
>
>         return pmd;
>
> in your patch. This will also consolidate all the related changes together.

Thanks, Aneesh. It may be better to have the ppc cleanup in a separate patch.

>
> >>
> >> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> >> index 8b762f282190..fd30fa20c392 100644
> >> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> >> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> >> @@ -112,13 +112,12 @@ static inline void hash__flush_tlb_kernel_range(unsigned long start,
> >>
> >>  struct mmu_gather;
> >>  extern void hash__tlb_flush(struct mmu_gather *tlb);
> >> -void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr);
> >>
> >>  #ifdef CONFIG_PPC_64S_HASH_MMU
> >>  /* Private function for use by PCI IO mapping code */
> >>  extern void __flush_hash_table_range(unsigned long start, unsigned long end);
> >> -extern void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd,
> >> -                               unsigned long addr);
> >> +extern void flush_hash_table_pmd_range(struct mm_struct *mm, pmd_t *pmd,
> >> +                                      unsigned long addr);
> >>  #else
> >>  static inline void __flush_hash_table_range(unsigned long start, unsigned long end) { }
> >>  #endif
> >> diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
> >> index ae008b9df0e6..f30131933a01 100644
> >> --- a/arch/powerpc/mm/book3s64/hash_pgtable.c
> >> +++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
> >> @@ -256,7 +256,7 @@ pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addres
> >>          * the __collapse_huge_page_copy can result in copying
> >>          * the old content.
> >>          */
> >> -       flush_tlb_pmd_range(vma->vm_mm, &pmd, address);
> >> +       flush_hash_table_pmd_range(vma->vm_mm, &pmd, address);
> >>         return pmd;
> >>  }
> >>
> >> diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
> >> index eb0bccaf221e..a64ea0a7ef96 100644
> >> --- a/arch/powerpc/mm/book3s64/hash_tlb.c
> >> +++ b/arch/powerpc/mm/book3s64/hash_tlb.c
> >> @@ -221,7 +221,7 @@ void __flush_hash_table_range(unsigned long start, unsigned long end)
> >>         local_irq_restore(flags);
> >>  }
> >>
> >> -void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
> >> +void flush_hash_table_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
> >>  {
> >>         pte_t *pte;
> >>         pte_t *start_pte;
> >>
>
