Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595074D1421
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbiCHKEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiCHKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:04:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD213A5F1;
        Tue,  8 Mar 2022 02:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646733793; x=1678269793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rtW+MFf0KlWKiIpC8eDfkdOzFdS5LxJYrRPmGTvHdMQ=;
  b=OgumAsFVukEtA8MwQ7H7ruhduo8ROs+w5NHv44YXQLjMnhNTyVRZP9cC
   N27eHBPQwAeR8MYRQWpV+ei0ZVlldV8bm2I3Icc76ft8otyRXFmWUhccl
   54vGUgg0jCHy3FHr7UfGtRNbcpOjjtDS0ouoMgYSyTi+qSwGZBkdgEL2l
   ehnKQNZ+LYJqkPXXlMkR+FEOCNPadD7qsnJwf4ukJ8R+QvK27nM/5zlQi
   18MAzkrXAcX5jBhjYk7pzaNUJ/1OwKTbw24/y5jFDBuYh7w6hsyS3qJQ6
   O27LfEbMdNg9RbTnulXUFhbiID+Mr53dbsLA2YpffsQzr8LWHFZ6aOFVY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="341078001"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="341078001"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:03:12 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="577942049"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:03:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRWfj-00DHqA-EM;
        Tue, 08 Mar 2022 12:02:27 +0200
Date:   Tue, 8 Mar 2022 12:02:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: sim: fix a typo
Message-ID: <Yicps+mb9xWrqch3@smile.fi.intel.com>
References: <20220308084627.214720-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308084627.214720-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 09:46:27AM +0100, Bartosz Golaszewski wrote:
> Just noticed this when applying Andy's patch. s/childred/children/

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: cb8c474e79be ("gpio: sim: new testing module")
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpio-sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index bb9bb595c1a8..8e5d87984a48 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -547,7 +547,7 @@ struct gpio_sim_bank {
>  	 *
>  	 * So we need to store the pointer to the parent struct here. We can
>  	 * dereference it anywhere we need with no checks and no locking as
> -	 * it's guaranteed to survive the childred and protected by configfs
> +	 * it's guaranteed to survive the children and protected by configfs
>  	 * locks.
>  	 *
>  	 * Same for other structures.
> -- 
> 2.30.1
> 

-- 
With Best Regards,
Andy Shevchenko


