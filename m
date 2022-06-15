Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF3A54D06A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358262AbiFORxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbiFORxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:53:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDCD33E30
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:53:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k7so1681741plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7490IR4u02XQR5Rx7eoe3R4qdOLni9htSGuUTdPLVYA=;
        b=KEHOZIsr6INrHpmLs6MZXeDUYYHY5HNCqRxG73Sz35/4gussDzCfuA8qC4mRSt2T7l
         DCyWH1tXqBXL9xls0S1CUuBnBuTFQl94uw8VYX4sp8DqBs1/LNJK4snKvrAwZcQALw0B
         SZUpmdgm6YQTwtHKzfGs7GV8//2YR5wyOCyNBlK34b9gchnZIO9E9FsXClR7YZ2WzM2k
         pkIaPoKdXz9iTmCS5VFCzRPsjGQALQrvGcY3i0frCGeOsfOFvMfMpxSUiAQzvns5lrpz
         qh5wdbokPBfdKu4kHt8kxaqMYGUxsgN5q2OHdttc+Q2lOFnM53/KPUCzLX14G7n5H3Rf
         1tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7490IR4u02XQR5Rx7eoe3R4qdOLni9htSGuUTdPLVYA=;
        b=VKwQvOAE9Rf8Cmku2w+TpLEt69znKg9VMs4EH3jNmDW99J6J1OE1W1RxujaEyc/EuI
         SjGr+p1zWpQDjEECpf+QNaY5L5wYkUj2KCAYPAhMk/vT1+d9iOOKFh7ujVLtbtmPGlEa
         UKLwaH8DtKOpHH3FPt4kaGj0sAOkqVpgIcqb1yzE7dToalPW0Iz3Rd1wBxbyh35iiibh
         1Yd27ijStsACnIYO0y/IXVKkVpPx4hZOEOlrwQA69y6csKSzA4bsAhiz2OrSzDXxnfTT
         RBhhyosIulzn+hcQEQbqQQ2LtAix6pqXfLR6f2T395fAuWyqDpDzmcC0hpiG7M0JpLJb
         lf6A==
X-Gm-Message-State: AJIora+FkCbE2bilqVs2wqZGgNCdBNcOzOqrWplVg3mW3zSqo/0gRSZn
        +6xKxR0EQK6T+/w7DYi7wR7Dxh3tKNDuBZixwk4=
X-Google-Smtp-Source: AGRyM1vPqbItoG7qZmRwvuecyIl7+jw3KNUfRZn6FWYRHajhbjya+hjZ9ZKi7WlcFjdgLC7Zd0Df81bUgvk9NSfonhs=
X-Received: by 2002:a17:902:8492:b0:167:6cbf:145b with SMTP id
 c18-20020a170902849200b001676cbf145bmr953726plo.26.1655315628118; Wed, 15 Jun
 2022 10:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220611084731.55155-1-linmiaohe@huawei.com> <20220611084731.55155-4-linmiaohe@huawei.com>
In-Reply-To: <20220611084731.55155-4-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Jun 2022 10:53:36 -0700
Message-ID: <CAHbLzkpy-uR4ZhS6A6zybu-Mw=Uy5XunxtG6WviM6pfFHkA9NQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] mm/khugepaged: trivial typo and codestyle cleanup
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 1:47 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Fix some typos and tweak the code to meet codestyle. No functional
> change intended.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/khugepaged.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a8adb2d1e9c6..1b5dd3820eac 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -260,7 +260,7 @@ static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
>         unsigned long max_ptes_none;
>
>         err = kstrtoul(buf, 10, &max_ptes_none);
> -       if (err || max_ptes_none > HPAGE_PMD_NR-1)
> +       if (err || max_ptes_none > HPAGE_PMD_NR - 1)
>                 return -EINVAL;
>
>         khugepaged_max_ptes_none = max_ptes_none;
> @@ -286,7 +286,7 @@ static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
>         unsigned long max_ptes_swap;
>
>         err  = kstrtoul(buf, 10, &max_ptes_swap);
> -       if (err || max_ptes_swap > HPAGE_PMD_NR-1)
> +       if (err || max_ptes_swap > HPAGE_PMD_NR - 1)
>                 return -EINVAL;
>
>         khugepaged_max_ptes_swap = max_ptes_swap;
> @@ -313,7 +313,7 @@ static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
>         unsigned long max_ptes_shared;
>
>         err  = kstrtoul(buf, 10, &max_ptes_shared);
> -       if (err || max_ptes_shared > HPAGE_PMD_NR-1)
> +       if (err || max_ptes_shared > HPAGE_PMD_NR - 1)
>                 return -EINVAL;
>
>         khugepaged_max_ptes_shared = max_ptes_shared;
> @@ -599,7 +599,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>         int none_or_zero = 0, shared = 0, result = 0, referenced = 0;
>         bool writable = false;
>
> -       for (_pte = pte; _pte < pte+HPAGE_PMD_NR;
> +       for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>              _pte++, address += PAGE_SIZE) {
>                 pte_t pteval = *_pte;
>                 if (pte_none(pteval) || (pte_present(pteval) &&
> @@ -1216,7 +1216,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>
>         memset(khugepaged_node_load, 0, sizeof(khugepaged_node_load));
>         pte = pte_offset_map_lock(mm, pmd, address, &ptl);
> -       for (_address = address, _pte = pte; _pte < pte+HPAGE_PMD_NR;
> +       for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>              _pte++, _address += PAGE_SIZE) {
>                 pte_t pteval = *_pte;
>                 if (is_swap_pte(pteval)) {
> @@ -1306,7 +1306,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>                 /*
>                  * Check if the page has any GUP (or other external) pins.
>                  *
> -                * Here the check is racy it may see totmal_mapcount > refcount
> +                * Here the check is racy it may see total_mapcount > refcount
>                  * in some cases.
>                  * For example, one process with one forked child process.
>                  * The parent has the PMD split due to MADV_DONTNEED, then
> @@ -1557,7 +1557,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>                  * mmap_write_lock(mm) as PMD-mapping is likely to be split
>                  * later.
>                  *
> -                * Not that vma->anon_vma check is racy: it can be set up after
> +                * Note that vma->anon_vma check is racy: it can be set up after
>                  * the check but before we took mmap_lock by the fault path.
>                  * But page lock would prevent establishing any new ptes of the
>                  * page, so we are safe.
> --
> 2.23.0
>
>
