Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308C8574C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbiGNLc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbiGNLc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:32:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F32DD3;
        Thu, 14 Jul 2022 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657798374; x=1689334374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WtBev9dHMwuukNjd40pA16rIrhzGg5WZruaX/rRQtr4=;
  b=SdYBnnIRNt5+zeZfIl1/br5o78Qce+7WsUE8Es6PdhbsQu6+Ha5Z0sLb
   Fq9Hw8ojxyWICYawYLlRh0JDHgYoKl9uIXPLQFCAb2ktL4sgnAFOD2b1U
   4uRdNYUGg+dYPxvSSpDet7c/1blGabS1zlUKXkv4twPJpiOcj51ZERItq
   hWABd67Leio3AhGbKqqCfS37AorOOlhcO2GkoN8F7zr+Ajn0W5blQO7F0
   so5JZr5uF9afFnq4szyk5EnOR1D2fcu9UexMiiXMPigQ14EeOB5K560uN
   X4HgoC/cXpIlQC3GpWEl51ew6VfzcJkGnKVYL8fNFmcdZu1kx9z7LMRSz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="349454318"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="349454318"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 04:32:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="842112922"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 04:32:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oBx5M-001DC3-0A;
        Thu, 14 Jul 2022 14:32:48 +0300
Date:   Thu, 14 Jul 2022 14:32:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <luca.ellero@brickedbrain.com>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: Re: [PATCH 1/3] ads7846: don't report pressure for ads7845
Message-ID: <Ys/+37mzoi++8MDW@smile.fi.intel.com>
References: <20220714084319.107334-1-luca.ellero@brickedbrain.com>
 <20220714084319.107334-2-luca.ellero@brickedbrain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714084319.107334-2-luca.ellero@brickedbrain.com>
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

On Thu, Jul 14, 2022 at 10:43:17AM +0200, Luca Ellero wrote:
> From: Luca Ellero <l.ellero@asem.it>
> 
> ADS7845 doesn't support pressure.
> This patch avoids the following error reported by libinput-list-devices:
> "ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE"

Missed period, otherwise looks good.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Luca Ellero <l.ellero@asem.it>
> ---
>  drivers/input/touchscreen/ads7846.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index bed68a68f330..24605c40d039 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -1316,8 +1316,9 @@ static int ads7846_probe(struct spi_device *spi)
>  			pdata->y_min ? : 0,
>  			pdata->y_max ? : MAX_12BIT,
>  			0, 0);
> -	input_set_abs_params(input_dev, ABS_PRESSURE,
> -			pdata->pressure_min, pdata->pressure_max, 0, 0);
> +	if (ts->model != 7845)
> +		input_set_abs_params(input_dev, ABS_PRESSURE,
> +				pdata->pressure_min, pdata->pressure_max, 0, 0);
>  
>  	/*
>  	 * Parse common framework properties. Must be done here to ensure the
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


