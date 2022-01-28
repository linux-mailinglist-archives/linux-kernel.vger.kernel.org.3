Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6253349F5DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiA1JD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:03:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230179AbiA1JDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643360604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6fRFZaCxJ9/sKr7eukzgsxP2eZihqtSLhrBXhP7zxA=;
        b=GfDddd73q9tt9uPHozJOcVxY51iVwyDXqkMZbqw2DArnLJJsGLv9iQlVS7peL+adRJ0JzJ
        LhlTCqHaUZP8mwaIcKJNhCefRer3fGEbBDm9586Wm/CZbTah/GV79ousSYMExEeuV+weXV
        zxKaXqf776jnH/WWz9/PHrzY6kuhQIE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-7hb1BxDBOG6N-c7CHq0Vhw-1; Fri, 28 Jan 2022 04:03:23 -0500
X-MC-Unique: 7hb1BxDBOG6N-c7CHq0Vhw-1
Received: by mail-ed1-f72.google.com with SMTP id ed6-20020a056402294600b004090fd8a936so2732376edb.23
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=k6fRFZaCxJ9/sKr7eukzgsxP2eZihqtSLhrBXhP7zxA=;
        b=gdTnXDtnEqBbXZVO/+zwTahiwn/XRwTVVC0sDa/sELirZp8/iBYXOh+zQHCDnRa99P
         ySYrjovato7DIxb+6IsW3ZjPr6o+NSjXLaZ8l+VOZMtavfBXstIciCwuMhqF8p8mp/P4
         kdxV013p6BgYqgoo2Q2/35md6z781449s3I13YXdPDkDyqNafX5MrDLa3PDmjxPKpXNe
         tIGZ2CK7HSZg4HdOoueDK0jzYMMEcPaEm/MPAKfy46BIqqFdcreIn6Z/f2dASYPc/XdL
         ukf95P3QHL5tdNYlt4YaMNSMIuqfoIGHdw+aO4Vbc7sG8AtoAcQpFhQVKsXglvppNYGo
         wmcw==
X-Gm-Message-State: AOAM5310VWO07m7ogv3J36X5YlKbvByIUwcocad1UU8kEw3lW+F3So/d
        lXBiEyU1wxJ3oXFN3KOud8mxPEZrEx6fScuBV+taZpv9/XJjrm9LYkVg7Xavd37e4qyuRL0h+94
        m5nIxnbOoBaV0o2oTTlcl9joO
X-Received: by 2002:aa7:d313:: with SMTP id p19mr7550079edq.380.1643360601822;
        Fri, 28 Jan 2022 01:03:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwLTfB+FQpW/Kh46RzIU62HlxvCR6hkBiYhxXWrkOPDyzrf6sUvdJ0chSBKeGemvbFZzeuFw==
X-Received: by 2002:aa7:d313:: with SMTP id p19mr7550062edq.380.1643360601598;
        Fri, 28 Jan 2022 01:03:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5c00:522f:9bcd:24a0:cd70? (p200300cbc70e5c00522f9bcd24a0cd70.dip0.t-ipconnect.de. [2003:cb:c70e:5c00:522f:9bcd:24a0:cd70])
        by smtp.gmail.com with ESMTPSA id u12sm12634499edq.8.2022.01.28.01.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 01:03:21 -0800 (PST)
Message-ID: <847ceb80-d379-b704-8b47-0d662468370b@redhat.com>
Date:   Fri, 28 Jan 2022 10:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/4] mm: Change zap_details.zap_mapping into even_cows
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20220128045412.18695-1-peterx@redhat.com>
 <20220128045412.18695-4-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220128045412.18695-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.22 05:54, Peter Xu wrote:
> Currently we have a zap_mapping pointer maintained in zap_details, when it is
> specified we only want to zap the pages that has the same mapping with what the
> caller has specified.
> 
> But what we want to do is actually simpler: we want to skip zapping
> private (COW-ed) pages in some cases.  We can refer to unmap_mapping_pages()
> callers where we could have passed in different even_cows values.  The other
> user is unmap_mapping_folio() where we always want to skip private pages.
> 
> According to Hugh, we used a mapping pointer for historical reason, as
> explained here:
> 
>   https://lore.kernel.org/lkml/391aa58d-ce84-9d4-d68d-d98a9c533255@google.com/
> 
> Quotting partly from Hugh:

s/Quotting/Quoting/

> 
>   Which raises the question again of why I did not just use a boolean flag
>   there originally: aah, I think I've found why.  In those days there was a
>   horrible "optimization", for better performance on some benchmark I guess,
>   which when you read from /dev/zero into a private mapping, would map the zero
>   page there (look up read_zero_pagealigned() and zeromap_page_range() if you
>   dare).  So there was another category of page to be skipped along with the
>   anon COWs, and I didn't want multiple tests in the zap loop, so checking
>   check_mapping against page->mapping did both.  I think nowadays you could do
>   it by checking for PageAnon page (or genuine swap entry) instead.
> 
> This patch replaced the zap_details.zap_mapping pointer into the even_cows
> boolean, then we check it against PageAnon.
> 
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 14d8428ff4db..ffa8c7dfe9ad 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1309,8 +1309,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>   * Parameter block passed down to zap_pte_range in exceptional cases.
>   */
>  struct zap_details {
> -	struct address_space *zap_mapping;	/* Check page->mapping if set */
>  	struct folio *single_folio;	/* Locked folio to be unmapped */
> +	bool even_cows;			/* Zap COWed private pages too? */
>  };
>  
>  /* Whether we should zap all COWed (private) pages too */
> @@ -1321,13 +1321,10 @@ static inline bool should_zap_cows(struct zap_details *details)
>  		return true;
>  
>  	/* Or, we zap COWed pages only if the caller wants to */
> -	return !details->zap_mapping;
> +	return details->even_cows;
>  }
>  
> -/*
> - * We set details->zap_mapping when we want to unmap shared but keep private
> - * pages. Return true if we should zap this page, false otherwise.
> - */
> +/* Decides whether we should zap this page with the page pointer specified */
>  static inline bool should_zap_page(struct zap_details *details, struct page *page)
>  {
>  	/* If we can make a decision without *page.. */
> @@ -1338,7 +1335,8 @@ static inline bool should_zap_page(struct zap_details *details, struct page *pag
>  	if (!page)
>  		return true;
>  
> -	return details->zap_mapping == page_rmapping(page);
> +	/* Otherwise we should only zap non-anon pages */
> +	return !PageAnon(page);
>  }
>  
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> @@ -3403,7 +3401,7 @@ void unmap_mapping_folio(struct folio *folio)
>  	first_index = folio->index;
>  	last_index = folio->index + folio_nr_pages(folio) - 1;
>  
> -	details.zap_mapping = mapping;
> +	details.even_cows = false;

Already initialized to 0 via struct zap_details details = { };

We could think about

struct zap_details details = {
	.single_folio = folio,
};

>  	details.single_folio = folio;
>  
>  	i_mmap_lock_write(mapping);
> @@ -3432,7 +3430,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  	pgoff_t	first_index = start;
>  	pgoff_t	last_index = start + nr - 1;
>  
> -	details.zap_mapping = even_cows ? NULL : mapping;
> +	details.even_cows = even_cows;
>  	if (last_index < first_index)
>  		last_index = ULONG_MAX;
>  

Eventually

struct zap_details details = {
	.even_cows = even_cows,
};

-- 
Thanks,

David / dhildenb

