Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0857B5908D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbiHKXAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKXAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:00:07 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF759F0D7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:00:05 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id m67so19697569vsc.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=27PgIpqf/7IrKXemxCZ0QU4yOMIMu6eeW8/O/aowK08=;
        b=sbHc6PYTA1u3Vdj4XX/DprcMwSPQrCYVachJlRFTyu6wHb27JeSZlni2sXrwGwbsXw
         zuCHJolXIxsiCycfLERmcvUUPuSg27+fSFe6UIaFPaSChYUPJS8XNBtd+Yd4gWXUAL1f
         GrkvwwItrIQ2PBUPiWRJvY6GmnPh1OsP1LD0ZXdd4/tbaeU6XScVXpkzFt3Dw4pEYct+
         2zQtSA5zONpzWvS2AQCiXpAwFAzmOOm/xRlgSUEGQ/+uWCaPia+PgNFoNs6O5CGFur14
         bKHMcavso3hScUezz0KZzPck1tG7KTHRVzwXULJxak7QFkBEzDxypTRGzGj3Gl5G8RHy
         Wbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=27PgIpqf/7IrKXemxCZ0QU4yOMIMu6eeW8/O/aowK08=;
        b=mFf3isSIxi08wR3im1oW1cXIEyB/gfwzJErEc70x/Q197jBu4Wq5gEMS+EI7wHKuHD
         CSPxXxL3TGL9gBZzaEJDBdV5eHw/mcyAt+nqYT+bglhFls0P5UfQSyJ/cZcuOYqesnwE
         37z5sFQ20UXMFzQXajYiH3JuYyAWiCeqD93wyNmnXbY2iSjrGshEWsEWDahAI42nM1i3
         IE0MUHlnRt+96m8owVpEJvItr8l/5Gj/yFIJL23So6htuksRvQBgAjS5wOt18NBIrTyZ
         qq5C7B2hoBQ6VXd9R/M/U0/qZl13P+0CaUNGaDgijboiGdcjBsMmwv38YdqvFZztv0wx
         sXvw==
X-Gm-Message-State: ACgBeo05kCRuzUcGIr1OQiAKMOAc9uuGbTDQj83VoShVmK6O+Evo94c2
        Ag0yT4AphiCZS2zoZ82T1zEJIhXGqwLOlyOXL9SbCg==
X-Google-Smtp-Source: AA6agR7a2DO3sohlbvRF9brUBNPB25FG43m/e3hhC0YToCad8gXlqFDldrUSQF25PdAXWJI/pgaQP6Z6QM8buxbzwjA=
X-Received: by 2002:a05:6102:5094:b0:388:6903:5f09 with SMTP id
 bl20-20020a056102509400b0038869035f09mr742614vsb.46.1660258804465; Thu, 11
 Aug 2022 16:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220805184016.2926168-1-alexlzhu@fb.com> <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com> <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com> <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com> <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
 <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com> <CAOUHufbGcuvJ8EfBkWrdCgeMCiceP0SxHZzcJnOt1Mw0P2w9kw@mail.gmail.com>
 <CAHbLzkqGq6LDDSCcFTJW9_O8dfAMje8_W6ddpDP9ESDQWUb07w@mail.gmail.com>
 <F28E23D0-C635-4A49-91EE-100AAA8C9EAD@fb.com> <CAOUHufYeuMN9As58BVwMKSN6viOZKReXNeCBgGeeL6ToWGsEKw@mail.gmail.com>
 <868F0874-70E8-4416-B39B-DA74C9D76A40@fb.com> <CAOUHufas1o1Ez9EDSjjxsO-w6Ph6Km8R8yOX+1_c=4LvG6DEWw@mail.gmail.com>
 <DD679B3A-BDF7-4EBD-AAC2-A663057AC8E3@fb.com> <CAOUHufbD-9PpQ+kuD=-8z-ptsrprjyThpkFe+4_NtFnzAjDG9g@mail.gmail.com>
 <DEB2F4F2-7F62-48F0-914D-5F71BFDBCBEE@fb.com> <3195C304-2140-4E5D-890D-AC55653193E5@fb.com>
 <CAOUHufaggjiYAywB646N5Rj48eSJDjir8oLwDVu039ymbLm0PA@mail.gmail.com> <CAHbLzkpRVOOGK2d0L25A4PKfEbHngm-WEWWH34UYVg1O40Tiig@mail.gmail.com>
