Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959535A84D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiHaRz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiHaRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:55:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF87D3E65
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:55:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 76so15175709pfy.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vmx4gHJp3u58Y95b/+pQhpJVRJy7LPLrGYUILaqzP90=;
        b=cR6Hz+GMMYCP8ejaPhssEUK/Gx3B34EwyM3LRufVEgzzzrO5yjztpWB3eb476vbXap
         mT8BdcHIZg3Vf94818iIUNfNWKoHPsOU+gNxl7BHpIIcRQJ5RQW6jriNTwViEx7KgUW6
         G45dwnVeLQqAJKCAO8booBUPOGUmS/V1/wgaeWJabK+dXammfkjTmWxCX/XooMXoMjbj
         2dmF7skteetLhBWrBOGpEFSib0wakZxn4yd2T5NtZlQw1c08d+gH6tsgJmLkEJJB5fJQ
         bbXYuYBkexBNqhVsmU7xGqhovjourbT3BbYrbN2062xgPrGh7TrApRjQtiNoLiiFu7i2
         qGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vmx4gHJp3u58Y95b/+pQhpJVRJy7LPLrGYUILaqzP90=;
        b=JmXvrvQWrjk25jYwCkq4dx5Z+6jcRSJdwYXfU3ZqJ7gC2rBP8JEGfeKyMmAOUNNKiT
         fmYU7px8Zsnh4a5uxtxsUg3WtN4WDojGF6y6Rqo2VTEzWkUj23YAWNnv69KoWquw3Z/i
         kdxk2TxgpuqKnpNyOB8s4Kn7hMDwe3dsKPPb823W1TrNLJGXmenC0YSDRA9ZkAfpmOhk
         DoqXOj5TT4U1VebqdJzkU+gbz/52MyW619ujenu4Zv3qYnmuXA3B/6c1u4Ttw/6uZGF7
         CQ/PBMZTSFsRHaHiSnpET4cRA9pMX9oUxmzgfFkkIVwLCabQn0zDnT+xU8VK+WxRV8/R
         VeIw==
X-Gm-Message-State: ACgBeo2F3Uo1hTOEjUm1sMeTTHAaZQsoP19bDuwySi0xn9lBPtVfPTrg
        aBz0yHJhInEM93q+Alf2C5dciecnUuTdLzNPCs0=
X-Google-Smtp-Source: AA6agR7/NHH+IR98XLUgrClivA8XFdyDFCxcjCDKLVj7jfAgRPUp7YKdkpzhs8wwSbn2yp6oifmnZc80rfMAGHkfMYc=
X-Received: by 2002:aa7:9193:0:b0:536:62e6:1a84 with SMTP id
 x19-20020aa79193000000b0053662e61a84mr27241415pfa.20.1661968555798; Wed, 31
 Aug 2022 10:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220831083024.37138-1-david@redhat.com>
In-Reply-To: <20220831083024.37138-1-david@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 31 Aug 2022 10:55:43 -0700
Message-ID: <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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

On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
>
> The comment is stale, because a TLB flush is no longer sufficient and
> required to synchronize against concurrent GUP-fast. This used to be true
> in the past, whereby a TLB flush would have implied an IPI on architectures
> that support GUP-fast, resulting in GUP-fast that disables local interrupts
> from completing before completing the flush.

Hmm... it seems there might be problem for THP collapse IIUC. THP
collapse clears and flushes pmd before doing anything on pte and
relies on interrupt disable of fast GUP to serialize against fast GUP.
But if TLB flush is no longer sufficient, then we may run into the
below race IIUC:

         CPU A                                                CPU B
THP collapse                                             fast GUP

gup_pmd_range() <-- see valid pmd

gup_pte_range() <-- work on pte
clear pmd and flush TLB
__collapse_huge_page_isolate()
    isolate page <-- before GUP bump refcount

   pin the page
__collapse_huge_page_copy()
    copy data to huge page
    clear pte (don't flush TLB)
Install huge pmd for huge page

return the obsolete page


>
> However, ever since general RCU GUP-fast was introduced in
> commit 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()"),
> this handling no longer applies in general. RCU primarily prevents page
> tables from getting freed while they might still get walked by GUP-fast,
> but we can race with GUP-fast after clearing the PTE and flushing the
> TLB.
>
> Nowadays, we can see a refcount change from GUP-fast at any point in
> time. However, GUP-fast detects concurrent PTE changes by looking up the
> PTE, temporarily grabbing a reference, and dropping the reference again if
> the PTE changed in the meantime.
>
> An explanation by Jason Gunthorpe regarding how existing memory barriers
> should be fine to make sure that concurrent GUP-fast cannot succeed in
> grabbing a reference with write permissions after we cleared the PTE and
> flushed the TLB can be found at [1].
>
> Note that clearing PageAnonExclusive via page_try_share_anon_rmap()
> might still need some explicit memory barriers to not have any possible
> races with RCU GUP-fast.
>
> [1] https://lkml.kernel.org/r/Yw5rwIUPm49XtqOB@nvidia.com
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/ksm.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 42ab153335a2..e88291f63461 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1072,23 +1072,20 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
>                 swapped = PageSwapCache(page);
>                 flush_cache_page(vma, pvmw.address, page_to_pfn(page));
>                 /*
> -                * Ok this is tricky, when get_user_pages_fast() run it doesn't
> -                * take any lock, therefore the check that we are going to make
> -                * with the pagecount against the mapcount is racy and
> -                * O_DIRECT can happen right after the check.
> -                * So we clear the pte and flush the tlb before the check
> -                * this assure us that no O_DIRECT can happen after the check
> -                * or in the middle of the check.
> -                *
> -                * No need to notify as we are downgrading page table to read
> -                * only not changing it to point to a new page.
> +                * Especially if we're downgrading protection, make sure to
> +                * flush the TLB now. No need to notify as we are not changing
> +                * the PTE to point at a different page.
>                  *
>                  * See Documentation/mm/mmu_notifier.rst
>                  */
>                 entry = ptep_clear_flush(vma, pvmw.address, pvmw.pte);
> +
>                 /*
> -                * Check that no O_DIRECT or similar I/O is in progress on the
> -                * page
> +                * Make sure that there are no unexpected references (e.g.,
> +                * concurrent O_DIRECT). Note that while concurrent GUP-fast
> +                * could raise the refcount temporarily to grab a write
> +                * reference, it will observe the changed PTE and drop that
> +                * temporary reference again.
>                  */
>                 if (page_mapcount(page) + 1 + swapped != page_count(page)) {
>                         set_pte_at(mm, pvmw.address, pvmw.pte, entry);
> --
> 2.37.1
>
>
