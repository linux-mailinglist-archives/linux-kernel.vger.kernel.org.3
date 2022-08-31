Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1296D5A8821
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiHaVaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiHaVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:30:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4746EF13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661981420; x=1693517420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rSnUoGMhuC5zlijS2vBa0BR4NHyX4MpKBuKfLDQV5ng=;
  b=jEE0mtnw0yyzTn/dBLUX6Pnzuh+O/TP2c5WGGdBQaLVuRAuu2DvJb/s9
   qS60Ylj/ZloilwOSCc7n8Ww2b9iTrhNYU9Jkjr5jzmLouuL39mv2WV2kP
   r6EILR8huNkYHzEMFl4/Sq3aCFme6Unv0mY7sDSWPYufJyW8BeNvQVY95
   ecB9FJYC2ygCB2VCDvJIyHQpNOw03DHpouKepPhkeQFYRAYYiw+/cKDQk
   HHTqG2i83ih3yrJrdGNG9wJeTKIhv9frwcsvoy8+P+CYavEp3hJ8tPGnq
   8hkN3GumsvoqLcN6LFfm/t6/3Sao848IxPEEe9fPA3TpKQclUwwb4euNR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="357266532"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="357266532"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:30:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="680579063"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:30:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oTVHs-006Zzf-1N;
        Thu, 01 Sep 2022 00:30:16 +0300
Date:   Thu, 1 Sep 2022 00:30:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: mmio: Fix rebase error
Message-ID: <Yw/S6NjDcd/JeZCG@smile.fi.intel.com>
References: <20220831141303.501548-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831141303.501548-1-linus.walleij@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 04:13:03PM +0200, Linus Walleij wrote:
> A dangling pointless "ret 0" was left in and some unneeded
> whitespace can go too.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 81c0386c1376 ("regmap: mmio: Support accelerared noinc operations")
> Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/base/regmap/regmap-mmio.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
> index e8d2675463ac..b47ee3e8d050 100644
> --- a/drivers/base/regmap/regmap-mmio.c
> +++ b/drivers/base/regmap/regmap-mmio.c
> @@ -410,14 +410,11 @@ static int regmap_mmio_noinc_read(void *context, unsigned int reg,
>  		}
>  	}
>  
> -
>  out_clk:
>  	if (!IS_ERR(ctx->clk))
>  		clk_disable(ctx->clk);
>  
>  	return ret;
> -
> -	return 0;
>  }
>  
>  
> -- 
> 2.37.2
> 

-- 
With Best Regards,
Andy Shevchenko


