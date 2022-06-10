Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C137B546EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350833AbiFJVHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346538AbiFJVHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:07:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241872A955
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:07:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so3445638pjo.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QPcJjJ8NgWpXuQk67LHqsrHvmsBFq1YRfLhC4pTbCc=;
        b=FCsj8r0T4ALIwotsyawl2qmVPoUIoEaV/xO0ejGPruuJJXao58co5IBlukxgDu4CJ8
         Fhhz98IZOr55iwcTp5RnaPJ1wXX0tCj7hZ6VqW3eo/J2bG5BU8Wm9cheEDcB/C8ptFjA
         hS2kTRN5BeXUG7COmoOe+MfN4RxdZyFcfROf2gZX/Q2QgBM78gcvtDNR+afk5dUf9pLm
         deIgZKH0HbDr5QCJjy6x+INmPDiUNXhB+aGdKr4KJlv2R5ZA7PlEEY1hLvpBOZEloTnk
         oHgG5EU79/z2p5WrPmpfXmcekLLXGXcfeP9m6d78v9+yjXqG70NPP66CbDYVsk411n3y
         BAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QPcJjJ8NgWpXuQk67LHqsrHvmsBFq1YRfLhC4pTbCc=;
        b=ToTrWsIxu4qdWrmqHqLrt9ycqNO/jJ0rzAEttJSIeryKbtxvZ6QSRyKzQEL6nVM6R3
         V7nCU/hD/eeKm793ofyCAZtp90vVJiR1XcgdYfiSaaPgst6CsQuPALcXwvBpYE3J87Wh
         6/8d3SWhl8mUF7vASva7vle0lHUyYYSS2GQKYsZQKPuOc6z2v6CPVv0bfY6Y3Y14Qs7D
         EKavAanS064cJQ3TilMTJz6odw9rwqSBXVWnnQZJ44Pzol8NsfU6wYICd3cmZiZQLi4a
         U1QBsUrzvRJIxqoP+WP+i/LmFxt8R+6QpwE6MiEJ+g/NAhKjrN4f5daOhM0lLsYH/qtQ
         uHXw==
X-Gm-Message-State: AOAM531n6Omy7Cl0xwZm9HoWFeN28v2W+t0RZ/5X4qWjqabWgtZx3Z7V
        Tq+RxDoUPt5lLhNOgb7/9MSyzGqLH8MZabhHCfo=
X-Google-Smtp-Source: ABdhPJz7VByUP6COJL5OWE4PnzwAQv8u8CQwi0qmXKbLvXSfRSgkcdGr1QKPikF5i7oyyEFW27TCZN7cGsvH36e4vag=
X-Received: by 2002:a17:903:32c4:b0:167:6e6f:204b with SMTP id
 i4-20020a17090332c400b001676e6f204bmr32405338plr.117.1654895256476; Fri, 10
 Jun 2022 14:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-7-shy828301@gmail.com>
 <CAAa6QmQ4DaFo9RFXRBZnvq=JbQcVOW9P2njCNXU_pjTxcg=3Sg@mail.gmail.com> <CAHbLzkpQJu16gKXTTk0QpeQUHhXqqt8SnVHjrKQw=F4Ra+xZ5A@mail.gmail.com>
