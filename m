Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F01479FEE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 09:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhLSIne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 03:43:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229585AbhLSInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 03:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639903411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5OW/lDvTpbrYgLzJr47rwZgzIFEUQ9ppLjvNC//jJI=;
        b=QP9PMZelvEEI2XHACq6iQzlzgNps7DeTMBPKFtKNaCCpPjOj+/zi9o/HF+MeGjJEjzTroI
        bdS6kJ4ZA62CH4y7o8mV2e/bujD1SylFkC17cv5awu6vmyF7/fOwgqNyAjoCrYC5mUxs70
        ENglxif4OfKZYwWqnaNCoQPfqHcYhBs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-fgjLxjPZOu6F-WmkQwXaqA-1; Sun, 19 Dec 2021 03:43:30 -0500
X-MC-Unique: fgjLxjPZOu6F-WmkQwXaqA-1
Received: by mail-wr1-f69.google.com with SMTP id c16-20020adfa310000000b001a2349890e1so2344078wrb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 00:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=y5OW/lDvTpbrYgLzJr47rwZgzIFEUQ9ppLjvNC//jJI=;
        b=oXqDU+u+8AjvUzAH2lCV76rtwIj91IgMEqEf+zzuaKF89vf833uGKADLBe9sUKybIn
         VhxY7EFkLqEoJYGj+yJxUTeQl7IP7CXFuoZa2EswLCMAfktEl7BTL13y4RNNRbPzf4BW
         s8jJorT7qvUlfBEpdDvA3gej1+gJR1jei5xwUFbPBgc0LtVErV0B+Ci6otdElvgwQVBC
         orpttvrvdghFz252BrJtErFJs/PMltqVHMTNf1bmreAPEtpySo24SU5n0+1UlUwwOuUA
         fsjYd/CBXPywel7zV3RzBRC42jjCsCIYi36IgBIwbRHrFcJwTnEOaTMU89Zrk7DxyAkH
         iSgQ==
X-Gm-Message-State: AOAM530DovS18TDWaJPzLANIpb23VJ3pDD+6mdcnFcz1q7JsGK2mM62U
        CO2DbyGcAhI/ipbfy/m58FuwhypwED17nOfMoQgLOuy3Floyzq8qlRpzC2rldCddxT00/OsYLiD
        N0+7kdeHNM8FSTa4v1+MwBjSB
X-Received: by 2002:a05:6000:1864:: with SMTP id d4mr9071201wri.703.1639903409048;
        Sun, 19 Dec 2021 00:43:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSRv9WH6xityKG1zDVhBM2CBMFkYSNisYcxl5/Av88JuAcsaXz7mBub0wJBPV5yClBbktv9Q==
X-Received: by 2002:a05:6000:1864:: with SMTP id d4mr9071174wri.703.1639903408802;
        Sun, 19 Dec 2021 00:43:28 -0800 (PST)
Received: from [192.168.3.132] (p4ff23c6f.dip0.t-ipconnect.de. [79.242.60.111])
        by smtp.gmail.com with ESMTPSA id f8sm6035014wry.16.2021.12.19.00.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 00:43:28 -0800 (PST)
Message-ID: <b8297279-594f-9294-4482-dcac7463091b@redhat.com>
Date:   Sun, 19 Dec 2021 09:43:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com>
 <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com>
 <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com>
 <CAHk-=wiujJLsLdGQho8oSbEe2-B1k1tJg6pzePkbqZBqEZL56A@mail.gmail.com>
 <f271bb98-dfdd-1126-d9b9-3103e4398e00@redhat.com>
 <CAHk-=wjvoTRSb87R-D50yOXqX4mshjiiAyurAKCsdW0_J+sf7A@mail.gmail.com>
 <40e7e0ab-0828-b2e7-339f-35f68a228b3d@redhat.com>
 <CAHk-=wg95CiyT45ZOxtnWQ7cdKmejXcOydEyJcTTNnp5-nd+xg@mail.gmail.com>
 <CAHk-=wjevjeL44qafYd8=cJHZgNUOUuWVJ28vkS4U4v_Af-xaQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <CAHk-=wjevjeL44qafYd8=cJHZgNUOUuWVJ28vkS4U4v_Af-xaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.12.21 20:52, Linus Torvalds wrote:
