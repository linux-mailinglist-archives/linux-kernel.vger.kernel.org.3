Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA42655EB00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiF1R1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiF1R1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:27:04 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D7B3A1B1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:27:02 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id j1so12654256vsj.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhyBnAO5QNoF6w+Lsog5TuZgN4aDac8U8BguLGYhLjI=;
        b=S8APzwr+Vhh9BgpyrDN8EoZVFKgT2q0w+Qh23YJX0OKJtu8sLxD3jZG31rxdq7f503
         fRXSZTW2kMrWo1JzoRd21ArLvAEN5Oe7vAdthOKUpEDRFVkeKOxGYXlvPF+616rKbqpU
         jEA1yha7GfeElgBTHD+HW6q0QTfbGYlFGnII7QLC4Eru1tXy+4B82YAri7wnv+IGEeM9
         RM0hX8rKRtcHqZHcZNmkAD5aShH482DzlFCDcmHgfwLN2aMGg1nk0Qsm97zu5wxbKR6k
         hKecFNqXGvj0PEyhDQhCSoshBmB+7UIKBaoeeJv+XCP6hKa0dnW2bh6s7Dc6Sqq4/XcG
         LUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhyBnAO5QNoF6w+Lsog5TuZgN4aDac8U8BguLGYhLjI=;
        b=KYm+LqJDltNgSfHmaKwXQzSfPS5Qvkcs6FwXbyuHpF/0Eysxm8cBCKxuLb7hBpfe7P
         90a7YGZampyP9VxtC7lenODMz17KSUzmZu54K/W+mfCzXy+BONaJWbujaSzD0GqrQvWz
         7naFhte7bLS27gCgpsLW95rcrjBtj54oBAsrT8DUfWrfz8e9+xixdPf0YhKIH6QkgZgr
         BA455nJS3YrIjflzPbzVTSTWOr4wgac/P1N5jad4RHqC//+E4VdPslH2gUU4yqbjyQXq
         cuHA+VlQi1PMrg2xFL5iTWgheBmkl99uvqbNbbagGXFxzMtNgpJLE/fVs2JW4/6/eyrU
         Z0Ng==
X-Gm-Message-State: AJIora/XHSAlcql0ZHU90HOLO8WYt1QFTvQeiTh62vjIDFGepkmk+knr
        uU3yuj5pTUGONKN1xYHeEoVeQ9hpkXdTbShvFfga9g==
X-Google-Smtp-Source: AGRyM1v1HZYiDVEp7Bu2EbXStl1WmLdTrAmR/vKEBHl8rLxLi1E90YW5y+3EigoFHkQ8yB3rcF5EvJu58kpHOoWkHBY=
X-Received: by 2002:a67:f958:0:b0:354:3f56:8a2d with SMTP id
 u24-20020a67f958000000b003543f568a2dmr2171129vsq.59.1656437221096; Tue, 28
 Jun 2022 10:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <CAHS8izPnJd5EQjUi9cOk=03u3X1rk0PexTQZi+bEE4VMtFfksQ@mail.gmail.com> <CADrL8HWse7-=1Z=1_d8szwdkhFH1t8L4pOBO7E7yxgCYF-gc8w@mail.gmail.com>
