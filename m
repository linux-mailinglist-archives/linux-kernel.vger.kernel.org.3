Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AD45A0EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbiHYLUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241468AbiHYLUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:20:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD54E3882;
        Thu, 25 Aug 2022 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661426413; x=1692962413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Lmf0RCmom+4+9idaLbZAdtf826Dbuqzs50BC3wHcUI=;
  b=LPtJJIceykeSHBnDp9KySv28BwCG2I3C4UU7Mwnhxq8v82pYj4yZkuvg
   3dGGx/AspE/frZoXFwnQW3wAXQw3iiTXhoCbXDjEltBGA4fq/ATn+V8F+
   d0f756cLpM8J2y6mY62KhZWt0OTU8nDs2pm9Q3vFk2nM7dYg4NF9fN1dE
   8l8sSwEOZfh+PJ4iW6UD2mWDmY8zHkbZB0AkUiNIMHKmTYALuw6NKCa+u
   rVfGOK4bwXeQjfaTP9XyzC5xRnb3F64zTWvvYTEH57BicbUQfbMxB3d7g
   9pPBtzjngqXxJ0r+4AKyzF43iXNcsJRIW0P8KYyq553hC8wjgbCDSI4nk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="277231719"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="277231719"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 04:20:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="643221713"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 04:20:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oRAtx-003M9R-17;
        Thu, 25 Aug 2022 14:19:57 +0300
Date:   Thu, 25 Aug 2022 14:19:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        simon.guinot@sequanux.org
Subject: Re: [PATCH v6 1/7] gpio-f7188x: switch over to using pr_fmt
Message-ID: <Ywda3eq+h1mx+9hZ@smile.fi.intel.com>
References: <20220825104422.14156-1-henning.schild@siemens.com>
 <20220825104422.14156-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825104422.14156-2-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:44:16PM +0200, Henning Schild wrote:
> Subsequent patches will touch that file, apply some nice to have style
> changes before actually adding functional changes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/gpio/gpio-f7188x.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> index 18a3147f5a42..fef539bbc03a 100644
> --- a/drivers/gpio/gpio-f7188x.c
> +++ b/drivers/gpio/gpio-f7188x.c
> @@ -7,6 +7,9 @@
>   * Author: Simon Guinot <simon.guinot@sequanux.org>
>   */
>  
> +#define DRVNAME "gpio-f7188x"
> +#define pr_fmt(fmt) DRVNAME ": " fmt
> +
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> @@ -14,8 +17,6 @@
>  #include <linux/gpio/driver.h>
>  #include <linux/bitops.h>
>  
> -#define DRVNAME "gpio-f7188x"
> -
>  /*
>   * Super-I/O registers
>   */
> @@ -110,7 +111,7 @@ static inline int superio_enter(int base)
>  {
>  	/* Don't step on other drivers' I/O space by accident. */
>  	if (!request_muxed_region(base, 2, DRVNAME)) {
> -		pr_err(DRVNAME "I/O address 0x%04x already in use\n", base);
> +		pr_err("I/O address 0x%04x already in use\n", base);
>  		return -EBUSY;
>  	}
>  
> @@ -487,7 +488,7 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
>  	err = -ENODEV;
>  	devid = superio_inw(addr, SIO_MANID);
>  	if (devid != SIO_FINTEK_ID) {
> -		pr_debug(DRVNAME ": Not a Fintek device at 0x%08x\n", addr);
> +		pr_debug("Not a Fintek device at 0x%08x\n", addr);
>  		goto err;
>  	}
>  
> @@ -518,13 +519,13 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
>  		sio->type = f81865;
>  		break;
>  	default:
> -		pr_info(DRVNAME ": Unsupported Fintek device 0x%04x\n", devid);
> +		pr_info("Unsupported Fintek device 0x%04x\n", devid);
>  		goto err;
>  	}
>  	sio->addr = addr;
>  	err = 0;
>  
> -	pr_info(DRVNAME ": Found %s at %#x, revision %d\n",
> +	pr_info("Found %s at %#x, revision %d\n",
>  		f7188x_names[sio->type],
>  		(unsigned int) addr,
>  		(int) superio_inb(addr, SIO_DEVREV));
> @@ -548,13 +549,13 @@ f7188x_gpio_device_add(const struct f7188x_sio *sio)
>  	err = platform_device_add_data(f7188x_gpio_pdev,
>  				       sio, sizeof(*sio));
>  	if (err) {
> -		pr_err(DRVNAME "Platform data allocation failed\n");
> +		pr_err("Platform data allocation failed\n");
>  		goto err;
>  	}
>  
>  	err = platform_device_add(f7188x_gpio_pdev);
>  	if (err) {
> -		pr_err(DRVNAME "Device addition failed\n");
> +		pr_err("Device addition failed\n");
>  		goto err;
>  	}
>  
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


