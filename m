Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F5954719C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350069AbiFKDZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbiFKDZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:25:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DCB99821
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:25:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c12-20020a17090a558c00b001ea95be66a5so1568pji.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2pCkZrUQ6Oqm7D3+gc130GZemzdGNVVRuGqto/BBFg=;
        b=c91vSN1EOtttZNPIjk94SJX8MRKWUOqYrUNGhQVY3vpdcXdcO+Ox/Pq6KL7gmgFxvy
         TfByjIgiVDMn1Tv9Q0lnZpavYbnvie5Mwt7eFIvEVLmFzqfkjqxun6Wvcf0Ik+Syzqz7
         pYyOKSW4um7INBaU1Ccz76LOfsVWjHxRnFCM51WSkRILiA2hW3OEO6kmiiKUidb1/xd+
         97s/s/f5+gy+GV1GAXVW+LSy1IBk7MXjCtkQF116eVv8+kEcEoxrhN7ahHm0N+PoZgmE
         A7DnggoqNhFrJ2MDjTPJp01nfbrbz8LxybijIUACU5cJ2WB+fPXa2R97Dy1ZrMIaZOxj
         0L9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2pCkZrUQ6Oqm7D3+gc130GZemzdGNVVRuGqto/BBFg=;
        b=3twwKfGzKKXGYoT3CMuV2HfkroJVeoAO7gf/9iNWlBhCbyraAIM1ExEYsvQMIZtdVt
         XOGI4u+x0qEay1i425wHeKLpGMiPXoz2YPbEIQxPFGoJPVKpauv+NqvoWOCPnGC26JbE
         QtjOGTV3kAe6G6D0UsZ7LgymQ6+xHLiPBWN+MJw+7jgVdGzEM2PYhmI2yYIwsCPvrv61
         1gTr/LDRK7OS2HSl0Y56K8bE+v/6vTf2svqo8icAYde72zqPx12ep8HRSxFXjup393h+
         YK7Ls5faMFWLbSM7lwhmbuC3jiogDyJStkD8nZXy+nZZHLjhK0FQrztRyjM3AU2mGSQ4
         JeIA==
X-Gm-Message-State: AOAM530qlOFEnZLNEjlLaUGZcYmgyJy3k64fuwNAqrzIxsLFG0tMTyTC
        RYjtZDpf+9F8Vt8CT/YQ8SKo7goMAXtU4WIJwP8=
X-Google-Smtp-Source: ABdhPJzvJrMeD+SiwQ88uPJNyqWqNTttvSh6KqWkshOz63REgZBWuqLhpCbWwiVDE5nBD3O9qfF5YIKju4CNLD7B3BY=
X-Received: by 2002:a17:90b:4c4c:b0:1e8:6f9a:b642 with SMTP id
 np12-20020a17090b4c4c00b001e86f9ab642mr2998342pjb.21.1654917930824; Fri, 10
 Jun 2022 20:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-5-shy828301@gmail.com>
 <CAAa6QmSCk+7HLtLOzbTYev7dAM0aff-f4USV3AXAQdSKu7_6HA@mail.gmail.com>
 <CAHbLzkpJWSiBX0fYWXjagA-19mJb6hwXZ=_Sk-qJHxMD_3sdYw@mail.gmail.com>
 <CAHbLzkpOQrshbBDfHjGVDbpcfdV7hgiwav6TyaZTzm_cq4PeDw@mail.gmail.com> <CAAa6QmT4mvpLMdtRV+tJJsPBBbPGuWVzKs5eoFBahG0s_Mba0Q@mail.gmail.com>
In-Reply-To: <CAAa6QmT4mvpLMdtRV+tJJsPBBbPGuWVzKs5eoFBahG0s_Mba0Q@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Jun 2022 20:25:18 -0700
Message-ID: <CAHbLzkrebC-jug86B4w2gkSxiiEUWWjrxBwjevX9q2adG04nzQ@mail.gmail.com>
Subject: Re: [v3 PATCH 4/7] mm: khugepaged: use transhuge_vma_suitable replace open-code
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

