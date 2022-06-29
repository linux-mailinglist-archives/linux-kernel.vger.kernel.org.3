Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2354560A90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiF2Tpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiF2Tpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:45:30 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C1D25C46;
        Wed, 29 Jun 2022 12:45:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x138so13366158pfc.3;
        Wed, 29 Jun 2022 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zX93b4uo7r2zzM20H0vNMZpGBveIXWgxPACeOg4RsOo=;
        b=oi24oy8pB5I5ioF84ISCdNpuTo7TCnpI6ZmcooU6WiEr8PStnOU7pOwqXU/KD3DCvw
         onhUjkKKusDKbSWuLaHrRe5QZv+lsQTR+rbd0O2w7eExewrDZQjg8WVpRvUXtUtwo8i0
         NvrHU6UuipcewkCfCCZZEJiSuFgjDhxlduRkQ4Nzub9aZhjDdmPqVjgGqtWRKyAjj6ZG
         MgdZzudjoS4/q+yUhfw6sRst7Hy3oiCKD9ifiZ2a6dLienB+uwlxubFG/IzfGbRKUMag
         wa6ceJcYw/RLdZpbARhWKZWe6VnL06G6eJPcUqxmeYyMuQuF15mD4HKTkOdSVlN7wxhV
         ZjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zX93b4uo7r2zzM20H0vNMZpGBveIXWgxPACeOg4RsOo=;
        b=r5WohLB1NZ2fwPPHrQGLwWpJFf9fYGo9lTHn6zyvleYpP/Gw0UhpeTbHpLltL27EsF
         MqdewiSGqtsrOHvXGrLpShJonlw8ClnKEc1orh1ufTODTiK3DeGlwiD4pugBLdNz5LEY
         5qCZeevXUIeWhzwbs+GHVOh3kl6yBl8ITYojwd3mlN8KKuZro8OP7t+UH+iNS0v1W8O5
         GhD/fvcUQ0E9Tce5/L92odX41sBsTMQfZoJZzUA1HZgytgWaGUsTpE6BgaY+eCd6uw8W
         J7BbsIf367DWw9IKRg/lv46Z60OtSH2nvswuiD9SNxWpHVE6ju3h112/zLFKWum6R4/x
         FTuQ==
X-Gm-Message-State: AJIora9YQeSNgEEKML3rUthYhEV8DClAFDDyOAcLKDHgmrRHw79rmyMM
        oMJgPGPz66JnPhllIXCKdl0=
X-Google-Smtp-Source: AGRyM1vhnun+Dx/Iat4x3HGNWqaZwBKHI4Xr3keeaJWM7+Gp+HWhYaNAyqHh7y97JFLA0sm9Wf6etg==
X-Received: by 2002:a63:242:0:b0:401:b84a:6008 with SMTP id 63-20020a630242000000b00401b84a6008mr4183776pgc.100.1656531929988;
        Wed, 29 Jun 2022 12:45:29 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902c2cf00b0016a268563ecsm11867517pla.23.2022.06.29.12.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 12:45:29 -0700 (PDT)
Message-ID: <2e9d3702-595d-20e3-9e8c-c9723384b3a9@gmail.com>
Date:   Thu, 30 Jun 2022 04:45:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] PM / devfreq: imx-bus: use NULL to pass a null pointer
 rather than zero
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220623180054.79687-1-colin.i.king@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220623180054.79687-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 24. 03:00, Colin Ian King wrote:
> The 3rd argument to the function of_get_property is a pointer and it is
> being passed using 0. Use NULL instead.
> 
> Cleans up sparse warning:
> warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/devfreq/imx-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index f3f6e25053ed..f87067fc574d 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -59,7 +59,7 @@ static int imx_bus_init_icc(struct device *dev)
>  	struct imx_bus *priv = dev_get_drvdata(dev);
>  	const char *icc_driver_name;
>  
> -	if (!of_get_property(dev->of_node, "#interconnect-cells", 0))
> +	if (!of_get_property(dev->of_node, "#interconnect-cells", NULL))
>  		return 0;
>  	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX)) {
>  		dev_warn(dev, "imx interconnect drivers disabled\n");

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
