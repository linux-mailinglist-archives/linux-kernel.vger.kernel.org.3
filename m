Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282D64EBB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243456AbiC3GzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbiC3Gy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:54:57 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB5B823D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:53:11 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id y142so35365866ybe.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBzSo1IuAffvd9iEt2NILMJqpADmVwfXfVQFJPM3PLI=;
        b=kAYoRpp9RINiAX6gGmakqpZiOCu0pfap3QsrG9nwA3zBT2uee70bbf3gbgO/zx5fm5
         L2WI/E+Ow+oKhG+rGP9/ELE0bdkQzMpabru264473bY1jHaI8WIjIyt03VvK30m6NUL1
         IGizFqWSH+UmjP8VQlNNu8MEjm8l/yGR9H00XMzEYy4XHLCmnnDLGVXyJ3DCF+g/lvP2
         S4SsNwg863PozI3QQtELU8kw9fsG5As/XSPI8bAzuiqkMJq24RLUd6GC0uAXrM/I6fDL
         zFxL6bjXXEIOXPrHRJFQ8NQrv2YI7rbQmF53M71mgjGIP5elWMKs0b8NOXPSiQADILbF
         HLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBzSo1IuAffvd9iEt2NILMJqpADmVwfXfVQFJPM3PLI=;
        b=uQjd3IUPbNWkhW7z3bV8FlKQNcIZAJZy9ugQbmSxNIuJQhIXvAoi1Jnb4EV5HjMTVz
         VeM1SmCYykc1GuniAWvyjcW3cMNc8Ux0W2GKjr9c627pBIRkhsONqDzuUbmby6WuYEZe
         wPfSAahZRUVX3A1dkxuoLlvxQSYKHkZnNVj/uQx2XaTyX2YwS1rKcKtu912rWIGaG3mH
         5q3SQydhIbPiRa4rNxGuhNfpOG0l+xz0CfyIOdjUJivwDDDq3EKwv6S/nyo+UIJIxHYS
         NzF/PvF9grBb0kMBUfffwUO9v5gcFetRXYRmWbMJYseXBMj5wc5avfydxqUVYO2EBfA2
         TlYw==
X-Gm-Message-State: AOAM532gSo3bcag4K32ZSuzpKsM2TVBPIdzzVe0i8mhsUStVvnDs3jtS
        YmdAx/lmXdxCDptr/IW5B363g2Mq8gNRtuGZnw9NQA==
X-Google-Smtp-Source: ABdhPJz1NmSJcW22Bmlc1MqhqmJWo3w4jKN4gY8Qemj+A1qqBdDzOs97xpu9EMhs3p8t4EeZBcqTWFKlkfcfuPlRFzE=
X-Received: by 2002:a25:c049:0:b0:634:6751:e8d2 with SMTP id
 c70-20020a25c049000000b006346751e8d2mr31868071ybf.6.1648623190862; Tue, 29
 Mar 2022 23:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220329045535.45641-1-songmuchun@bytedance.com> <CAGsJ_4w0N9GiKfZe6t+XxVUHvBOoF2Fk8tfuy5gD6Lg2s_q5iw@mail.gmail.com>
In-Reply-To: <CAGsJ_4w0N9GiKfZe6t+XxVUHvBOoF2Fk8tfuy5gD6Lg2s_q5iw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 30 Mar 2022 14:52:34 +0800
Message-ID: <CAMZfGtVOXx+tuGCtHzjnT+EXkswy1hzqwxe=W+pxZaHC5CrbmQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] arm64: mm: hugetlb: add support for free
 vmemmap pages of HugeTLB
