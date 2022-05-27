Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B98535D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350544AbiE0J2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbiE0J2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:28:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F70B7D2;
        Fri, 27 May 2022 02:28:10 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 27so4383446ljw.0;
        Fri, 27 May 2022 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Krhf4p2A4F/OozPS2wYakVlCdwv1A4RoS750BCdPKcc=;
        b=Lw1bpYpSg6Xu8NYSj+hYo9JMrcr1uhDlArl5ZVRhx6dypMyJ7zKZ3kcR9dRux2FrPZ
         BmVJTGXFFCR3ba14zXc5mJ7+oYZxeWuzvLMfTDBudWpx7eTDF1zVAqJSsDFZW8FP0Jcv
         LCuSpakjj/F+JPoz5ggzjQkap3QhTs34BCJG+s4ZdWIy9hmIbtufuKALLsn+YPKZ/8Y1
         qd7PP1O4Mth3HrZXpnbXWo5nZ5CHgpWaodAe2lFGAFpUYjnj5mWQ7XJMknD521TV5LqR
         E2e17Y6Y6xXevcEbzNJsgqd/z7Zr7cY6OsenyRBQd7sy54/cmLQLf1whxWN2zge/OB8W
         sCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Krhf4p2A4F/OozPS2wYakVlCdwv1A4RoS750BCdPKcc=;
        b=ZCRPsf1KVUc10SrZ9QjvxM3Z0/qU6XKc1y0a4D7Bcra9vuiIA+WbmN8q+ZsgRJG2Eo
         yC4yBzbBZIfP0VjW6kkTCAOQjN6t2QophnguqhXVoRI7qP1D0AldSDOTQHNGSf2aUa3C
         fS0ErL4PbMr2nOTzhIbGBbKw0c5spgfxzRFuikOBE4b6RxiR0/Ozvk8mjYtROKDDJIoG
         wPlnVvdbsg67KoZPVSzPjI1nPPDi5lmxxIbeGXNq+GvgFhFLfBmccWfIoCyiF3GKxzpR
         C8ozTkWM18Fv/Z2rcDEUxpUQAKHufCirYfSnpwew2od/YxdORf5rNZzGeCj8adR+gm8W
         gguA==
X-Gm-Message-State: AOAM531EWxPPt3KjVJo5C3KMqAeKFW6XUyb8+XvlmPbD0HxG1nAeSUuz
        32TDc/mTRfrbaL6ThQM4cDc=
X-Google-Smtp-Source: ABdhPJyilFQbXSAMaOm+DGPi2n3CTBILPrU5RfGaNxR0GU6ym+ew2t5uYYPEGFHYpijTzWR52odNHQ==
X-Received: by 2002:a05:651c:248:b0:253:d7cb:136 with SMTP id x8-20020a05651c024800b00253d7cb0136mr23043541ljn.65.1653643688369;
        Fri, 27 May 2022 02:28:08 -0700 (PDT)
Received: from [192.168.0.192] ([194.146.248.76])
        by smtp.gmail.com with ESMTPSA id k27-20020ac2457b000000b0047255d2114csm792432lfm.123.2022.05.27.02.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 02:28:07 -0700 (PDT)
Message-ID: <6531e5e0-d4d5-1a16-5c5c-e8ff443f3275@gmail.com>
Date:   Fri, 27 May 2022 11:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] media: platform: samsung: s5p-jpeg: replace ternary
 operator with max()
Content-Language: en-US
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "moderated list:ARM/SAMSUNG S5P SERIES JPEG CODEC SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S5P SERIES JPEG CODEC SUPPORT" 
        <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com
References: <1761ab1a-68ce-4946-24d4-8f4f9575e735@xs4all.nl>
 <20220518120836.126368-1-guozhengkui@vivo.com>
From:   Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
In-Reply-To: <20220518120836.126368-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo Zhengkui,

Sorry about the delay.

W dniu 18.05.2022 o 14:08, Guo Zhengkui pisze:
> Fix the following coccicheck warning:
> 
> drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c:1712:24-25:
> WARNING opportunity for max()
> 
> max() macro is defined in include/linux/minmax.h. It avoids multiple
> evaluations of the arguments when non-constant and performs strict
> type-checking.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Acked-by: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>

> ---
> v1 -> v2: Change the subject according to Hans Verkuil's suggestion.
> 
>   drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
> index 456287186ad8..55814041b8d8 100644
> --- a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
> +++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
> @@ -1709,7 +1709,7 @@ static int exynos3250_jpeg_try_downscale(struct s5p_jpeg_ctx *ctx,
>   	w_ratio = ctx->out_q.w / r->width;
>   	h_ratio = ctx->out_q.h / r->height;
>   
> -	scale_factor = w_ratio > h_ratio ? w_ratio : h_ratio;
> +	scale_factor = max(w_ratio, h_ratio);
>   	scale_factor = clamp_val(scale_factor, 1, 8);
>   
>   	/* Align scale ratio to the nearest power of 2 */
