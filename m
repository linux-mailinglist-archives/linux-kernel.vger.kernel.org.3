Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE264FF94C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiDMOtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiDMOsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:48:54 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FB063BE7;
        Wed, 13 Apr 2022 07:46:32 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id p65so4133200ybp.9;
        Wed, 13 Apr 2022 07:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgKi5d12e4FAl/0V1LdompotqB5pfVogXOB1g3Gr0Ac=;
        b=UaH1hLc0mPWksMzgVsudp0JU/lWU81GM7bQp42HEl7RzGPWKQDEqh8xUT3pw3j7JrH
         +x6uBP7WxLBRKcQdQP4lHyk12AdS7L4bZMZslJQAO1P+TbNkJg/meMGneoXstY69Lw8s
         ShxXHOb4FY+njqb6dBFAq8JS7LiJAaiEBJRmQchtqZeigZYnwrb7MkLs6dgVuT5iClDp
         7gHTGmgOejR3jz87dUyPYizgvAw065H6rwlUy8Z9fnaOX53ekMtXD4cA9CgvLtFms7PN
         0IKfaPO/V85Mg+5G5PfpOut6c+uT+Iyh2vBQz5zyBsy3H06H0RcVwfm6r0c3pnOvKGUL
         2UyQ==
X-Gm-Message-State: AOAM531gM4XvNRLSrvUvIWUi1oM7xNT+IE6M4YlhF26ncrMJTzB57juP
        BzvQ5g2eaJmHNr+0xkip+MvBWBCSA+U7ymfY+dw=
X-Google-Smtp-Source: ABdhPJxExu+Dw9bX39rPq1txg98SmRbBG64o0lPvSHYo4nUeuNV9jjWQMrpraSw9bV+jM7JW4zv01Yi0vRfqx+qNaYw=
X-Received: by 2002:a05:6902:1544:b0:63d:d3a7:8cc4 with SMTP id
 r4-20020a056902154400b0063dd3a78cc4mr31293846ybu.622.1649861191424; Wed, 13
 Apr 2022 07:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220325014415.110740-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220325014415.110740-1-yang.lee@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 16:46:20 +0200
Message-ID: <CAJZ5v0i-rU9R7j3YTdGBfOw_0jfaDVLKFefuxntEbZbViyZnCQ@mail.gmail.com>
Subject: Re: [PATCH -next] kernel/power: Fix some kernel-doc comments
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 2:44 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Add parameter description in alloc_rtree_node()  kernel-doc
> comment and fix several inconsistent function name descriptions.
>
> Remove some warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
>
> kernel/power/snapshot.c:438: warning: Function parameter or member
> 'gfp_mask' not described in 'alloc_rtree_node'
> kernel/power/snapshot.c:438: warning: Function parameter or member
> 'safe_needed' not described in 'alloc_rtree_node'
> kernel/power/snapshot.c:438: warning: Function parameter or member 'ca'
> not described in 'alloc_rtree_node'
> kernel/power/snapshot.c:438: warning: Function parameter or member
> 'list' not described in 'alloc_rtree_node'
> kernel/power/snapshot.c:916: warning: expecting prototype for
> memory_bm_rtree_next_pfn(). Prototype was for memory_bm_next_pfn()
> instead
> kernel/power/snapshot.c:1947: warning: expecting prototype for
> alloc_highmem_image_pages(). Prototype was for alloc_highmem_pages()
> instead
> kernel/power/snapshot.c:2230: warning: expecting prototype for load
> header(). Prototype was for load_header() instead
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  kernel/power/snapshot.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 330d49937692..89c8f9df9fdc 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -427,6 +427,12 @@ struct memory_bitmap {
>
>  /**
>   * alloc_rtree_node - Allocate a new node and add it to the radix tree.
> + * @gfp_mask: GFP mask for the allocation.
> + * @safe_needed: Get pages that were not used before hibernation
> + *              (restore only)
> + * @ca: used for allocating small objects out of a linked list of pages
> + *     called 'the chain'.
> + * @list: the inner node or leave of Radix Tree to add.
>   *
>   * This function is used to allocate inner nodes as well as the
>   * leave nodes of the radix tree. It also adds the node to the
> @@ -902,7 +908,7 @@ static bool rtree_next_node(struct memory_bitmap *bm)
>  }
>
>  /**
> - * memory_bm_rtree_next_pfn - Find the next set bit in a memory bitmap.
> + * memory_bm_next_pfn - Find the next set bit in a memory bitmap.
>   * @bm: Memory bitmap.
>   *
>   * Starting from the last returned position this function searches for the next
> @@ -1937,7 +1943,7 @@ static inline int get_highmem_buffer(int safe_needed)
>  }
>
>  /**
> - * alloc_highmem_image_pages - Allocate some highmem pages for the image.
> + * alloc_highmem_pages - Allocate some highmem pages for the image.
>   *
>   * Try to allocate as many pages as needed, but if the number of free highmem
>   * pages is less than that, allocate them all.
> @@ -2224,7 +2230,7 @@ static int check_header(struct swsusp_info *info)
>  }
>
>  /**
> - * load header - Check the image header and copy the data from it.
> + * load_header - Check the image header and copy the data from it.
>   */
>  static int load_header(struct swsusp_info *info)
>  {
> --

Applied as 5.19 with edits in the subject and some comment adjustments
to avoid line breaks in kerne-doc.

Thanks!
