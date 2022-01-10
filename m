Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA414893C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbiAJIkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241829AbiAJIh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641803844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3ZXbLvGYI/b7mbTJ6ZItXOIrU+G5SGQYBHJoZKG4+k=;
        b=cjDegLFzCpWcsusUvPrQqQedjTey2/Y0lJjOasI6e3hiHSw9nrsZ7P+loGi7PyWyFTnvOo
        9burXV8TTTVkvBLcyvEX9qpKez84vgXg+QJBCOZyfsbxFztbByMwFs1wrvLFbt5zQA2hyb
        Xlh56YirUQdSUvrziYBIDOP2jAEJGZA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-v7PVH9VaORaR4b7htta6Fw-1; Mon, 10 Jan 2022 03:37:18 -0500
X-MC-Unique: v7PVH9VaORaR4b7htta6Fw-1
Received: by mail-ed1-f69.google.com with SMTP id m16-20020a056402431000b003fb60bbe0e2so6690755edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=J3ZXbLvGYI/b7mbTJ6ZItXOIrU+G5SGQYBHJoZKG4+k=;
        b=Sac8KRq0Zqjfd+ZPUdDQNQ52y/OqrySosp5cZxbdSrvMTT5BUK8R85cA5RmR74HVQH
         5aCEv6C5fd89RlbXl8WQekofESp5IVrxWtxcLYpNt0D95uCAgJ7ONEqOYvfT+6Aoc/3e
         nQYGRQz8dtX9ss+jeSw1+xnscdOI9EBeSuCNnqQHeCIkL/EkUzTrfPLTWWDXDZcrqrwa
         BRW5zmz4SLa/64aG4BTC/LCqVbEqxmP6jxXqO8HTIQ8csyNiqBJfuZGYcrCGjOrv99IE
         sJgIgAMzaaHkbtvc19RVBVQm0kZS68iJY40Zn9EJQfbUsXKmh0OHsT3vR/lGPYkwFjwR
         HkuA==
X-Gm-Message-State: AOAM530zPdmUJNjBb1DVgfX9m/5NBq200fGLZfuoytePUOXiEfzXF7Of
        5E/eituofc2lfW/ullGeYjG7Z65vLzb81MdCuvJxnenutoVtBH6d41R614DP7UOdXhVIjmNJxPG
        eml84nRNc062gS28D6VcpcITn
X-Received: by 2002:a17:907:6d1b:: with SMTP id sa27mr6854697ejc.526.1641803836969;
        Mon, 10 Jan 2022 00:37:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNgqZ92X1ml6n44KUvzn1t6/3Y7Na64azssIYicpA2bzsb1xabTGbFZDZ4nQdxYF38tZXVig==
X-Received: by 2002:a17:907:6d1b:: with SMTP id sa27mr6854677ejc.526.1641803836723;
        Mon, 10 Jan 2022 00:37:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:cf00:ac25:f2e3:db05:65c3? (p200300cbc701cf00ac25f2e3db0565c3.dip0.t-ipconnect.de. [2003:cb:c701:cf00:ac25:f2e3:db05:65c3])
        by smtp.gmail.com with ESMTPSA id b4sm2150892ejb.131.2022.01.10.00.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:37:16 -0800 (PST)
Message-ID: <849f1e44-d35e-b8c6-c7c3-a73941028ba7@redhat.com>
Date:   Mon, 10 Jan 2022 09:37:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-2-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
In-Reply-To: <20211115134951.85286-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.21 14:49, Peter Xu wrote:
> This check existed since the 1st git commit of Linux repository, but at that
> time there's no page migration yet so I think it's okay.
> 
> With page migration enabled, it should logically be possible that we zap some
> shmem pages during migration.  When that happens, IIUC the old code could have
> the RSS counter accounted wrong on MM_SHMEMPAGES because we will zap the ptes
> without decreasing the counters for the migrating entries.  I have no unit test
> to prove it as I don't know an easy way to trigger this condition, though.
> 
> Besides, the optimization itself is already confusing IMHO to me in a few points:
> 
>   - The wording "skip swap entries" is confusing, because we're not skipping all
>     swap entries - we handle device private/exclusive pages before that.

I think one part of the confusion is "swap vs non-swap" entries.
For !pte_none() && !pte_present() we can have

* swap entry
* non-swap entry
** device exclusive entry
** device private entry
** HWpoison entry
** migration entry

So the comment claims to skip "swap entries" but also skips HWpoison and
migration entries, and I think that's the confusing part.
Both only apply to PageAnon().


IIUC, the only way we could get details != NULL is via unmap_mapping_page()+unmap_mapping_pages().

I do wonder if any of the callers really cares about PageAnon() pages where this would be relevant.

Am I wrong or is unmap_mapping_pages() never called with "even_cows == true" and we can remove
that paremeter:


