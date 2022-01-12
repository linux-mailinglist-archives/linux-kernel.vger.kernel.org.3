Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C99D48CA01
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355714AbiALRmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:42:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243138AbiALRm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642009345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtoOALOKXJRZ0rX5JFYiDqkhpVXBYvGRnWcTrYRXWhI=;
        b=IyWuq9P2oaDAVlLOEIQqPoRnqKtNvRVQsSRs9eFPXrUh4gSImbM51AR6gHdtao9c5wprUD
        i5ivb/rE4E7qtOO9frJ6/C7KlG+DrpcB/CVXmVOged6kdR5RLxnR0BJlMe7ATeJk+ZZzve
        znTFIDMN1l0bIitJVJvzohyrbC4Z09g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-_OlLw_VePRGRIrBzOH1Sjw-1; Wed, 12 Jan 2022 12:42:24 -0500
X-MC-Unique: _OlLw_VePRGRIrBzOH1Sjw-1
Received: by mail-ed1-f69.google.com with SMTP id b8-20020a056402350800b003f8f42a883dso2906075edd.16
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=vtoOALOKXJRZ0rX5JFYiDqkhpVXBYvGRnWcTrYRXWhI=;
        b=mCJ40NJgYSdBPP2xwo3K1KtXgXsPk+2YjoGe6DANoYTTr0z/3wC7/1yfVGaW2Vx7y9
         Uqe3CG6XtP14tNYhxEje+VHte20LJMfLyEnq5sOKebbwH6pTKKW89v71SWykJObts6FP
         T1b1yacarWc7aKS3tjKv0UdszaWDZsBhuUplEdifr00nLJhEzY1jdpoBmtYWLbNVl9HT
         0ezkd3UqZtM8l9pIJXoeYMk5kUVGL+byAOAa8D8kOAh9zWjBPl9Du4tf5uxcr3Mp6iNp
         eWtwBa5ARXyqg1UT9CTxmrWpMdRZgFPr4Bk3FQKyUto/L3bj6TBzMIgeMTg0KVw63j4I
         BGwA==
X-Gm-Message-State: AOAM533gEwIoZQjgoKJgMVFzq+X2SjYIeZ5VBsOTEznEues/rUaT6Xzw
        nWdDAilAz/eaKH/++6JVlGEzalLakPn2tB4R4D20U/WC6S1+tzvH23cE5ErVV9tVd3N6gvHUGle
        zFCYrVAcwrKWLQ90vhesyGmbn
X-Received: by 2002:aa7:dc05:: with SMTP id b5mr697088edu.46.1642009343249;
        Wed, 12 Jan 2022 09:42:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZj1h2GRPhZ1kPWze0KLwP25d0Ho7SdKcyQhvf3yYfpe4HlkxujmDWMyAYxJR7kMykOONeww==
