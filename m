Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B64FC17C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348301AbiDKPyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiDKPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:54:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7E72126C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649692319; x=1681228319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O3c2sru/Ro2NHdk9MOmll5J24V6BmPvGXpDCAy6U6Hc=;
  b=CNqe6MV+yFeKaKEt//s5wVJ6zemsSsbSPpXuroYLsuo7n1w4Ox/PFR6R
   KB79u1GSpLG5CFLduEbSKX0D7e+bFo/++KWeGuOq5DJGr2dSnXmDGBPL9
   Br0pcpeGPP8ZiqMpsOMZjdWvKiq6LgzgZcBlZTpzoXVypPyKcpkqtKoUT
   fc09J111lWKo/M2aHMizDG7NvrVXZ+D2onUa7z1+dpRdeVE6HmC/nbzi+
   4D5uBwvZt9pUkvcSi5VBR+74LoORNcXWVtuhMJG3OiKIBETur/Z+daQiO
   ynKRefDgiY792fsjWo0RKIm8ILvMgNX9XLH5O0izqd9y+z2cZWQRKXrXS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261586713"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261586713"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 08:51:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="526029217"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 08:51:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndwH3-001J8J-PI;
        Mon, 11 Apr 2022 18:48:17 +0300
Date:   Mon, 11 Apr 2022 18:48:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] include/linux/find: Fix documentation
Message-ID: <YlRNwV3jlikHfu/v@smile.fi.intel.com>
References: <20220411150555.26023-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411150555.26023-1-anna-maria@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 05:05:55PM +0200, Anna-Maria Behnsen wrote:
> The order of the arguments in function documentation doesn't fit the
> implementation. Change the documentation so that it corresponds to the
> code. This prevent people to get confused when reading the documentation.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  include/linux/find.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/find.h b/include/linux/find.h
> index 5bb6db213bcb..424ef67d4a42 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -21,8 +21,8 @@ extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long siz
>  /**
>   * find_next_bit - find the next set bit in a memory region
>   * @addr: The address to base the search on
> - * @offset: The bitnumber to start searching at
>   * @size: The bitmap size in bits
> + * @offset: The bitnumber to start searching at
>   *
>   * Returns the bit number for the next set bit
>   * If no bits are set, returns @size.
> @@ -50,8 +50,8 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
>   * find_next_and_bit - find the next set bit in both memory regions
>   * @addr1: The first address to base the search on
>   * @addr2: The second address to base the search on
> - * @offset: The bitnumber to start searching at
>   * @size: The bitmap size in bits
> + * @offset: The bitnumber to start searching at
>   *
>   * Returns the bit number for the next set bit
>   * If no bits are set, returns @size.
> @@ -79,8 +79,8 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
>  /**
>   * find_next_zero_bit - find the next cleared bit in a memory region
>   * @addr: The address to base the search on
> - * @offset: The bitnumber to start searching at
>   * @size: The bitmap size in bits
> + * @offset: The bitnumber to start searching at
>   *
>   * Returns the bit number of the next zero bit
>   * If no bits are zero, returns @size.
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