In-Reply-To: <CAHbLzkpQJu16gKXTTk0QpeQUHhXqqt8SnVHjrKQw=F4Ra+xZ5A@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Jun 2022 14:07:23 -0700
Message-ID: <CAHbLzkrpE1NiEkAJhuOsYQBk7uoLymohpCpZHbnpUzmGRFLtrQ@mail.gmail.com>
Subject: Re: [v3 PATCH 6/7] mm: thp: kill __transhuge_page_enabled()
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Jun 10, 2022 at 10:24 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Jun 9, 2022 at 7:22 PM Zach O'Keefe <zokeefe@google.com> wrote:
> >
> > On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > The page fault path checks THP eligibility with
> > > __transhuge_page_enabled() which does the similar thing as
> > > hugepage_vma_check(), so use hugepage_vma_check() instead.
> > >
> > > However page fault allows DAX and !anon_vma cases, so added a new flag,
> > > in_pf, to hugepage_vma_check() to make page fault work correctly.
> > >
> > > The in_pf flag is also used to skip shmem and file THP for page fault
> > > since shmem handles THP in its own shmem_fault() and file THP allocation
> > > on fault is not supported yet.
> > >
> > > Also remove hugepage_vma_enabled() since hugepage_vma_check() is the
> > > only caller now, it is not necessary to have a helper function.
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  fs/proc/task_mmu.c         |  2 +-
> > >  include/linux/huge_mm.h    | 57 ++------------------------------------
> > >  include/linux/khugepaged.h |  2 +-
> > >  mm/huge_memory.c           | 25 ++++++++++++-----
> > >  mm/khugepaged.c            |  8 +++---
> > >  mm/memory.c                |  7 +++--
> > >  6 files changed, 31 insertions(+), 70 deletions(-)
> > >
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index fd79566e204c..a0850303baec 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -860,7 +860,7 @@ static int show_smap(struct seq_file *m, void *v)
> > >         __show_smap(m, &mss, false);
> > >
> > >         seq_printf(m, "THPeligible:    %d\n",
> > > -                  hugepage_vma_check(vma, vma->vm_flags, true));
> > > +                  hugepage_vma_check(vma, vma->vm_flags, true, false));
> > >
> > >         if (arch_pkeys_enabled())
> > >                 seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index f561c3e16def..d478e8875023 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -153,48 +153,6 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > >         return true;
> > >  }
> > >
> > > -static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> > > -                                         unsigned long vm_flags)
> > > -{
> > > -       /* Explicitly disabled through madvise. */
> > > -       if ((vm_flags & VM_NOHUGEPAGE) ||
> > > -           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> > > -               return false;
> > > -       return true;
> > > -}
> > > -
> > > -/*
> > > - * to be used on vmas which are known to support THP.
> > > - * Use transparent_hugepage_active otherwise
> > > - */
> > > -static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> > > -{
> > > -
> > > -       /*
> > > -        * If the hardware/firmware marked hugepage support disabled.
> > > -        */
> > > -       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
> > > -               return false;
> > > -
> > > -       if (!transhuge_vma_enabled(vma, vma->vm_flags))
> > > -               return false;
> > > -
> > > -       if (vma_is_temporary_stack(vma))
> > > -               return false;
> > > -
> > > -       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
> > > -               return true;
> > > -
> > > -       if (vma_is_dax(vma))
> > > -               return true;
> > > -
> > > -       if (transparent_hugepage_flags &
> > > -                               (1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
> > > -               return !!(vma->vm_flags & VM_HUGEPAGE);
> > > -
> > > -       return false;
> > > -}
> > > -
> > >  static inline bool file_thp_enabled(struct vm_area_struct *vma)
> > >  {
> > >         struct inode *inode;
> > > @@ -211,7 +169,7 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
> > >
> > >  bool hugepage_vma_check(struct vm_area_struct *vma,
> > >                         unsigned long vm_flags,
> > > -                       bool smaps);
> > > +                       bool smaps, bool in_pf);
> > >
> > >  #define transparent_hugepage_use_zero_page()                           \
> > >         (transparent_hugepage_flags &                                   \
> > > @@ -355,11 +313,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
> > >         return false;
> > >  }
> > >
> > > -static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> > > -{
> > > -       return false;
> > > -}
> > > -
> > >  static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > >  {
> > >         return false;
> > > @@ -371,15 +324,9 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > >         return false;
> > >  }
> > >
> > > -static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> > > -                                         unsigned long vm_flags)
> > > -{
> > > -       return false;
> > > -}
> > > -
> > >  static inline bool hugepage_vma_check(struct vm_area_struct *vma,
> > >                                        unsigned long vm_flags,
> > > -                                      bool smaps)
> > > +                                      bool smaps, bool in_pf)
> > >  {
> > >         return false;
> > >  }
> > > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > > index 8a6452e089ca..e047be601268 100644
> > > --- a/include/linux/khugepaged.h
> > > +++ b/include/linux/khugepaged.h
> > > @@ -55,7 +55,7 @@ static inline void khugepaged_enter(struct vm_area_struct *vma,
> > >  {
> > >         if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> > >             khugepaged_enabled()) {
> > > -               if (hugepage_vma_check(vma, vm_flags, false))
> > > +               if (hugepage_vma_check(vma, vm_flags, false, false))
> > >                         __khugepaged_enter(vma->vm_mm);
> > >         }
> > >  }
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index bc8370856e85..b95786ada466 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -71,17 +71,25 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
> > >
> > >  bool hugepage_vma_check(struct vm_area_struct *vma,
> > >                         unsigned long vm_flags,
> > > -                       bool smaps)
> > > +                       bool smaps, bool in_pf)
> > >  {
> > > -       if (!transhuge_vma_enabled(vma, vm_flags))
> > > +       /* Explicitly disabled through madvise or prctl. */
> >
> > Or s390 kvm (not that this has to be exhaustively maintained).
> >
> > > +       if ((vm_flags & VM_NOHUGEPAGE) ||
> > > +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> > > +               return false;
> > > +       /*
> > > +        * If the hardware/firmware marked hugepage support disabled.
> > > +        */
> > > +       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
> > >                 return false;
> >
> > This introduces an extra check for khugepaged path. I don't know
> > enough about TRANSPARENT_HUGEPAGE_NEVER_DAX, but I assume this is ok?
> > What would have happened previously if khugepaged tried to collapse
> > this memory?
>
> Please refer to commit bae849538157 ("mm/pmem: avoid inserting
> hugepage PTE entry with fsdax if hugepage support is disabled") for
> why this flag was introduced.
>
> It is set if hardware doesn't support hugepages, and khugepaged
> doesn't collapse since khugepaged won't be started at all.
>
> But this flag needs to be checked in the page fault path.
>
> >
> > > +       /* Special VMA and hugetlb VMA */
> > >         if (vm_flags & VM_NO_KHUGEPAGED)
> > >                 return false;
> >
> > This adds an extra check along the fault path. Is it also safe to add?
>
> I think it is safe since hugepage_vma_check() is just used by THP.
> Hugetlb has its own page fault handler.

I just found one exception. The fuse dax has VM_MIXEDMAP set for its
vmas, so this check should be moved after vma_is_dax() check.

AFAICT, only dax supports huge_fault() and dax vmas don't have any
VM_SPECIAL flags set other than fuse.

>
> >
> > > -       /* Don't run khugepaged against DAX vma */
> > > +       /* khugepaged doesn't collapse DAX vma, but page fault is fine. */
> > >         if (vma_is_dax(vma))
> > > -               return false;
> > > +               return in_pf;
> >
> > I assume vma_is_temporary_stack() and vma_is_dax() is mutually exclusive.
>
> I think so.
>
> >
> > >         if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
> > >                                 vma->vm_pgoff, HPAGE_PMD_NR))
> > > @@ -91,7 +99,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
> > >                 return false;
> > >
> > >         /* Enabled via shmem mount options or sysfs settings. */
> > > -       if (shmem_file(vma->vm_file))
> > > +       if (!in_pf && shmem_file(vma->vm_file))
> > >                 return shmem_huge_enabled(vma);
> >
> > Will shmem_file() ever be true in the fault path? Or is this just an
> > optimization?
>
> It could be true. But shmem has its own implementation for huge page
> fault and doesn't implement huge_fault() in its vm_operations, so it
> will fallback even though "in_pf" is not checked.
>
> But xfs does have huge_fault() implemented, so it may try to allocate
> THP for non-DAX xfs files. So the "in_pf" flag is introduced to handle
> this. Since we need this flag anyway, why not use it to return earlier
> for shmem instead of relying on fallback.
>
> Anyway this is all because __transparent_huge_enabled() is replaced by
> hugepage_vma_check().
>
> > >         if (!khugepaged_enabled())
> > > @@ -102,7 +110,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
> > >                 return false;
> > >
> > >         /* Only regular file is valid */
> > > -       if (file_thp_enabled(vma))
> > > +       if (!in_pf && file_thp_enabled(vma))
> > >                 return true;
> >
> > Likewise for file_thp_enabled()
>
> Yes, same as the above.
>
> >
> > >         if (!vma_is_anonymous(vma))
> > > @@ -114,9 +122,12 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
> > >         /*
> > >          * THPeligible bit of smaps should show 1 for proper VMAs even
> > >          * though anon_vma is not initialized yet.
> > > +        *
> > > +        * Allow page fault since anon_vma may be not initialized until
> > > +        * the first page fault.
> > >          */
> > >         if (!vma->anon_vma)
> > > -               return smaps;
> > > +               return (smaps || in_pf);
> > >
> > >         return true;
> > >  }
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index aa0769e3b0d9..ab6183c5489f 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -473,7 +473,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
> > >  {
> > >         if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> > >             khugepaged_enabled()) {
> > > -               if (hugepage_vma_check(vma, vm_flags, false))
> > > +               if (hugepage_vma_check(vma, vm_flags, false, false))
> > >                         __khugepaged_enter(vma->vm_mm);
> > >         }
> > >  }
> > > @@ -918,7 +918,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > >
> > >         if (!transhuge_vma_suitable(vma, address))
> > >                 return SCAN_ADDRESS_RANGE;
> > > -       if (!hugepage_vma_check(vma, vma->vm_flags, false))
> > > +       if (!hugepage_vma_check(vma, vma->vm_flags, false, false))
> > >                 return SCAN_VMA_CHECK;
> > >         return 0;
> > >  }
> > > @@ -1399,7 +1399,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
> > >          * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
> > >          * will not fail the vma for missing VM_HUGEPAGE
> > >          */
> > > -       if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false))
> > > +       if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false, false))
> > >                 return;
> > >
> > >         /* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
> > > @@ -2089,7 +2089,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
> > >                         progress++;
> > >                         break;
> > >                 }
> > > -               if (!hugepage_vma_check(vma, vma->vm_flags, false)) {
> > > +               if (!hugepage_vma_check(vma, vma->vm_flags, false, false)) {
> > >  skip:
> > >                         progress++;
> > >                         continue;
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index bc5d40eec5d5..673f7561a30a 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -4962,6 +4962,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
> > >                 .gfp_mask = __get_fault_gfp_mask(vma),
> > >         };
> > >         struct mm_struct *mm = vma->vm_mm;
> > > +       unsigned long vm_flags = vma->vm_flags;
> > >         pgd_t *pgd;
> > >         p4d_t *p4d;
> > >         vm_fault_t ret;
> > > @@ -4975,7 +4976,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
> > >         if (!vmf.pud)
> > >                 return VM_FAULT_OOM;
> > >  retry_pud:
> > > -       if (pud_none(*vmf.pud) && __transparent_hugepage_enabled(vma)) {
> > > +       if (pud_none(*vmf.pud) &&
> > > +           hugepage_vma_check(vma, vm_flags, false, true)) {
> > >                 ret = create_huge_pud(&vmf);
> > >                 if (!(ret & VM_FAULT_FALLBACK))
> > >                         return ret;
> > > @@ -5008,7 +5010,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
> > >         if (pud_trans_unstable(vmf.pud))
> > >                 goto retry_pud;
> > >
> > > -       if (pmd_none(*vmf.pmd) && __transparent_hugepage_enabled(vma)) {
> > > +       if (pmd_none(*vmf.pmd) &&
> > > +           hugepage_vma_check(vma, vm_flags, false, true)) {
> > >                 ret = create_huge_pmd(&vmf);
> > >                 if (!(ret & VM_FAULT_FALLBACK))
> > >                         return ret;
> > > --
> > > 2.26.3
> > >
> > >
