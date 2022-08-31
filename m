Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5725A88E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiHaWS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHaWSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:18:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7985FE992A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:18:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso612810pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zyw/eC7l+o0wMdEAj5KqnO8fiNMT30lG6RjAzbV/PlI=;
        b=D7USHTEKx2MfvljGpX6xGf2pTM5VkJjMsd3VggokKrV1LeFyRXxiWRO4COzTDubFMG
         er0g1EidEOBeT5cqmSI8NUvo95w32KuI/0Lhnu6fF25hgEq0qgxrH2UdKg6H12iHeLAf
         TrzBt0cxLfZ8kgKA8OzYFt4SpcyQKjmEdN+6moy7ptNHJ05v8TwNlFOrt0ZxrvoqK85B
         Fy5zQaBZjQQfLWZJUI0KRXG0pofaL1+qwZzgnPQMEWxbFAYCEhrcTHllCA1gHqAywr2v
         mEFKY0B5FOqEJ8K6P4obm6ZpzWA2URDg9744QYiK96Zs0dafADtYrGNENu7mcXXvnY1H
         Fdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zyw/eC7l+o0wMdEAj5KqnO8fiNMT30lG6RjAzbV/PlI=;
        b=kYI7AWGlYP//FAbMkVIgLnJo2THIfwodJzK4ku5CqsUm6PEcFC6G62ekuMnPiCqbSq
         tcoTdDFe3vZLjhEZXi1ZDs/TmpIhfY/As0bG/dmJREO2qWFOjJVm218j7okiYCzCbBtT
         pYL0ZBi9oZ7usci54l9DzWaafCgQilF+VyFxRPEnFLyqVPq5IIlczGoe819OJ2PqQvZa
         xyuD8UGV1ezVX7PcuXScEj3MU1rxXIEm6PzzJelTFoNS/vXS0fEiHQBpgqEhGdcOvFpe
         yRGjZBn0i/KLRAPrkSxTDoEL0NmFqsn/s1S4gm+YsDxMkJ8k9K9hR6IQLwUKLoLamdn9
         hYGQ==
X-Gm-Message-State: ACgBeo2Wj2m7rvO50zF1tc0g4I70QeSgDidhq3+GU778m54AmhrCtf0f
        bTX7kz/UnU3RTDGb23H7UusilnIHrqJ706Ii0Rs=
X-Google-Smtp-Source: AA6agR6mmpBDP7RNimLqgx2iOpt52CKVLdlqOaNx9iqhiZbQ3acLhnOkYWzujon4aia2O8hVvJiDZ0C3gmtMf8BZ834=
X-Received: by 2002:a17:90b:1b49:b0:1fd:dccc:91f7 with SMTP id
 nv9-20020a17090b1b4900b001fddccc91f7mr5332349pjb.200.1661984333042; Wed, 31
 Aug 2022 15:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220831083024.37138-1-david@redhat.com> <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <4845ae71-b7dd-1707-ebc3-2eb3521e7fa0@redhat.com> <CAHbLzkoMMWAgai2bvgu7y5EAcKOhhx3gK+OA4v2+kOHBW4cauw@mail.gmail.com>
 <ab41f458-eb0f-5edb-ccab-643bf00d5110@redhat.com> <CAHbLzkpFqSBTv3HVye4UCKj93NPW8VRqCGZO1p5hk_wfNA_GtQ@mail.gmail.com>
 <94c3217d-df73-2b6b-21f0-95baf117c584@redhat.com> <CAHbLzkp+HNmz7hGS5uDrfDDW0HpSj5Z+xmmkRbwvgn1qYk8Btg@mail.gmail.com>
In-Reply-To: <CAHbLzkp+HNmz7hGS5uDrfDDW0HpSj5Z+xmmkRbwvgn1qYk8Btg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 31 Aug 2022 15:18:40 -0700
Message-ID: <CAHbLzkqM5qj7AZRpeCemsA56oKuHo2T51chTbh1pkGrr0wRFDQ@mail.gmail.com>
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

