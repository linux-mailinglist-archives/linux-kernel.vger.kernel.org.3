Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBE858E462
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiHJBOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiHJBNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:13:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49422804AA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660094030; x=1691630030;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=8Xge/9Yr6O6A+kIvlPS10YwFvkruFukln1LqLT800M8=;
  b=V+gtvCX1UfmnGMeAlJhL8zADSo2UkyF0javTEpTGUOUVaOvTO6mM8vVJ
   6bWM9MCW4fmlMVSY8Hi8AUb6A5yIzEYTySbI2AIGYgu+D3q8DAiM2AOxE
   iUtyQS+NjoDtol+mrtXrUvdFcv4qmsjqqxCQsCPNCjyAupYNAwvC/NMXv
   Q394imu85Yd5NNVf8ClIOBaHVVlOhDgsT3M6I2UuDZCX2XKs87V6Wwcuz
   GQmCSdyuZcm/HEZbbP4j+Vmc2/8wg9ZQVWBBeAP7Jik0NLZVHTBxfcsVo
   nJAXcArhQYtIoQHoJwbYUzozAOnMMMkmCpIYzgBgLFC1fxShmWkSLwfwu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="290971286"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="290971286"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 18:13:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="673104676"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 18:13:47 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 1/7] mm/x86: Use SWP_TYPE_BITS in 3-level swap macros
References: <20220809220100.20033-1-peterx@redhat.com>
        <20220809220100.20033-2-peterx@redhat.com>
Date:   Wed, 10 Aug 2022 09:13:44 +0800
In-Reply-To: <20220809220100.20033-2-peterx@redhat.com> (Peter Xu's message of
        "Tue, 9 Aug 2022 18:00:54 -0400")
Message-ID: <87k07ggat3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> Replace all the magic "5" with the macro.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying

> ---
>  arch/x86/include/asm/pgtable-3level.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
> index e896ebef8c24..28421a887209 100644
> --- a/arch/x86/include/asm/pgtable-3level.h
> +++ b/arch/x86/include/asm/pgtable-3level.h
> @@ -256,10 +256,10 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
>  /* We always extract/encode the offset by shifting it all the way up, and then down again */
>  #define SWP_OFFSET_SHIFT	(SWP_OFFSET_FIRST_BIT + SWP_TYPE_BITS)
>  
> -#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > 5)
> -#define __swp_type(x)			(((x).val) & 0x1f)
> -#define __swp_offset(x)			((x).val >> 5)
> -#define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) << 5})
> +#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS)
> +#define __swp_type(x)			(((x).val) & ((1UL << SWP_TYPE_BITS) - 1))
> +#define __swp_offset(x)			((x).val >> SWP_TYPE_BITS)
> +#define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) << SWP_TYPE_BITS})
>  
>  /*
>   * Normally, __swp_entry() converts from arch-independent swp_entry_t to