In-Reply-To: <CAHbLzkpRVOOGK2d0L25A4PKfEbHngm-WEWWH34UYVg1O40Tiig@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 11 Aug 2022 16:59:28 -0600
Message-ID: <CAOUHufaqV1diQ8W1omcxMoMcbgEjR7n3MJct=-v=dPttx20KMA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to /proc/thp_utilization
To:     Yang Shi <shy828301@gmail.com>
Cc:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>, Rik van Riel <riel@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ning Zhang <ningzhang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 11, 2022 at 4:12 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Aug 11, 2022 at 2:55 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Thu, Aug 11, 2022 at 1:20 PM Alex Zhu (Kernel) <alexlzhu@fb.com> wro=
te:
> > >
> > > Hi Yu,
> > >
> > > I=E2=80=99ve updated your patch set from last year to work with folio=
 and am testing it now. The functionality in split_huge_page() is the same =
as what I have. Was there any follow up work done later?
> >
> > Yes, but it won't change the landscape any time soon (see below). So
> > please feel free to continue along your current direction.
> >
> > > If not, I would like to incorporate this into what I have, and then r=
esubmit. Will reference the original patchset. We need this functionality f=
or the shrinker, but even the changes to split_huge_page() by itself it sho=
uld show some performance improvement when used by the existing deferred_sp=
lit_huge_page().
> >
> > SGTM. Thanks!
> >
> > A side note:
> >
> > I'm working on a new mode: THP=3Dauto, meaning the kernel will detect
> > internal fragmentation of 2MB compound pages to decide whether to map
> > them by PMDs or split them under memory pressure. The general workflow
> > of this new mode is as follows.
>
> I tend to agree that avoiding allocating THP in the first place is the
> preferred way to avoid internal fragmentation. But I got some
> questions about your design/implementation:
>
> >
> > In the page fault path:
> > 1. Compound pages are allocated as usual.
> > 2. Each is mapped by 512 consecutive PTEs rather than a PMD.
> > 3. There will be more TLB misses but the same number of page faults.
> > 4. TLB coalescing can mitigate the performance degradation.
>
> Why not just allocate base pages in the first place? Khugepaged has
> max_pte_none tunable to detect internal fragmentation. If you worry
> about zero page, you could add max_pte_zero tunable.
>
> Or did you investigate whether the new MADV_COLLAPSE may be helpful or
> not? It leaves the decision to the userspace.

There are two problems we have to workaround.
1. External fragmentation that prevents later compound page allocations.
2. The cost of taking mmap_lock for write.

IIRC, the first reference I listed describes the first problem. (It
uses a similar reservation technique.) From a very high level, smaller
page allocations add more entropy than larger ones and accelerate the
system toward equilibrium, in which state the system can't allocate
more THPs without exerting additional force (compaction).

Reserving compound pages delays the equilibrium whereas MADV_COLLAPSE
tries to reverse the equilibrium. The latter has a higher cost. In
addition, it needs to take mmap_lock for write.

> > In khugepaged:
> > 1. Check the dirty bit in the PTEs mapping a compound page, to
> > determine its utilization.
> > 2. Remap compound pages that meet a certain utilization threshold by
> > PMDs in place, i.e., no migrations.
> >
> > In the reclaim path, e.g., MGLRU page table scanning:
> > 1. Decide whether compound pages mapped by PTEs should be split based
> > on their utilizations and memory pressure, e.g., reclaim priority.
> > 2. Clean subpages should be freed directly after split, rather than swa=
pped out.
> >
> > N.B.
> > 1. This workflow relies on the dirty bit rather examining the content o=
f a page.
> > 2. Sampling can be done by periodically switching between a PMD and
> > 512 consecutive PTEs.
> > 3. It only needs to hold mmap_lock for read because this special mode
> > (512 consecutive PTEs) is not considered the split mode.
> > 4. Don't hold your breath :)
> >
> > Other references:
> > 1. https://www.usenix.org/system/files/atc20-zhu-weixi_0.pdf
> > 2. https://www.usenix.org/system/files/osdi21-hunter.pdf
