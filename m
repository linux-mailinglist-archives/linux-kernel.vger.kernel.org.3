Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBE50F19D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbiDZHD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbiDZHDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:03:23 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC8DF70
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:00:15 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id 63so6516463uaw.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiJEB0dRG8Vs28wunrpsUd3aNm5kWfCeFbd3eFY3as0=;
        b=d5Yk9vkBLEnKHZ514Yf7ffIGn1EMaNSf9hcUKn32e7vRywUbt99pLhvqkR7Liz+aP8
         sozJ0ZzYbXQ8jrjtb5NyDXRaai+A2UT7dybpsV4vswDl9pVDBXrK/HvM3tdK+vBkDas5
         u4pRqvPtK619yrrKfHNYAPBOddzYm/XqjOCWEjmKcIw/YcsNrgtftJEl3A3Oi2uBHlct
         5CuoeK/L0Cllvp3/1VRIoE8zAUKrSBpPnBfrcSMd+oMFDLlxx4rRX3k8CStKnzUDvgg3
         ie8x7Q5M7PPH+2xHukY2sM0rSNrnhtRnbfH/ZxmsCnuQx3BIO4btY8/oYwhwTKq9U8dB
         XJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiJEB0dRG8Vs28wunrpsUd3aNm5kWfCeFbd3eFY3as0=;
        b=IlwJOZQ//RKHLsPt5oykobCEEzYpWuoqQFYEOUsIvHnjP8++M6r3GZCZ5F6FYOrNU9
         iCKxj4e2xPR0/aOQ5RJ/fm2FU5Q5LmkG6uzhjJ/Y5LIM84QsTECDdu0H+TDucfTMCTxU
         O39utp9yOkfNodH78i9g+cUslczBW/ya0eoPPTvXbZfHvW6DijEdNg/29s9hiLrzxwj8
         EHc8nZPxQLz37Wwn97A+f1Qih1iIwPZ43euhFQhDLSzkZxWhDjxq03P8g20btg820I0x
         OdFd+Jr8XXuqZOIRFOzYvfPUM7UWXmDhWAwzFIvQjXDdxd0Z3j+Tri9ao/7DhJ1CYHBw
         GbMg==
X-Gm-Message-State: AOAM533zaQkiSRvrERF/we3/5URqcOB2EVyZTSgfwZnCuW/iRdluKPa8
        TXdI3oJWpzlxk5HGKQZXD4gxkjjqkaeUOx2NXP6uwg==
X-Google-Smtp-Source: ABdhPJzkXr9BOqsgJAkCTK7/ifPaSnlqKx7Ilm0RuLZ18kZbUoUwyM07wgDkFY+vVJrPQc3/yTK2PG51XyTTjydMhQs=
X-Received: by 2002:ab0:482d:0:b0:35d:1e5e:ed19 with SMTP id
 b42-20020ab0482d000000b0035d1e5eed19mr6553573uad.17.1650956413953; Tue, 26
 Apr 2022 00:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-13-yuzhao@google.com>
 <20220411191634.674554d3de2ba37b3db40ca2@linux-foundation.org>
 <CAOUHufYhhCPFqoRbtn+=OFxZxNWS9yxW9Re_s-2TYGqCEaMXVw@mail.gmail.com> <20220415212024.c682ac000e3e91572d8d6d2b@linux-foundation.org>
In-Reply-To: <20220415212024.c682ac000e3e91572d8d6d2b@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 26 Apr 2022 00:59:37 -0600
Message-ID: <CAOUHufa60CVZcXJ937=P4GVtV_Cn76mYCWwcyBNjMAADmyWEwQ@mail.gmail.com>
Subject: Re: [PATCH v10 12/14] mm: multi-gen LRU: debugfs interface
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:20 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 15 Apr 2022 18:03:16 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > > Presumably sysfs is the place.  Fully documented and with usage
> > > examples in the changelog so we can carefully review the proposed
> > > extensions to Linux's ABI.  Extensions which must be maintained
> > > unchanged for all time.
> >
> > Eventually, yes. There still is a long way to go. Rest assured, this
> > is something Google will keep investing resources on.
>
> So.  The plan is to put these interfaces in debugfs for now, with a
> view to migrating stabilized interfaces into sysfs (or procfs or
> whatever) once end-user requirements and use cases are better
> understood?

The requirements are well understood and the use cases are proven,
e.g., Google [1], Meta [2] and Alibaba [3].

[1] https://dl.acm.org/doi/10.1145/3297858.3304053
[2] https://dl.acm.org/doi/10.1145/3503222.3507731
[3] https://gitee.com/anolis/cloud-kernel/blob/release-5.10/mm/kidled.c

> If so, that sounds totally great to me.  But it should have been in
> the darn changelog!  This is the sort of thing which we care about most
> keenly.
>
> It would be helpful for reviewers to understand the proposed timeline
> for this process, because the entire feature isn't really real until
> this is completed, is it?  I do think we should get this nailed down
> relatively rapidly, otherwise people will be reluctant to invest much
> into a moving target.
>
> And I must say, I see dissonance between the overall maturity of the
> feature as described in these emails versus the immaturity of these
> userspace control interfaces.  What's happening there?

Very observant. To answer both of the questions above: each iteration
of the entire stack is a multi-year effort.

Given its ROI, companies I know of constantly pour money into this
area. Given its scale, this debugfs is the least of their concerns. A
good example is the proactive reclaim sysfs interface [4]. It's been
used at Google for many years and at Meta for a few years. We only
started finalizing it recently.

[4] https://lore.kernel.org/r/20220425190040.2475377-1-yosryahmed@google.com/
