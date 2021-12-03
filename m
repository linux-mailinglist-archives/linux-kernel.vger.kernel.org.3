Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EFB46799C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381530AbhLCOsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhLCOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:48:30 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC32C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:45:06 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u3so7116186lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 06:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=scZUqwoe/cvKGUS4d3voXFgyPguXwcuU4NvbWZlBd6k=;
        b=QRVw533su6nuyf2yzzNStUibspi0/SQyKG11/j8oyomM7ghfnl7s0ejroE0OL33L+0
         OyTxMd3Z9AXXUY4LeT/eUjMi1wjsS6leS6vEVAdgcgMLwT2YfGVGhNMnN18/0nvo1MkY
         EhmHBsuxQG0NoF9zb+GHNGzC7YhYj/DyvV+U53kIYxkLK+xIv8V3996aNbuLLsdPHkMq
         JS2WqjKHVs1Yw2JE0xTbbL2QxRhY/C2A79oz6hAF49bl9x/JTwqWDhH8vTWqL1lk5JH5
         MkPJR9C+tohlmjA2SnkVB20atly/sLRPRRRBGt+G5exGeq2epNbdq8rDPVeoOc/6J4Ee
         vl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=scZUqwoe/cvKGUS4d3voXFgyPguXwcuU4NvbWZlBd6k=;
        b=0wgyut5nmQU4ShH99g1J6ZfJxyf1Ul6VdVYDjxqiXkzuQ8EW810CQe3aCi95QJ/9Md
         yS+oHO8XY6oRoyt6+yAj8u8YF25kmRNHq5kHxSzuMBX+jVIFqI+8rxNe5D2q3EINMJQS
         pnrAUUmPZVSBhocx5agK1knY73RJyBWgMvxTE5V06dbtN2m/P44sRsAm0kjoKkN3LAE0
         fzF8Qgzun2zeQPZIHojXojDLf4orpYw9/gwZpfZHXgF4srBxIrupcb69fJ85/g9ErHWe
         DCo52G9r1vixgbQz9NHrZC8egIkxHHYT8vkBWwl3B1tV/AyBSyeJcg2q/o1KCgwCuKPg
         rIuQ==
X-Gm-Message-State: AOAM533O40EEAEWpWuQKAvCsEa4cUwTbFEVNeE2/5DYDiAHg5Xl+LGGg
        dB+SRIchrCtUH9O7vq99DRA=
X-Google-Smtp-Source: ABdhPJxM5aAacDM0IWLjqUmhPGQbSAnERAMKy9fh66EWM/b4VlrQzk+6+hv6dA3YgRNZJFp1LpZBow==
X-Received: by 2002:a19:fc08:: with SMTP id a8mr18563847lfi.645.1638542704780;
        Fri, 03 Dec 2021 06:45:04 -0800 (PST)
Received: from [10.0.0.115] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id u2sm395546lfi.108.2021.12.03.06.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 06:45:04 -0800 (PST)
Message-ID: <1a2831d2-49bb-f1fc-14e8-d6a0d53664cf@gmail.com>
Date:   Fri, 3 Dec 2021 16:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v1 1/2] ASoC: ti: davinci-mcasp: Get rid of duplicate
 of_node assignment
In-Reply-To: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2021 22:56, Andy Shevchenko wrote:
> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove assignment here.

Thanks, looks good,
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> For the details one may look into the of_gpio_dev_init() implementation.

Which works after commit 1df62542e0161.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index 56a19eeec5c7..81c1ccec5904 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -2230,9 +2230,6 @@ static int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
>  	mcasp->gpio_chip = davinci_mcasp_template_chip;
>  	mcasp->gpio_chip.label = dev_name(mcasp->dev);
>  	mcasp->gpio_chip.parent = mcasp->dev;
> -#ifdef CONFIG_OF_GPIO
> -	mcasp->gpio_chip.of_node = mcasp->dev->of_node;
> -#endif
>  
>  	return devm_gpiochip_add_data(mcasp->dev, &mcasp->gpio_chip, mcasp);
>  }
> 

-- 
Péter
