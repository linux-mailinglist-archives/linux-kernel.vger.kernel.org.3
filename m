Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCC950BF6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiDVSNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbiDVSNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:13:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A748E5D187;
        Fri, 22 Apr 2022 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650651009; x=1682187009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HX/ZyQQsLl+UqtREKQBoegBeMaZnDPZSJUdaRvkzaVM=;
  b=mEoSPu+8mtqzw1UUgwDgJMPdMsXUjamfyAa+fFJvrgmeBo9oyw9SiQU7
   v9c5V3JK+S2SbBKU6lALCJ90gESXpxzCLdBGV+UklxW1AbFYjLBOeJwp3
   iHTQXmcxF20trDul51aONVHcigLPfwsqXQY5z/nNm5aA8SAmTKLZbrXVJ
   wwGvzv6RPg77iur7ADkXBW9t/eUI1+cSXI3C7+//vcDkxmt+YbIVWJGU+
   bPhl9V1vfuqQWYgsedsVm9ZA/sSPyZohdpGigb135Va2ZZYRQ1/KZEXVd
   Bwz4M15LegKhfyzMX4Xp4fcmC020w7sP8kWKP12Rmu8pqySZmMOhtMw1X
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264521726"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264521726"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 11:08:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="563138636"
Received: from hltravis-mobl1.amr.corp.intel.com (HELO localhost) ([10.213.166.215])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 11:08:46 -0700
Date:   Fri, 22 Apr 2022 11:08:46 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Message-ID: <YmLvLvnZm0DJs0r4@iweiny-desk3>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com>
 <20220421180200.16901-2-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421180200.16901-2-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:01:57PM +0200, Fabio M. De Francesco wrote:
> `scripts/kernel-doc -v -none include/linux/highmem*` reports the following
> warnings:
> 
> include/linux/highmem.h:160: warning: expecting prototype for kunmap_atomic(). Prototype was for nr_free_highpages() instead
> include/linux/highmem.h:204: warning: No description found for return value of 'alloc_zeroed_user_highpage_movable'
> include/linux/highmem-internal.h:256: warning: Function parameter or member '__addr' not described in 'kunmap_atomic'
> include/linux/highmem-internal.h:256: warning: Excess function parameter 'addr' description in 'kunmap_atomic'
> 
> Fix these warnings by (1) moving the kernel-doc comments from highmem.h to
> highmem-internal.h (which is the file were the kunmap_atomic() macro is
> actually defined), (2) extending and merging it with the comment which was
> already in highmem-internal.h, and (3) using correct parameter names.
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  include/linux/highmem-internal.h | 14 +++++++++++---
>  include/linux/highmem.h          | 15 +++------------
>  2 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index a77be5630209..b099a08e29d3 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -236,9 +236,17 @@ static inline unsigned long totalhigh_pages(void) { return 0UL; }
>  
>  #endif /* CONFIG_HIGHMEM */
>  
> -/*
> - * Prevent people trying to call kunmap_atomic() as if it were kunmap()
> - * kunmap_atomic() should get the return value of kmap_atomic, not the page.
> +/**
> + * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
> + * @__addr:       Virtual address to be unmapped
> + *
> + * Unmap an address previously mapped by kmap_atomic() and re-enables
> + * pagefaults and preemption. Mappings should be unmapped in the reverse
> + * order that they were mapped. See kmap_local_page() for details.
> + * @__addr can be any address within the mapped page, so there is no need
> + * to subtract any offset that has been added. In contrast to kunmap(),
> + * this function takes the address returned from kmap_atomic(), not the
> + * page passed to it. The compiler will warn you if you pass the page.
>   */
>  #define kunmap_atomic(__addr)					\
>  do {								\
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 39bb9b47fa9c..c3d562b5f0c1 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -37,7 +37,7 @@ static inline void *kmap(struct page *page);
>  
>  /**
>   * kunmap - Unmap the virtual address mapped by kmap()
> - * @addr:	Virtual address to be unmapped
> + * @page:	Virtual address to be unmapped
                ^^^^^^^^^^^^^^^
		Page

Not only was the name wrong but the description of an address is wrong.

Other than that LGTM:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>   *
>   * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=n and for mappings of
>   * pages in the low memory area.
> @@ -145,17 +145,6 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
>   */
>  static inline void *kmap_atomic(struct page *page);
>  
> -/**
> - * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
> - * @addr:	Virtual address to be unmapped
> - *
> - * Counterpart to kmap_atomic().
> - *
> - * Effectively a wrapper around kunmap_local() which additionally undoes
> - * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
> - * preemption.
> - */
> -
>  /* Highmem related interfaces for management code */
>  static inline unsigned int nr_free_highpages(void);
>  static inline unsigned long totalhigh_pages(void);
> @@ -191,6 +180,8 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>   * @vma: The VMA the page is to be allocated for
>   * @vaddr: The virtual address the page will be inserted into
>   *
> + * Returns: The allocated and zeroed HIGHMEM page
> + *
>   * This function will allocate a page for a VMA that the caller knows will
>   * be able to migrate in the future using move_pages() or reclaimed
>   *
> -- 
> 2.34.1
> 
