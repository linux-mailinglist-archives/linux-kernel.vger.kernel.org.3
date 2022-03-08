Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E714D0C65
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiCHAE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343994AbiCHAEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:04:20 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F4934B82
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:03:25 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso682899pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9wbXIRTldTtmuQubha8O7jdPMIdPkNXtDtnMlsvwSo=;
        b=D87M53alQtZEnb5Nxh9tl58QMmIVaYCGTYKkPrxRZrPG7KU8lZ6S7NFZEl9Y5UlqQ3
         wfqcXLvzegMv2kSU1R73uRWogrDub/0B5FB3xfcj4XZl24WzcaJGozDjnQOrQSU0dOrI
         XeE5XP3DU6bLdgmupoAm88xQDEkS/q41h1LGnJbHMM5x4rphyxpKec6Fj0PTuuEDB5qW
         8LFuKEQ46MF66Ww926o4sZrhjDoCGFIzN1a4SqMy67RhBfIzIKRsggz7l1JAABjWV6+6
         7i+ldoimjRVb0IE69i0V4Ijg9pD7Tec6ErcALewNunmmvEOSlnPwBUf4wzvS7Gdc1Wuk
         wJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9wbXIRTldTtmuQubha8O7jdPMIdPkNXtDtnMlsvwSo=;
        b=KjJdQ1kjgnlj9egnYwuvXb4fOWhwZRrBixfYiEnrPizvOjwe9MszytU7+xtPR3Vw7j
         /oIo31goc70JIUqliuFfFQmjbvvjTU8c9q0VI1TjBxlS2xY8OP5pobc2HukhhDmMjCKo
         ECy/zbk1ehPcKLBYdAb3NaMAGk2o3bNjEsVdiK9G5/UmQx23piLYuvBdR4LxsHuZL0h1
         RrvKr2yfpUgebzYyhECa/sSgw4TsEs0XwIoDhvtubQd/3ufbaGaKgWh80Gmot+l4SDLd
         5eg14tTjl5vgCrf7v5nrwqbfgcSUHxXg5N7eb908OO1Wfoc/H9GoHHvMumFwFRC77RU3
         jhyQ==
X-Gm-Message-State: AOAM530apxzAhafYGOWY1MlbTshd+N/odcWsTVGI0qPYNxuZMUlKQtyM
        4mCwbctPdCBPHBhhQEXL6vcWmh4J7vOM2mupbSE=
X-Google-Smtp-Source: ABdhPJw/ms+120QdyjSh1B6KKPoO7l8dAlw76td2jm1Ksw2GuzOkn4+GvrlwOyuHDgFV+kszD03ayeW6jrc0Uqmn35E=
X-Received: by 2002:a17:903:124a:b0:151:99fe:1a10 with SMTP id
 u10-20020a170903124a00b0015199fe1a10mr14660065plh.87.1646697804764; Mon, 07
 Mar 2022 16:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20220303222014.517033-1-shy828301@gmail.com> <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com>
 <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com>
 <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com> <20220306180718.6d4e6233130b94fdad98df88@linux-foundation.org>
 <84a6c9c1-d18f-6955-2666-0a2d7bce6094@redhat.com> <20220307154326.6494f7fca7def491a23e5df1@linux-foundation.org>
In-Reply-To: <20220307154326.6494f7fca7def491a23e5df1@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Mar 2022 16:03:12 -0800
Message-ID: <CAHbLzkqY69nFniK+ckQaeu117Q+OqZ2hvFEdVbZaW2C_zAzDbg@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting PMD
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
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

