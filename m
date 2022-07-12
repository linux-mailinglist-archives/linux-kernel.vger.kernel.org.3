Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93B4571CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiGLObg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiGLObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:31:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB1FAE3A5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657636292; x=1689172292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8VaZtscI5pp0hY+DtvP9CdNw3OvobWQDH5Z194rvsCM=;
  b=VMaravAEmoSyncAQuh0+rQqmKjAMpz7UN1sPNLPY2uvhb7UcBgtf54a2
   /aPR1l/EBCxWfnpgEYsn5pPK9mTStIQ4HomKXGFVmxg8fDwmSDP3DZIwi
   AFUVMta2lkv1VCqVYS8uH3XIYxiwdIwgisHgH4hBNSJFTT4SGzYNUgre7
   W4F4IbaI3mpNdS0ypITDJGznKfl5y+9sSV/ecZqCAc4bafVe7Pe1EQmv6
   qrVWQB93zapfoUXIbwv+VQ7ZU38pV7p75frFb0DJ30ctt6E/mIQVVuR0k
   TQDj0mjfL0qpCKuWQuYCxFoN48CniXoc1cP1IzfpA8/uGA5hAAtwCj+6d
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="371258235"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="371258235"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 07:30:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="662970836"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 07:30:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oBGuW-001BXJ-2L;
        Tue, 12 Jul 2022 17:30:48 +0300
Date:   Tue, 12 Jul 2022 17:30:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] lib/bitmap: fix off-by-one in bitmap_to_arr64()
Message-ID: <Ys2FmN3hDKPAciKi@smile.fi.intel.com>
References: <20220711180930.28271-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711180930.28271-1-alexandr.lobakin@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 08:09:28PM +0200, Alexander Lobakin wrote:
> Fix tail clearing in bitmap_to_arr64() for 32-bit BEs and expand
> the tests to cover the bug being fixed.

Thanks,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Alexander Lobakin (2):
>   lib/bitmap: fix off-by-one in bitmap_to_arr64()
>   lib/test_bitmap: test the tail after bitmap_to_arr64()
> 
>  lib/bitmap.c      | 2 +-
>  lib/test_bitmap.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)

-- 
With Best Regards,
Andy Shevchenko


