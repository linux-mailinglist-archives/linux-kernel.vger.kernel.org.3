Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965395A5EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiH3IxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiH3Iwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:52:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC0863F0F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:52:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z25so14578016lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kguPy3wkAys/EGwS8Nyv4zZp1jqQK2hNEkzoKqRl47o=;
        b=TPRi+MgkWEfe3wDbg7GpgpypRM62/orWgjZwhLwTwvxq1Q6qUQULhI+lr/OfIiCbig
         mVS9Wz9Z21/SKULBKaJmLRRZh1XMTJYc1nAdH1LRy8AWmR6QG0ORxf7wdw5IEunn3BhX
         lXrtUE8LW9tLPtehwHw6hyXxCkOFUgMDEmApEJ9rqt8W1LfE9pMO0vDJ5I/3GYX8vJNL
         GgXWZF55qFA4EUV4v3X1vfhDnRqw4gDDQUNQAMeqzsDwi6PNbVch6UVPrmQys4PTeDrA
         mfuLEm59fejkvqK8Bzu0nP3yayb2AKOK7GADH2GWhhkEsQ+0lfoCmAXDuWjig3ttKePR
         Ty2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kguPy3wkAys/EGwS8Nyv4zZp1jqQK2hNEkzoKqRl47o=;
        b=wbLMjFXxZN4kap/cv9rWWutBesLVBvrF26ReVsAh9ngVb/J4KIjpe8I4xoE2YFiE4F
         ZkbcJu0rM7zXhXWRxxxg9+7Zvgt4li3EubtGWTL70wE3QnVI/LWW409+GLsudWaGw1En
         HCERx8K/C5Q8uWXSuDLgAeHbLhpiKeZaKQqm/QJMHSezm1ynYDuJo/IG4FHhg3QdSpWw
         NMZULMO1pyQchkVhA4rG4WAS2ZR9LNzptmw3hB8ih6gZOrevaIe6i/UjfiiVv0EjHt3c
         GdjlSxJSHEZImkQp803DFh7gXNN1q76dNpNvXzHkhvugcYdXxJvqEFMZwHYNIMhPkW1B
         2tig==
X-Gm-Message-State: ACgBeo2XhrCaZt+KfmQpCTpYNeESAoCMEAZyEijNGD8B+8810SpGzyBg
        x6A03M1j895s+OhXfqT95BpiTaDQulMclA9/6E0WU3uL
X-Google-Smtp-Source: AA6agR5Saf7AnuJL9SY2My7MlZXUw7DF+aC3twmdn8zwmRrKs39J2HhW1ZcErvKGBWL/ZO/X1LFI2OxzDCBVAvRHEhY=
X-Received: by 2002:a05:6512:12c5:b0:48c:df54:a41a with SMTP id
 p5-20020a05651212c500b0048cdf54a41amr7049124lfg.464.1661849557114; Tue, 30
 Aug 2022 01:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <1661483530-11308-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAGWkznH=Gwr_TDF3=fv+_ZH5P4QN6JXEAtH4DAzNus20pHxyeg@mail.gmail.com>
 <12759ac7-4a6c-89fa-5fd0-914728f6415e@redhat.com> <CAGWkznEtFp2+1QLFF-mA0_jhfB48n4oneVXXNvipw3eBYji4kw@mail.gmail.com>
 <29503bc0-441e-359e-29d0-37ac3c5dff04@redhat.com>
In-Reply-To: <29503bc0-441e-359e-29d0-37ac3c5dff04@redhat.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 30 Aug 2022 16:52:09 +0800
Message-ID: <CAGWkznH9XFvEeuKcpcp6T+c6jSCs4Snwi4CWR0cE1ca0ycahvw@mail.gmail.com>
Subject: Re: [PATCH] mm: skip reserved page for kmem leak scanning
To:     David Hildenbrand <david@redhat.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 4:03 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 30.08.22 04:41, Zhaoyang Huang wrote:
> > On Mon, Aug 29, 2022 at 8:19 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 26.08.22 05:23, Zhaoyang Huang wrote:
> >>> On Fri, Aug 26, 2022 at 11:13 AM zhaoyang.huang
> >>> <zhaoyang.huang@unisoc.com> wrote:
> >>>>
> >>>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>>>
> >>>> It is no need to scan reserved page, skip it.
> >>>>
> >>>> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>>> ---
> >>>>  mm/kmemleak.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> >>>> index a182f5d..c546250 100644
> >>>> --- a/mm/kmemleak.c
> >>>> +++ b/mm/kmemleak.c
> >>>> @@ -1471,7 +1471,7 @@ static void kmemleak_scan(void)
> >>>>                         if (page_zone(page) != zone)
> >>>>                                 continue;
> >>>>                         /* only scan if page is in use */
> >>>> -                       if (page_count(page) == 0)
> >>>> +                       if (page_count(page) == 0 || PageReserved(page))
> >>> Sorry for previous stupid code by my faint, correct it here
> >>
> >> Did you even test the initial patch?
> >>
> >> I wonder why we should consider this change
> >>
> >> (a) I doubt it's a performance issue. If it is, please provide numbers
> >>     before/after.
> > For Android-like SOC systems where AP(cpu runs linux) are one of the
> > memory consumers which are composed of other processors such as modem,
> > isp,wcn etc. The reserved memory occupies a certain number of
> > memory(could be 30% of MemTotal) which makes scan reserved pages
> > pointless.
>
> But we only scan the memmap (struct page) here and not the actual
> memory. Do you have any performance numbers showing that there is even
> an observable change?
>
> >> (b) We'll stop scanning early allocations. As the memmap is usually
> >>     allocated early during boot ... we'll stop scanning essentially the
> >>     whole mmap and that whole loop would be dead code? What am i
> >>     missing?
> > memmap refers to pages here? If we can surpass these as it exist
> > permanently during life period. Besides, I wonder if PageLRU should
> > also be skipped?
> > -                       if (page_count(page) == 0)
> > +                       if (page_count(page) == 0 ||
> > PageReserved(page) || PageLRU(page))
>
> I think we need a really good justification to start poking holes into
> the memmap scanner. I'm no expert on this code (and under which
> circumstances we actually might find referenced objects in a memmap),
> though.
>
> But we should be careful with that.
Agree. It may be helpless as kmemleak is for debugging purposes. Nack
this patch by myself. Sorry for interrupt.
>
> --
> Thanks,
>
> David / dhildenb
>
