Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6ABC4AF3F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiBIOYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiBIOYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:24:48 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435AFC06157B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:24:51 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BB4024003D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644416688;
        bh=/jtBgBZJr0M09mLpWCdwbeiLcjTbmSLlRU+RSibqKYU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=YGUUTIfwvcVRR0dDJuxbSq0xigWUAVG8eLwYP09agamrCAMJkRbWeLt0+PkkuWbTb
         ofFFZfwu4k0B0TEGKdoV7DNCtD1RDqPeVUUv4ePTWoEi+LVzO40u7uNAVC7260kLIZ
         H/idn+M4L5PvSviQg8oWqPPRCcTarAkv78/uRloeIlLiTwS3+yL1XcSJO6WP7+kUjR
         +ewBgMNhn8lTg9dXN8R/7gB7rkw3jyq+Is2sCPborKHVoCHQl2CFeMBY9DaVKhoVwV
         BDZOPpoYsL+ADYw3/nR6rWy38CNlvee8MtKVdxi2uksHOIF01xqE2L2xKhK5IWpdDh
         VW2d9Ctkwk9uw==
Received: by mail-pj1-f69.google.com with SMTP id 62-20020a17090a09c400b001b80b0742b0so1793519pjo.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 06:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jtBgBZJr0M09mLpWCdwbeiLcjTbmSLlRU+RSibqKYU=;
        b=W0TKto7qMWjI5ruvM6duoZnBDWSZcQ70a5CHtwJkPF6SesU1IpzgAsU7O9crqAwCGD
         U9/C+cUXe1cX4OLHXkVjA9AEeK06/xQkTjxp1Sj0+xe2BCYbQsW7GkZwUquXrdPvo1vJ
         2mIpwQnGnEp0YnNg6GEbu1pbtkfLbrXAu9HXFIpewKXPimC2gqU4Dvo550a2ASHaT1bS
         MJWGnWymjejVT6R+7FiiShQ+gJaYgxX3OzOK/myZ9WzJ/fQPP8hx6Aa3Z5l3FGkvn5aH
         czXBruPNs1ZGlJ1W21mOaqAtY6tyAlv7eM9qqYqLFB9D+ukGhfpJ9WwZ8FUrEesFdEji
         sPGA==
X-Gm-Message-State: AOAM531YQ+1uxgPCx9UYKLkHUdsak1p5Q/K53MrkAmkDneueuRE18CcB
        SwqToVQdg/X5lsyKZ4zt2dEC2e0r1yCKYHes7+BaaG9oCVlOpUnW0tFmkTXMs8K5HDKvEU6FFXo
        8mi8rH/Db2bhQa0yAu4NUJS3yl2wep+O9PPbXbXVpvmJ0y9Pok3Ek7eQyTg==
X-Received: by 2002:a63:e054:: with SMTP id n20mr2021189pgj.560.1644416687083;
        Wed, 09 Feb 2022 06:24:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygdhnjzmIdoKJK8oZqTsmTcv+ATV7Y5oUO+X7KpjGBaqvsfNxvAsbj2MI8knNQg5ah/9aHDhx1a+Xn2ei7EcI=
X-Received: by 2002:a63:e054:: with SMTP id n20mr2021171pgj.560.1644416686737;
 Wed, 09 Feb 2022 06:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20220204195852.1751729-1-willy@infradead.org> <20220204195852.1751729-52-willy@infradead.org>
In-Reply-To: <20220204195852.1751729-52-willy@infradead.org>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Wed, 9 Feb 2022 11:24:34 -0300
Message-ID: <CAO9xwp2+3Sh-X8xcukLxp5NE3pLWTx=KqVhivDB33W1Xci7uHQ@mail.gmail.com>
Subject: Re: [PATCH 51/75] mm/rmap: Convert try_to_unmap() to take a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and Matthew,

On Fri, Feb 4, 2022 at 5:00 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Change both callers and the worker function try_to_unmap_one().
...
> diff --git a/mm/rmap.c b/mm/rmap.c
...
> @@ -1598,8 +1602,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>                         }
>
>                         /* MADV_FREE page check */
> -                       if (!PageSwapBacked(page)) {
> -                               if (!PageDirty(page)) {
> +                       if (!folio_test_swapbacked(folio)) {
> +                               if (!folio_test_dirty(folio)) {
>                                         /* Invalidate as we cleared the pte */
>                                         mmu_notifier_invalidate_range(mm,
>                                                 address, address + PAGE_SIZE);
> @@ -1608,11 +1612,11 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>                                 }
>
>                                 /*
> -                                * If the page was redirtied, it cannot be
> +                                * If the folio was redirtied, it cannot be
>                                  * discarded. Remap the page to page table.
>                                  */
>                                 set_pte_at(mm, address, pvmw.pte, pteval);
> -                               SetPageSwapBacked(page);
> +                               folio_set_swapbacked(folio);
>                                 ret = false;
>                                 page_vma_mapped_walk_done(&pvmw);
>                                 break;
...

This conflicts with patch [1], currently in mmotm, and I'll send
another version anyway.
Should that patch be on top of these folio changes, or the other way around?

The latter would help w/ the stable backports that don't have folios
yet, but I can
send backports there as well; not a problem.

Thanks,

[1] https://lkml.kernel.org/r/20220131230255.789059-1-mfo@canonical.com
[PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev direct IO read

-- 
Mauricio Faria de Oliveira
