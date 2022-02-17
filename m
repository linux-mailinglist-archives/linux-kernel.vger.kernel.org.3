Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434B54BA92F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244948AbiBQTEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:04:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbiBQTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:04:11 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B9B8118C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:03:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b8so6488863pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tuph2oj2GgXsuvbqidnNP8qpmrKej2apMqYW+XlK6Io=;
        b=C7v6YuXskwE5qqpjDquE19isFipjTh1a/uDmHHgGHzZq6nxIgVIcXz0Tvef+YJUXfD
         /fOMZKaBq3o9L0h62DdfmhCpLXnjrlGsT6tvTA3OkGLsPpUyB57xHPAF5MkFqR5a+kip
         kgGIYl0PFM7/69QzaYLLFMMNoxoA0i3tO/GXalyqztUKmLK//gfgpkHB3b8dCn4tvPG/
         wpDw9bt2jtqAjegT0L4ztLATo8agSVK6Z7jhB482JsQn7TfRch6Z/GUhMCe80VN/+xHL
         Lx+N1DvwYhm/VtGicXdCe8g9444RI+lVkVrO1v0vNXGmsoJViHV3JGVYHEogOO17yn/t
         N/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tuph2oj2GgXsuvbqidnNP8qpmrKej2apMqYW+XlK6Io=;
        b=bI4Q5SBPB5wpn9cGCUoTh7ZkFAfm6uHMncb9jnBXM3PBjVs4FoiQFg5y8HozIFNJso
         Ee4o0iFlDnWNzmoragWLqr7dmQpOeJbX7Okh+Y/il9pY3yqUDWreSOhN84gzpThWvyte
         fk4b94Uc5i0HXnpOD21/pr23KQ/ZEzxGtY3nkCDSRtO3Wzio6EqLAv7hW/cZmsJ1A1Un
         5aifhTc6zns71opTGuHpmSFmuRQXlzJ38H+Ml/aKohD0UtUoZZn+zRb8kGzapNb1wVF6
         hXyyZOXMbm2KRrKnRBWbWsuLhV9+lAigZglRtJ6gOBLErFjTfcwpekN/+gmA55gEZXmu
         1ARg==
X-Gm-Message-State: AOAM532NGTquYfS7cHNDHiwlEM3PsmcRwRJF8sn3+N7WzErR0WbPqGrQ
        Sm44Wa1wLlPBEasREaw1L5uNtw==
X-Google-Smtp-Source: ABdhPJwJUoF80WtVQZUaVb6gZsyH67X15ro43d+R6cMm9UpbR3H5yWr2lfCLx+jtXRjbrHysWmFIaA==
X-Received: by 2002:a17:90a:a385:b0:1b9:cfb8:de07 with SMTP id x5-20020a17090aa38500b001b9cfb8de07mr4400794pjp.162.1645124636039;
        Thu, 17 Feb 2022 11:03:56 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id nu11sm2701119pjb.36.2022.02.17.11.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 11:03:52 -0800 (PST)
Date:   Thu, 17 Feb 2022 12:03:49 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     bjorn.andersson@linaro.org, matthias.bgg@gmail.com,
        pihsun@chromium.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] rpmsg: mtk_rpmsg: Fix circular locking dependency
Message-ID: <20220217190349.GA477215@p14s>
References: <20220114144737.375621-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114144737.375621-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Fri, Jan 14, 2022 at 03:47:37PM +0100, AngeloGioacchino Del Regno wrote:
> During execution of the worker that's used to register rpmsg devices
> we are safely locking the channels mutex but, when creating a new
> endpoint for such devices, we are registering a IPI on the SCP, which
> then makes the SCP to trigger an interrupt, lock its own mutex and in
> turn register more subdevices.
> This creates a circular locking dependency situation, as the mtk_rpmsg
> channels_lock will then depend on the SCP IPI lock.
> 
> [   18.014514]  Possible unsafe locking scenario:
> [   18.014515]        CPU0                    CPU1
> [   18.014517]        ----                    ----
> [   18.045467]   lock(&mtk_subdev->channels_lock);
> [   18.045474]                                lock(&scp->ipi_desc[i].lock);

I spent well over an hour tracing through the meanders of the code to end up in
scp_ipi_register() which, I think, leads to the above.  But from there I don't
see how an IPI can come in and that tells me my assumption is wrong.

Can you give more details on the events that lead to the above?  I'm not saying
there is no problem, I just need to understand it.

Thanks,
Mathieu

> [   18.228399]                                lock(&mtk_subdev->channels_lock);
> [   18.228405]   lock(&scp->ipi_desc[i].lock);
> [   18.264405]
> 
> To solve this, simply unlock the channels_lock mutex before calling
> mtk_rpmsg_register_device() and relock it right after, as safety is
> still ensured by the locking mechanism that happens right after
> through SCP.
> Notably, mtk_rpmsg_register_device() does not even require locking.
> 
> Fixes: 7017996951fd ("rpmsg: add rpmsg support for mt8183 SCP.")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/rpmsg/mtk_rpmsg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
> index 5b4404b8be4c..d1213c33da20 100644
> --- a/drivers/rpmsg/mtk_rpmsg.c
> +++ b/drivers/rpmsg/mtk_rpmsg.c
> @@ -234,7 +234,9 @@ static void mtk_register_device_work_function(struct work_struct *register_work)
>  		if (info->registered)
>  			continue;
>  
> +		mutex_unlock(&subdev->channels_lock);
>  		ret = mtk_rpmsg_register_device(subdev, &info->info);
> +		mutex_lock(&subdev->channels_lock);
>  		if (ret) {
>  			dev_err(&pdev->dev, "Can't create rpmsg_device\n");
>  			continue;
> -- 
> 2.33.1
> 
