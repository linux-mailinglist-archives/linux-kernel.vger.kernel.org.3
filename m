Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390424633FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241445AbhK3MPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241456AbhK3MPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:15:14 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EC0C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:11:55 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id i6so40801670uae.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ezWEJY1UxPw2PKLFovyt/KEg8Ohs2gMv1LSWNGSFZEM=;
        b=O4wjtzO3oSmjpegvP0d5IYeBeM4kG4ToTjzD/3PruseWwAGb5cdISnLLUb5hEAIVNY
         wmeJA0GLnfKGt09V6oEsF8HesJaRWNZnMFH7h947bSxxBmb+ilkkhMHbie2QMXyUMebg
         JU8XJOwSGKCkwWhv3hLlPJIBciMmE+wTYcpjuJ9IGNpcMseH0FiyPqqWyPRiExfBc8mQ
         vzc2AYzIwVZ68BzIbhw3j1NpG5Jf6V8NE5y7wdqkjmGtDKdqvB3geomqlex8POnJ7FOQ
         vurW53g2dzU7MrJNgQLMQG1S7wHlLRpVhYjriz1narmIPOH+4qRRuzjSmOaz9Yq22170
         zIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ezWEJY1UxPw2PKLFovyt/KEg8Ohs2gMv1LSWNGSFZEM=;
        b=7xC9rt75Ah8e5aUuFgFLL4KZA5S14eezB942zKYkh9AG/rTEzjsh9+je7Y3BROIUns
         KVwRYjtKehcdcFmugx0idp1PTUMJHVh7Anw8bhUex1hAI8NUKEIC3KCBpLTuzxeQ9cB7
         1dqy+zr/ndsFBC9naLFuTDyVGglTjUXUeGl3W3x6YrDfNZAvNS2IwNIjOdMz4Jy+3xcc
         ZPo6+R/pQqxVsqpNZ/yFCb9JR298RQox5yOp+xBNE+K1gvPwsO55yJwiVsthNkkza4cE
         8ce3RztEgOwoylQ2OFR1Hzcd+xtPiOuM1QgtFOc/kLGX5yJs75Pd/rbNFtKSLcMJfh4P
         ZWaQ==
X-Gm-Message-State: AOAM530cqE+n85nKejAb4gHDdzuhDWjyVUpdblbpfYh7VvoocRKAWHJr
        rpjgLJL5+dNFFFxqQ3iwgo5T/ilDWSpgVw==
X-Google-Smtp-Source: ABdhPJxLXNhuLHrxh6uP38+mjJjJNBxkZpXCbKo3QO6/zmhliW+JnAqbYneMwOFJzA7HoYYmlfSDzg==
X-Received: by 2002:ab0:22c6:: with SMTP id z6mr57430523uam.80.1638274314802;
        Tue, 30 Nov 2021 04:11:54 -0800 (PST)
Received: from eze-laptop (host208.201-253-22.telecom.net.ar. [201.253.22.208])
        by smtp.gmail.com with ESMTPSA id s13sm9960047vkh.32.2021.11.30.04.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 04:11:53 -0800 (PST)
Date:   Tue, 30 Nov 2021 09:11:48 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-media@vger.kernel.org, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/9] media: hantro: Fix probe func error path
Message-ID: <YaYVBDdhhG2c7enw@eze-laptop>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
 <20211129182633.480021-2-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129182633.480021-2-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 07:26:25PM +0100, Jernej Skrabec wrote:
> If clocks for some reason couldn't be enabled, probe function returns
> immediately, without disabling PM. This obviously leaves PM ref counters
> unbalanced.
> 
> Fix that by jumping to appropriate error path, so effects of PM functions
> are reversed.
> 
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks!

> ---
>  drivers/staging/media/hantro/hantro_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index ab2467998d29..3d3107a39dae 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -981,7 +981,7 @@ static int hantro_probe(struct platform_device *pdev)
>  	ret = clk_bulk_prepare(vpu->variant->num_clocks, vpu->clocks);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to prepare clocks\n");
> -		return ret;
> +		goto err_pm_disable;
>  	}
>  
>  	ret = v4l2_device_register(&pdev->dev, &vpu->v4l2_dev);
> @@ -1037,6 +1037,7 @@ static int hantro_probe(struct platform_device *pdev)
>  	v4l2_device_unregister(&vpu->v4l2_dev);
>  err_clk_unprepare:
>  	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
> +err_pm_disable:
>  	pm_runtime_dont_use_autosuspend(vpu->dev);
>  	pm_runtime_disable(vpu->dev);
>  	return ret;
> -- 
> 2.34.1
> 
