Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E45A0EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbiHYLUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241514AbiHYLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:20:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5508B851;
        Thu, 25 Aug 2022 04:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661426438; x=1692962438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gq6Zn9kn9CM/Af0brn+d05ChPMrkIzXvAhxHUkvI3OU=;
  b=Yvxj/cs20qTSWDscvfOkzfcEKS9EDr6Vfjsl6qrLXfem5exbyxRbPEEm
   qlycw6eIpBpjQ/7b1TGw5QA+/aKHENoMVkZYmKqWVcI3pbzyx7S035DYA
   y4FHyXEH4geE8ofJAQ5IRNC/yDUa7NLGG/Wc16BAkV/BHeTG1v+n/aa8X
   KkQIB0Di+c552bEge+CTWlx8IDd30sp4z/tcrSSa8R/gqONhetpTchvGq
   NpZpe0K5ba0R6HoRwBwWQgMdX7GTZIrXgLX/i83PASKAlav+nBQl3ALCR
   K1pJogITiTaXVugz/kL5vn34EuGrnWN3I6NHYDa1NcsVD23aUdDdy7eBk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="277231783"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="277231783"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 04:20:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="613138737"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 04:20:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oRAuV-003MAN-2G;
        Thu, 25 Aug 2022 14:20:31 +0300
Date:   Thu, 25 Aug 2022 14:20:31 +0300
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
Subject: Re: [PATCH v6 2/7] gpio-f7188x: add a prefix to macros to keep gpio
 namespace clean
Message-ID: <Ywda/0DQIpAjPa8f@smile.fi.intel.com>
References: <20220825104422.14156-1-henning.schild@siemens.com>
 <20220825104422.14156-3-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825104422.14156-3-henning.schild@siemens.com>
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

On Thu, Aug 25, 2022 at 12:44:17PM +0200, Henning Schild wrote:
> Subsequent patches will touch that file, apply some nice to have style
> changes before actually adding functional changes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/gpio/gpio-f7188x.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> index fef539bbc03a..878458249833 100644
> --- a/drivers/gpio/gpio-f7188x.c
> +++ b/drivers/gpio/gpio-f7188x.c
> @@ -165,11 +165,11 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
>  		.regbase = _regbase,					\
>  	}
>  
> -#define gpio_dir(base) (base + 0)
> -#define gpio_data_out(base) (base + 1)
> -#define gpio_data_in(base) (base + 2)
> +#define f7188x_gpio_dir(base) ((base) + 0)
> +#define f7188x_gpio_data_out(base) ((base) + 1)
> +#define f7188x_gpio_data_in(base) ((base) + 2)
>  /* Output mode register (0:open drain 1:push-pull). */
> -#define gpio_out_mode(base) (base + 3)
> +#define f7188x_gpio_out_mode(base) ((base) + 3)
>  
>  static struct f7188x_gpio_bank f71869_gpio_bank[] = {
>  	F7188X_GPIO_BANK(0, 6, 0xF0),
> @@ -267,7 +267,7 @@ static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
>  		return err;
>  	superio_select(sio->addr, SIO_LD_GPIO);
>  
> -	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> +	dir = superio_inb(sio->addr, f7188x_gpio_dir(bank->regbase));
>  
>  	superio_exit(sio->addr);
>  
> @@ -289,9 +289,9 @@ static int f7188x_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
>  		return err;
>  	superio_select(sio->addr, SIO_LD_GPIO);
>  
> -	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> +	dir = superio_inb(sio->addr, f7188x_gpio_dir(bank->regbase));
>  	dir &= ~BIT(offset);
> -	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
> +	superio_outb(sio->addr, f7188x_gpio_dir(bank->regbase), dir);
>  
>  	superio_exit(sio->addr);
>  
> @@ -310,12 +310,12 @@ static int f7188x_gpio_get(struct gpio_chip *chip, unsigned offset)
>  		return err;
>  	superio_select(sio->addr, SIO_LD_GPIO);
>  
> -	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> +	dir = superio_inb(sio->addr, f7188x_gpio_dir(bank->regbase));
>  	dir = !!(dir & BIT(offset));
>  	if (dir)
> -		data = superio_inb(sio->addr, gpio_data_out(bank->regbase));
> +		data = superio_inb(sio->addr, f7188x_gpio_data_out(bank->regbase));
>  	else
> -		data = superio_inb(sio->addr, gpio_data_in(bank->regbase));
> +		data = superio_inb(sio->addr, f7188x_gpio_data_in(bank->regbase));
>  
>  	superio_exit(sio->addr);
>  
> @@ -335,16 +335,16 @@ static int f7188x_gpio_direction_out(struct gpio_chip *chip,
>  		return err;
>  	superio_select(sio->addr, SIO_LD_GPIO);
>  
> -	data_out = superio_inb(sio->addr, gpio_data_out(bank->regbase));
> +	data_out = superio_inb(sio->addr, f7188x_gpio_data_out(bank->regbase));
>  	if (value)
>  		data_out |= BIT(offset);
>  	else
>  		data_out &= ~BIT(offset);
> -	superio_outb(sio->addr, gpio_data_out(bank->regbase), data_out);
> +	superio_outb(sio->addr, f7188x_gpio_data_out(bank->regbase), data_out);
>  
> -	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> +	dir = superio_inb(sio->addr, f7188x_gpio_dir(bank->regbase));
>  	dir |= BIT(offset);
> -	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
> +	superio_outb(sio->addr, f7188x_gpio_dir(bank->regbase), dir);
>  
>  	superio_exit(sio->addr);
>  
> @@ -363,12 +363,12 @@ static void f7188x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  		return;
>  	superio_select(sio->addr, SIO_LD_GPIO);
>  
> -	data_out = superio_inb(sio->addr, gpio_data_out(bank->regbase));
> +	data_out = superio_inb(sio->addr, f7188x_gpio_data_out(bank->regbase));
>  	if (value)
>  		data_out |= BIT(offset);
>  	else
>  		data_out &= ~BIT(offset);
> -	superio_outb(sio->addr, gpio_data_out(bank->regbase), data_out);
> +	superio_outb(sio->addr, f7188x_gpio_data_out(bank->regbase), data_out);
>  
>  	superio_exit(sio->addr);
>  }
> @@ -391,12 +391,12 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
>  		return err;
>  	superio_select(sio->addr, SIO_LD_GPIO);
>  
> -	data = superio_inb(sio->addr, gpio_out_mode(bank->regbase));
> +	data = superio_inb(sio->addr, f7188x_gpio_out_mode(bank->regbase));
>  	if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
>  		data &= ~BIT(offset);
>  	else
>  		data |= BIT(offset);
> -	superio_outb(sio->addr, gpio_out_mode(bank->regbase), data);
> +	superio_outb(sio->addr, f7188x_gpio_out_mode(bank->regbase), data);
>  
>  	superio_exit(sio->addr);
>  	return 0;
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


