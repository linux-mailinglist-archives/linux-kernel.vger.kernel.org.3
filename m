Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D33480A95
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhL1Ox7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhL1Ox6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:53:58 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11942C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 06:53:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r17so38874625wrc.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 06:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=25qf0XUnbGHEj5vg+5G4WLH5F89cbHHWYGCIQ9dS1uY=;
        b=fxY3OcVQeu1QknWvAhC07wCcatiSI0pUUHId/HZzZ1pm8Mvt+9c4IniVsMFxvEQWXZ
         69nDOtXhTUKrYlXCEvKDPf6UkxV5L2F1r6iizH10fmZpGm00D91SHR+Iavb2yl20VAdx
         6ZhhNFYOfTirbi07w3gQPem7NLp22mSxtTthStSG6PsFBUdyJEAt7qOQFAMkH4LgQ5zc
         59UfcheyQdr3QXZmHe02a2JCtfL2nh8UO74GwrP3+f0JjuBXJLjY4yCv1Sei605sEvEF
         NhyAjzsLvaUai8dj6ugFs4kzoSCSMD5niHAM/vs8jnK2mbUKAob3VisluT05aI9KdOOz
         WCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=25qf0XUnbGHEj5vg+5G4WLH5F89cbHHWYGCIQ9dS1uY=;
        b=o4aAsqJqPu9dC0n3qtDaAgwyaIoDi1fL/iSrWchn8DwiqYRrPJB7NnM2BJPh4nsL2+
         7Tu9Fb64AmfWoyn0r7Ox0+XYf0umYV4ME5DEEKvTNbfnUukU3sWBYggxLA/4/UsprnS2
         jkCdkQXAgqxK/iC4liXmqPv4n0Lb3S42IeFJ6U7ME0qFvezFzHIxrfbilzS5sqP7KGuJ
         JM/M+dLhvChIgbt5EAeey6IWwOJPIc+6wYyluYnAxyiFfrH/9Xr36f9nasSC4SIw6nyW
         AvjSaWmX0zngWg+dmWLtCotxtP1vXKotQPCQ8xN1KbY7Zcz3Lzql6UvhGXQPnOjmSgEJ
         OfWA==
X-Gm-Message-State: AOAM531bg9bWXaKiVfJKWPd2I9Ma/M6rk+JiQ5k37sMxu4ntRLhmIPtH
        EedX+CI41PtuLu1MViTuKaFb3H5ny/tXrQ==
X-Google-Smtp-Source: ABdhPJxHVFXemI/84jypP87JEPzJM3v8K0/yYjNa6T2mSJs3rhe4xR1SVFGvstCb2ymf1aisIUBVcw==
X-Received: by 2002:adf:f390:: with SMTP id m16mr16261571wro.589.1640703236599;
        Tue, 28 Dec 2021 06:53:56 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id l26sm18003618wme.36.2021.12.28.06.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 06:53:56 -0800 (PST)
Message-ID: <fcaccc97-e920-08eb-ec3f-4c4b11ea8925@gmail.com>
Date:   Tue, 28 Dec 2021 15:53:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211228092527.29894-1-miles.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] drm/mediatek: Fix unused-but-set variable warning
In-Reply-To: <20211228092527.29894-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/12/2021 10:25, Miles Chen wrote:
> Fix unused-but-set variable warning:
> drivers/gpu/drm/mediatek/mtk_cec.c:85:6: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
> 

Actually we ignore the value passed to mtk_cec_mask. In case of
mtk_cec_mask(cec, CEC_CKGEN, 0 | CEC_32K_PDN, PDN | CEC_32K_PDN);


We are not setting CEC_32K_PDN. I wonder which side effect will it have to set 
that bit.

Anyway, if it's the right thing to do, we should add:

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")


Regards,
Matthias

> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_cec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
> index e9cef5c0c8f7..cdfa648910b2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_cec.c
> +++ b/drivers/gpu/drm/mediatek/mtk_cec.c
> @@ -85,7 +85,7 @@ static void mtk_cec_mask(struct mtk_cec *cec, unsigned int offset,
>   	u32 tmp = readl(cec->regs + offset) & ~mask;
>   
>   	tmp |= val & mask;
> -	writel(val, cec->regs + offset);
> +	writel(tmp, cec->regs + offset);
>   }
>   
>   void mtk_cec_set_hpd_event(struct device *dev,
> 
