Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC2449F6B4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347751AbiA1JzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:55:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232772AbiA1JzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643363704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ylz87V1WG45yYtILZ9U05QYarg4IApL3yG/h/CzZXDg=;
        b=H+30CHhBO3o0cbCjQcsmOgTn0WLk6tZO3C01D82dp3q6/yxkm/qisEIp/Mc+oqpoAXIy04
        tt50z6p6qh/NxWmAA2Tu5OpNx1TzF5DHiu96mX/lKmjJ8f0E++Qe79Qar1ixqr29/ycnbp
        7JNUM2BlEt5XjTsT1eFoNB8inRFfRZU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-d1wyb-A4OSuyJHaLwyQ4Ow-1; Fri, 28 Jan 2022 04:55:03 -0500
X-MC-Unique: d1wyb-A4OSuyJHaLwyQ4Ow-1
Received: by mail-wm1-f71.google.com with SMTP id z2-20020a05600c220200b0034d2eb95f27so2744981wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Ylz87V1WG45yYtILZ9U05QYarg4IApL3yG/h/CzZXDg=;
        b=aXAr75YdSUvkHMW6l6NCdSipMqDZVMJBxZVSxfUTm3c/fRXgjmaxAxAoZjpP0PDBvB
         Ps+VTMPbp8mxBk7KOlUCMA0mN2yvVdoe+KRaCMQKFvYdhHl9iJpdZ1jWfJ/I5d2C2NQe
         tq84FDLaYWgbxOnKUY1gwJkQJglYTunSUW/NasthyglFO+wKNdaXkkAnxjfXMUVKZiNA
         p6DxrsUQo+O98r6f6uZfFeGaw/nEomWE/rjFcGNBOftm7MJFzoNKae4w7VaeVvTjKENa
         ojkfC3NaD3ozYcxKh66R3FEd428u4x1N3gre8X716RBUOoDWEuzEXq5t9KLUNw2r/GYS
         S5xw==
X-Gm-Message-State: AOAM531UZs0jyigO6P/+w+AZSRxf4sneyoIpLz5a1byDTcrsffZBp+j/
        oexlwgSLiCW8/rOZkDvTA6TdoSB2cvO6hdEYZ0eUFjqu4pXmTeRrnolFwDc4hdprsfHuOYqvf7i
        0wu51SvfLo5a5wirRBrygtFRw
X-Received: by 2002:a5d:4205:: with SMTP id n5mr6324453wrq.479.1643363702379;
        Fri, 28 Jan 2022 01:55:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLum6pte96pf8j4lks4HqDl2FTk5t1ERYShrc8FV8j9dMFbmCX/cqz6Z/mfrBEG7A5whbDIg==
X-Received: by 2002:a5d:4205:: with SMTP id n5mr6324431wrq.479.1643363702152;
        Fri, 28 Jan 2022 01:55:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5c00:522f:9bcd:24a0:cd70? (p200300cbc70e5c00522f9bcd24a0cd70.dip0.t-ipconnect.de. [2003:cb:c70e:5c00:522f:9bcd:24a0:cd70])
        by smtp.gmail.com with ESMTPSA id n26sm1671855wms.13.2022.01.28.01.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 01:55:01 -0800 (PST)
Message-ID: <2ddd0a26-33fd-9cde-3501-f0584bbffefc@redhat.com>
Date:   Fri, 28 Jan 2022 10:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220113180308.15610-1-mike.kravetz@oracle.com>
 <b476e461-aba9-e92b-d392-270029ab6b18@redhat.com>
 <21242c94-6748-b76d-f38e-5ac140c6117b@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/3] Add hugetlb MADV_DONTNEED support
In-Reply-To: <21242c94-6748-b76d-f38e-5ac140c6117b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 18:55, Mike Kravetz wrote:
> On 1/27/22 03:57, David Hildenbrand wrote:
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
> 
> Yes it is really different.  And, some might even consider that a bug?
> Imagine if those private anon (COW) pages contain important data.  They
> could be unmapped/freed by some other process that has write access to
> the hugetlb file on which the private mapping is based.

Right, that's also what I once worried about in QEMU code. But then I
realized that any kind of fallocate(FALLOC_FL_PUNCH_HOLE) on a file
shared by multiple parties mapped MAP_PRIVATE might be bogus already.

Assume you have a VM running with MAP_SHARED on a file. The file
contains the VM memory state. Assume you pause the VM and want to
convert it into 2 instances that will continue running independently
based on the captured file state.

You'd have to MAP_PRIVATE the file such that both VMs start with the
original state and only see their modifications.

... but if one process decides to fallocate(FALLOC_FL_PUNCH_HOLE), for
example, due to memory ballooning, even a page that's still shared by
both processes (!COW), you'd corrupt the other VM.

So my assumption is that MAP_PRIVATE in combination with
fallocate(FALLOC_FL_PUNCH_HOLE) on a file mapped by more than one
process is just bogus already.

> 
> I believe this same issue exists for hugetlbfs ftruncate.  When fallocate
> hole punch support was added, it was based on the ftruncate functionality.
> 
> I am hesitant to change the behavior of hugetlb hole punch or truncate
> as people may be relying on that behavior today.  Your QEMU example is
> one such case.

Yes, I assume we're stuck with that.

-- 
Thanks,

David / dhildenb

