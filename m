Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA349FB02
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241018AbiA1NpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:45:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243502AbiA1NpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643377502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10Eey55xTkOQ+M0ixDUVHuv817gP1iR41jEopYowSyE=;
        b=fcsaRwoZgyyUFmjWIantrZ4qGlceLuq4v5EgUrxzl0c9xV6+n/2ue+YYbwzH1LUTD2uvdI
        7ZlYPjAkODwrC6sjfb/uo3+LmF0ahCIH+G86Ioc52tCVTugWuSTt0amSqDYmTHA6T2YqFw
        4JuLVx+owjxbrJtbe6cFt1SLuLLb8VY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-8Gc8rxJgNHWnLVbNzlqDww-1; Fri, 28 Jan 2022 08:45:01 -0500
X-MC-Unique: 8Gc8rxJgNHWnLVbNzlqDww-1
Received: by mail-ed1-f69.google.com with SMTP id i22-20020a50fd16000000b00405039f2c59so3071020eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=10Eey55xTkOQ+M0ixDUVHuv817gP1iR41jEopYowSyE=;
        b=iWSICKvMj2NX3ctgg0WTUMS5NIYwstdQqIerm0dMDJp827Iu4vuzWAYQjPBsiZhAV/
         LMouwF6wUdhK3HuxrKHOrajuYXWfC+uaSpUkeWxA4th3rUGGsFQTOq7/dYobjalKtTiN
         /x+jCAFrvm0fEw+3PiTTpcuCoA/Wf7v/WCdNnEz7uZsfjj0vnwE+d8cFIdFi2tTLxEhC
         zzUKfFeKi0pr8XkRmDdXMKwAtatTgzMqxZe+nJacHm+QSv3Twpo9wCNKdnuhP/PpC91r
         Kv/K+6HVy9od37SkTl8l9fVnufQpek9Jci97btl41mlntlOfh8oBvJklo2N/23uxxfVe
         n61Q==
X-Gm-Message-State: AOAM533I/4bmsyc6f3vusetuwvYHZglzxWFsrNt3SA+QLGm1Qc5jWko8
        ge+J75IC79EnIqycP9QVtr1XCa/O3T39g6miU8k+03c+y60sBUZbS65f/3lccRGTYW7y6mUhwzG
        3QSMPUQtAY7VTxlt/qIG0Qkys
X-Received: by 2002:a17:906:c154:: with SMTP id dp20mr6684490ejc.184.1643377499211;
        Fri, 28 Jan 2022 05:44:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNCBP2VMhlbABcw/y5YRl4UJdpLwVqkyx6+POBcHA0b4voAnDuiuMbH6TeQTA5UHRobKcEMA==
X-Received: by 2002:a17:906:c154:: with SMTP id dp20mr6684430ejc.184.1643377498306;
        Fri, 28 Jan 2022 05:44:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5c00:522f:9bcd:24a0:cd70? (p200300cbc70e5c00522f9bcd24a0cd70.dip0.t-ipconnect.de. [2003:cb:c70e:5c00:522f:9bcd:24a0:cd70])
        by smtp.gmail.com with ESMTPSA id g24sm10046770ejx.11.2022.01.28.05.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 05:44:57 -0800 (PST)
Message-ID: <661673b1-5559-d234-da7a-c07263aef520@redhat.com>
Date:   Fri, 28 Jan 2022 14:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>
References: <20220126095557.32392-1-david@redhat.com>
 <20220126095557.32392-2-david@redhat.com>
 <595b8e80-96c0-dab6-5d13-652f0a0e40ec@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC v2 1/9] mm: optimize do_wp_page() for exclusive pages
 in the swapcache
In-Reply-To: <595b8e80-96c0-dab6-5d13-652f0a0e40ec@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.22 13:53, Vlastimil Babka wrote:
> On 1/26/22 10:55, David Hildenbrand wrote:
>> Liang Zhang reported [1] that the current COW logic in do_wp_page() is
>> sub-optimal when it comes to swap+read fault+write fault of anonymous
>> pages that have a single user, visible via a performance degradation in
>> the redis benchmark. Something similar was previously reported [2] by
>> Nadav with a simple reproducer.
> 
> Can we make the description more self-contained? I.e. describe that
> sub-optimal COW means we copy when it's not necessary, and this can happen
> if swap-out is followed by a swap-in for read and a then a write fault
> (IIUC), because the swap cache reference increases page_count()..

Sure, I can add some more details.

> 
>> Let's optimize for pages that have been added to the swapcache but only
>> have an exclusive owner. Try removing the swapcache reference if there is
>> hope that we're the exclusive user.
> 
> Can we expect any downside for reclaim efficiency due to the more aggressive
> removal from swapcache? Probably not, as we are doing the removal when the
> page is about to get dirty, so we wouldn't be able to reuse any previously
> swapped out content anyway. Maybe it's even beneficial?

We're only try removing the swapcache reference if it's likely that we
succeed in reusing the page after we succeeded in removing the swapcache
reference (IOW, no other swap entries, no writeback).

So the early "page_count(page) > 1 + PageSwapCache(page)" check is of
big value I think. It should be rare that we remove the reference and
still end up with "page_count(page) != 1".

And if we're reusing the page (re-dirtying it), removing it from the
swapache is the right thing to do: reuse_swap_cache() would have done
the same.

[...]

>>
>> Reported-by: Liang Zhang <zhangliang5@huawei.com>
>> Reported-by: Nadav Amit <nadav.amit@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!


-- 
Thanks,

David / dhildenb

