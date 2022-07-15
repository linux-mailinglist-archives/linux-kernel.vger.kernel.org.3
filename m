Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6475762E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiGONlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiGONlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:41:02 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C857E00D;
        Fri, 15 Jul 2022 06:41:00 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s204so6098648oif.5;
        Fri, 15 Jul 2022 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e7J6lrL0WNeRPirg+hsgGpyVmncfl7kTniNmX54mAOs=;
        b=nm64lUXu5oveTkQskxEPiDkfL7ef9auSBw+ZGiXSB8MaFpuTysdPm7oQAqxcmzW+lF
         KsTCm6gWO9eGrPFUiWTtRoPnXKcxrUiut5R8vP6s5/C1EYoHZEKnIHCGwuAUzbY7kcmG
         qG8NMaFgdVrVBGYPIw4CxnPZFxerRWtANjOG8MmnyYpYXsHHzu+2upcLz+84fOEsm7Zz
         CHcsYHiOXl1ovojHwteYFBbKtV9bMhABRHtJtGSZlPJW0g7qbDf4HeTvRVpOFgVWny1V
         PRmAGdsZfA6NPpWH9GrZbS1gAiBD8/YcV7plcWnC9vU/x0l7EEq2pa9MlMP0K8xfP63C
         X3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e7J6lrL0WNeRPirg+hsgGpyVmncfl7kTniNmX54mAOs=;
        b=xVu8tw/y0uT4hetyDjs7G4dPJ1pZpuXtmQlU+f3iY52oCzeTuSRY/V7mnrwrzUz/pf
         ILsK8/wgMsX/H/e8I+FQTupkXtn9EuvfwY5nYk8XvSeZOAzteUO0Qs70RmWO7e9S3DKd
         faD8kplIRNzBDxTzPjJdLo0k3Z+JFLW4SdcHSVUQBjALaLhNgutDgImTlmRm6cHVIGW4
         gwChbLK4kzkOzbAo+z4qFR1cw0iwu6QRnH5yrl8MMfYic9vdXeHAPqIm2aDJrOgsuCIO
         CIp+r8tI3rdnW3lmIzxr3w8Unt8UsstK8+SBCQ1skWJGkyQ2OR2cQLQqBMp761b1GA4f
         HROA==
X-Gm-Message-State: AJIora/JLixUZ1hZWT2MDwu7W0OJt7O/1t5ixOg68SDs3mhuDhKGeDek
        Ko1JfC3KDzvr4+MJT91pJQQ+jEXktEMKKw==
X-Google-Smtp-Source: AGRyM1tzfC5Gi+cV4oh/9elVlqEF3MUF7EXlJafOwpnC/3rJo6dGXN0UJ4r+hFk39SMsa1Ku3eCNOA==
X-Received: by 2002:a05:6808:111:b0:33a:5c75:fffa with SMTP id b17-20020a056808011100b0033a5c75fffamr129423oie.73.1657892459982;
        Fri, 15 Jul 2022 06:40:59 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id b1-20020a4aba01000000b00425ce891cd8sm1825342oop.34.2022.07.15.06.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 06:40:59 -0700 (PDT)
Date:   Fri, 15 Jul 2022 06:40:50 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the bitmap tree
Message-ID: <YtFuYtlMSxGFEDGn@yury-laptop>
References: <20220715222255.2e7fae53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715222255.2e7fae53@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:22:55PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the bitmap tree, today's linux-next build (arm64 defconfig)
> produced this warning:

Fixed, thanks.

(I found some issues of this sort with allyesconfig, but not this one.)
 
