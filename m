Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256E44D129C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345105AbiCHIsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345133AbiCHIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:47:54 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D133FBFB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:46:55 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id r13so37578907ejd.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWDxW77171tKULic9PATZflHGAWN9agWbTs/Al0RNIA=;
        b=yDq6cJj7scG6xMfY6mQBRZI2teHCxzKWxFahnkYD75apQHz+R+CrU3MTQ6xyW1c0UW
         JM2b+S5Npi2BSgCR+6cTMscJ4fJKrQaMDWQcH7ijwSRS2Bt5UvmcWMqOK/NyyXnPmkQp
         4HohBUjbccLAZubYdl0A9y9x/z7KFrLl6oBijkyfSp7IFSWfg8hRZc1Ut8VVgTbK1y8q
         Pq0OULrEwQpV+7ivCIdE5aUvHQ+Dm1f7J5VYHOvkw4OAZtwR/hkX1B9jY1uC0cST7Mvm
         jfQDMJwUwcj40vAoPr++9qB5Z6sp1LfMVI5MN1mGAa76lb76s40yOR/r/8XauNvsQBfK
         8cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWDxW77171tKULic9PATZflHGAWN9agWbTs/Al0RNIA=;
        b=SR/CkBKG4wcoqUXrAnD+Nx/vE7kBGeYhE3AqmyhxM9Lo++miQE68CVlrjMsjsjydfp
         7rz3FGNM7Ny9WOlr6gbjscJtGJZVxQNZ80kLqnzH26q3cjWVhGbnfzhKYv66oQQo/G8c
         ufvD7ykf+tfujEAu1UGT2tznpSKaQB04sjHZ94WESAJ3zt3nORwAeyNwEwJ03uziK2eY
         9CNFrfuCT1Zbu0/tr37t3AHtSQ3JzeQzC+F4+nKRq9Uw1lA0elcivdNhP/Af7XN8Gvcl
         nZ/3HLhsTuUNkaeasPRClXWrML6i1B68bTJ7W3grX7pTZXtP0IzApy0HZnN63yal/T/u
         /GYQ==
X-Gm-Message-State: AOAM5336+3rP9oqgYM3+jRYZl1Tm4Thys9Zzgw101xpAnihsUtNmh1C+
        hriJs7tMw3DvyKNHPW8dyFDO20kYR/3hfbGJc59+cN147M8=
X-Google-Smtp-Source: ABdhPJw2uMD2RB52Mu2RDi0WheUdgR/Sw7e1yql8YPmxsLsQoIY5nRZis9nQH5Ko1YfJ7Y6TG+EtlW8T6gqs6LEV6dI=
X-Received: by 2002:a17:906:888e:b0:6da:ed04:5e40 with SMTP id
 ak14-20020a170906888e00b006daed045e40mr12736944ejc.286.1646729213855; Tue, 08
 Mar 2022 00:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20220307163840.64495-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220307163840.64495-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Mar 2022 09:46:43 +0100
Message-ID: <CAMRc=Mf_gRcrc+AECb+Y5zLFdr-muKfxhFZr3+qkvLHB4ajndw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: sim: Declare gpio_sim_hog_config_item_ops static
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 5:38 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Compiler is not happy:
>
>   warning: symbol 'gpio_sim_hog_config_item_ops' was not declared. Should it be static?
>
> Fixes: cb8c474e79be ("gpio: sim: new testing module")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index 153fe79e1bf3..bb9bb595c1a8 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -1322,7 +1322,7 @@ static void gpio_sim_hog_config_item_release(struct config_item *item)
>         kfree(hog);
>  }
>
> -struct configfs_item_operations gpio_sim_hog_config_item_ops = {
> +static struct configfs_item_operations gpio_sim_hog_config_item_ops = {
>         .release        = gpio_sim_hog_config_item_release,
>  };
>
> --
> 2.34.1
>

Queued for fixes, thanks!

Bart
