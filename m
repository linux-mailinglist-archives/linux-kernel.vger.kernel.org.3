Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350B4468799
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 21:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355190AbhLDU7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 15:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353378AbhLDU7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 15:59:49 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A06DC0613F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 12:56:23 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b1so15160344lfs.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 12:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OPvjDBqjKrEr3rCU6Ypf1Nh6PeMaDSW0GSJx+jjs91E=;
        b=WN5Df8voZmPhnJyeK9VVbRxtRFeqrC9aRt0puxIPsiByy8EMh2f3kSeuhOBVeyrk8F
         Y43UgQdzOKtl0cjeyp6OYNdgLOR85GhKqcPEBZ8BgGttzRxM6dDjtQ5VLjujqcZERMSu
         Y7+QTQ+GuldBr9PwgG9gN+74TX3RLuF0kiOiaiKIjEqqoRTKrG3QPDBOEBEsA4d+C7zK
         PuXhuuEMGZNS/y/7IsF2j4Ba8xY/bC/63BjekMo0L4XnIMkB9Inq8JlSimxOxndnWj2E
         pkbb+INiKfi/z+qCdpBuIyW07NrhTZ/3MccMnYEDQL+OCFikAuAN/H8xinzTBHTcI492
         ZquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OPvjDBqjKrEr3rCU6Ypf1Nh6PeMaDSW0GSJx+jjs91E=;
        b=BApO0h8JGyVVnADMw8UTHiEZ50I4tstB20jwJkrgKSapi/pPgN/txnJOh3/58nJ/57
         wRalKCb45t4IDoNM0Y043WhBKDXgcxtVwyyY98l8xu0YNz1XMH/pQ47W8Smv4rP2MgNb
         +Rypl++5TvcfC3CuWQUCFDUJSIv2O1Q36TvlW5G9GkiLf7jdstChO6qk9yAEgr9PbpZX
         z3WjJYVUkaTKPWaiBH5P18VUKTcPMXoM1e+6qcq8OKNvkHoU5x5fAAfiNzyayiU3fZV6
         N/V0TTVrY35b1GqP9PkGMaloF99LLSSCf6pg5HWcdxhGTYhz8BarjT7y8jJaZFt3EX+d
         W0aw==
X-Gm-Message-State: AOAM530LhloEwCXjG9E4B/LBBAcl4NE5rtBaht7VAmaR4rugMTjXLSpI
        WeMmSR+33K3/xJR+x/3Ue5pcUXjV/wLI5w==
X-Google-Smtp-Source: ABdhPJylUmg0TqiyMASBi1dvn+e6etre5OB39NT/92hJJcQMpFMxUcZv2KoIWwS/j07aDs6muTugQg==
X-Received: by 2002:a05:6512:3ca1:: with SMTP id h33mr25609312lfv.640.1638651381507;
        Sat, 04 Dec 2021 12:56:21 -0800 (PST)
Received: from localhost (h-46-59-88-219.A463.priv.bahnhof.se. [46.59.88.219])
        by smtp.gmail.com with ESMTPSA id 190sm939797ljf.4.2021.12.04.12.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:56:20 -0800 (PST)
Date:   Sat, 4 Dec 2021 21:56:19 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: max96712: add V4L2 dependencies
Message-ID: <YavV85Xj0589TQwe@oden.dyn.berto.se>
References: <20211204174559.1146671-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211204174559.1146671-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for your patch.

I'm sorry for introducing the fault in the first place, Sakari already 
sent a fix for my mistake [1]. Just waiting for Mauro to pick it up.

1. https://patchwork.linuxtv.org/project/linux-media/patch/20211126080623.1587610-1-sakari.ailus@linux.intel.com/

On 2021-12-04 18:45:48 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without the extra dependencies, I run into randconfig build failures:
> 
> WARNING: unmet direct dependencies detected for VIDEO_V4L2_SUBDEV_API
>   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=n] && MEDIA_CONTROLLER [=y]
>   Selected by [y]:
>   - VIDEO_MAX96712 [=y] && STAGING [=y] && STAGING_MEDIA [=y] && MEDIA_SUPPORT [=y] && I2C [=y] && OF_GPIO [=y]
> 
> aarch64-linux-ld: drivers/staging/media/max96712/max96712.o: in function `max96712_probe':
> max96712.c:(.text+0x1b8): undefined reference to `v4l2_fwnode_endpoint_parse'
> aarch64-linux-ld: max96712.c:(.text+0x374): undefined reference to `v4l2_ctrl_handler_init_class'
> aarch64-linux-ld: max96712.c:(.text+0x3b0): undefined reference to `v4l2_ctrl_new_std'
> 
> Fixes: 5814f32fef13 ("media: staging: max96712: Add basic support for MAX96712 GMSL2 deserializer")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/media/max96712/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/media/max96712/Kconfig b/drivers/staging/media/max96712/Kconfig
> index 258d47644cbd..62534110ca3b 100644
> --- a/drivers/staging/media/max96712/Kconfig
> +++ b/drivers/staging/media/max96712/Kconfig
> @@ -3,6 +3,7 @@ config VIDEO_MAX96712
>  	tristate "Maxim MAX96712 Quad GMSL2 Deserializer support"
>  	depends on I2C
>  	depends on OF_GPIO
> +	depends on VIDEO_DEV && VIDEO_V4L2
>  	select V4L2_FWNODE
>  	select VIDEO_V4L2_SUBDEV_API
>  	select MEDIA_CONTROLLER
> -- 
> 2.29.2
> 

-- 
Kind Regards,
Niklas Söderlund
