Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AC45422A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiFHDa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 23:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiFHDae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:30:34 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C633C20ED6A;
        Tue,  7 Jun 2022 17:45:35 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id x5so19958436edi.2;
        Tue, 07 Jun 2022 17:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6G6v+U3PQZ98KAwPWp+vie7a7TsZCRfiTc7/2kHm14=;
        b=JNOYJH0NVg3VXaNwMMfLmSDeajuwm0jjsfsCYzz4zLbDRxZCEEO1ODq6Jv7ux/nqWG
         PAPM7n0lgrhyAtZ6CoqINifT9vRWp5sFFu7c2RlFxCi42xPOhVcjwt7w0znkmnIxATAl
         FfbKo5Rr/9zxO+Wsl0NM+JEBHJr2IZfrdyCTfqFpFb/cD03c+vXqDF+9NWOOZoldsR5w
         WJgvKzoPuA7i/Zwl/XjjN/8k2tQZeEbVmMDYgqBEEpOsZ9g4rAqeM7boBOkiplc09dgx
         tQdWtQkCfwk7cien0Ydf00bCqBxM8CpRWeaPC3/bc2NvodDtdPQ0PtvH+oaxaYLeKlu9
         bBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6G6v+U3PQZ98KAwPWp+vie7a7TsZCRfiTc7/2kHm14=;
        b=wyy63s92XhRQfuY03pgkqVscLZJ2PiAsfq6u75faQcYYcdgGSpSk0C9e6UETSp4yZQ
         oY/KSaC5pnSlq2pcfOluikdzzFhm5++cYuL/HZJ5iqEAEIyOAMF7HNqq5Xv6Ty860C+c
         fgD6we/N9btdpUngg3MZBhm0KhDRGihEZnMo6Cbwdpg5yEOL/b+kQLUgYCxGQ/Ood7ui
         V+VOKPsk/sEX9WHR0/0nDXgIbWRBQTpzR5p2TZVlOCaUTXla0oWBViMhRlonl2Bq7uwj
         ++GKBWAWsoGBnQKy0BFPbgHhwi8ThFlUIHt49LmNX27n7axuEKuevJH1dcdCsVyb2giv
         Cd8g==
X-Gm-Message-State: AOAM531l18aEKjt32nahcppslx/L29/EndOkOIKcZCrpwCbhG25BtFBr
        BC/4X4VpGwSwfmafWov5ccpKroJ0RMUN0WCm7rQ=
X-Google-Smtp-Source: ABdhPJz+sYFrvX+1urqNbffSy0LGIhXdDvmkdAbaPCcvl4WzDlqp96l7zhactnoOnBL8HTcTkcmupOQHUjCUKLCeO2g=
X-Received: by 2002:a05:6402:510d:b0:42d:e266:e02f with SMTP id
 m13-20020a056402510d00b0042de266e02fmr36223915edd.277.1654649006703; Tue, 07
 Jun 2022 17:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com> <20220518014632.922072-8-yuzhao@google.com>
 <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com>
 <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com>
 <20220607102135.GA32448@willie-the-truck> <CAGsJ_4zGEdHDv0ObZ-5y8sFKLO7Y6ZjTsZFs0KvdLwA_-iGJ5A@mail.gmail.com>
 <20220607104358.GA32583@willie-the-truck> <CAOUHufZh46A2hh_fn-8vVBDi_621rgbZq64_afDt8VxrzqJz1g@mail.gmail.com>
In-Reply-To: <CAOUHufZh46A2hh_fn-8vVBDi_621rgbZq64_afDt8VxrzqJz1g@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 8 Jun 2022 12:43:15 +1200
Message-ID: <CAGsJ_4yvsXCj8snemAyX3jPJgWJR+tFCtUhV-3QJ75RNi=q_KA@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Yu Zhao <yuzhao@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Brian Geffon <bgeffon@google.com>,
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
        Vaibhav Jain <vaibhav@linux.ibm.com>, huzhanyuan@oppo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 9:07 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Jun 7, 2022 at 4:44 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Jun 07, 2022 at 10:37:46AM +1200, Barry Song wrote:
