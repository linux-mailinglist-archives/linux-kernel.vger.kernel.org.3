Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B205349F4D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347137AbiA1ICQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242915AbiA1ICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643356934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HrLvSZIR36NorBIqDb36MQSYEjpSxjJoIGRv0e2Vkb8=;
        b=hX1/HM4KGbcqmA4WLnW92SujFOg7jX/7m1INhu+KvHukY1CO7wbBdq8NQnIj3VbMsLGPY4
        66FlcweOaaaPO4g++WBuOeFNPdK/rK0a8d7BMJ5mNaravIHkKueKbm6kF2dHGcY/dtC5Se
        gEo48vzJh4jMyAuSaxPQkWqARSj3KoA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-FSXSxS63PkOQNct2l9Ph9A-1; Fri, 28 Jan 2022 03:02:11 -0500
X-MC-Unique: FSXSxS63PkOQNct2l9Ph9A-1
Received: by mail-wm1-f72.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso3340616wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HrLvSZIR36NorBIqDb36MQSYEjpSxjJoIGRv0e2Vkb8=;
        b=ksEvUx55YASXpGg+bHu48w0WNEf7oNrui4qF3jos7OQfIhowLTK9xDJwZQluKl4b5Z
         wQKud4yyHAgvqIwksfWjXCXi7lsJs3DqYW175KmEqKGPp4Prc+mhShBPZjDXN77nmexp
         hik57ekkqz0nNdp1QAhdFN8DGfWKCqqL70jAgDhH6dukiityNZr147/kZZpOpk1hiEWd
         XPJQGFkc5BDshZFjq2PAJh347vIBl703p5HTkPqPUd3/3fNtRWkfCYSJpagAc++X0+YU
         WJKOAFffP2pF5+nXM7SzqAAeX8sOUaaALPffAf2kyN9/90Fkr3XrrW4iE7w2ceUF0ra9
         vXCA==
X-Gm-Message-State: AOAM531+t/yEEiPGQMUmVa8cJtVoy9jPGP3YcuXpN+63xl9t0Y8ODDYs
        V/TUUPVsVT9yJYwcYMWli9ByTl9ftilpxLLRtCLm+Fg5G1fom47DDp4FRf6mA/SA1mt7hl563c5
        2EN6xQR7CtJ0qTVwg0zSkSt5N
X-Received: by 2002:a05:600c:ac7:: with SMTP id c7mr1161832wmr.61.1643356930393;
        Fri, 28 Jan 2022 00:02:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJ7HYlNONpmT6c6aBVaZKnXYE6GGvxfmIczVldqWZrOLYQq8sPpaKzRiokTtE3ZubTa8rfYg==
X-Received: by 2002:a05:600c:ac7:: with SMTP id c7mr1161809wmr.61.1643356930170;
        Fri, 28 Jan 2022 00:02:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5c00:522f:9bcd:24a0:cd70? (p200300cbc70e5c00522f9bcd24a0cd70.dip0.t-ipconnect.de. [2003:cb:c70e:5c00:522f:9bcd:24a0:cd70])
        by smtp.gmail.com with ESMTPSA id i9sm4914187wry.32.2022.01.28.00.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 00:02:09 -0800 (PST)
