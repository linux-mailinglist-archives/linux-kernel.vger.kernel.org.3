Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07714C6C57
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiB1MZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbiB1MZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:25:04 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F40874876
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:24:01 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bu29so21154565lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5douA7CZIH+Mx4m1ZPjo7hgc7hLgTfbR8KBe0Jl3pk8=;
        b=Zx/DYktODLaBxNdmRkxWJ2LcmngjxLMA/yR0j3z1EzR73uwoD1Aw26Y+/6VfDWXHEn
         JeDYCHDhA0wjBHdfH8SViYJpOwSsAXGWVQk7A7UUutoKVUr3fv4077+yK+kmlj4fC0MI
         UaFAt3HBPUG5Ol87P3Hr5qmAT3V/xzociNyvkF1YNtOSMCvK7/2RJjEjw2ZkCOvqfDAY
         eRLJOrHy+3Uyby4dGOeEDHKbuhcYc666aYGEqC8z2m0IwhttTlyq43WaOXXN7FNy1odj
         vxsx8tCmZ8LPygFMX88UzAcb8Ahwynd/RqSua/MRhJDC7kQNCxx4yyuUJ1WSO/i7mHoe
         R5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5douA7CZIH+Mx4m1ZPjo7hgc7hLgTfbR8KBe0Jl3pk8=;
        b=DZkRYV83+MAqXmV3upMb0BrSYfcYR2GzikQy+RMIy7jh/0oByNEsxEVfmgzoBUj7ry
         EZEOqVZItrTgVZ+0XYDqEXlwtmJKNyLRu1NTuu9dxIufy545WGvbV60mQ1PzGCqxWoMN
         DYIdUXsQb0JxdvcJrTzDiPwrQKU2+ZwdG2t2wz5eNBqqvQcU7hzcu/VUePCkSPfok/F3
         UQxlPGBRErg0BOCNLxlcI7oR4ldLIHYV0AoNZKONzyyXhhyf4Dx3VOflz0fATOPMP5ga
         xtJ1y9Wjp4wnoI4OrMd+w4Ocb+4hpz/qehXqZAtKU8LpxGgCLlyWtj5lvz4LmabqdTGp
         pP3w==
X-Gm-Message-State: AOAM5339+tzznQlEpxf99FUBLKTmAcV3ssEbVtKaLnRg5hJuDQjJU4M/
        MZTVEvSk9al19cTknWGwiwU=
X-Google-Smtp-Source: ABdhPJxiEZ409LKvmGodDzUeaJr366SPHcC8ExlBAW+6dq9/QYXc467qpqIa/MIJW/fuzCdIK/mGRw==
X-Received: by 2002:ac2:4898:0:b0:443:7f7c:2de4 with SMTP id x24-20020ac24898000000b004437f7c2de4mr13058704lfc.428.1646051039453;
        Mon, 28 Feb 2022 04:23:59 -0800 (PST)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id m11-20020a05651202eb00b00443130ce80asm932589lfq.138.2022.02.28.04.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 04:23:59 -0800 (PST)
Message-ID: <764a2715-9c24-25f0-74ee-c9cf5d8a46c6@gmail.com>
Date:   Mon, 28 Feb 2022 14:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] ASoC: ti: davinci-i2s: Add check for clk_enable()
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220228031540.3571959-1-jiasheng@iscas.ac.cn>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220228031540.3571959-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/02/2022 05:15, Jiasheng Jiang wrote:
> As the potential failure of the clk_enable(),
> it should be better to check it and return error
> if fails.

Thank you for the patch!

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>


> 
> Fixes: 5f9a50c3e55e ("ASoC: Davinci: McBSP: add device tree support for McBSP")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  sound/soc/ti/davinci-i2s.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
> index 6dca51862dd7..0363a088d2e0 100644
> --- a/sound/soc/ti/davinci-i2s.c
> +++ b/sound/soc/ti/davinci-i2s.c
> @@ -708,7 +708,9 @@ static int davinci_i2s_probe(struct platform_device *pdev)
>  	dev->clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(dev->clk))
>  		return -ENODEV;
> -	clk_enable(dev->clk);
> +	ret = clk_enable(dev->clk);
> +	if (ret)
> +		goto err_put_clk;
>  
>  	dev->dev = &pdev->dev;
>  	dev_set_drvdata(&pdev->dev, dev);
> @@ -730,6 +732,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
>  	snd_soc_unregister_component(&pdev->dev);
>  err_release_clk:
>  	clk_disable(dev->clk);
> +err_put_clk:
>  	clk_put(dev->clk);
>  	return ret;
>  }

-- 
Péter