> > > On Tue, Jun 7, 2022 at 10:21 PM Will Deacon <will@kernel.org> wrote:
> > > > On Tue, Jun 07, 2022 at 07:37:10PM +1200, Barry Song wrote:
> > > > > I can't really explain why we are getting a random app/java vm crash in monkey
> > > > > test by using ptep_test_and_clear_young() only in lru_gen_look_around() on an
> > > > > armv8-a machine without hardware PTE young support.
> > > > >
> > > > > Moving to  ptep_clear_flush_young() in look_around can make the random
> > > > > hang disappear according to zhanyuan(Cc-ed).
> > > > >
> > > > > On x86, ptep_clear_flush_young() is exactly ptep_test_and_clear_young()
> > > > > after
> > > > >  'commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case clear
> > > > > the accessed bit instead of flushing the TLB")'
> > > > >
> > > > > But on arm64, they are different. according to Will's comments in this
> > > > > thread which
> > > > > tried to make arm64 same with x86,
> > > > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1793881.html
> > > > >
> > > > > "
> > > > > This is blindly copied from x86 and isn't true for us: we don't invalidate
> > > > > the TLB on context switch. That means our window for keeping the stale
> > > > > entries around is potentially much bigger and might not be a great idea.
> > > > >
> > > > > If we roll a TLB invalidation routine without the trailing DSB, what sort of
> > > > > performance does that get you?
> > > > > "
> > > > > We shouldn't think ptep_clear_flush_young() is safe enough in LRU to
> > > > > clear PTE young? Any comments from Will?
> > > >
> > > > Given that this issue is specific to the multi-gen LRU work, I think Yu is
> > > > the best person to comment. However, looking quickly at your analysis above,
> > > > I wonder if the code is relying on this sequence:
> > > >
> > > >
> > > >         ptep_test_and_clear_young(vma, address, ptep);
> > > >         ptep_clear_flush_young(vma, address, ptep);
> > > >
> > > >
> > > > to invalidate the TLB. On arm64, that won't be the case, as the invalidation
> > > > in ptep_clear_flush_young() is predicated on the pte being young (and this
> > > > patches the generic implementation in mm/pgtable-generic.c. In fact, that
> > > > second function call is always going to be a no-op unless the pte became
> > > > young again in the middle.
> > >
> > > thanks for your reply, sorry for failing to let you understand my question.
> > > my question is actually as below,
> > > right now  lru_gen_look_around() is using ptep_test_and_clear_young()
> > > only without flush to clear pte for a couple of pages including the specific
> > > address:
> > > void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
> > > {
> > >        ...
> > >
> > >        for (i = 0, addr = start; addr != end; i++, addr += PAGE_SIZE) {
> > >                ...
> > >
> > >                if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
> > >                        continue;
> > >
> > >                ...
> > > }
> > >
> > > I wonder if it is safe to arm64. Do we need to move to ptep_clear_flush_young()
> > > in the loop?
> >
> > I don't know what this code is doing, so Yu is the best person to answer
> > that. There's nothing inherently dangerous about eliding the TLB
> > maintenance; it really depends on the guarantees needed by the caller.
>
> Ack.
>
> > However, the snippet you posted from folio_referenced_one():
> >
> >  |                  if (pvmw.pte) {
> >  |  +                       if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
> >  |  +                           !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
> >  |  +                               lru_gen_look_around(&pvmw);
> >  |  +                               referenced++;
> >  |  +                       }
> >  |  +
> >  |                          if (ptep_clear_flush_young_notify(vma, address,
> >
> >
> > Does seem to call lru_gen_look_around() *and*
> > ptep_clear_flush_young_notify(), which is what prompted my question as it
> > looks pretty suspicious to me.
>
> The _notify varint reaches into the MMU notifier --
> lru_gen_look_around() doesn't do that because GPA space generally has
> no locality. I hope this explains why both.
>
> As to why the code is organized this way -- it depends on the point of
> view. Mine is that lru_gen_look_around() is an add-on, since its logic
> is independent/separable from ptep_clear_flush_young_notify(). We can
> make lru_gen_look_around() include ptep_clear_flush_young_notify(),
> but that would make the code functionally interwinted, which is bad
> for my taste.

Given we used to have a flush for clear pte young in LRU, right now we are
moving to nop in almost all cases for the flush unless the address becomes
young exactly after look_around and before ptep_clear_flush_young_notify.
It means we are actually dropping flush. So the question is,  were we
overcautious? we actually don't need the flush at all even without mglru?
for arm64, without the flush, stale data might be used for a
relatively long time
as commented in [1], does it actually harm?
[1]https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1793881.html

Thanks
Barry
