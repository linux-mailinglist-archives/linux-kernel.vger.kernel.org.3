Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A234D0838
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbiCGUSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbiCGUSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:18:42 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C1713F77
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:17:46 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o26so14520791pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IE33MNFmcLiUfT2SeIR7Z5A5TrPI+9cgpazyT5PX0I0=;
        b=eOE+cxc6Xuwvo/+Q/JI3RL1AAJ0ynlHNo7aZOoZlcDphD//vTauuwndlbyD+2auxNi
         8dF4w1Qgur+7hWFsJRzL3svUsN/5W6WURdwEbGeoF9IGq9/IpR1XpliFS3DACsmNVnTD
         DjazJfNsoCwKbjLF48asNgmK92mT8btEb01LqyW63vHlXS2q6bdR/0xI1kT7PehWFjUR
         jJ1CnyX6GzJqXWKvppEt/vuX/+Zw6Cp3O6gnUTDZp1tk+myp6mww0FksXYQguRzRsej/
         S6adSSbrjdYeEi3JJyPQV/N6BqkK4aPX2NiUb4vJuzr8aja4HBNx+4N+Ja2rGKY0D3Nq
         vxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IE33MNFmcLiUfT2SeIR7Z5A5TrPI+9cgpazyT5PX0I0=;
        b=zLv0yy5vGf+1UctmNOyLAz6F/m9u+4QawiBM0WysVxrijatzfvOJ1Yr3b+pe0hBK78
         Nm33XFtE9I+z5OCW3ApNwLA7Pi4UH484Izbg7aULQbJFgx1TClRX+xjc1shuyE4AyUlv
         nZT4RDKhulyOKYdPWiXxWmSRIIAHsim0AxlqAMTXGHtt6GwqtmhdaFiTtIHlvqQ7C5hO
         p8+LeMtL6u651R6yg3m1ZPHSGBJwP5HxjQIMwPuBrRZiINsa9epWz1X98wl5dGYpXOHJ
         lIL2/rz7q0IUGV0WIfjJKxhN9ieBIfBgvKg37lbxYmxySD/cw0PQncoqgLxgvyeG95aX
         lxoQ==
X-Gm-Message-State: AOAM530ngx44NfGQz/JbMsFDL1lPnEGKD+TAfI5nlkzn+DHRueBVJ2PS
        pi/SnwaZTzT8vhek1+201sWQHi6+sFSOtJKeEYA=
X-Google-Smtp-Source: ABdhPJwKfUQp7AdXNaIKZ0xvrWClL+7EBzqrC5z1DqpF0HBrOa+twOzmmANBNj4/M2wVkJ9NkWyQzngBA5G47/dcsvE=
X-Received: by 2002:a63:571e:0:b0:378:9f08:129b with SMTP id
 l30-20020a63571e000000b003789f08129bmr11170307pgb.75.1646684266434; Mon, 07
 Mar 2022 12:17:46 -0800 (PST)
MIME-Version: 1.0
References: <351df0af-78f2-c20-2a6d-e5f978e5ca1@google.com>
 <a2f6aa01-8003-6791-718d-3898f77ef643@redhat.com> <9dda55d5-eafa-3177-2a4c-32ccb7e146e3@google.com>
 <90aafe84-fe7d-c70e-8e15-c222869f30fc@redhat.com> <6e5262ff-8596-a86-7388-eddb2b2c53c@google.com>
 <3eafa969-5b1a-accf-88fe-318784c791a@google.com>
In-Reply-To: <3eafa969-5b1a-accf-88fe-318784c791a@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Mar 2022 12:17:34 -0800
Message-ID: <CAHbLzkprkQM3g8R_1EYSR07y-NZdRA-Kh=BJa_mMxAL91P8XUg@mail.gmail.com>
Subject: Re: [PATCH mmotm v2] mm: delete __ClearPageWaiters()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
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

