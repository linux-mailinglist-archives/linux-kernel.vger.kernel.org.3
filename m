Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D894E6028
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348880AbiCXIPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348852AbiCXIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:15:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011BA6D3B9;
        Thu, 24 Mar 2022 01:14:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k10so4692018edj.2;
        Thu, 24 Mar 2022 01:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etzSqv0/9aE5pl3dptR4Y8mgC5YpOiktHoANWy6nVdw=;
        b=Hc7dpeqOaV8CbCzshfeBcroqqi9BWzXZNnC75s6jVj4ou7A/Az8JJZcWxp9eXEaPJ2
         DLQecJ3yjC64JAw39a3YrNXqEFckso4ovxJ0+w5xoMWAE+2H+O07V6akUaLfbRNNmIQg
         H2J1URluwCxdDV05AQ5GAkvCo71xyKd3D21tTUK87RVYfmG7CVBtdGOwXYDrgu+m3sJU
         iEkbSMfx2q3Py7p1y3ieK7GpQao70xTEEzmoUDttUWEq744IaIc/w6DCFylRiV3u2BsC
         QtVEwXhrqauOPnOsrmMmE8mKu0GmUa3pfGX8cUlIJBBbjJfAoWXIuyUNWAwxTLB+UjnA
         Dx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etzSqv0/9aE5pl3dptR4Y8mgC5YpOiktHoANWy6nVdw=;
        b=l5D1h4nIzphQMrdi4oObgwyLCGVDj21cq4L+IVGSjn++JvxWi2ly75/DCpeYjr7Kf4
         7YsC+rIXxXBjVUkL+XX/SgAjmIQUVsZdSojAPARuK+ytAElH6q3aweBa7EHvlUOVrh9x
         +TrPhhVttHeab/NSPYwOOB/6ZKpt9rXIocCkBHdQTalylAR+3bFPis2Ajd+Q1PkXuCgK
         12KLxFCaG63KyTxR6DPl/806khoO95mhi5+E8w1HqKT4cVTpZxz7L/aJToVAZW4NwL/v
         OduxESOVdIGxpfYAoa5VPpez92hOz7lbozXDFYZVx2DohkLy/RXotnyG0pktodLJ/UZA
         IaqA==
X-Gm-Message-State: AOAM531lqP/rOLKx6PgMR/q0/Dm3eLoZfHbAp3mI4heuG22sQBHBTSqq
        yKPNruIfrP5Pq9Tji8I8W6mpo7lCSavbutTDVfA=
X-Google-Smtp-Source: ABdhPJxB9yM2gtllAWM/wn6zYLnJI+r0tWFlQ5gSs9AFZo0W3max2hZtxlTeTG9Es8ssycmuut12zhjOu6WdRn5durE=
X-Received: by 2002:a50:fe0d:0:b0:415:e2ee:65af with SMTP id
 f13-20020a50fe0d000000b00415e2ee65afmr5075480edt.383.1648109642312; Thu, 24
 Mar 2022 01:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-7-yuzhao@google.com>
 <CAGsJ_4xfL7h6M92WGusxbTxQzHOJDj4X4AuC=0HgrEyAYJaJFg@mail.gmail.com>
 <CAOUHufbiSShp=khZFL6BmJKNNkG-LBrsPoLwYxewcgtZhi5tFg@mail.gmail.com>
 <CAGsJ_4zeNtAsq7E9SKVwuKaXnKj80BP2NPHdjtd1i=098M6eDw@mail.gmail.com> <CAOUHufazsjhp3GzV7QFOqEeG98zJyRWd+HocyYR1FP3nk-Ho0Q@mail.gmail.com>