git grep -C2 unmap_mapping_pages
fs/afs/callback.c-      struct afs_vnode *vnode = container_of(work, struct afs_vnode, cb_work);
fs/afs/callback.c-
fs/afs/callback.c:      unmap_mapping_pages(vnode->vfs_inode.i_mapping, 0, 0, false);
fs/afs/callback.c-}
fs/afs/callback.c-
--
fs/dax.c-               if (dax_is_zero_entry(entry)) {
fs/dax.c-                       xas_unlock_irq(xas);
fs/dax.c:                       unmap_mapping_pages(mapping,
fs/dax.c-                                       xas->xa_index & ~PG_PMD_COLOUR,
fs/dax.c-                                       PG_PMD_NR, false);
--
fs/dax.c-        * get_user_pages() slow path.  The slow path is protected by
fs/dax.c-        * pte_lock() and pmd_lock(). New references are not taken without
fs/dax.c:        * holding those locks, and unmap_mapping_pages() will not zero the
fs/dax.c-        * pte or pmd without holding the respective lock, so we are
fs/dax.c-        * guaranteed to either see new references or prevent new
fs/dax.c-        * references from being established.
fs/dax.c-        */
fs/dax.c:       unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1, 0);
fs/dax.c-
fs/dax.c-       xas_lock_irq(&xas);
--
fs/dax.c-               /* we are replacing a zero page with block mapping */
fs/dax.c-               if (dax_is_pmd_entry(entry))
fs/dax.c:                       unmap_mapping_pages(mapping, index & ~PG_PMD_COLOUR,
fs/dax.c-                                       PG_PMD_NR, false);
fs/dax.c-               else /* pte entry */
fs/dax.c:                       unmap_mapping_pages(mapping, index, 1, false);
fs/dax.c-       }
fs/dax.c-
--
include/linux/mm.h-                         bool *unlocked);
include/linux/mm.h-void unmap_mapping_page(struct page *page);
include/linux/mm.h:void unmap_mapping_pages(struct address_space *mapping,
include/linux/mm.h-             pgoff_t start, pgoff_t nr, bool even_cows);
include/linux/mm.h-void unmap_mapping_range(struct address_space *mapping,
--
include/linux/mm.h-}
include/linux/mm.h-static inline void unmap_mapping_page(struct page *page) { }
include/linux/mm.h:static inline void unmap_mapping_pages(struct address_space *mapping,
include/linux/mm.h-             pgoff_t start, pgoff_t nr, bool even_cows) { }
include/linux/mm.h-static inline void unmap_mapping_range(struct address_space *mapping,
--
mm/khugepaged.c-
mm/khugepaged.c-                if (page_mapped(page))
mm/khugepaged.c:                        unmap_mapping_pages(mapping, index, 1, false);
mm/khugepaged.c-
mm/khugepaged.c-                xas_lock_irq(&xas);
--
mm/memory.c- * Unmap this page from any userspace process which still has it mmaped.
mm/memory.c- * Typically, for efficiency, the range of nearby pages has already been
mm/memory.c: * unmapped by unmap_mapping_pages() or unmap_mapping_range().  But once
mm/memory.c- * truncation or invalidation holds the lock on a page, it may find that
mm/memory.c- * the page has been remapped again: and then uses unmap_mapping_page()
--
mm/memory.c-
mm/memory.c-/**
mm/memory.c: * unmap_mapping_pages() - Unmap pages from processes.
mm/memory.c- * @mapping: The address space containing pages to be unmapped.
mm/memory.c- * @start: Index of first page to be unmapped.
--
mm/memory.c- * cache.
mm/memory.c- */
mm/memory.c:void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
mm/memory.c-            pgoff_t nr, bool even_cows)
mm/memory.c-{
--
mm/memory.c-    i_mmap_unlock_write(mapping);
mm/memory.c-}
mm/memory.c:EXPORT_SYMBOL_GPL(unmap_mapping_pages);
mm/memory.c-
mm/memory.c-/**
--
mm/memory.c-    }
mm/memory.c-
mm/memory.c:    unmap_mapping_pages(mapping, hba, hlen, even_cows);
mm/memory.c-}
mm/memory.c-EXPORT_SYMBOL(unmap_mapping_range);
--
mm/truncate.c-                           * zap the rest of the file in one hit.
mm/truncate.c-                           */
mm/truncate.c:                          unmap_mapping_pages(mapping, index,
mm/truncate.c-                                          (1 + end - index), false);
mm/truncate.c-                          did_range_unmap = 1;
--
mm/truncate.c-   */
mm/truncate.c-  if (dax_mapping(mapping)) {
mm/truncate.c:          unmap_mapping_pages(mapping, start, end - start + 1, false);
mm/truncate.c-  }
mm/truncate.c-out:


-- 
Thanks,

David / dhildenb