Message-ID: <8c0430e5-fecb-3eda-3d40-e94caa8cbd78@redhat.com>
Date:   Fri, 28 Jan 2022 09:02:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [v2 PATCH] fs/proc: task_mmu.c: don't read mapcount for migration
 entry
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
References: <20220120202805.3369-1-shy828301@gmail.com>
 <af603cbe-4a38-9947-5e6d-9a9328b473fb@redhat.com>
 <CAG48ez1xuZdELb=5ed1i0ruoFu5kAaWsf0LgRXEGhrDAcHz8fw@mail.gmail.com>
 <f7f82234-7599-9e39-1108-f8fbe2c1efc9@redhat.com>
 <CAG48ez17d3p53tSfuDTNCaANyes8RNNU-2i+eFMqkMwuAbRT4Q@mail.gmail.com>
 <5b4e2c29-8f1a-5a68-d243-a30467cc02d4@redhat.com>
 <CAHbLzkqLTkVJk+z8wpa03ponf7k30=Sx6qULwsGsvr5cq5d1aw@mail.gmail.com>
 <5a565d5a-0540-4041-ce63-a8fd5d1bb340@redhat.com>
 <CAHbLzkqXy-W9sD5HFOK_rm_TR8uSP29b+RjKjA5zOZ+0dkqMbQ@mail.gmail.com>
 <2a1c5bd2-cb8c-b93b-68af-de620438d19a@redhat.com>
 <CAHbLzkrQiQyh=36fOtqcODU3RO92jBVxU0o7wU8PyHJ_83LjiQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHbLzkrQiQyh=36fOtqcODU3RO92jBVxU0o7wU8PyHJ_83LjiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 22:16, Yang Shi wrote:
> On Wed, Jan 26, 2022 at 10:54 AM David Hildenbrand <david@redhat.com> wrote:
>>
>>>>> Just page lock or elevated page refcount could serialize against THP
>>>>> split AFAIK.
>>>>>
>>>>>>
>>>>>> But yeah, using the mapcount of a page that is not even mapped
>>>>>> (migration entry) is clearly wrong.
>>>>>>
>>>>>> To summarize: reading the mapcount on an unlocked page will easily
>>>>>> return a wrong result and the result should not be relied upon. reading
>>>>>> the mapcount of a migration entry is dangerous and certainly wrong.
>>>>>
>>>>> Depends on your usecase. Some just want to get a snapshot, just like
>>>>> smaps, they don't care.
>>>>
>>>> Right, but as discussed, even the snapshot might be slightly wrong. That
>>>> might be just fine for smaps (and I would have enjoyed a comment in the
>>>> code stating that :) ).
>>>
>>> I think that is documented already, see Documentation/filesystems/proc.rst:
>>>
>>> Note: reading /proc/PID/maps or /proc/PID/smaps is inherently racy (consistent
>>> output can be achieved only in the single read call).
>>
>> Right, but I think there is a difference between
>>
>> * Atomic values that change immediately afterwards ("this value used to
>>   be true at one point in time")
>> * Values that are unstable because we cannot read them atomically ("this
>>   value never used to be true")
>>
>> I'd assume with the documented race we actually talk about the first
>> point, but I might be just wrong.
>>
>>>
>>> Of course, if the extra note is preferred in the code, I could try to
>>> add some in a separate patch.
>>
>> When staring at the (original) code I would have hoped to find something
>> like:
>>
>> /*
>>  * We use page_mapcount() to get a snapshot of the mapcount. Without
>>  * holding the page lock this snapshot can be slightly wrong as we
>>  * cannot always read the mapcount atomically. As long we hold the PT
>>  * lock, the page cannot get unmapped and it's at safe to call
>>  * page_mapcount().
>>  */
>>
>> With the addition of
>>
>> "... For unmapped pages (e.g., migration entries) we cannot guarantee
>> that, so treat the mapcount as being 1."
> 
> It seems a little bit confusing to me, it is not safe to call with PTL
> held either, right? I'd like to rephrase the note to:

The implication that could have been spelled out is that only a mapped
page can get unmapped. (I know, there are some weird migration entries
nowadays ...)

/*
 * We use page_mapcount() to get a snapshot of the mapcount. Without
 * holding the page lock this snapshot can be slightly wrong as we
 * cannot always read the mapcount atomically. As long we hold the PT
 * lock, a mapped page cannot get unmapped and it's at safe to call
 * page_mapcount(). Especially for migration entries, it's not safe to
 * call page_mapcount(), so we treat the mapcount as being 1.
 */



-- 
Thanks,

David / dhildenb

