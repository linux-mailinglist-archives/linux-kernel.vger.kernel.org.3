Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E412464DD9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244262AbhLAMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbhLAMa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:30:59 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19AAC061574;
        Wed,  1 Dec 2021 04:27:38 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id m12so9641275ljj.6;
        Wed, 01 Dec 2021 04:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ViUuu1qSd+ky5OJ7V5pX1mwKaBcH00QL+0ApLGprjo4=;
        b=GyFKdqA5jt9wbIXTWA64Ts33pbQfmdoiXzlEbZvg5BJoallUKilPHUr2IR+8Xq73pt
         Hnfclxrt+8O1JXs+ipRcs1cxjYziJGXEOCivHpCbez03ilggJJjP4o5jXgn9rOyXpa8L
         3WVhOc5hdbSWR6273D9TD07qFpWnnBXkzX4GolnNEIGoTWPCEbkYLncwFbdm5ikw23mx
         GwMuZffd6ru79fETX5aaI3c6XkOBh9Aw+f7Eigrj9qq7iQ+0FAYY0E+J31LmatMS4ukP
         bwjMfhJCbVRAWwAiMGxTgecAbfYNsqV0Qxlh4oysintGrAxANp7ptFAXB9tZ7PxjQi7j
         Do6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ViUuu1qSd+ky5OJ7V5pX1mwKaBcH00QL+0ApLGprjo4=;
        b=4Zx86uCFjGkG1usD9TlaB2URTUgHUfziZEDEfmIrkIRr82CjLs567jO1sZM3i/7jbW
         sBbyeogW5n41lxJM0dr6GXBYWHw7o3HFZlRcKmOq/RJkLwpN8zbGDV2YnDtSU4Xx8IDF
         VqSOqQdg4AvNHlq2pjHpxF6j8Z68IK6v68td6dLS0fQFB0iW27Ih0rahnKUbQec2kiPK
         qJUwY9AyQW+1xyDtarGn+QKD+VyhDpHwd1sGA1ISuOYQYMGe8uQ4FKZzS0p7No5DQFc4
         eqFjVYYKjslN/CYUfG9PFy+LQ70pwjtyxxqu2iI8mJgIOe8gec7f5jDcEKdXoASOPoD1
         8XiA==
X-Gm-Message-State: AOAM53366YvXnYvav1pwjXFBmzAX9ZPDtbdc7HL4JwnRd5EvJf15Abpx
        Ewk2DPhseF89nA5KcuRYOM4=
X-Google-Smtp-Source: ABdhPJz9xhTWBA2zdGTVvKW+Fp2ClJBAMFWva/kNK9I3TDvUTTTCd4Soc0nq6Z8H+071N7DKvdamFA==
X-Received: by 2002:a2e:a30f:: with SMTP id l15mr5307948lje.135.1638361657046;
        Wed, 01 Dec 2021 04:27:37 -0800 (PST)
Received: from mobilestation ([95.79.218.126])
        by smtp.gmail.com with ESMTPSA id y23sm2082938lfk.24.2021.12.01.04.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 04:27:36 -0800 (PST)
Date:   Wed, 1 Dec 2021 15:27:34 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: dwapb: clarify usage of the register file
 version
Message-ID: <20211201122734.o7m5xb6zh4ngjpo7@mobilestation>
References: <20211130164956.37540-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130164956.37540-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 06:49:56PM +0200, Andy Shevchenko wrote:
> First of all, it's obvious that different versions can't be provided
> simultaneously. Hence, versions can't be bit masks.
> 
> Second, due to above we have to mask out the version field in the flags
> and only that can be evaluated against the certain version.
> 
> Clarify all above by:
>  - introducing GPIO_REG_OFFSET_V1 and GPIO_REG_OFFSET_MASK
>  - replacing conditional to mask out bits and compare to a version
> 
> Luckily there is no functional change (at least intended), so no need
> to backport this.

Seems reasonable. Thanks.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-dwapb.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index f98fa33e1679..ec0767d7800d 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -53,7 +53,9 @@
>  #define GPIO_SWPORT_DR_STRIDE	0x0c /* register stride 3*32 bits */
>  #define GPIO_SWPORT_DDR_STRIDE	0x0c /* register stride 3*32 bits */
>  
> +#define GPIO_REG_OFFSET_V1	0
>  #define GPIO_REG_OFFSET_V2	1
> +#define GPIO_REG_OFFSET_MASK	BIT(0)
>  
>  #define GPIO_INTMASK_V2		0x44
>  #define GPIO_INTTYPE_LEVEL_V2	0x34
> @@ -141,7 +143,7 @@ static inline u32 gpio_reg_v2_convert(unsigned int offset)
>  
>  static inline u32 gpio_reg_convert(struct dwapb_gpio *gpio, unsigned int offset)
>  {
> -	if (gpio->flags & GPIO_REG_OFFSET_V2)
> +	if ((gpio->flags & GPIO_REG_OFFSET_MASK) == GPIO_REG_OFFSET_V2)
>  		return gpio_reg_v2_convert(offset);
>  
>  	return offset;
> @@ -668,15 +670,15 @@ static int dwapb_get_clks(struct dwapb_gpio *gpio)
>  }
>  
>  static const struct of_device_id dwapb_of_match[] = {
> -	{ .compatible = "snps,dw-apb-gpio", .data = (void *)0},
> +	{ .compatible = "snps,dw-apb-gpio", .data = (void *)GPIO_REG_OFFSET_V1},
>  	{ .compatible = "apm,xgene-gpio-v2", .data = (void *)GPIO_REG_OFFSET_V2},
>  	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, dwapb_of_match);
>  
>  static const struct acpi_device_id dwapb_acpi_match[] = {
> -	{"HISI0181", 0},
> -	{"APMC0D07", 0},
> +	{"HISI0181", GPIO_REG_OFFSET_V1},
> +	{"APMC0D07", GPIO_REG_OFFSET_V1},
>  	{"APMC0D81", GPIO_REG_OFFSET_V2},
>  	{ }
>  };
> -- 
> 2.33.0
> 
