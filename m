Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD55A8671
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiHaTJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiHaTJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:09:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93971C9253
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:09:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x23so15003086pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ji1g99B3ksPEqP/vBsoq8oWjl/Stw3yVojPXqCh1rP0=;
        b=X6LjA+o1ewCZZiobat06cWgAPq+M0EmmBVSqk68O97COSS3nwBlV/8WsDywUQvdpgQ
         LeMOOuEOUhuZJ0qLm10zaV2AwUD6Iy/eRMNz8kCAQLpo33Lrnk9tmISNehXijggetaVY
         0rCiJLjOGFo9hdx+jNZ8oz7E6S79Lm7cZY+ATGKKzmeVlFM5Ki7FWS9DpbjONlcNhK3s
         CretUBiw+OFk84Kgo5c58ztcXdH0lvEJEq0QoJRjoPdSr88ckg2ul3q7s5nC04ZRQPat
         TpMKkzV85lX3K8XuIvhPJWJVkf2Bv4Q1B+NOiRYjFoT6U0iiFHBfAQJNsbsSsnu/cOO2
         jlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ji1g99B3ksPEqP/vBsoq8oWjl/Stw3yVojPXqCh1rP0=;
        b=4VmYmst6iSDy4s8kZGAy3wqTHRqE4oGC0lkCaUlaCBLA7RR7l5dYOtpNgY/gGQtOnN
         oM5Ac0VRYKdoUYt/XTPYc8UdRv2a5lmayxDnxDqzCJZrzLKyz/qn3dCnVN1P6pyCk3wp
         oBZsqyzKLcydRnVTcQp8CLC6wx3bG9fU4KUNunoskpZG75xN0eEsv6Gzob5xTV2ygtaj
         5G70lnfgQG3ckCuxoNR7U75Zih63oOvx9e+vFmt09tTt+hqBC11O8hDI8h+MQDs0J3Lh
         0si8HPthBnw1q4ulfMfQCWCg5u5vqSFYwkCRCfo4TnkO7TdY/FQa5bw0cSWV+vQeXFip
         0A/g==
X-Gm-Message-State: ACgBeo3P+Cy9TxtuKt9KSwM/rssaEdga6PHJ8cIAk0SbH97r+8nnFULf
        mcY2ByhCch1uD3ZkGxt7mTXDteZbaC1NLPrtwvA=
X-Google-Smtp-Source: AA6agR4KWusGvy70OzqRV+jD6Ni977koXVjdSM/62qROg0vxeWZQT/2eUEEwwxglrjOdyiKz+e4axEAVHnOhLKgDQPg=
X-Received: by 2002:a17:90a:6b0d:b0:1fa:c6fe:db6 with SMTP id
 v13-20020a17090a6b0d00b001fac6fe0db6mr4665036pjj.99.1661972941031; Wed, 31
 Aug 2022 12:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220831083024.37138-1-david@redhat.com> <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <4845ae71-b7dd-1707-ebc3-2eb3521e7fa0@redhat.com>
In-Reply-To: <4845ae71-b7dd-1707-ebc3-2eb3521e7fa0@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 31 Aug 2022 12:08:48 -0700
Message-ID: <CAHbLzkoMMWAgai2bvgu7y5EAcKOhhx3gK+OA4v2+kOHBW4cauw@mail.gmail.com>
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

On Wed, Aug 31, 2022 at 11:29 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 31.08.22 19:55, Yang Shi wrote:
> > On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> The comment is stale, because a TLB flush is no longer sufficient and
> >> required to synchronize against concurrent GUP-fast. This used to be true
> >> in the past, whereby a TLB flush would have implied an IPI on architectures
> >> that support GUP-fast, resulting in GUP-fast that disables local interrupts
> >> from completing before completing the flush.
> >
> > Hmm... it seems there might be problem for THP collapse IIUC. THP
> > collapse clears and flushes pmd before doing anything on pte and
> > relies on interrupt disable of fast GUP to serialize against fast GUP.
> > But if TLB flush is no longer sufficient, then we may run into the
> > below race IIUC:
> >
> >          CPU A                                                CPU B
> > THP collapse                                             fast GUP
> >
> > gup_pmd_range() <-- see valid pmd
> >
> > gup_pte_range() <-- work on pte
> > clear pmd and flush TLB
> > __collapse_huge_page_isolate()
> >     isolate page <-- before GUP bump refcount
> >
> >    pin the page
> > __collapse_huge_page_copy()
> >     copy data to huge page
> >     clear pte (don't flush TLB)
> > Install huge pmd for huge page
> >
> > return the obsolete page
>
> Hm, the is_refcount_suitable() check runs while the PTE hasn't been
> cleared yet. And we don't check if the PMD changed once we're in
> gup_pte_range().

Yes

>
> The comment most certainly should be stale as well -- unless there is
> some kind of an implicit IPI broadcast being done.
>
> 2667f50e8b81 mentions: "The RCU page table free logic coupled with an
> IPI broadcast on THP split (which is a rare event), allows one to
> protect a page table walker by merely disabling the interrupts during
> the walk."
>
> I'm not able to quickly locate that IPI broadcast -- maybe there is one
> being done here (in collapse) as well?

The TLB flush may call IPI. I'm supposed it is arch dependent, right?
Some do use IPI, some may not.

>
> --
> Thanks,
>
> David / dhildenb
>