> On Sat, Dec 18, 2021 at 11:21 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> To recap:
>>  (1) is important, and page_count() is the only thing that guarantees
>> "you get full access to a page only when it's *obviously* exclusively
>> yours".
>>  (2) is NOT important, but could be a performance issue, but we have
>> real data from the past year that it isn't.
>>  (3) is important, and has a really spectacularly simple conceptual
>> fix with quite simple code too.
>>
>> In contrast, with the "mapcount" games you can't even explain why they
>> should work, and the patches I see are actively buggy because
>> everything is so subtle.
> 
> So to challenge you, please explain exactly how mapcount works to
> solve (1) and (3), and how it incidentally guarantees that (2) doesn't
> happen.

Oh, there is no need for additional challenges, I've been challenged
with this problem for way too long already ;)

And again, I appreciate this discussion and your feedback. I want to get
all of this fixed ASAP, even if it's not going to be the way I propose
as I raised. Any input is appreciated (as long as people don't scream at
me).


To get to your point: I thought about your remarks with the swapcount
and it makes sense. The mapcount itself is not expressive enough to
catch macpount == 1 vs mapcount > 1.

What *would* work to have precise COW I think is having the active and
inactive count instead of just the active (mapcount) part, whereby:

active: page tables mapping this page -> mapcount
inactive: page tables referencing this page via swap/migration entry

An alternative would be to just know that there are inactive users. We'd
have to read both values atomically in one shot.

There would be ways to store that information in the _mapcount but it
certainly adds a lot of complexity, and ...

> 
> And that really involves explaining the actual code too. I can explain
> the high-level concepts in literally a couple of sentences.
> 
> For (1), "the page_count()==1 guarantees you are the only owner, so a
> COW event can re-use the page" really explains it. And the code is
> pretty simple too. There's nothing subtle about "goto copy" when
> pagecount is not 1. And even the locking is simple: "we hold the page
> table lock, we found a page, it has only one ref to it, we own it"
> 
> Our VM is *incredibly* complicated. There really are serious
> advantages to having simple rules in place.

... you have a point here.

Having that said, I hope we can agree that the "page_count" is not the
perfect solution. I hope we can at least tweak it for now to get rid of
3) Wrong COW.

> 
> And for (2), the simple rule is "yeah, we can cause spurious cow
> events". That's not only simple to explain, it's simple to code for.
> Suddenly you don't need to worry. "Copying the page is always safe".
> That's a really really powerful statement.
> 
> Now, admittedly (3) is the one that ends up being more complicated,
> but the *concept* sure is simple. "If you don't want to COW this page,
> then don't mark it for COW".
> 
> The *code* for (3) is admittedly a bit more complicated. The "don't
> mark it for COW" is simple to say, but we do have that fairly odd
> locking thing with fork() doing a seqcount_write_begin/end, and then
> GIP does the read-seqcount thing with retry. So it's a bit unusual,
> and I don't think we have that particular pattern anywhere else, but
> it's one well-defined lock and while unusual it's not *complicated* as
> far as kernel locking rules go. It's unusual and perhaps not trivial,
> but in the end those seqcount code sequences are maybe 10 lines total,
> and they don't interact with anything else.
> 
> And yes, the "don't mark it for COW" means that write-protecting
> something is special, mainly because we sadly do not have extra bits
> in the page tables. It would be *really* easy if we could just hide
> this "don't COW this page" in the page table. Truly trivial. We don't,
> because of portability across different architectures ;(
> 
> So I'll freely give you that my (3) is somewhat painful, but it's
> painful with a really simple concept.

Thanks for admitting that!

I might have had an idea yesterday on how to fix most of the issues
without relying on the mapcount, doing it similar (but slightly
different) as you propose here. Let's call it a mixture of the unsharing
approach and your approach. I cannot promise anything, so ...

... I'll go playing with it and share some details ASAP. At least it
sounds comparatively simple in my head.

> 
> And the places that get (3) wrong are generally places that nobody has
> been able to care about. I didn't realize the problem with creating a
> swap page after the fact for a while, so that commit feb889fb40fa
> ("mm: don't put pinned pages into the swap cache") came later, but
> it's literally a very simple two-liner.
> 

Just to give you my perspective:


Personally I don't care too much about 2). The only reason why I somehow
care about "Unnecessary COW" are
* Challenging for hugetlb use as I explained. We might still want to use
  the mapcount there.
* It's mostly a symptom of our eventually too simple COW logic that
  effectively leads to 3).

While I do care about 1) (Missed CoW) for our customers, I *especially*
care about 3) (Wrong Cow) simply because silent memory corruptions in
user space are not acceptable.

As you say, fixing 1) the "page_count" way might be easy, at least for THP.

Simple example: Have swapping enabled and register a fixed io_uring
buffer at the wrong time. Fixed io_uring buffers are no a commodity
feature for unprivileged users space ...

So that's why I so deeply care about all of this.

-- 
Thanks,

David / dhildenb