In-Reply-To: <CAOUHufazsjhp3GzV7QFOqEeG98zJyRWd+HocyYR1FP3nk-Ho0Q@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 24 Mar 2022 21:13:48 +1300
Message-ID: <CAGsJ_4y=TkCGoWWtWSAptW4RDFUEBeYXwfwu=fUFvV4Sa4VA4A@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] mm: multi-gen LRU: minimal implementation
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 7:24 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Mar 23, 2022 at 1:47 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Sat, Mar 19, 2022 at 4:11 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Fri, Mar 18, 2022 at 9:01 PM Barry Song <21cnbao@gmail.com> wrote:
> > > >
> > > > > +static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
> > > > > +{
> > > > > +       unsigned long old_flags, new_flags;
> > > > > +       int type = folio_is_file_lru(folio);
> > > > > +       struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > > > > +       int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
> > > > > +
> > > > > +       do {
> > > > > +               new_flags = old_flags = READ_ONCE(folio->flags);
> > > > > +               VM_BUG_ON_FOLIO(!(new_flags & LRU_GEN_MASK), folio);
> > > > > +
> > > > > +               new_gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > > > > +               new_gen = (old_gen + 1) % MAX_NR_GENS;
> > > >
> > > > new_gen is assigned twice, i assume you mean
> > > >                old_gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > > >                new_gen = (old_gen + 1) % MAX_NR_GENS;
> > > >
> > > > or do you always mean new_gen =  lru_gen_from_seq(min_seq) + 1?
> > >
> > > Thanks a lot for your attention to details!
> > >
> > > The first line should be in the next patch but I overlooked during the
> > > last refactoring:
> >
> > Thanks for the clarification. So an unmapped file-backed page which is
> > accessed only by system call will always be in either min_seq or
> > min_seq + 1? it has no chance to be in max_seq like a faulted-in
> > mapped file page?
>
> That's right. The rationale is documented here under the `Assumptions`
> section [1]. This is also related to Aneesh's question about why MGLRU
> doesn't need additional heuristics for VM_EXEC pages [2]. Unmapped
> file pages weaken the protection of executable pages under heavy
> buffered IO workloads like Java NIO.

ok. This is probably right.
i will also run a test by maltreating unmapped page in vanilla LRU, the
PoC code is like (not been tested yet):

Subject: [PATCH 1/1] mm: vmscan: maltreat unmapped file-backed pages

[This patch has not been tested yet.]

A lesson we learned from MGLRU is that mapped filed-backed pages
are much more important than unmapped ones.
So this patch doesn't move the second accessed unmapped pages to
the active list, alternatively, it keeps the pages in the inactive
list. And we abuse PG_workingset to let the memory reclaim this
is a relatively hot file-backed page, so the reclaim should keep
the pages in the inactive list.

---
 mm/swap.c   | 34 ++++++++++++++++++++++------------
 mm/vmscan.c |  6 ++++--
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index e65e7520bebf..cb0c6e704f2e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -470,18 +470,28 @@ void folio_mark_accessed(struct folio *folio)
  * evictable page accessed has no effect.
  */
  } else if (!folio_test_active(folio)) {
- /*
- * If the page is on the LRU, queue it for activation via
- * lru_pvecs.activate_page. Otherwise, assume the page is on a
- * pagevec, mark it active and it'll be moved to the active
- * LRU on the next drain.
- */
- if (folio_test_lru(folio))
- folio_activate(folio);
- else
- __lru_cache_activate_folio(folio);
- folio_clear_referenced(folio);
- workingset_activation(folio);
+ if (folio_mapped(folio)) {
+ /*
+ * If the mapped page is on the LRU, queue it for activation via
+ * lru_pvecs.activate_page. Otherwise, assume the page is on a
+ * pagevec, mark it active and it'll be moved to the active
+ * LRU on the next drain.
+ */
+ if (folio_test_lru(folio))
+ folio_activate(folio);
+ else
+ __lru_cache_activate_folio(folio);
+ folio_clear_referenced(folio);
+ workingset_activation(folio);
+ } else {
+ /*
+ * we maltreat unmmaped file-backed pages and abuse PG_workingset
+ * flag to let the eviction know this page is a relatively hot file
+ * page, thus, the eviction can move it back to the head of the
+ * inactive list
+ */
+ folio_set_workingset(folio);
+ }
  }
  if (folio_test_idle(folio))
  folio_clear_idle(folio);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d6f3c9812f97..56a66eb4a3f7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1393,12 +1393,14 @@ enum page_references {
 static enum page_references page_check_references(struct page *page,
    struct scan_control *sc)
 {
- int referenced_ptes, referenced_page;
+ int referenced_ptes, referenced_page, workingset;
  unsigned long vm_flags;

  referenced_ptes = page_referenced(page, 1, sc->target_mem_cgroup,
    &vm_flags);
  referenced_page = TestClearPageReferenced(page);
+ workingset = page_is_file_lru(page) && !page_mapped(page) &&
+ TestClearPageWorkingset(page);

  /*
  * Mlock lost the isolation race with us.  Let try_to_unmap()
@@ -1438,7 +1440,7 @@ static enum page_references
page_check_references(struct page *page,

  /* Reclaim if clean, defer dirty pages to writeback */
  if (referenced_page && !PageSwapBacked(page))
- return PAGEREF_RECLAIM_CLEAN;
+ return workingset ?  PAGEREF_KEEP : PAGEREF_RECLAIM_CLEAN;

  return PAGEREF_RECLAIM;
 }

>
> [1] https://lore.kernel.org/linux-mm/20220309021230.721028-15-yuzhao@google.com/
> [2] https://lore.kernel.org/linux-mm/CAOUHufYfpiGdLSdffvzDqaD5oYFG99oDJ2xgQd2Ph77OFR5NAA@mail.gmail.com/

Thanks
Barry
