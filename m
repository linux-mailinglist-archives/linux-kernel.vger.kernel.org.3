Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7D148DD42
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiAMRzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:55:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233807AbiAMRzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642096531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hb/USEUKkhn3s02KS0xUKc0vx42orgCcuSnwseHShRk=;
        b=I2pkuxJhtN/NBGs8QGGr/klDN0pC0DpiYA0nMqjBN9vUmmY0biFZMhJ4bBDmOqvrmvF5uO
        wiePcQ/52Cv2QJvOheF+wAoFPmozZfr4F2E8mpcVhEqDW3VFhw3ybeae/u8hZ1+aBkl3Nq
        PYLRDoFz5kiTrRB5+jepn+ueYG+B5ao=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-2Lvq9xr7NZGereHqlo6yyw-1; Thu, 13 Jan 2022 12:55:30 -0500
X-MC-Unique: 2Lvq9xr7NZGereHqlo6yyw-1
Received: by mail-ed1-f69.google.com with SMTP id ec25-20020a0564020d5900b003fc074c5d21so5983275edb.19
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Hb/USEUKkhn3s02KS0xUKc0vx42orgCcuSnwseHShRk=;
        b=yhSwK9adnIkD+um5w/+kzhmrEKt5KwXqdfXnx3y8LnX2Vx7Wvm/RN5+HgZvVibzw+e
         sIzdiHOBNd/rOuDR8wgKBNiRVsR/HZiMBZVNSt0HUt6TpRTyICn9zIKnNCo+s9kBN48t
         YvaE/WuJq9VAGJ/Y4YFSg49dk/vHiiB7+vIMy/p2JhDoav64g4ika84oFdD4e3P/mIVb
         s1FCyQEuQTQwL2JG1IfCnUvrKc3Sf9CmyYPaoM5EngDr0Se7dv/0Ut4VVdmAbP5enAXb
         +0J3A8UsgoHGmXVkeLDWQkF2NDTSWsjhNS5EeYlXaur/I7y92qIS9QQBc707InRtvWU+
         ZBww==
X-Gm-Message-State: AOAM533tz3MwnYnMI6k4Qk0SuuBsI4dN4kxdqPZsRPkmR/11DTue6DWA
        tv6LYf3DjCRSH195KmEwzLCioR7GMvMU1V3Po8u5ZHov+2E8uqgTpEOkjUL4y8JmWiCwrXwwQWF
        E82O1ur8qoHzraTB+UbikKEyJ
X-Received: by 2002:a05:6402:40cf:: with SMTP id z15mr5184668edb.185.1642096529027;
        Thu, 13 Jan 2022 09:55:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6o+NIPMdPbJERoH5Eo09Y5Ux7/iYWtpEKrIO6PgwTcNZgvFXP0WCgNbsuUjSVTZorr3sY1Q==
X-Received: by 2002:a05:6402:40cf:: with SMTP id z15mr5184652edb.185.1642096528838;
        Thu, 13 Jan 2022 09:55:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:e200:8511:ed0f:ac2c:42f7? (p200300cbc703e2008511ed0fac2c42f7.dip0.t-ipconnect.de. [2003:cb:c703:e200:8511:ed0f:ac2c:42f7])
        by smtp.gmail.com with ESMTPSA id g16sm1101134ejt.202.2022.01.13.09.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 09:55:28 -0800 (PST)
Message-ID: <0c44a89d-06a7-d0bb-e71e-7947d651f4d1@redhat.com>
Date:   Thu, 13 Jan 2022 18:55:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Liang Zhang <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <CAHk-=wi21DZ4H5uLnn2QgAeAUqg0wNPboijC0OgDDk1e7TdkPw@mail.gmail.com>
 <c3f34084-7315-e0c5-55db-d1cb006979f4@redhat.com>
 <CAHk-=wjv+beg2gRNdERANGfaGcqwDzzVD5RDD07FcrE5c6k-XA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
In-Reply-To: <CAHk-=wjv+beg2gRNdERANGfaGcqwDzzVD5RDD07FcrE5c6k-XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.22 18:44, Linus Torvalds wrote:
> On Thu, Jan 13, 2022 at 9:25 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> I might be missing something, but it's not only about whether we can remove
>> the page from the swap cache, it's about whether we can reuse the page
>> exclusively in a process with write access, avoiding a COW. And for that we
>> have to check if it's mapped somewhere else already (readable).
> 
> No.
> 
> The "try to remove from swap cache" is one thing. That uses the swap count.

However, reuse_swap_page() currently does multiple things, and that's part of the issue.

> 
> The "see if we can reuse this page for COW" is a completely different
> test, and that's the "page_count() == 1" one.
> 
> The two should not be mixed up with each other. Just don't do it.
> There's no reason - except for legacy confusion that should be
> actively avoided and removed.
> 
> IOW, the COW path would do
> 
>  trylock - copy if fails
>  try to remove from swap cache
>  if page_count() is now 1, we can reuse it

I thought about that exact sequence as well. I remember stumbling over
one of the other users of reuse_swap_page() that would require more thought
-- do_swap_page(). There, we essentially do a COW before having the
page mapped. (nasty)

I'll give it more thought.

> 
> Note how the "try to remove from swap cache" is entirely independent
> of whether we then reuse it or not.
> 
> And yes, we can have optimistic other tests - like not even bothering
> to trylock if we can see that the page-count is so elevated that it
> makes no difference and trying to remove from swap cache would be just
> pointless extra work (both the removal itself, and then potentially
> later re-additions).
> 
> But those should be seen for what they are - not important for
> semantics, only a "don't bother, this page has so many users that we
> already know that removing the swapcache one doesn't make any
> difference at all".

Right.

> 
> Now, it's possible that I'm missing something, but I think this kind
> of clarity is very much what we should aim for. Clear rules, no mixing
> of "can I COW this" with "can I remove this from the swap cache".

I consider reuse_swap_page() at this point just absolutely nasty.

While we're at it, is there a real reason we can't simplify to

diff --git a/mm/memory.c b/mm/memory.c
index e8e2144cbfa6..ab114a5862a0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3295,7 +3295,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
                        goto copy;
                if (!trylock_page(page))
                        goto copy;
-               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
+               if (PageKsm(page) || page_count(page) != 1) {
                        unlock_page(page);
                        goto copy;

Our page mapping has to hold a reference, so it seems unnecessary to check both.

> 
> And now I need to start my travel nightmare, so I'll be effectively
> offline for the next 24 hours ;(

Happy traveling then :) No worries, I'll be working on all this more
than 24 hours, especially PageAnonExclusive() that makes my head
hurt when it comes to swap, but this discussion already helps a lot
on how to eventually sort it all out.

-- 
Thanks,

David / dhildenb