On Fri, Jun 10, 2022 at 5:28 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On Fri, Jun 10, 2022 at 3:04 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Fri, Jun 10, 2022 at 9:59 AM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Thu, Jun 9, 2022 at 6:52 PM Zach O'Keefe <zokeefe@google.com> wrote:
> > > >
> > > > On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
> > > > >
> > > > > The hugepage_vma_revalidate() needs to check if the address is still in
> > > > > the aligned HPAGE_PMD_SIZE area of the vma when reacquiring mmap_lock,
> > > > > but it was open-coded, use transhuge_vma_suitable() to do the job.  And
> > > > > add proper comments for transhuge_vma_suitable().
> > > > >
> > > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > > ---
> > > > >  include/linux/huge_mm.h | 6 ++++++
> > > > >  mm/khugepaged.c         | 5 +----
> > > > >  2 files changed, 7 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > > > index a8f61db47f2a..79d5919beb83 100644
> > > > > --- a/include/linux/huge_mm.h
> > > > > +++ b/include/linux/huge_mm.h
> > > > > @@ -128,6 +128,12 @@ static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
> > > > >         return false;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * Do the below checks:
> > > > > + *   - For non-anon vma, check if the vm_pgoff is HPAGE_PMD_NR aligned.
> > > > > + *   - For all vmas, check if the haddr is in an aligned HPAGE_PMD_SIZE
> > > > > + *     area.
> > > > > + */
> > > >
> > > > AFAIK we aren't checking if vm_pgoff is HPAGE_PMD_NR aligned, but
> > > > rather that linear_page_index(vma, round_up(vma->vm_start,
> > > > HPAGE_PMD_SIZE)) is HPAGE_PMD_NR aligned within vma->vm_file. I was
> > >
> > > Yeah, you are right.
> > >
> > > > pretty confused about this (hopefully I have it right now - if not -
> > > > case and point :) ), so it might be a good opportunity to add some
> > > > extra commentary to help future travelers understand why this
> > > > constraint exists.
> > >
> > > I'm not fully sure I understand this 100%. I think this is related to
> > > how page cache is structured. I will try to add more comments.
> >
> > How's about "The underlying THP is always properly aligned in page
> > cache, but it may be across the boundary of VMA if the VMA is
> > misaligned, so the THP can't be PMD mapped for this case."
>
> I could certainly still be wrong / am learning here - but I *thought*
> the reason for this check was to make sure that the hugepage
> to-be-collapsed is naturally aligned within the file (since, AFAIK,
> without this constraint, different mm's might have different ideas
> about where hugepages in the file should be).

The hugepage is definitely naturally aligned within the file, this is
guaranteed by how page cache is organized, you could find some example
code from shmem fault, for example, the below code snippet:

hindex = round_down(index, folio_nr_pages(folio));
error = shmem_add_to_page_cache(folio, mapping, hindex, NULL, gfp &
GFP_RECLAIM_MASK, charge_mm);

The index is actually rounded down to HPAGE_PMD_NR aligned.

The check in hugepage_vma_check() is used to guarantee there is an PMD
aligned area in the vma exactly overlapping with a PMD range in the
page cache. For example, you have a vma starting from 0x1000 maps to
the file's page offset of 0, even though you get THP for the file, it
can not be PMD mapped to the vma. But if it maps to the file's page
offset of 1, then starting from 0x200000 (assuming the vma is big
enough) it can PMD map the second THP in the page cache. Does it make
sense?

>
> > >
> > > >
> > > > Also I wonder while we're at it if we can rename this to
> > > > transhuge_addr_aligned() or transhuge_addr_suitable() or something.
> > >
> > > I think it is still actually used to check vma.
> > >
> > > >
> > > > Otherwise I think the change is a nice cleanup.
> > > >
> > > > >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > > > >                 unsigned long addr)
> > > > >  {
> > > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > > index 7a5d1c1a1833..ca1754d3a827 100644
> > > > > --- a/mm/khugepaged.c
> > > > > +++ b/mm/khugepaged.c
> > > > > @@ -951,7 +951,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > > > >                 struct vm_area_struct **vmap)
> > > > >  {
> > > > >         struct vm_area_struct *vma;
> > > > > -       unsigned long hstart, hend;
> > > > >
> > > > >         if (unlikely(khugepaged_test_exit(mm)))
> > > > >                 return SCAN_ANY_PROCESS;
> > > > > @@ -960,9 +959,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > > > >         if (!vma)
> > > > >                 return SCAN_VMA_NULL;
> > > > >
> > > > > -       hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> > > > > -       hend = vma->vm_end & HPAGE_PMD_MASK;
> > > > > -       if (address < hstart || address + HPAGE_PMD_SIZE > hend)
> > > > > +       if (!transhuge_vma_suitable(vma, address))
> > > > >                 return SCAN_ADDRESS_RANGE;
> > > > >         if (!hugepage_vma_check(vma, vma->vm_flags))
> > > > >                 return SCAN_VMA_CHECK;
> > > > > --
> > > > > 2.26.3
> > > > >
> > > > >
