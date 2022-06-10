Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E23546AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349702AbiFJQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349742AbiFJQiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:38:22 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCBA56B38
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:38:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u18so23213652plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpTRX66gSZYkc1etlSX8TA/uq6NReqtWWcPkMVe7cOE=;
        b=BqN2FQMgN2l9mnU0AVl5BXVzTTuplUoAMIAqQg0lHQb0YPdPU14ytfIhlZG8CMZ2Tm
         PT5/R6AEqMEHAQqaKQ1wUHF7G1SBgCB/PtNj1HtjC4kPP5WidWXJJgDVtlEsAio3G18g
         Wpyl6pErg7HUAheqEIg+YOluBVa5pRpxClTsHEZ9e5W1uHWbypQ8RbDyaSU48IsGI9HJ
         Pq7KmFW8orMamR7hTJCZcfMcy7Ce3JsA6ayQPaz+RPTTx00/NFJOdqxC75bAdl6mkvN9
         7xoc82eXNLXkWrtV0PgBTuaMo/8D9c2yTeoNnwsNziK6dTxt0cXixWo3xbM6ZlrQM4nZ
         zQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpTRX66gSZYkc1etlSX8TA/uq6NReqtWWcPkMVe7cOE=;
        b=jsu0JBEo25+PCahxwyqFJFIyRZ1VGGRUhvs1Ht0Rsj2OdhWMub7Eojr23OHiUoSjrZ
         VB4bBolLbyW+CAtXgLyNufHOPhim/p7Cu7MN49HJnsQTQWmPX0qYseLHGB50Sww4nGQo
         kyWkpT0UYodEOsEunY/cN9XDaicfd/U8quet02B0H3Vof9Ed0+VRTFUxoROiyJo9DrvI
         zd0coZXKY0Zh42VjVljqRNygTT//2G8c/RqJL+f0scDuwxwSykjw/axH+/uUZVRX9IJT
         VKP4xMsrNZd+rnYmI2qzaeEekQMpZ6+3H8i7BLv+jA3skd3QGanN8730jtIQMgi/qeNX
         hBFA==
X-Gm-Message-State: AOAM5305cRn8IlqAyKQWW/ihP+y9DoF2PeaVOHZmwtsJIVFu0wKx8g3K
        6AjZ45FS1kWWgnrljrpZ/RHOFDW0ol7bFhbf3zE=
X-Google-Smtp-Source: ABdhPJx+5iZXS9OXXK7nPDz0MieRvvl1XTaGp9Lqx/jFLol9ZxAtlwC8L7CHMrMVYtF85fgTF0dw9G1+8SA7HTz4Hc0=
X-Received: by 2002:a17:903:32c4:b0:167:6e6f:204b with SMTP id
 i4-20020a17090332c400b001676e6f204bmr31417815plr.117.1654879101310; Fri, 10
 Jun 2022 09:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-3-shy828301@gmail.com>
 <CAAa6QmTYZQVf_U3dBnFpYGh3E8Qc4w8CKctMUC7jV_t=naGURQ@mail.gmail.com>
 <CAHbLzkr42VJhwj5EELw4oOXxm8bHzB7AEUBa0JqWYpvNXw6oNg@mail.gmail.com> <CAAa6QmRThv3OMr_j9Z7i_Q4zL3EFYHJSJxdUhE5ebmOMD_+n7w@mail.gmail.com>
In-Reply-To: <CAAa6QmRThv3OMr_j9Z7i_Q4zL3EFYHJSJxdUhE5ebmOMD_+n7w@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Jun 2022 09:38:09 -0700
Message-ID: <CAHbLzkq8Ko+KL1wnxLGjgL=z8k9Bz5cX6q9Y-cfaWo9T5iSXbg@mail.gmail.com>
Subject: Re: [v3 PATCH 2/7] mm: thp: introduce transhuge_vma_size_ok() helper
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

