Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DCE49F697
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347705AbiA1Jo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:44:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbiA1JoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643363064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/1XryswyXoExyh39X8CoSuzkVzyRpWNUf/ugBJHXp0=;
        b=UgOWBuKxgx5KWhMzV8bUjXiwu0pB0iUPW0I/3c10RRHsuQ1BL6WNbbYjw17pM1Sg3F0567
        TVwGMZ2GVJiIKCVV2y1bn+gJlOwUH7m2viNLC29+2bG2+0WhB5Eq3cJ1/XOJhKwS2yVTqQ
        7fQqh2XL0P16Y3aIgPw2RsnuQdOvrw8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-bok6q0YlMfyAEn0HcoSpfA-1; Fri, 28 Jan 2022 04:44:22 -0500
X-MC-Unique: bok6q0YlMfyAEn0HcoSpfA-1
Received: by mail-wm1-f70.google.com with SMTP id f188-20020a1c1fc5000000b0034d79edde84so1270178wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=N/1XryswyXoExyh39X8CoSuzkVzyRpWNUf/ugBJHXp0=;
        b=XY57BvUBE7V3s/fxorFWblSvPD3mplckuMsLCY7PMWsi9BwHiQsDO4OxUtvv1IeVqL
         5LDixwS5PnTKbbHghkYqVz3P76v2JVvgd2+1PcAYxcyWtmywLHP0RlH6z9HXT1fsULbf
         4bOZuP53N4zorCPp8yt4IGt6Zw+WDbEaGzf1AArjL9Q+MwioGM91BYpvaUDR0t5OdHpI
         LLBe3+9TnZUuYpigxofW+cB/gbPzO+xorvo3eoTUxjNBMxkwdAlzUgG8u3L6ueLNkHUF
         /rbOewI84JrnlMC1yfdsEOno0N/r8a6VLm6dywrMbHdoB/qQujbNe680KL6gOfRyKThH
         L9RQ==
X-Gm-Message-State: AOAM5315TnOU4s8TXV/1K6IskWGavEHt03bApWwEwXcMiu1mojSPfzCx
        9o1uq10NAt8RqqhJhB+4d0VXdoVIcW8X5m3wI6o7Tg0W8clKNs8jCSii6e5FmHDjM+k/4O44c/z
        39krodxXFyLnOQmF3gVse0iYo
X-Received: by 2002:adf:d1ec:: with SMTP id g12mr6767047wrd.8.1643363061492;
        Fri, 28 Jan 2022 01:44:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8dUE3RS9JJMTdlIcqRMNDQF4r6hqZqUxrMGbTPi2btOQb6674Dqu75CkkcVlyFGa6kDwklQ==
X-Received: by 2002:adf:d1ec:: with SMTP id g12mr6767033wrd.8.1643363061261;
        Fri, 28 Jan 2022 01:44:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5c00:522f:9bcd:24a0:cd70? (p200300cbc70e5c00522f9bcd24a0cd70.dip0.t-ipconnect.de. [2003:cb:c70e:5c00:522f:9bcd:24a0:cd70])
        by smtp.gmail.com with ESMTPSA id l40sm1618445wms.0.2022.01.28.01.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 01:44:20 -0800 (PST)
Message-ID: <6505eb77-8901-00b7-49dd-4fd49eb7efe6@redhat.com>
Date:   Fri, 28 Jan 2022 10:44:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 0/3] Add hugetlb MADV_DONTNEED support
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220113180308.15610-1-mike.kravetz@oracle.com>
 <b476e461-aba9-e92b-d392-270029ab6b18@redhat.com>
 <CAJHvVciKkrumi=WZE=NoQ1PYdYnu-UCV037HSTg_nUDDBe_gow@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJHvVciKkrumi=WZE=NoQ1PYdYnu-UCV037HSTg_nUDDBe_gow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 18:52, Axel Rasmussen wrote:
> On Thu, Jan 27, 2022 at 3:57 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 13.01.22 19:03, Mike Kravetz wrote:
>>> Userfaultfd selftests for hugetlb does not perform UFFD_EVENT_REMAP
>>> testing.  However, mremap support was recently added in commit
>>> 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed
>>> vma").  While attempting to enable mremap support in the test, it was
>>> discovered that the mremap test indirectly depends on MADV_DONTNEED.
>>>
>>> hugetlb does not support MADV_DONTNEED.  However, the only thing
>>> preventing support is a check in can_madv_lru_vma().  Simply removing
>>> the check will enable support.
>>>
>>> This is sent as a RFC because there is no existing use case calling
>>> for hugetlb MADV_DONTNEED support except possibly the userfaultfd test.
>>> However, adding support makes sense as it is fairly trivial and brings
>>> hugetlb functionality more in line with 'normal' memory.
>>>
>>
>> Just a note:
>>
>> QEMU doesn't use huge anonymous memory directly (MAP_ANON | MAP_HUGE...)
>> but instead always goes either via hugetlbfs or via memfd.
>>
>> For MAP_PRIVATE hugetlb mappings, fallocate(FALLOC_FL_PUNCH_HOLE) seems
>> to get the job done (IOW: also discards private anon pages). See the
>> comments in the QEMU code below. I remember that that is somewhat
>> inconsistent. For ordinary MAP_PRIVATE mapped files I remember that we
>> always need fallocate(FALLOC_FL_PUNCH_HOLE) + madvise(QEMU_MADV_DONTNEED)
>> to make sure
>>
>> a) All file pages are removed
>> b) All private anon pages are removed
>>
>> IIRC hugetlbfs really is different in that regard, but maybe other fs
>> behave similarly.
>>
>> That's why QEMU was able to live for now without MADV_DONTNEED support
>> for hugetlbfs and most probably won't ever need it.
> 
> Agreed, all of the production use cases I'm aware of use hugetlbfs,
> not MAP_HUGE...
> 
> But, I would say this is convenient for testing purposes. It's
> slightly more convenient to not have to mount hugetlbfs / perform the
> associated setup for tests.

Creating a memfd is not too hard, but yes, not a single-liner. Maybe the
uffd test should go via memfds for hugetlb instead. But maybe that
limits the mremap functionality? No expert.

> 
> Perhaps that's only a small motivation for enabling this, but then
> again Mike's patch to do so is likewise very small. :)

... and apparently buggy :P

-- 
Thanks,

David / dhildenb