On Mon, Mar 7, 2022 at 3:43 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 7 Mar 2022 09:24:58 +0100 David Hildenbrand <david@redhat.com> wrote:
>
> > On 07.03.22 03:07, Andrew Morton wrote:
> > > On Fri, 4 Mar 2022 19:50:08 +0100 David Hildenbrand <david@redhat.com> wrote:
> > >
> > >> @Andrew, the last mail I received was
> > >>
> > >> + mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
> > >> added to -mm tree
> > >>
> > >> The patch shows up in mmotm as
> > >>
> > >> #[merged]mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
> > >>
> > >> ... which shouldn't be true.
> > >
> > > I guess I mislabelled the reason for dropping it.  Should have been to-be-updated,
> > > due to https://lkml.kernel.org/r/CAHbLzkpbnQyHRckoRtbZoaLvANu92MY4kEsbKudaQ8MDUA3nVg@mail.gmail.com
> > >
> >
> > Let me clarify.
> >
> > 1. I sent [1] (9 patches)
> >
> > 2. You queued the 9 patches
> >
> > E.g., in "mmotm 2022-02-15-20-22 uploaded"
> >
> > * mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
> > * mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
> > * mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
> > * mm-streamline-cow-logic-in-do_swap_page.patch
> > * mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
> > * mm-khugepaged-remove-reuse_swap_page-usage.patch
> > * mm-swapfile-remove-stale-reuse_swap_page.patch
> > * mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch
> > * mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
> >
> > 3. The last patch in the series was dropped. What remains are 8 patches.
> >
> > E.g., in "mmotm 2022-02-24-22-38 uploaded"
> >
> > * mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
> > * mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
> > * mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
> > * mm-streamline-cow-logic-in-do_swap_page.patch
> > * mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
> > * mm-khugepaged-remove-reuse_swap_page-usage.patch
> > * mm-swapfile-remove-stale-reuse_swap_page.patch
> > * mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch
> >
> > 4. Yang Shi sent his patch (the one we're replying to)
> >
> > 5. You picked his patch and dropped it again due to [2]
> >
> >
> > I'm wondering why 3 happened and why
> > https://www.ozlabs.org/~akpm/mmotm/series contains:
> >
> >
> > mm-optimize-do_wp_page-for-exclusive-pages-in-the-swapcache.patch
> > mm-optimize-do_wp_page-for-fresh-pages-in-local-lru-pagevecs.patch
> > mm-slightly-clarify-ksm-logic-in-do_swap_page.patch
> > mm-streamline-cow-logic-in-do_swap_page.patch
> > mm-huge_memory-streamline-cow-logic-in-do_huge_pmd_wp_page.patch
> > mm-khugepaged-remove-reuse_swap_page-usage.patch
> > mm-swapfile-remove-stale-reuse_swap_page.patch
> > mm-huge_memory-remove-stale-page_trans_huge_mapcount.patch
> > ...
> > #[merged]mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
>
> OK, thanks.  I guess it was me seeing 100% rejects when merging onto
> the folio changes then incorrectly deciding the patch was now in
> linux-next via some other tree.
>
> I restored it and fixed things up.  Please check.

Thanks, Andrew. I think we could clean it up a little bit further.

>
>
> --- a/mm/huge_memory.c~mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd
> +++ a/mm/huge_memory.c
> @@ -2133,8 +2133,6 @@ void __split_huge_pmd(struct vm_area_str
>  {
>         spinlock_t *ptl;
>         struct mmu_notifier_range range;
> -       bool do_unlock_folio = false;
> -       pmd_t _pmd;
>
>         mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
>                                 address & HPAGE_PMD_MASK,
> @@ -2153,42 +2151,14 @@ void __split_huge_pmd(struct vm_area_str
>                         goto out;
>         }
>
> -repeat:
>         if (pmd_trans_huge(*pmd)) {
> -               if (!folio) {
> +               if (!folio)
>                         folio = page_folio(pmd_page(*pmd));

We could remove the "if (pmd_trans_huge(*pmd))" section since folio is
actually not used afterward at all.

> -                       /*
> -                        * An anonymous page must be locked, to ensure that a
> -                        * concurrent reuse_swap_page() sees stable mapcount;
> -                        * but reuse_swap_page() is not used on shmem or file,
> -                        * and page lock must not be taken when zap_pmd_range()
> -                        * calls __split_huge_pmd() while i_mmap_lock is held.
> -                        */
> -                       if (folio_test_anon(folio)) {
> -                               if (unlikely(!folio_trylock(folio))) {
> -                                       folio_get(folio);
> -                                       _pmd = *pmd;
> -                                       spin_unlock(ptl);
> -                                       folio_lock(folio);
> -                                       spin_lock(ptl);
> -                                       if (unlikely(!pmd_same(*pmd, _pmd))) {
> -                                               folio_unlock(folio);
> -                                               folio_put(folio);
> -                                               folio = NULL;
> -                                               goto repeat;
> -                                       }
> -                                       folio_put(folio);
> -                               }
> -                               do_unlock_folio = true;
> -                       }
> -               }
>         } else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
>                 goto out;
>         __split_huge_pmd_locked(vma, pmd, range.start, freeze);

With the above if removed, this could be changed to:

if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
            is_pmd_migration_entry(*pmd))
                __split_huge_pmd_locked(vma, pmd, range.start, freeze);

>  out:
>         spin_unlock(ptl);
> -       if (do_unlock_folio)
> -               folio_unlock(folio);
>         /*
>          * No need to double call mmu_notifier->invalidate_range() callback.
>          * They are 3 cases to consider inside __split_huge_pmd_locked():
> _
>