In-Reply-To: <CADrL8HWse7-=1Z=1_d8szwdkhFH1t8L4pOBO7E7yxgCYF-gc8w@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 28 Jun 2022 10:26:49 -0700
Message-ID: <CAHS8izNSsEW88Q=ozcC2rbnmvcX3zOL-qkFTPgn=M6S1R5t=Yw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity mapping
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 9:27 AM James Houghton <jthoughton@google.com> wrote:
>
> On Fri, Jun 24, 2022 at 11:41 AM Mina Almasry <almasrymina@google.com> wrote:
> >
> > On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
> > >
> > > [trimmed...]
> > > ---- Userspace API ----
> > >
> > > This patch series introduces a single way to take advantage of
> > > high-granularity mapping: via UFFDIO_CONTINUE. UFFDIO_CONTINUE allows
> > > userspace to resolve MINOR page faults on shared VMAs.
> > >
> > > To collapse a HugeTLB address range that has been mapped with several
> > > UFFDIO_CONTINUE operations, userspace can issue MADV_COLLAPSE. We expect
> > > userspace to know when all pages (that they care about) have been fetched.
> > >
> >
> > Thanks James! Cover letter looks good. A few questions:
> >
> > Why not have the kernel collapse the hugepage once all the 4K pages
> > have been fetched automatically? It would remove the need for a new
> > userspace API, and AFACT there aren't really any cases where it is
> > beneficial to have a hugepage sharded into 4K mappings when those
> > mappings can be collapsed.
>
> The reason that we don't automatically collapse mappings is because it
> would take additional complexity, and it is less flexible. Consider
> the case of 1G pages on x86: currently, userspace can collapse the
> whole page when it's all ready, but they can also choose to collapse a
> 2M piece of it. On architectures with more supported hugepage sizes
> (e.g., arm64), userspace has even more possibilities for when to
> collapse. This likely further complicates a potential
> automatic-collapse solution. Userspace may also want to collapse the
> mapping for an entire hugepage without completely mapping the hugepage
> first (this would also be possible by issuing UFFDIO_CONTINUE on all
> the holes, though).
>

To be honest I'm don't think I'm a fan of this. I don't think this
saves complexity, but rather pushes it to the userspace. I.e. the
userspace now must track which regions are faulted in and which are
not to call MADV_COLLAPSE at the right time. Also, if the userspace
gets it wrong it may accidentally not call MADV_COLLAPSE (and not get
any hugepages) or call MADV_COLLAPSE too early and have to deal with a
storm of maybe hundreds of minor faults at once which may take too
long to resolve and may impact guest stability, yes?

For these reasons I think automatic collapsing is something that will
eventually be implemented by us or someone else, and at that point
MADV_COLLAPSE for hugetlb memory will become obsolete; i.e. this patch
is adding a userspace API that will probably need to be maintained for
perpetuity but actually is likely going to be going obsolete "soon".
For this reason I had hoped that automatic collapsing would come with
V1.

I wonder if we can have a very simple first try at automatic
collapsing for V1? I.e., can we support collapsing to the hstate size
and only that? So 4K pages can only be either collapsed to 2MB or 1G
on x86 depending on the hstate size. I think this may be not too
difficult to implement: we can have a counter similar to mapcount that
tracks how many of the subpages are mapped (subpage_mapcount). Once
all the subpages are mapped (the counter reaches a certain value),
trigger collapsing similar to hstate size MADV_COLLAPSE.

I gather that no one else reviewing this has raised this issue thus
far so it might not be a big deal and I will continue to review the
RFC, but I had hoped for automatic collapsing myself for the reasons
above.

> >
> > > ---- HugeTLB Changes ----
> > >
> > > - Mapcount
> > > The way mapcount is handled is different from the way that it was handled
> > > before. If the PUD for a hugepage is not none, a hugepage's mapcount will
> > > be increased. This scheme means that, for hugepages that aren't mapped at
> > > high granularity, their mapcounts will remain the same as what they would
> > > have been pre-HGM.
> > >
> >
> > Sorry, I didn't quite follow this. It says mapcount is handled
> > differently, but the same if the page is not mapped at high
> > granularity. Can you elaborate on how the mapcount handling will be
> > different when the page is mapped at high granularity?
>
> I guess I didn't phrase this very well. For the sake of simplicity,
> consider 1G pages on x86, typically mapped with leaf-level PUDs.
> Previously, there were two possibilities for how a hugepage was
> mapped, either it was (1) completely mapped (PUD is present and a
> leaf), or (2) it wasn't mapped (PUD is none). Now we have a third
> case, where the PUD is not none but also not a leaf (this usually
> means that the page is partially mapped). We handle this case as if
> the whole page was mapped. That is, if we partially map a hugepage
> that was previously unmapped (making the PUD point to PMDs), we
> increment its mapcount, and if we completely unmap a partially mapped
> hugepage (making the PUD none), we decrement its mapcount. If we
> collapse a non-leaf PUD to a leaf PUD, we don't change mapcount.
>
> It is possible for a PUD to be present and not a leaf (mapcount has
> been incremented) but for the page to still be unmapped: if the PMDs
> (or PTEs) underneath are all none. This case is atypical, and as of
> this RFC (without bestowing MADV_DONTNEED with HGM flexibility), I
> think it would be very difficult to get this to happen.
>