X-Received: by 2002:aa7:dc05:: with SMTP id b5mr697075edu.46.1642009342989;
        Wed, 12 Jan 2022 09:42:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec? (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de. [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
        by smtp.gmail.com with ESMTPSA id gt38sm120003ejc.114.2022.01.12.09.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 09:42:22 -0800 (PST)
Message-ID: <c9c97e6a-5bb6-475e-2d0e-d791f11d2cf9@redhat.com>
Date:   Wed, 12 Jan 2022 18:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, huww98@outlook.com,
        John Hubbard <jhubbard@nvidia.com>
References: <20211228175904.3739751-1-minchan@kernel.org>
 <cf596fdc-6599-7c53-26e8-1524c5f214f7@redhat.com>
 <Yd8AYViR6vuBVU2L@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC v2] mm: introduce page pin owner
In-Reply-To: <Yd8AYViR6vuBVU2L@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> What about something like:
>>
>> "mm: selective tracing of page reference holders on unref"
>>
>> PAGE_EXT_PIN_OWNER -> PAGE_EXT_TRACE_UNREF
>>
>> $whatever feature/user can then set the bit, for example, when migration
>> fails.
> 
> I couldn't imagine put_page tracking is generally useful except
> migration failure. Do you have reasonable usecase in your mind
> to make the feature general to be used?

HWpoison etc. purposes maybe? Trace who still held a reference a page
that was poisoned and couldn't be removed?  Or in general, tracking
references to something that should have a refcount of 0 because it
should have been freed, but for some reason there are still references
around?

> Otherwise, I'd like to have feature naming more higher level
> to represent page migration failure and then tracking unref of
> the page. In the sense, PagePinOwner John suggested was good
> candidate(Even, my original naming PagePinner was worse) since

Personally, I dislike both variants.

> I was trouble to abstract the feature with short word.
> If we approach "what feature is doing" rather than "what's
> the feature's goal"(I feel the your suggestion would be close
> to what feature is doing), I'd like to express "unreference on
> migraiton failed page" so PAGE_EXT_UNMIGRATED_UNREF
> (However, I prefer the feature naming more "what we want to achieve")
> 
E.g., PAGE_EXT_TRACE_UNREF will trace unref to the page once the bit is
set. The functionality itself is completely independent of migration
failures. That's just the code that sets it to enable the underlying
tracing for that specific page.

>>
>> I somewhat dislike that it's implicitly activated by failed page
>> migration. At least the current naming doesn't reflect that.
>>
>>
>>> This will consume an additional 8 bytes per 4KB page, or an
>>> additional 0.2% of RAM. In addition to the storage space, it will
>>> have some performance cost, due to increasing the size of struct
>>> page so that it is greater than the cacheline size (or multiples
>>> thereof) of popular (x86, ...) CPUs.
>>
>> I think I might be missing something. Aren't you simply reusing
>> &page_ext->flags ? I mean, the "overhead" is just ordinary page_ext
>> overhead ... and whee exactly are you changing "struct page" layout? Is
>> this description outdated?
> 
> The feature enables page_ext which adds up 8 bytes per 4KB and on every
> put operation, it need to access the additional flag on page_ext which
> affects performance since page_put is the common operation.
> Yeah, the struct size stuff in the wording is rather misleading.
> Let me change the workding something like this:
> 
>  This will consume an additional 8 bytes per 4KB page, or an
>  additional 0.2% of RAM. In addition to the storage space, it will
>  have some performance cost, due to checking additional flag on
>  every put_page opeartion.

I'd adjust to

As this feature depends on page_ext->flags, it will consume an
additional 8 bytes per 4KB page to enable page_ext if not already
enabled. ...

> 
>>
>>>
>>> The idea can apply every user of migrate_pages as well as CMA to
>>> know the reason why the page migration failed. To support it,
>>> the implementation takes "enum migrate_reason" string as filter
>>> of the tracepoint(see below).
>>>
>>
>> I wonder if we could achieve the same thing for debugging by
>>
>> a) Tracing the PFN when migration fails
>> b) Tracing any unref of any PFN
>>
>> User space can then combine both information to achieve the same result.
>> I assume one would need a big trace buffer, but maybe for a debug
>> feature good enough?
> 
> I definitely tried it for cma allocation failure but it generated
> enormous output(Please keep it in mind that we also need stacktrace)
> due to too frequent put_page and compaction operation(Even, I filter
> them out to track only cma pages but it was still huge since the CMA
> size is 1/8 of the system). Even though I increased the buffer size
> a lot, the buffer was easily overwritten. Moreover, even though it's
> debug feature, we need to release the feature into dogfooder to catch
> the real problem in the field so consuming too much memory as well as
> backtrace operhead on every put page are tough to be used in field.

Makes sense, I was expecting the output to be large, but possible it's
going to be way too large.

Would it also make sense to track for a flagged page new taken
references, such that you can differentiate between new (e.g.,
temporary) ones and previous ones? Feels like a reasonable addition.

-- 
Thanks,

David / dhildenb

