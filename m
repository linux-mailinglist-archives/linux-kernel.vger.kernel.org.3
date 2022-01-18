Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D82492FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbiARVCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349468AbiARVCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:02:22 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A31C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:02:21 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so195753otu.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1VLSpDu78a/QQtlbDHw8oRJ41Gic+mpyfMuI9CFwaS4=;
        b=oyfsdS43YUPbHomPJmvS7UB7JpqPg2VMwTN5ajXlyJmBBvFNT7pc6f8z+BD7YjMWzd
         oUSCXl+2cA5Ln44yyBF46k6vdsJdA1GYZNYZQpVGADN1ZjomOWKlxGF2uXmimH0nnvSR
         wCZhSpABsmN4J/VgIgQDS+odQ2TxhhutMFE95eMNCXO5AWCtFlArmqO+/RR6szL8q0ub
         0RhUNLHj+M9bTk6u7jNOHPtBMrPM5r1cpTopnnJ8fT6uVESC/kmMS+XI388RhK9AIyM8
         ISh4ZNhG9TM9J0X5HDZ0decq+jfKGz641ylwXHBTdTA/jq9fJs1BFAzKyRGG/09n1GHu
         wapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1VLSpDu78a/QQtlbDHw8oRJ41Gic+mpyfMuI9CFwaS4=;
        b=UE/raQzVR4B0Z0kQs1If1N1I1gBt7LDiTExxmb1FbhHhSPD97rEc4LKWW1Kk0Opey4
         AOiw+FHzZCMw305IvADjd5TxQ+yMxW9xyyWmDucQQVchyZ3VOhrWt9fkaWnM6rP9ZQGP
         CRy+TX4833UwDZBfB5aE8/zuLzdJktVsowfTFn0zALSfZqVaelbcYYL/7RnmHjkibmyC
         F691m1YspmDr2mnkLAsLiJIFJXlQqqIxiEX5Jj51PrRwzbUsDA02kelZlFH9dxn11InY
         HUy2vdwSpvs60ZKssTJYqDZy4ggTp2/gh+I2RXXd6DfeMvGL7zlPgkIxUT5NzWZU3Y9X
         BWjg==
X-Gm-Message-State: AOAM530TrGRTBZyY+L5i8Ni8/lEpji06VfYmF9WVi2kbOCHFHulZtb6I
        31OCtkm9mXxlhzoVYBrug1/YPQ==
X-Google-Smtp-Source: ABdhPJy9JqUlPm4DjmcQEbF/c7bKPYBtmvOFvFI1wvmpsaCmzCHcGp9F8cZ10lhpzdzWUlzzZUoGbg==
X-Received: by 2002:a9d:17cc:: with SMTP id j70mr21545588otj.313.1642539741207;
        Tue, 18 Jan 2022 13:02:21 -0800 (PST)
Received: from eze-laptop ([190.194.87.200])
        by smtp.gmail.com with ESMTPSA id j26sm4929362oou.29.2022.01.18.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 13:02:19 -0800 (PST)
Date:   Tue, 18 Jan 2022 18:02:15 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT v2 1/8] media: hantro: jpeg: Relax register writes
 before write starting hardware
Message-ID: <Yecq111pZDP9XFNO@eze-laptop>
References: <20220107093455.73766-1-wenst@chromium.org>
 <20220107093455.73766-2-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107093455.73766-2-wenst@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

The series looks good, thanks for picking up this task.

Just a one comment.

On Fri, Jan 07, 2022 at 05:34:48PM +0800, Chen-Yu Tsai wrote:
> In the earlier submissions of the Hantro/Rockchip JPEG encoder driver, a
> wmb() was inserted before the final register write that starts the
> encoder. In v11, it was removed and the second-to-last register write
> was changed to a non-relaxed write, which has an implicit wmb() [1].
> The rockchip_vpu2 (then rk3399_vpu) variant is even weirder as there
> is another writel_relaxed() following the non-relaxed one.
> 
> Turns out only the last writel() needs to be non-relaxed. Device I/O
> mappings already guarantee strict ordering to the same endpoint, and
> the writel() triggering the hardware would force all writes to memory
> to be observed before the writel() to the hardware is observed.
> 
> [1] https://lore.kernel.org/linux-media/CAAFQd5ArFG0hU6MgcyLd+_UOP3+T_U-aw2FXv6sE7fGqVCVGqw@mail.gmail.com/
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/staging/media/hantro/hantro_h1_jpeg_enc.c        | 3 +--
>  drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
> index 1450013d3685..03db1c3444f8 100644
> --- a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
> +++ b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
> @@ -123,8 +123,7 @@ int hantro_h1_jpeg_enc_run(struct hantro_ctx *ctx)
>  		| H1_REG_AXI_CTRL_INPUT_SWAP32
>  		| H1_REG_AXI_CTRL_OUTPUT_SWAP8
>  		| H1_REG_AXI_CTRL_INPUT_SWAP8;
> -	/* Make sure that all registers are written at this point. */
> -	vepu_write(vpu, reg, H1_REG_AXI_CTRL);
> +	vepu_write_relaxed(vpu, reg, H1_REG_AXI_CTRL);
>  

As far as I can remember, this logic comes from really old Chromium Kernels.
You might be right, and this barrier isn't needed... but then OTOH the comment
is here for a reason, so maybe it is needed (or was needed on some RK3288 SoC revision).

I don't have RK3288 boards near me, but in any case, I'm not sure
we'd be able to test this easily (maybe there are issues that only
trigger under a certain load).

I'd personally avoid this one change, but if you are confident enough with it
that's fine too.

Thanks!
Ezequiel

>  	reg = H1_REG_ENC_CTRL_WIDTH(MB_WIDTH(ctx->src_fmt.width))
>  		| H1_REG_ENC_CTRL_HEIGHT(MB_HEIGHT(ctx->src_fmt.height))
> diff --git a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c b/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
> index 4df16f59fb97..b931fc5fa1a9 100644
> --- a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
> +++ b/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
> @@ -152,8 +152,7 @@ int rockchip_vpu2_jpeg_enc_run(struct hantro_ctx *ctx)
>  		| VEPU_REG_INPUT_SWAP8
>  		| VEPU_REG_INPUT_SWAP16
>  		| VEPU_REG_INPUT_SWAP32;
> -	/* Make sure that all registers are written at this point. */
> -	vepu_write(vpu, reg, VEPU_REG_DATA_ENDIAN);
> +	vepu_write_relaxed(vpu, reg, VEPU_REG_DATA_ENDIAN);
>  
>  	reg = VEPU_REG_AXI_CTRL_BURST_LEN(16);
>  	vepu_write_relaxed(vpu, reg, VEPU_REG_AXI_CTRL);
> -- 
> 2.34.1.575.g55b058a8bb-goog
> 