On Fri, Mar 4, 2022 at 1:25 PM Hugh Dickins <hughd@google.com> wrote:
>
> The PG_waiters bit is not included in PAGE_FLAGS_CHECK_AT_FREE, and
> vmscan.c's free_unref_page_list() callers rely on that not to generate
> bad_page() alerts.  So __page_cache_release(), put_pages_list() and
> release_pages() (and presumably copy-and-pasted free_zone_device_page())
> are redundant and misleading to make a special point of clearing it (as
> the "__" implies, it could only safely be used on the freeing path).
>
> Delete __ClearPageWaiters().  Remark on this in one of the "possible"
> comments in folio_wake_bit(), and delete the superfluous comments.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Tested-by: Yu Zhao <yuzhao@google.com>
> ---
> v2: Add Tested-by from Yu Zhao.
>     Update to latest function names in the commit message.
>     Reword comment in folio_wake_bit() per David Hildenbrand.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
>  include/linux/page-flags.h |  2 +-
>  mm/filemap.c               | 23 ++++++++---------------
>  mm/memremap.c              |  2 --
>  mm/swap.c                  |  4 ----
>  4 files changed, 9 insertions(+), 22 deletions(-)
>
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -481,7 +481,7 @@ static unsigned long *folio_flags(struct folio *folio, unsigned n)
>         TESTSETFLAG_FALSE(uname, lname) TESTCLEARFLAG_FALSE(uname, lname)
>
>  __PAGEFLAG(Locked, locked, PF_NO_TAIL)
> -PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
> +PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
>  PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)
>  PAGEFLAG(Referenced, referenced, PF_HEAD)
>         TESTCLEARFLAG(Referenced, referenced, PF_HEAD)
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1179,24 +1179,17 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
>         }
>
>         /*
> -        * It is possible for other pages to have collided on the waitqueue
> -        * hash, so in that case check for a page match. That prevents a long-
> -        * term waiter
> +        * It's possible to miss clearing waiters here, when we woke our page
> +        * waiters, but the hashed waitqueue has waiters for other pages on it.
> +        * That's okay, it's a rare case. The next waker will clear it.
>          *
> -        * It is still possible to miss a case here, when we woke page waiters
> -        * and removed them from the waitqueue, but there are still other
> -        * page waiters.
> +        * Note that, depending on the page pool (buddy, hugetlb, ZONE_DEVICE,
> +        * other), the flag may be cleared in the course of freeing the page;
> +        * but that is not required for correctness.
>          */
> -       if (!waitqueue_active(q) || !key.page_match) {
> +       if (!waitqueue_active(q) || !key.page_match)
>                 folio_clear_waiters(folio);
> -               /*
> -                * It's possible to miss clearing Waiters here, when we woke
> -                * our page waiters, but the hashed waitqueue has waiters for
> -                * other pages on it.
> -                *
> -                * That's okay, it's a rare case. The next waker will clear it.
> -                */
> -       }
> +
>         spin_unlock_irqrestore(&q->lock, flags);
>  }
>
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -487,8 +487,6 @@ void free_zone_device_page(struct page *page)
>         if (WARN_ON_ONCE(!page->pgmap->ops || !page->pgmap->ops->page_free))
>                 return;
>
> -       __ClearPageWaiters(page);
> -
>         mem_cgroup_uncharge(page_folio(page));
>
>         /*
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -97,7 +97,6 @@ static void __page_cache_release(struct page *page)
>                 mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
>                 count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
>         }
> -       __ClearPageWaiters(page);
>  }
>
>  static void __put_single_page(struct page *page)
> @@ -152,7 +151,6 @@ void put_pages_list(struct list_head *pages)
>                         continue;
>                 }
>                 /* Cannot be PageLRU because it's passed to us using the lru */
> -               __ClearPageWaiters(page);
>         }
>
>         free_unref_page_list(pages);
> @@ -966,8 +964,6 @@ void release_pages(struct page **pages, int nr)
>                         count_vm_event(UNEVICTABLE_PGCLEARED);
>                 }
>
> -               __ClearPageWaiters(page);
> -
>                 list_add(&page->lru, &pages_to_free);
>         }
>         if (lruvec)
