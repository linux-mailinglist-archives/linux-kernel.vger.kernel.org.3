Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2857D5423B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442220AbiFHAyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444567AbiFGXCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:02:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD04EC3EA;
        Tue,  7 Jun 2022 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654633010; x=1686169010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7V/VA70lsYPB2rHKj1GQNpN5bDhVdxSUPtPF7P0+zbo=;
  b=fbsSxyQUV8mvku3KKGwZ4Q3jQfGS2tG5xtFQ/UQYvtEp3Gruj1nAwISO
   T0BGRmZkrfzuhlxavw2agJVj1n1BZrMCkN9yDls3FuDXCOoRrd9n2iT9L
   DrFYTjbJxxdvtO3Pc6uglyNTM6xtfoge6bLMscRY9NIV/k84H3vI4Li3r
   i2En5jse4+Z4prQcQ/Wu6+Y30kEYudIF7mhkUWRUkSybS0NMk026aoylM
   k6DuaWC/jpsS/9Bpp89904e/WwquViakZ/EhOsfMyRNXHBtX7z36QPkYU
   5kBK5lutWxf5/r/8/24S1hUc7HgRlcji5HKfyt92qU+pvRXPJ5emn2BSP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="274279199"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="274279199"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 13:16:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="648216227"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 13:16:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyfd6-000W7i-N9;
        Tue, 07 Jun 2022 23:16:44 +0300
Date:   Tue, 7 Jun 2022 23:16:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Len Baker <len.baker@gmx.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: ftbft: Use backlight helper
Message-ID: <Yp+yLJNq70U3Z7AZ@smile.fi.intel.com>
References: <20220607185516.1129900-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607185516.1129900-1-steve@sk2.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 08:55:16PM +0200, Stephen Kitt wrote:
> backlight_properties.fb_blank is deprecated. The states it represents
> are handled by other properties; but instead of accessing those
> properties directly, drivers should use the helpers provided by
> backlight.h.
> 
> Instead of manually checking the power state in struct
> backlight_properties, use backlight_is_blank().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Noralf Trønnes" <noralf@tronnes.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Len Baker <len.baker@gmx.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-staging@lists.linux.dev
> ---
>  drivers/staging/fbtft/fb_ssd1351.c | 3 +--
>  drivers/staging/fbtft/fbtft-core.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
> index 6fd549a424d5..b8d55aa8c5c7 100644
> --- a/drivers/staging/fbtft/fb_ssd1351.c
> +++ b/drivers/staging/fbtft/fb_ssd1351.c
> @@ -196,8 +196,7 @@ static int update_onboard_backlight(struct backlight_device *bd)
>  		      "%s: power=%d, fb_blank=%d\n",
>  		      __func__, bd->props.power, bd->props.fb_blank);
>  
> -	on = (bd->props.power == FB_BLANK_UNBLANK) &&
> -	     (bd->props.fb_blank == FB_BLANK_UNBLANK);
> +	on = !backlight_is_blank(bd);
>  	/* Onboard backlight connected to GPIO0 on SSD1351, GPIO1 unused */
>  	write_reg(par, 0xB5, on ? 0x03 : 0x02);
>  
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index 60b2278d8b16..9b3eaed80cdd 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -137,8 +137,7 @@ static int fbtft_backlight_update_status(struct backlight_device *bd)
>  		      "%s: polarity=%d, power=%d, fb_blank=%d\n",
>  		      __func__, polarity, bd->props.power, bd->props.fb_blank);
>  
> -	if ((bd->props.power == FB_BLANK_UNBLANK) &&
> -	    (bd->props.fb_blank == FB_BLANK_UNBLANK))
> +	if (!backlight_is_blank(bd))
>  		gpiod_set_value(par->gpio.led[0], polarity);
>  	else
>  		gpiod_set_value(par->gpio.led[0], !polarity);
> 
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


