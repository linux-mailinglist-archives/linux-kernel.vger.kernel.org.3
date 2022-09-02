Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17415AB55E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiIBPh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiIBPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:36:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC09915F3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:24:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 72so2195315pfx.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=G7HynGLQc1lxwSQPRc+SEtUVh5DnkPFwTvXscgNVKWk=;
        b=MIlwnhk5iohQXB4yWWluNoV6PH4wvqbewJceO2QyTOWiyuMFfxZw7qWmRdahwYFcqN
         oJ1aqy/j7x2ywrMdz/G9DHxFQsVPz+oe9bmmVpKTKu+pAFG3CqvKgq1D0dnT5ZpaTlhy
         UnEwJKlWjAP8lzZWMVPMS2cCAkHe05TcsKio4irTr4s0Qc/KIxNeyKzGpV8Rf0cdG8yo
         Giu43fLMEyeF/XJujQia3KWdCNc0ZesT+BA4HrG9Ukts3l+3QnpXs+IfpXCcBpMdlM7G
         7qPhcTv2fVUq/hSYFFOcYicWALAIX3xcuWLcT/gy84LMjfGi+fwQ732XPrI//kDkvgKV
         AHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=G7HynGLQc1lxwSQPRc+SEtUVh5DnkPFwTvXscgNVKWk=;
        b=facuAXdTNH0z6gD+x7TaXisXQb7rs3A8FPiFmKbe/5Lu3YP0NRTkWy9Og3EEAH4yf+
         ew67d2PWqvuFWxSpuCADWpdBmUuld0PDVIDcPTw559XDOupMvx0gvlTbhO6+Q3fvL8DW
         VDChEbZLH61F/9lk0/oHb+4k1Q1eYquj7AG1kvidOmO1KUYSaXzDXvdONmhcyEMJHyjd
         2Vq8WMrIVCQpwiJSJoW+BWrde5AgIALVJviduuZ1e12+3sax4xxoiF87oofJjpv/EZyh
         RaDF50Zmh8Ule0Y8+FXlvr/lgeWhYI92SoXqcGjVyVkHsCkVq08S7GGPKT2++akXvpuL
         XONQ==
X-Gm-Message-State: ACgBeo21vbhKq2/A06bDIzbvdIJdauXyLNMuYn4G6d1kwHt4F4ZezJZI
        MExU0UBDJ0a5A9831bp2YN2dycRQhp2T+YeBg0h785QU
X-Google-Smtp-Source: AA6agR4YmgwoquE39yMPajOiIFDzgAcGehCGWd2q/bUhcymtso6xZjcjiHr0UAhIbMOJ2E42FiPO4L050S/2+xKXJD4=
X-Received: by 2002:a65:6a05:0:b0:42c:87a0:ea77 with SMTP id
 m5-20020a656a05000000b0042c87a0ea77mr16909957pgu.75.1662132246849; Fri, 02
 Sep 2022 08:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220901222707.477402-1-shy828301@gmail.com> <YxE/vuQlWJCJMuG2@xz-m1.local>
 <CAHbLzkqjZ_UhUbJ_f9Br7WCAgQvjrm5bMPRsKYvaFc2bzSuzrw@mail.gmail.com> <1688bcf0-01b2-0f89-68db-d9d66e207bc6@redhat.com>
In-Reply-To: <1688bcf0-01b2-0f89-68db-d9d66e207bc6@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 2 Sep 2022 08:23:54 -0700
Message-ID: <CAHbLzkqniVH7G1i+7R_FG2AOmxcQVn=iTc-AZToEM7s9m8OJMw@mail.gmail.com>
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, kirill.shutemov@linux.intel.com,
        jhubbard@nvidia.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Thu, Sep 1, 2022 at 11:39 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 02.09.22 01:50, Yang Shi wrote:
> > On Thu, Sep 1, 2022 at 4:26 PM Peter Xu <peterx@redhat.com> wrote:
> >>
> >> Hi, Yang,
> >>
> >> On Thu, Sep 01, 2022 at 03:27:07PM -0700, Yang Shi wrote:
> >>> Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
> >>> introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
> >>> sufficient to handle concurrent GUP-fast in all cases, it only handles
> >>> traditional IPI-based GUP-fast correctly.
> >>
> >> If TLB flush (or, IPI broadcasts) used to work to protect against gup-fast,
> >> I'm kind of confused why it's not sufficient even if with RCU gup?  Isn't
> >> that'll keep working as long as interrupt disabled (which current fast-gup
> >> will still do)?
> >
> > Actually the wording was copied from David's commit log for his
> > PageAnonExclusive fix. My understanding is the IPI broadcast still
> > works, but it may not be supported by all architectures and not
> > preferred anymore. So we should avoid depending on IPI broadcast IIUC.
>
> Right. Not all architectures perform an IPI broadcast on TLB flush.
>
> IPI broadcasts will continue working until we use RCU instead of
> disabling local interrupts in GUP-fast.
>
>
> >>>    CPU A                                          CPU B
> >>> THP collapse                                     fast GUP
> >>>                                               gup_pmd_range() <-- see valid pmd
> >>>                                                   gup_pte_range() <-- work on pte
> >>> pmdp_collapse_flush() <-- clear pmd and flush
> >>> __collapse_huge_page_isolate()
> >>>     check page pinned <-- before GUP bump refcount
> >>>                                                       pin the page
> >>>                                                       check PTE <-- no change
> >>> __collapse_huge_page_copy()
> >>>     copy data to huge page
> >>>     ptep_clear()
> >>> install huge pmd for the huge page
> >>>                                                       return the stale page
> >>> discard the stale page
> >>>
> >>> The race could be fixed by checking whether PMD is changed or not after
> >>> taking the page pin in fast GUP, just like what it does for PTE.  If the
> >>> PMD is changed it means there may be parallel THP collapse, so GUP
> >>> should back off.
> >>
> >> Could the race also be fixed by impl pmdp_collapse_flush() correctly for
> >> the archs that are missing? Do you know which arch(s) is broken with it?
> >
> > Yes, and this was suggested by me in the first place, but per the
> > suggestion from John and David, this is not the preferred way. I think
> > it is because:
> >
> > Firstly, using IPI to serialize against fast GUP is not recommended
> > anymore since fast GUP does check PTE then back off so we should avoid
> > it.
> > Secondly, if checking PMD then backing off could solve the problem,
> > why do we still need broadcast IPI? It doesn't sound performant.
>
> I'd say, using an IPI is the old-styled way of doing things. Sure, using
> an IPI broadcast will work (and IMHO it's a lot easier to
> not-get-wrong). But it somewhat contradicts to the new way of doing things.
>
> >>
> >> It's just not clear to me whether this patch is an optimization or a fix,
> >> if it's a fix whether the IPI broadcast in ppc pmdp_collapse_flush() would
> >> still be needed.
> >
> > It is a fix and the fix will make IPI broadcast not useful anymore.
>
> I'd wonder how "easy" adding the IPI broadcast would be -- IOW, if the
> IPI fix has a real advantage.

Not sure either, but I guess calling a dummy function via IPI
broadcast should just work. Powepc does so.

>
>
> --
> Thanks,
>
> David / dhildenb
>
