Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88CF4A9319
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 05:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356950AbiBDE3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 23:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiBDE3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 23:29:42 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B16C061714;
        Thu,  3 Feb 2022 20:29:42 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id z7so3881193ilb.6;
        Thu, 03 Feb 2022 20:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wNFwjW4PYcifd9RezG6AJwf0bLCg9aSqyt07d3zX9jU=;
        b=A1bh1iNcaCgez+6i8g3ApzO/lcs1iqFtK+bb28hHm1PubPk8Xff+pshB7YqMSSQ07V
         kzE1uGH6FPhjXt0UhfWmLyOl+LW03GQ2jFA+JEGZI+WxDopjc0PPJ1rm1XYgtyr9iNbE
         U17xDXckyZcyme4qKTLCUrI/c9Ptu5W9dHegB2oM6VUH8WS5Yx2sBrSKLiHCEeVUJWW6
         FRQWrE1w+wqGtY9cKCH0r6qo/9YE4FXO9xgWG58jsMg89vIbLa5+Oik+WG+Gk4hVwmL1
         ePjpm9zU3D8nnAbfRB1B6SnGnNNOSi43iat3hLxNoGDh7QgsLxhemT1ILFYLCwDG1OyB
         Yeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wNFwjW4PYcifd9RezG6AJwf0bLCg9aSqyt07d3zX9jU=;
        b=noe8uyqwxTnea8iB3b8tbSrjqLIIEdzrU3l8Cax8RNRM4xHzuNCy2piHcwn//6wLvO
         gH8OMegGl96/zGdFYZiHx27/umfmYRmtr3ylaq1xirtXcCuS7wiV5MnYpeCnl6XeZfaM
         L9zxCN1tOVAshSX3KBPkPbuno4VXftmKqHGdB7ZxjwmlH1s1wgKNWvxd9KbcqLrqraqA
         MfP1l9yhGQnmgDHRzM/d9IjEcaSkP+QZoFYo0T0EJ2HLgXFC9v8yiWVXN0LQKi4E6aMM
         TxUCKRL54b4bI88CkSaQOLzcvcBsdBP9gMLqd/Ve6SZ75h6J8PNXyivi+F/eHLX3EMAD
         sWUg==
X-Gm-Message-State: AOAM53186loxz1jSHm43Q/qN7CDmIxQny7s9vGdMdLXkDWBGoMGdpsy3
        3XE+gBGFdM5peMRBKdmPHSamnMMzrR0=
X-Google-Smtp-Source: ABdhPJxCbimJKBDAGULxMpWI6Z/Oeyi6vPWsPUhcgDxbxxP9J7AvhHop0RwDzDiwvR/bCVL4Mj5CJA==
X-Received: by 2002:a92:680b:: with SMTP id d11mr588761ilc.74.1643948981266;
        Thu, 03 Feb 2022 20:29:41 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id m1sm459683ilu.87.2022.02.03.20.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 20:29:40 -0800 (PST)
Date:   Thu, 3 Feb 2022 20:29:38 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: stmpe-adc: Use correctly sized arguments for bit
 field
Message-ID: <YfyrspBCYjH56xEU@yury-laptop>
References: <20211215232513.2070158-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215232513.2070158-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 03:25:13PM -0800, Kees Cook wrote:
> The find.h APIs are designed to be used only on unsigned long arguments.
> This can technically result in a over-read, but it is harmless in this
> case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
> which we'd like to enable globally:
> 
> In file included from ./include/linux/bitmap.h:9,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/cpumask.h:5,
>                  from ./arch/x86/include/asm/msr.h:11,
>                  from ./arch/x86/include/asm/processor.h:22,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:60,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:55,
>                  from ./include/linux/swait.h:7,
>                  from ./include/linux/completion.h:12,
>                  from drivers/iio/adc/stmpe-adc.c:10:
> drivers/iio/adc/stmpe-adc.c: In function 'stmpe_adc_probe':
> ./include/linux/find.h:98:23: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
>    98 |                 val = *addr | ~GENMASK(size - 1, offset);
>       |                       ^~~~~
> drivers/iio/adc/stmpe-adc.c:258:13: note: while referencing 'norequest_mask'
>   258 |         u32 norequest_mask = 0;
>       |             ^~~~~~~~~~~~~~
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/iio/adc/stmpe-adc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index fba659bfdb40..d2d405388499 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -256,6 +256,7 @@ static int stmpe_adc_probe(struct platform_device *pdev)
>  	struct stmpe_adc *info;
>  	struct device_node *np;
>  	u32 norequest_mask = 0;
> +	unsigned long bits;
>  	int irq_temp, irq_adc;
>  	int num_chan = 0;
>  	int i = 0;
> @@ -309,8 +310,8 @@ static int stmpe_adc_probe(struct platform_device *pdev)
>  
>  	of_property_read_u32(np, "st,norequest-mask", &norequest_mask);
>  
> -	for_each_clear_bit(i, (unsigned long *) &norequest_mask,
> -			   (STMPE_ADC_LAST_NR + 1)) {
> +	bits = norequest_mask;

This would not work on 64-bit BE architecture. It should use bitmap_from_arr32()

> +	for_each_clear_bit(i, &bits, (STMPE_ADC_LAST_NR + 1)) {
>  		stmpe_adc_voltage_chan(&info->stmpe_adc_iio_channels[num_chan], i);
>  		num_chan++;
>  	}
> -- 
> 2.30.2