Thank you for the detailed explanation. Please add it to the cover letter.

I wonder the case "PUD present but all the PMD are none": is that a
bug? I don't understand the usefulness of that. Not a comment on this
patch but rather a curiosity.

> >
> > > - Page table walking and manipulation
> > > A new function, hugetlb_walk_to, handles walking HugeTLB page tables for
> > > high-granularity mappings. Eventually, it's possible to merge
> > > hugetlb_walk_to with huge_pte_offset and huge_pte_alloc.
> > >
> > > We keep track of HugeTLB page table entries with a new struct, hugetlb_pte.
> > > This is because we generally need to know the "size" of a PTE (previously
> > > always just huge_page_size(hstate)).
> > >
> > > For every page table manipulation function that has a huge version (e.g.
> > > huge_ptep_get and ptep_get), there is a wrapper for it (e.g.
> > > hugetlb_ptep_get).  The correct version is used depending on if a HugeTLB
> > > PTE really is "huge".
> > >
> > > - Synchronization
> > > For existing bits of HugeTLB, synchronization is unchanged. For splitting
> > > and collapsing HugeTLB PTEs, we require that the i_mmap_rw_sem is held for
> > > writing, and for doing high-granularity page table walks, we require it to
> > > be held for reading.
> > >
> > > ---- Limitations & Future Changes ----
> > >
> > > This patch series only implements high-granularity mapping for VM_SHARED
> > > VMAs.  I intend to implement enough HGM to support 4K unmapping for memory
> > > failure recovery for both shared and private mappings.
> > >
> > > The memory failure use case poses its own challenges that can be
> > > addressed, but I will do so in a separate RFC.
> > >
> > > Performance has not been heavily scrutinized with this patch series. There
> > > are places where lock contention can significantly reduce performance. This
> > > will be addressed later.
> > >
> > > The patch series, as it stands right now, is compatible with the VMEMMAP
> > > page struct optimization[3], as we do not need to modify data contained
> > > in the subpage page structs.
> > >
> > > Other omissions:
> > >  - Compatibility with userfaultfd write-protect (will be included in v1).
> > >  - Support for mremap() (will be included in v1). This looks a lot like
> > >    the support we have for fork().
> > >  - Documentation changes (will be included in v1).
> > >  - Completely ignores PMD sharing and hugepage migration (will be included
> > >    in v1).
> > >  - Implementations for architectures that don't use GENERAL_HUGETLB other
> > >    than arm64.
> > >
> > > ---- Patch Breakdown ----
> > >
> > > Patch 1     - Preliminary changes
> > > Patch 2-10  - HugeTLB HGM core changes
> > > Patch 11-13 - HugeTLB HGM page table walking functionality
> > > Patch 14-19 - HugeTLB HGM compatibility with other bits
> > > Patch 20-23 - Userfaultfd and collapse changes
> > > Patch 24-26 - arm64 support and selftests
> > >
> > > [1] This used to be called HugeTLB double mapping, a bad and confusing
> > >     name. "High-granularity mapping" is not a great name either. I am open
> > >     to better names.
> >
> > I would drop 1 extra word and do "granular mapping", as in the mapping
> > is more granular than what it normally is (2MB/1G, etc).
>
> Noted. :)
