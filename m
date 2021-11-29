Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3A4625F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhK2Woj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbhK2WoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:44:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3A3C0613A1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 13:32:55 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z5so12605150edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 13:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwtF+dlsYEMFu/RdZEresGPLO87mGYT5bh+/vwDanTQ=;
        b=jXuZO4/4sykyu54pdbVOcUUUAVu+gybxVefUtoOwvDZsorj8pK2djM6CPHIEWHQm4+
         V6bVtNIsee71GrNGp+Elde5LIkzkmw10SWZHEOmIyr7j8dTMHjyaAxz9wvEPFouBUemM
         /nWWNgDZCtZAhbMA1CqXRAwNAkpjKAPTR1WXga1bSJSNPkqA96OdzJC05pq6zYfc3kMu
         kdYr62PwbkvYdkt7IzrLp76RLw+WkMYvwHJPAprmHkH1tFQPsC3M2kDYE4RAPxEvvoio
         Fs4M5Css8NfOy+BBqGyf4fEe7FzXwJPHwk/jdS/IS9363a6WiVAJV1UzgaQAFPai84Vg
         CoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwtF+dlsYEMFu/RdZEresGPLO87mGYT5bh+/vwDanTQ=;
        b=NWTFqygRsYRT6utPJebUdRXAHK2L983RVkfftGqS3ySX0YDN+h2OLRTDI0m1RkBuSd
         rUyJijtEj7DS+6J2krXgDZjuRInpS89uAb91KTywaXME/JwBPhaP2vWQWgSvx17LU7D1
         FcNAQJxUarWg/tCyHs43gu2VOGm/aLPtbPZzKwSG8o1nHIfmipuLpUulpO3y9S6xitUn
         ijDoH0M/Hpp/+jPFgMCKLsxHGPPUygRg47Ajblry46b07/qO0YT6maDrS0fuhNAGiapX
         X4H1OcWA4wvL4wWaTszUsOLjn7E6iCQIFovH1Flwlj6tjZIHtZT9vurUhvxwzELQsXNl
         G+Xg==
X-Gm-Message-State: AOAM532TxPv1mcElHtDA17u0CRc3S2r9Fy1GRO1dZFnDsFbeAu6375gb
        Qxe6UMF4SmALo1RTBvZA44CZE8pB54fvC0hFADoKFyPp
X-Google-Smtp-Source: ABdhPJwvdxDHNEeaqwebCGk4wW8gYa8Lc/keXv5k24bjWnuQgJIG5d2O5/yrYVG7KCIrG5nwVcwGRvoFxFtWAhx4Bkk=
X-Received: by 2002:a17:907:1dd5:: with SMTP id og21mr64782841ejc.233.1638221574076;
 Mon, 29 Nov 2021 13:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20211120201230.920082-1-shakeelb@google.com> <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <YZ9kUD5AG6inbUEg@xz-m1.local> <CALvZod7L5Ga2xZOy_hgocsTxSuOYs840TiviOAhRwz59ATubWg@mail.gmail.com>
 <YaBevbuNuR+ToJ1o@xz-m1.local> <f464115b-f332-9f13-89c4-81bf6b282975@redhat.com>
In-Reply-To: <f464115b-f332-9f13-89c4-81bf6b282975@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 29 Nov 2021 13:32:41 -0800
Message-ID: <CAHbLzkoP-YTf_=OKatGbVosm6PPGT9TnY1g8_E4v4X5GE_m6HQ@mail.gmail.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Shakeel Butt <shakeelb@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 1:17 AM David Hildenbrand <david@redhat.com> wrote:
>
> >>
> >> Thanks for making me rerun this and yes indeed I had a very silly bug in the
> >> benchmark code (i.e. madvise the same page for the whole loop) and this is
> >> indeed several times slower than without the patch (sorry David for misleading
> >> you).
>
> No worries, BUGs happen :)
>
> >>
> >> To better understand what is happening, I profiled the benchmark:
> >>
> >> -   31.27%     0.01%  dontneed  [kernel.kallsyms]  [k] zap_page_range_sync
> >>    - 31.27% zap_page_range_sync
> >>       - 30.25% split_local_deferred_list
> >>          - 30.16% split_huge_page_to_list
> >>             - 21.05% try_to_migrate
> >>                + rmap_walk_anon
> >>             - 7.47% remove_migration_ptes
> >>                + 7.34% rmap_walk_locked
> >>       + 1.02% zap_page_range_details
> >
> > Makes sense, thanks for verifying it, Shakeel.  I forgot it'll also walk
> > itself.
> >
> > I believe this effect will be exaggerated when the mapping is shared,
> > e.g. shmem file thp between processes.  What's worse is that when one process
> > DONTNEED one 4k page, all the rest mms will need to split the huge pmd without
> > even being noticed, so that's a direct suffer from perf degrade.
>
> Would this really apply to MADV_DONTNEED on shmem, and would deferred
> splitting apply on shmem? I'm constantly confused about shmem vs. anon,
> but I would have assumed that shmem is fd-based and we wouldn't end up
> in rmap_walk_anon. For shmem, the pagecache would contain the THP which
> would stick around and deferred splits don't even apply.

The deferred split is anon THP only, it doesn't apply to shmem THP.

For the rmap walk, there are two ramp walks for anon THP, but just one
for shmem THP. Both needs one rmap walk to unmap the THP before doing
actual split, but anon THP needs another rmap walk to reinstall PTEs
for still mapped pages, however this is not needed for shmem pages
since they could be reached via page cache.

>
> But again, I'm constantly confused so I'd love to be enlighted.
>
> >
> >>
> >> The overhead is not due to copying page flags but rather due to two rmap walks.
> >> I don't think this much overhead is justified for current users of MADV_DONTNEED
> >> and munmap. I have to rethink the approach.
>
> Most probably not.
>
> >
> > Some side notes: I digged out the old MADV_COLLAPSE proposal right after I
> > thought about MADV_SPLIT (or any of its variance):
> >
> > https://lore.kernel.org/all/d098c392-273a-36a4-1a29-59731cdf5d3d@google.com/
> >
> > My memory was that there's some issue to be solved so that was blocked, however
> > when I read the thread it sounds like the list was mostly reaching a consensus
> > on considering MADV_COLLAPSE being beneficial.  Still copying DavidR in case I
> > missed something important.
> >
> > If we think MADV_COLLAPSE can help to implement an userspace (and more
> > importantly, data-aware) khugepaged, then MADV_SPLIT can be the other side of
> > kcompactd, perhaps.
> >
> > That's probably a bit off topic of this specific discussion on the specific use
> > case, but so far it seems all reasonable and discussable.
>
> User space can trigger a split manually using some MADV hackery. But it
> can only be used for the use case here, where we actually want to zap a
> page.
>
> 1. MADV_FREE a single 4k page in the range. This will split the PMD->PTE
>    and the compound page.
> 2. MADV_DONTNEED either the complete range or the single 4k page.
>
> --
> Thanks,
>
> David / dhildenb
>