On Thu, Jun 9, 2022 at 5:52 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On Thu, Jun 9, 2022 at 5:08 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Thu, Jun 9, 2022 at 3:21 PM Zach O'Keefe <zokeefe@google.com> wrote:
> > >
> > > On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > There are couple of places that check whether the vma size is ok for
> > > > THP or not, they are open coded and duplicate, introduce
> > > > transhuge_vma_size_ok() helper to do the job.
> > > >
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > >  include/linux/huge_mm.h | 17 +++++++++++++++++
> > > >  mm/huge_memory.c        |  5 +----
> > > >  mm/khugepaged.c         | 12 ++++++------
> > > >  3 files changed, 24 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > > index 648cb3ce7099..a8f61db47f2a 100644
> > > > --- a/include/linux/huge_mm.h
> > > > +++ b/include/linux/huge_mm.h
> > > > @@ -116,6 +116,18 @@ extern struct kobj_attribute shmem_enabled_attr;
> > > >
> > > >  extern unsigned long transparent_hugepage_flags;
> > > >
> > > > +/*
> > > > + * The vma size has to be large enough to hold an aligned HPAGE_PMD_SIZE area.
> > > > + */
> > > > +static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > > > +{
> > > > +       if (round_up(vma->vm_start, HPAGE_PMD_SIZE) <
> > > > +           (vma->vm_end & HPAGE_PMD_MASK))
> > > > +               return true;
> > > > +
> > > > +       return false;
> > > > +}
> > >
> > > First time coming across round_up() - thanks for that - but for
> > > symmetry, maybe also use round_down() for the end? No strong opinion -
> > > just a suggestion given I've just discovered it.
> >
> > Yeah, round_down is fine too.
> >
> > >
> > > >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > > >                 unsigned long addr)
> > > >  {
> > > > @@ -345,6 +357,11 @@ static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
> > > >         return false;
> > > >  }
> > > >
> > > > +static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > > > +{
> > > > +       return false;
> > > > +}
> > > > +
> > > >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > > >                 unsigned long addr)
> > > >  {
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index 48182c8fe151..36ada544e494 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -71,10 +71,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
> > > >
> > > >  bool transparent_hugepage_active(struct vm_area_struct *vma)
> > > >  {
> > > > -       /* The addr is used to check if the vma size fits */
> > > > -       unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> > > > -
> > > > -       if (!transhuge_vma_suitable(vma, addr))
> > > > +       if (!transhuge_vma_size_ok(vma))
> > > >                 return false;
> > > >         if (vma_is_anonymous(vma))
> > > >                 return __transparent_hugepage_enabled(vma);
> > >
> > > Do we need a check for vma->vm_pgoff alignment here, after
> > > !vma_is_anonymous(), and now that we don't call
> > > transhuge_vma_suitable()?
> >
> > Actually I was thinking about this too. But the THPeligible bit shown
> > by smaps is a little bit ambiguous for file vma. The document says:
> > "THPeligible" indicates whether the mapping is eligible for allocating
> > THP pages - 1 if true, 0 otherwise.
> >
> > Even though it doesn't fulfill the alignment, it is still possible to
> > get THP allocated, but just can't be PMD mapped. So the old behavior
> > of THPeligible for file vma seems problematic, or at least doesn't
> > match the document.
>
> I think the term "THP" is used ambiguously. Often, but not always, in
> the code, folks will go out of their way to specify "hugepage-sized"
> page vs "pmd-mapped hugepage" - but at least from my experience,
> external documentation doesn't. Given that THP as a concept doesn't
> make much sense without the possibility of pmd-mapping, I think
> "THPeligible here means "pmd mappable". For example, AnonHugePages in
> smaps means  pmd-mapped anon hugepages.

Yeah, depends on the expectation.

>
> That all said - the following patches will delete
> transparent_hugepage_active() anyways.

Yes, how I could forget this :-( The following removal of
transparent_hugepage_active() will restore the old behavior.

>
> > I should elaborate this in the commit log.
> >
> > >
> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > index 84b9cf4b9be9..d0f8020164fc 100644
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -454,6 +454,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
> > > >                                 vma->vm_pgoff, HPAGE_PMD_NR))
> > > >                 return false;
> > > >
> > > > +       if (!transhuge_vma_size_ok(vma))
> > > > +               return false;
> > > > +
> > > >         /* Enabled via shmem mount options or sysfs settings. */
> > > >         if (shmem_file(vma->vm_file))
> > > >                 return shmem_huge_enabled(vma);
> > > > @@ -512,9 +515,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
> > > >                           unsigned long vm_flags)
> > > >  {
> > > >         if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> > > > -           khugepaged_enabled() &&
> > > > -           (((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
> > > > -            (vma->vm_end & HPAGE_PMD_MASK))) {
> > > > +           khugepaged_enabled()) {
> > > >                 if (hugepage_vma_check(vma, vm_flags))
> > > >                         __khugepaged_enter(vma->vm_mm);
> > > >         }
> > > > @@ -2142,10 +2143,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
> > > >                         progress++;
> > > >                         continue;
> > > >                 }
> > > > -               hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> > > > +
> > > > +               hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
> > > >                 hend = vma->vm_end & HPAGE_PMD_MASK;
> > > > -               if (hstart >= hend)
> > > > -                       goto skip;
> > > >                 if (khugepaged_scan.address > hend)
> > > >                         goto skip;
> > > >                 if (khugepaged_scan.address < hstart)
> > >
> > > Likewise, could do round_down() here (just a suggestion)
> >
> > Fine to me.
> >
> > >
> > > > --
> > > > 2.26.3
> > > >
> > > >
