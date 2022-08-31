Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF795A86EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiHaTnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiHaTno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:43:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB39C15A28
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:43:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p8-20020a17090ad30800b001fdfc8c7567so4028583pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kSSNFSlAukoDMg7TWjFtnlVW5kvsYnq4LkLWWtnNaYE=;
        b=gUN+DOp9f+JznK2y/E1t6gj7I4RepxZAebIkWUqABncACk/ikxI5f3Z6JBDnt/iQ98
         8x88wI0enbkSGzVyMZwNnow0h9BrTcnk3v7b/35NtdgGeKhzUnharrdMQtJcsoMe4bYc
         qirwm13AxL4p1z5Bq26B88XqpO+2LHlU5Qr6Bym8WR8koWrIMhOGueqeAL8KsOmdXczt
         6/0CnwYwhHoue8kcscfRfVBKvz7zJddGTVM/PEXOXWW58pOvivipzCZ1J294+z7KXiNn
         9XskRfwckDjXK6LWRH+7W/w1Z3Ova5XiX9PULHaQELx2/qpijFyOddiIte5BJueq7joM
         pjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kSSNFSlAukoDMg7TWjFtnlVW5kvsYnq4LkLWWtnNaYE=;
        b=pkx36DPBZUX8wCFvRzDnPMXOyNco3GiAPSAc/Q/3KpB9Apq01jb7XKcC9LUwTpQHjF
         Hsh0rYjsnpI7zkJSFfL3DwmTpmSAeKAFQ9zyZ9Phfm+NhYPTLCSX0q5CE77lM+giVKTh
         EL7O7XsvXDuKzIJeN3liO898yiaCPIqpvSYOlei/rf+OsMtCOReWuw8vxUSez3HMb7Ki
         ytm3Ualy4o9SYCZlDXZszI3ZOGXVf4tiJ5OUZQd3DD/75n6a3FLB4+V5HA+wgqDG1z2C
         kW2h1/ZTwZqPA2Z9/Opsamobw8gOivFckcabKC2qAPIZTcbtvRfkE63PCR4zJUIyJWKl
         djbw==
X-Gm-Message-State: ACgBeo3WaYXbU30ZaODiXFJc8olr3n5/rfRhlfyynX0VzcK3g8sF3pIT
        x2wEdaD5daPzO5XQuw/wmf4B+sBMzL7S9sEFkLk=
X-Google-Smtp-Source: AA6agR5Rb7PUiQP5I33lNAG2HnP5lfmNWILZ3lh3SDLj8o8dNFcA1ugBSYLnI8Jiz1KL/JzcIdSZ0elgwtVUbZAoN+k=
X-Received: by 2002:a17:90b:1b49:b0:1fd:dccc:91f7 with SMTP id
 nv9-20020a17090b1b4900b001fddccc91f7mr4763539pjb.200.1661975023394; Wed, 31
 Aug 2022 12:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220831083024.37138-1-david@redhat.com> <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <4845ae71-b7dd-1707-ebc3-2eb3521e7fa0@redhat.com> <CAHbLzkoMMWAgai2bvgu7y5EAcKOhhx3gK+OA4v2+kOHBW4cauw@mail.gmail.com>
 <ab41f458-eb0f-5edb-ccab-643bf00d5110@redhat.com> <CAHbLzkpFqSBTv3HVye4UCKj93NPW8VRqCGZO1p5hk_wfNA_GtQ@mail.gmail.com>
 <94c3217d-df73-2b6b-21f0-95baf117c584@redhat.com>
In-Reply-To: <94c3217d-df73-2b6b-21f0-95baf117c584@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 31 Aug 2022 12:43:31 -0700
Message-ID: <CAHbLzkp+HNmz7hGS5uDrfDDW0HpSj5Z+xmmkRbwvgn1qYk8Btg@mail.gmail.com>
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

On Wed, Aug 31, 2022 at 12:36 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 31.08.22 21:34, Yang Shi wrote:
> > On Wed, Aug 31, 2022 at 12:15 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 31.08.22 21:08, Yang Shi wrote:
> >>> On Wed, Aug 31, 2022 at 11:29 AM David Hildenbrand <david@redhat.com> wrote:
> >>>>
> >>>> On 31.08.22 19:55, Yang Shi wrote:
> >>>>> On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
> >>>>>>
> >>>>>> The comment is stale, because a TLB flush is no longer sufficient and
> >>>>>> required to synchronize against concurrent GUP-fast. This used to be true
> >>>>>> in the past, whereby a TLB flush would have implied an IPI on architectures
> >>>>>> that support GUP-fast, resulting in GUP-fast that disables local interrupts
> >>>>>> from completing before completing the flush.
> >>>>>
> >>>>> Hmm... it seems there might be problem for THP collapse IIUC. THP
> >>>>> collapse clears and flushes pmd before doing anything on pte and
> >>>>> relies on interrupt disable of fast GUP to serialize against fast GUP.
> >>>>> But if TLB flush is no longer sufficient, then we may run into the
> >>>>> below race IIUC:
> >>>>>
> >>>>>          CPU A                                                CPU B
> >>>>> THP collapse                                             fast GUP
> >>>>>
> >>>>> gup_pmd_range() <-- see valid pmd
> >>>>>
> >>>>> gup_pte_range() <-- work on pte
> >>>>> clear pmd and flush TLB
> >>>>> __collapse_huge_page_isolate()
> >>>>>     isolate page <-- before GUP bump refcount
> >>>>>
> >>>>>    pin the page
> >>>>> __collapse_huge_page_copy()
> >>>>>     copy data to huge page
> >>>>>     clear pte (don't flush TLB)
> >>>>> Install huge pmd for huge page
> >>>>>
> >>>>> return the obsolete page
> >>>>
> >>>> Hm, the is_refcount_suitable() check runs while the PTE hasn't been
> >>>> cleared yet. And we don't check if the PMD changed once we're in
> >>>> gup_pte_range().
> >>>
> >>> Yes
> >>>
> >>>>
> >>>> The comment most certainly should be stale as well -- unless there is
> >>>> some kind of an implicit IPI broadcast being done.
> >>>>
> >>>> 2667f50e8b81 mentions: "The RCU page table free logic coupled with an
> >>>> IPI broadcast on THP split (which is a rare event), allows one to
> >>>> protect a page table walker by merely disabling the interrupts during
> >>>> the walk."
> >>>>
> >>>> I'm not able to quickly locate that IPI broadcast -- maybe there is one
> >>>> being done here (in collapse) as well?
> >>>
> >>> The TLB flush may call IPI. I'm supposed it is arch dependent, right?
> >>> Some do use IPI, some may not.
> >>
> >> Right, and the whole idea of the RCU GUP-fast was to support
> >> architectures that don't do it. x86-64 does it. IIRC, powerpc doesn't do
> >> it -- but maybe it does so for PMDs?
> >
> > It looks powerpc does issue IPI for pmd flush. But arm64 doesn't IIRC.
> >
> > So maybe we should implement pmdp_collapse_flush() for those arches to
> > issue IPI.
>
> ... or find another way to detect and handle this in GUP-fast?
>
> Not sure if, for handling PMDs, it could be sufficient to propagate the
> pmdp pointer + value and double check that the values didn't change.

Should work too, right before pinning the page.

pmdp_collapse_flush() is actually just called by khugepaged, so arch
specific implementation should not be a problem and we avoid making
gup fast more complicated.

>
> --
> Thanks,
>
> David / dhildenb
>
