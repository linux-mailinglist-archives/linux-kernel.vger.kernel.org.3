Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75C535D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350551AbiE0Jid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348413AbiE0Jia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:38:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B432949C82
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:38:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h11so4721170eda.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3WnguRZLVfGoSX9zr8213z+cLpZyYlKDXrozeUElf0g=;
        b=ix1Reun4wWMys+cSnZyVdjcSGZQHsynXRRo+htcqY0nvW5P5nuf8nWQ3i+jzgdgYer
         eLNMo3m+0s3R4BlXve4U0Q/HbtTILpVtY5RxqYWPQ9wc/ie7ibUHn7Wveea9DBtcd/ZA
         05S/Jl1AmlDk+T1DN2LXgG7KBw105KbKOIIt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3WnguRZLVfGoSX9zr8213z+cLpZyYlKDXrozeUElf0g=;
        b=OaxpSpSE/NeUepRcycSHptxFJ/xLhFRCnWFJeztvdqNPPQThzDIJid4wEY5rXs3dio
         95C29GFjfFwTsCbBis6mhqy7wTawklvRCgKELKfP5GdtKgIJ50hXn1s1ZTJT5JWGNPWz
         BYBaJDJ0kQ7f8619vG9vgOjoVL4g+5Sg21OzrUZGdw/Nuxate1+PowwWY5Bvbym7IRIS
         /MWWCeHVxtHH/7OihFLhc9LFLFx6gNTJrPkAvVWDIYjZB8BInoyq7qfp13BRhMUfIOCe
         81gNK/C4THCTGZPCG8gycCQyi9Gi0KK4wv1nLIoeO1y2yMySrTC4tbwADndS1uK5Zdc2
         55Ew==
X-Gm-Message-State: AOAM531To5IMZfkMkn833bAOXRmp9qyTpTxtWo+4EJjhTxWlXUixQEVN
        HBpHW/la9dd8mhUmTl+QQpiolw==
X-Google-Smtp-Source: ABdhPJxd2spwerZv6mnCc7ShmO42K83mj9j0PBdx2nzcPOue7O85RWLIieC+eGRZMA59o6m+M0F1kA==
X-Received: by 2002:aa7:c0ca:0:b0:42c:5fac:e526 with SMTP id j10-20020aa7c0ca000000b0042c5face526mr2489643edp.219.1653644307249;
        Fri, 27 May 2022 02:38:27 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-53-154.cust.vodafonedsl.it. [188.217.53.154])
        by smtp.gmail.com with ESMTPSA id i27-20020a50871b000000b0042ab8c5e99fsm1900671edb.14.2022.05.27.02.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 02:38:26 -0700 (PDT)
Date:   Fri, 27 May 2022 11:38:24 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] media: imx-jpeg: Leave a blank space before the
 configuration data
Message-ID: <20220527093824.GF11217@tom-ThinkPad-T14s-Gen-2i>
References: <20220527075437.16882-1-ming.qian@nxp.com>
 <20220527075437.16882-3-ming.qian@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527075437.16882-3-ming.qian@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,
I think have some comments on the code for this would be nice for the
future

On Fri, May 27, 2022 at 03:54:35PM +0800, Ming Qian wrote:
> There is a hardware bug that it will load
> the first 128 bytes of configuration data twice,
> it will led to some configure error.
> so shift the configuration data 128 bytes,
> and make the first 128 bytes all zero,
> then hardware will load the 128 zero twice,

From what I've understood you initialize cfg_stm with zeros then
you start to write the configuration from 0x80 (128 bytes), avoiding the hw issue right?

> and ignore them as garbage.
> then the configuration data can be loaded correctly
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
> ---
>  drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 734e1b65fbc7..ad4213e020f3 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -519,6 +519,7 @@ static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg,
>  				     GFP_ATOMIC);
>  	if (!cfg_stm)
>  		goto err;
> +	memset(cfg_stm, 0, MXC_JPEG_MAX_CFG_STREAM);
>  	jpeg->slot_data[slot].cfg_stream_vaddr = cfg_stm;
>  
>  skip_alloc:
> @@ -755,7 +756,7 @@ static unsigned int mxc_jpeg_setup_cfg_stream(void *cfg_stream_vaddr,
>  					      u32 fourcc,
>  					      u16 w, u16 h)
>  {
> -	unsigned int offset = 0;
> +	unsigned int offset = 0x80;
>  	u8 *cfg = (u8 *)cfg_stream_vaddr;
>  	struct mxc_jpeg_sof *sof;
>  	struct mxc_jpeg_sos *sos;
> -- 
> 2.36.1
> 

Thanks,
Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
