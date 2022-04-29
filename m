Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74F9514567
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356574AbiD2Jax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356576AbiD2Jas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:30:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31975C6153
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:27:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t6so9988772wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7pbCE0Q4zlVj4NZwSz/310V9gr01My0YoFSYrt6xtaE=;
        b=PDQ/mfAJ/RFqiuu/VQ7l2c2F4i1fkBAAR61h9GXLZs05jXxLGK/SIi840w6zgLViuJ
         vsQbP5QGwkO2GgX+wSxHk1JUPQ+6z2ntXK4MukEjh59ABp5BUTwCm0D4dSOJVjWPxA1m
         waIpYFyqvNDjbndhH4xRKbb3D0b79CQibqEfv7jY/pBdqamOunxsdt+SFRUqOs4uhuA5
         qzaWch//Tvrs/dxYQuyUI+ZRH+o+Wp4hZEIoMGxY+4pbnDrUluPR38VbqTVkZ6qGAlg+
         25cqMojIc6fNdduil5Y43EraMxFIRyuJVXSjKxHL9TXUvdBDVREIjExWCsfirstsLrFp
         4u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7pbCE0Q4zlVj4NZwSz/310V9gr01My0YoFSYrt6xtaE=;
        b=XE+YyliF5wnybk3kE4FxKKQ2WFIx+5gXL5LFPiksKV2A7/dzkepyUBw+gpLW84jIy1
         RzmP1JE/AjDqSb+Wz0ukUX2mOI5qbkSOoz1gRXS5hamX8a4Je/Sepz7xrIQ0b27DxSNA
         hyQduXhgYcQIWrRCaAU2KAjZyF1Es/KkX9Xu0lXibrtUGDsHBFavQAU0kuQeRaGQzaqm
         R0HImJAoq5/tWg+5eT6qqJ3mK3pzcFI7v6/MXxZRZlw8ryhs0+4aFjRcKY8ID5Zu6el1
         Tbx8Yj8kda52m7jFbTYm2nh2OIw54bW8LQqN25LI2JsQ7AAMQqphix3d8xniBj1Zl2yW
         pHFw==
X-Gm-Message-State: AOAM533q/cMvHe1IsOPHGt5yl4YkZObtNIIgRqEknW2xDLyx0EULJPNh
        0ZJ0SpIbr20yhtId3tXvsg8PU2yew8yAUw==
X-Google-Smtp-Source: ABdhPJx4jVEF45BknWzfqsqdZP9s9YG69LPuNOz3ITthfyYoy87sDR2Qb3hhuVDTtagEKxtt2cUwlQ==
X-Received: by 2002:adf:d1c6:0:b0:20a:f235:5f86 with SMTP id b6-20020adfd1c6000000b0020af2355f86mr9306565wrd.381.1651224445788;
        Fri, 29 Apr 2022 02:27:25 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id bs23-20020a056000071700b0020af0c2f000sm1794383wrb.78.2022.04.29.02.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:27:25 -0700 (PDT)
Message-ID: <3a6cc645-4e23-6ca0-b07e-37ff8660c1a7@linaro.org>
Date:   Fri, 29 Apr 2022 10:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] nvmem: qfprom: using pm_runtime_resume_and_get instead of
 pm_runtime_get_sync
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220411014036.2517274-1-chi.minghao@zte.com.cn>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220411014036.2517274-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/2022 02:40, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Applied thanks,

--srini
> ---
>   drivers/nvmem/qfprom.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index 162132c7dab9..c1e893c8a247 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
> @@ -217,9 +217,8 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
>   		goto err_clk_rate_set;
>   	}
>   
> -	ret = pm_runtime_get_sync(priv->dev);
> +	ret = pm_runtime_resume_and_get(priv->dev);
>   	if (ret < 0) {
> -		pm_runtime_put_noidle(priv->dev);
>   		dev_err(priv->dev, "Failed to enable power-domain\n");
>   		goto err_reg_enable;
>   	}