> In file included from include/linux/device.h:15,
>                  from include/linux/dmaengine.h:8,
>                  from drivers/dma/ti/k3-udma.c:9:
> drivers/dma/ti/k3-udma.c: In function 'setup_resources':
> drivers/dma/ti/k3-udma.c:5000:26: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
>  5000 |                          "Channels: %d (tchan: %u, rchan: %u, gp-rflow: %u)\n",
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                              ^~~
> include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
>   150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |                                                          ^~~~~~~
> drivers/dma/ti/k3-udma.c:4999:17: note: in expansion of macro 'dev_info'
>  4999 |                 dev_info(dev,
>       |                 ^~~~~~~~
> drivers/dma/ti/k3-udma.c:5000:49: note: format string is defined here
>  5000 |                          "Channels: %d (tchan: %u, rchan: %u, gp-rflow: %u)\n",
>       |                                                ~^
>       |                                                 |
>       |                                                 unsigned int
>       |                                                %lu
> In file included from include/linux/device.h:15,
>                  from include/linux/dmaengine.h:8,
>                  from drivers/dma/ti/k3-udma.c:9:
> drivers/dma/ti/k3-udma.c:5000:26: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'long unsigned int' [-Wformat=]
>  5000 |                          "Channels: %d (tchan: %u, rchan: %u, gp-rflow: %u)\n",
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                              ^~~
> include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
>   150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |                                                          ^~~~~~~
> drivers/dma/ti/k3-udma.c:4999:17: note: in expansion of macro 'dev_info'
>  4999 |                 dev_info(dev,
>       |                 ^~~~~~~~
> drivers/dma/ti/k3-udma.c:5000:60: note: format string is defined here
>  5000 |                          "Channels: %d (tchan: %u, rchan: %u, gp-rflow: %u)\n",
>       |                                                           ~^
>       |                                                            |
>       |                                                            unsigned int
>       |                                                           %lu
> In file included from include/linux/device.h:15,
>                  from include/linux/dmaengine.h:8,
>                  from drivers/dma/ti/k3-udma.c:9:
> drivers/dma/ti/k3-udma.c:5000:26: warning: format '%u' expects argument of type 'unsigned int', but argument 6 has type 'long unsigned int' [-Wformat=]
>  5000 |                          "Channels: %d (tchan: %u, rchan: %u, gp-rflow: %u)\n",
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                              ^~~
> include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
>   150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |                                                          ^~~~~~~
> drivers/dma/ti/k3-udma.c:4999:17: note: in expansion of macro 'dev_info'
>  4999 |                 dev_info(dev,
>       |                 ^~~~~~~~
> drivers/dma/ti/k3-udma.c:5000:74: note: format string is defined here
>  5000 |                          "Channels: %d (tchan: %u, rchan: %u, gp-rflow: %u)\n",
>       |                                                                         ~^
>       |                                                                          |
>       |                                                                          unsigned int
>       |                                                                         %lu
> In file included from include/linux/device.h:15,
>                  from include/linux/dmaengine.h:8,
>                  from drivers/dma/ti/k3-udma.c:9:
> drivers/dma/ti/k3-udma.c:5011:26: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
>  5011 |                          "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                              ^~~
> include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
>   150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |                                                          ^~~~~~~
> drivers/dma/ti/k3-udma.c:5010:17: note: in expansion of macro 'dev_info'
>  5010 |                 dev_info(dev,
>       |                 ^~~~~~~~
> drivers/dma/ti/k3-udma.c:5011:49: note: format string is defined here
>  5011 |                          "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
>       |                                                ~^
>       |                                                 |
>       |                                                 unsigned int
>       |                                                %lu
> In file included from include/linux/device.h:15,
>                  from include/linux/dmaengine.h:8,
>                  from drivers/dma/ti/k3-udma.c:9:
> drivers/dma/ti/k3-udma.c:5011:26: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'long unsigned int' [-Wformat=]
>  5011 |                          "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                              ^~~
> include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
>   150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |                                                          ^~~~~~~
> drivers/dma/ti/k3-udma.c:5010:17: note: in expansion of macro 'dev_info'
>  5010 |                 dev_info(dev,
>       |                 ^~~~~~~~
> drivers/dma/ti/k3-udma.c:5011:60: note: format string is defined here
>  5011 |                          "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
>       |                                                           ~^
>       |                                                            |
>       |                                                            unsigned int
>       |                                                           %lu
> In file included from include/linux/device.h:15,
>                  from include/linux/dmaengine.h:8,
>                  from drivers/dma/ti/k3-udma.c:9:
> drivers/dma/ti/k3-udma.c:5011:26: warning: format '%u' expects argument of type 'unsigned int', but argument 6 has type 'long unsigned int' [-Wformat=]
>  5011 |                          "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                              ^~~
> include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
>   150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |                                                          ^~~~~~~
> drivers/dma/ti/k3-udma.c:5010:17: note: in expansion of macro 'dev_info'
>  5010 |                 dev_info(dev,
>       |                 ^~~~~~~~
> drivers/dma/ti/k3-udma.c:5011:71: note: format string is defined here
>  5011 |                          "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
>       |                                                                      ~^
>       |                                                                       |
>       |                                                                       unsigned int
>       |                                                                      %lu
> In file included from include/linux/device.h:15,
>                  from include/linux/dmaengine.h:8,
>                  from drivers/dma/ti/k3-udma.c:9:
> drivers/dma/ti/k3-udma.c:5022:26: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
>  5022 |                          "Channels: %d (tchan: %u, rchan: %u)\n",
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                              ^~~
> include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
>   150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |                                                          ^~~~~~~
> drivers/dma/ti/k3-udma.c:5021:17: note: in expansion of macro 'dev_info'
>  5021 |                 dev_info(dev,
>       |                 ^~~~~~~~
> drivers/dma/ti/k3-udma.c:5022:49: note: format string is defined here
>  5022 |                          "Channels: %d (tchan: %u, rchan: %u)\n",
>       |                                                ~^
>       |                                                 |
>       |                                                 unsigned int
>       |                                                %lu
> In file included from include/linux/device.h:15,
>                  from include/linux/dmaengine.h:8,
>                  from drivers/dma/ti/k3-udma.c:9:
> drivers/dma/ti/k3-udma.c:5022:26: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'long unsigned int' [-Wformat=]
>  5022 |                          "Channels: %d (tchan: %u, rchan: %u)\n",
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                              ^~~
> include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
>   150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |                                                          ^~~~~~~
> drivers/dma/ti/k3-udma.c:5021:17: note: in expansion of macro 'dev_info'
>  5021 |                 dev_info(dev,
>       |                 ^~~~~~~~
> drivers/dma/ti/k3-udma.c:5022:60: note: format string is defined here
>  5022 |                          "Channels: %d (tchan: %u, rchan: %u)\n",
>       |                                                           ~^
>       |                                                            |
>       |                                                            unsigned int
>       |                                                           %lu
> 
> Introduced by commit
> 
>   31563fb891aa ("lib/bitmap: change type of bitmap_weight to unsigned long")
> 
> I have applied the following patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 15 Jul 2022 22:15:40 +1000
> Subject: [PATCH] fix up for k3-udma.c
> 
> due to "lib/bitmap: change type of bitmap_weight to unsigned long"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/dma/ti/k3-udma.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 2f0d2c68c93c..07cb48db76ba 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4997,7 +4997,7 @@ static int setup_resources(struct udma_dev *ud)
>  	switch (ud->match_data->type) {
>  	case DMA_TYPE_UDMA:
>  		dev_info(dev,
> -			 "Channels: %d (tchan: %u, rchan: %u, gp-rflow: %u)\n",
> +			 "Channels: %d (tchan: %lu, rchan: %lu, gp-rflow: %lu)\n",
>  			 ch_count,
>  			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
>  						       ud->tchan_cnt),
> @@ -5008,7 +5008,7 @@ static int setup_resources(struct udma_dev *ud)
>  		break;
>  	case DMA_TYPE_BCDMA:
>  		dev_info(dev,
> -			 "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
> +			 "Channels: %d (bchan: %lu, tchan: %lu, rchan: %lu)\n",
>  			 ch_count,
>  			 ud->bchan_cnt - bitmap_weight(ud->bchan_map,
>  						       ud->bchan_cnt),
> @@ -5019,7 +5019,7 @@ static int setup_resources(struct udma_dev *ud)
>  		break;
>  	case DMA_TYPE_PKTDMA:
>  		dev_info(dev,
> -			 "Channels: %d (tchan: %u, rchan: %u)\n",
> +			 "Channels: %d (tchan: %lu, rchan: %lu)\n",
>  			 ch_count,
>  			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
>  						       ud->tchan_cnt),
> -- 
> 2.35.1
> 
> -- 
> Cheers,
> Stephen Rothwell