On Wed, Aug 31, 2022 at 12:43 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Aug 31, 2022 at 12:36 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 31.08.22 21:34, Yang Shi wrote:
> > > On Wed, Aug 31, 2022 at 12:15 PM David Hildenbrand <david@redhat.com> wrote:
> > >>
> > >> On 31.08.22 21:08, Yang Shi wrote:
> > >>> On Wed, Aug 31, 2022 at 11:29 AM David Hildenbrand <david@redhat.com> wrote:
> > >>>>
> > >>>> On 31.08.22 19:55, Yang Shi wrote:
> > >>>>> On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
> > >>>>>>
> > >>>>>> The comment is stale, because a TLB flush is no longer sufficient and
> > >>>>>> required to synchronize against concurrent GUP-fast. This used to be true
> > >>>>>> in the past, whereby a TLB flush would have implied an IPI on architectures
> > >>>>>> that support GUP-fast, resulting in GUP-fast that disables local interrupts
> > >>>>>> from completing before completing the flush.
> > >>>>>
> > >>>>> Hmm... it seems there might be problem for THP collapse IIUC. THP
> > >>>>> collapse clears and flushes pmd before doing anything on pte and
> > >>>>> relies on interrupt disable of fast GUP to serialize against fast GUP.
> > >>>>> But if TLB flush is no longer sufficient, then we may run into the
> > >>>>> below race IIUC:
> > >>>>>
> > >>>>>          CPU A                                                CPU B
> > >>>>> THP collapse                                             fast GUP
> > >>>>>
> > >>>>> gup_pmd_range() <-- see valid pmd
> > >>>>>
> > >>>>> gup_pte_range() <-- work on pte
> > >>>>> clear pmd and flush TLB
> > >>>>> __collapse_huge_page_isolate()
> > >>>>>     isolate page <-- before GUP bump refcount
> > >>>>>
> > >>>>>    pin the page
> > >>>>> __collapse_huge_page_copy()
> > >>>>>     copy data to huge page
> > >>>>>     clear pte (don't flush TLB)
> > >>>>> Install huge pmd for huge page
> > >>>>>
> > >>>>> return the obsolete page
> > >>>>
> > >>>> Hm, the is_refcount_suitable() check runs while the PTE hasn't been
> > >>>> cleared yet. And we don't check if the PMD changed once we're in
> > >>>> gup_pte_range().
> > >>>
> > >>> Yes
> > >>>
> > >>>>
> > >>>> The comment most certainly should be stale as well -- unless there is
> > >>>> some kind of an implicit IPI broadcast being done.
> > >>>>
> > >>>> 2667f50e8b81 mentions: "The RCU page table free logic coupled with an
> > >>>> IPI broadcast on THP split (which is a rare event), allows one to
> > >>>> protect a page table walker by merely disabling the interrupts during
> > >>>> the walk."
> > >>>>
> > >>>> I'm not able to quickly locate that IPI broadcast -- maybe there is one
> > >>>> being done here (in collapse) as well?
> > >>>
> > >>> The TLB flush may call IPI. I'm supposed it is arch dependent, right?
> > >>> Some do use IPI, some may not.
> > >>
> > >> Right, and the whole idea of the RCU GUP-fast was to support
> > >> architectures that don't do it. x86-64 does it. IIRC, powerpc doesn't do
> > >> it -- but maybe it does so for PMDs?
> > >
> > > It looks powerpc does issue IPI for pmd flush. But arm64 doesn't IIRC.
> > >
> > > So maybe we should implement pmdp_collapse_flush() for those arches to
> > > issue IPI.
> >
> > ... or find another way to detect and handle this in GUP-fast?
> >
> > Not sure if, for handling PMDs, it could be sufficient to propagate the
> > pmdp pointer + value and double check that the values didn't change.
>
> Should work too, right before pinning the page.

I actually mean the same place for checking pte. So, something like:

diff --git a/mm/gup.c b/mm/gup.c
index 5abdaf487460..2b0703403902 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2392,7 +2392,8 @@ static int gup_pte_range(pmd_t pmd, unsigned
long addr, unsigned long end,
                        goto pte_unmap;
                }

-               if (unlikely(pte_val(pte) != pte_val(*ptep))) {
+               if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
+                   unlikely(pte_val(pte) != pte_val(*ptep))) {
                        gup_put_folio(folio, 1, flags);
                        goto pte_unmap;
                }

It doesn't build, just shows the idea.

>
> pmdp_collapse_flush() is actually just called by khugepaged, so arch
> specific implementation should not be a problem and we avoid making
> gup fast more complicated.
>
> >
> > --
> > Thanks,
> >
> > David / dhildenb
> >