To:     Barry Song <21cnbao@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 7:44 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Tue, Mar 29, 2022 at 5:57 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The feature of minimizing overhead of struct page associated with each
> > HugeTLB page aims to free its vmemmap pages (used as struct page) to
> > save memory, where is ~14GB/16GB per 1TB HugeTLB pages (2MB/1GB type).
> > In short, when a HugeTLB page is allocated or freed, the vmemmap array
> > representing the range associated with the page will need to be remapped.
> > When a page is allocated, vmemmap pages are freed after remapping.
> > When a page is freed, previously discarded vmemmap pages must be
> > allocated before remapping.  More implementations and details can be
> > found here [1].
> >
> > The preparation of freeing vmemmap pages associated with each HugeTLB
> > page is ready, so we can support this feature for arm64 now.  The
> > flush_dcache_page() need to be adapted to operate on the head page's
> > flags since the tail vmemmap pages are mapped with read-only after
> > the feature is enabled (clear operation is not permitted).
> >
> > There was some discussions about this in the thread [2], but there was
> > no conclusion in the end.  And I copied the concern proposed by Anshuman
> > to here.
> >
> > 1st concern:
> > '''
> > But what happens when a hot remove section's vmemmap area (which is
> > being teared down) is nearby another vmemmap area which is either created
> > or being destroyed for HugeTLB alloc/free purpose. As you mentioned
> > HugeTLB pages inside the hot remove section might be safe. But what about
> > other HugeTLB areas whose vmemmap area shares page table entries with
> > vmemmap entries for a section being hot removed ? Massive HugeTLB alloc
> > /use/free test cycle using memory just adjacent to a memory hotplug area,
> > which is always added and removed periodically, should be able to expose
> > this problem.
> > '''
> >
> > Answer: At the time memory is removed, all HugeTLB pages either have been
> > migrated away or dissolved.  So there is no race between memory hot remove
> > and free_huge_page_vmemmap().  Therefore, HugeTLB pages inside the hot
> > remove section is safe.  Let's talk your question "what about other
> > HugeTLB areas whose vmemmap area shares page table entries with vmemmap
> > entries for a section being hot removed ?", the question is not
> > established.  The minimal granularity size of hotplug memory 128MB (on
> > arm64, 4k base page), any HugeTLB smaller than 128MB is within a section,
> > then, there is no share PTE page tables between HugeTLB in this section
> > and ones in other sections and a HugeTLB page could not cross two
> > sections.  In this case, the section cannot be freed.  Any HugeTLB bigger
> > than 128MB (section size) whose vmemmap pages is an integer multiple of
> > 2MB (PMD-mapped).  As long as:
> >
> >   1) HugeTLBs are naturally aligned, power-of-two sizes
> >   2) The HugeTLB size >= the section size
> >   3) The HugeTLB size >= the vmemmap leaf mapping size
> >
> > Then a HugeTLB will not share any leaf page table entries with *anything
> > else*, but will share intermediate entries.  In this case, at the time memory
> > is removed, all HugeTLB pages either have been migrated away or dissolved.
> > So there is also no race between memory hot remove and
> > free_huge_page_vmemmap().
> >
> > 2nd concern:
> > '''
> > differently, not sure if ptdump would require any synchronization.
> >
> > Dumping an wrong value is probably okay but crashing because a page table
> > entry is being freed after ptdump acquired the pointer is bad. On arm64,
> > ptdump() is protected against hotremove via [get|put]_online_mems().
> > '''
> >
> > Answer: The ptdump should be fine since vmemmap_remap_free() only exchanges
> > PTEs or split the PMD entry (which means allocating a PTE page table).  Both
> > operations do not free any page tables (PTE), so ptdump cannot run into a
> > UAF on any page tables.  The wrost case is just dumping an wrong value.
> >
> > [1] https://lore.kernel.org/all/20210510030027.56044-1-songmuchun@bytedance.com/
> > [2] https://lore.kernel.org/all/20210518091826.36937-1-songmuchun@bytedance.com/
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> > Changes in v2:
> >  - Update commit message (Mark Rutland).
> >  - Fix flush_dcache_page().
> >
> >  arch/arm64/mm/flush.c | 14 ++++++++++++++
> >  fs/Kconfig            |  2 +-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> > index a06c6ac770d4..705484a9b9df 100644
> > --- a/arch/arm64/mm/flush.c
> > +++ b/arch/arm64/mm/flush.c
> > @@ -75,6 +75,20 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
> >   */
> >  void flush_dcache_page(struct page *page)
> >  {
> > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +       /*
> > +        * Only the head page's flags of HugeTLB can be cleared since the tail
> > +        * vmemmap pages associated with each HugeTLB page are mapped with
> > +        * read-only when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is enabled (more
> > +        * details can refer to vmemmap_remap_pte()).  Although
> > +        * __sync_icache_dcache() only set PG_dcache_clean flag on the head
> > +        * page struct, some tail page structs still can see the flag since
> > +        * the head vmemmap page frame is reused (more details can refer to
> > +        * the comments above page_fixed_fake_head()).
>
> Is this still true if hugetlb_free_vmemmap_enabled() is false?

No.  Do you think it is better to add hugetlb_free_vmemmap_enabled()
into the if block? Something like the following?

+       if (hugetlb_free_vmemmap_enabled() && PageHuge(page))
+               page = compound_head(page);

>
> btw, the subject is a bit confusing as it seems it is not bringing up
> HUGETLB_PAGE_FREE_VMEMMAP and it seems the feature
> has been already there, but we are lacking some fixes for some
> functions to make it work.

Right.

> could we explain this clear in commit
> log? maybe we need a better subject for the commit as well.

Will do.

Thanks.
