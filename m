Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A46E54F90A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382530AbiFQOUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiFQOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:20:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5658043EFB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:20:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o8so5983218wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3vOobyFVXymRVpn25jWFSnKeLAFJPxK2s0OnRHMF8AI=;
        b=Q30wclNYpthRDofrENHk9nKy2Pnt14+N0JhXzAnqU/vw/wjQgC4HxGJewSwSXhNe9r
         ZZbtcgKQlw9lojmioasAswJcZN55/pi/yVE+S3KslKTZPs3scqztumKtx9bjlt0vmE/4
         fHC4lhZFoP85iuSbr2W/VjxlRUIe62B2SlIVnCG+2kn6UvaCGFXIMHiyTWIEFu7yccY0
         TMNwBaSDI+FU3tDvrP2pjEPCj5bBwFNhmU9yRK98F8mrgO+1kPQoZGMkm+aXb15cOehV
         KvozbvcGEQyGsM6ujq2hrKENVriON5KcmZBU18t+GPvZttiIUM7aO6gLYsMDq5UgWRfi
         UFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3vOobyFVXymRVpn25jWFSnKeLAFJPxK2s0OnRHMF8AI=;
        b=YZnKgZjDRN9LS1PG9Q39tFhxxDvSnvfi9Us/9/mP6ZfU2QZszImId+6JTgWT7Iceas
         42jgslYzofy9hPyJ82YgTYexrqT2bjnnHfrXbZLa6lFPjhJprKDBpyoXn27iFgt99Ioz
         guKJsHkBm2Pvaw86fYZ7K93B9ygUEDsgy9xgAPq1YbUS++VG9P+LQ3cd3wWmOcjJ4L4i
         G0r8weCAk3pZgpDAklq4aN/Yp8vFYzXvVajTXbUoV7yJsUibm5/xOuizKkmk5BOGQfo1
         lLmlrgoookmwdF6FHlK5UXw8Ftv9a8Nm/tJzNqvYMFYISgiBtHc9qDQQzdNUymMELo9f
         pKog==
X-Gm-Message-State: AJIora+idpICl++nir/luDEaM5JyEZAaPBQbUxBslxOXucChtHnWMsmJ
        rP+7eP1JVlj1LzspE4RV2U0=
X-Google-Smtp-Source: AGRyM1tSFKuuZgKhZCminfQNyUROPCnyVZuRKnAJ/XwFsiDP7GyB2J+se02W0S3o38+Jv4Sjok+blw==
X-Received: by 2002:a5d:47c9:0:b0:20f:e7da:6a48 with SMTP id o9-20020a5d47c9000000b0020fe7da6a48mr9593609wrc.315.1655475612766;
        Fri, 17 Jun 2022 07:20:12 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id d8-20020adfc088000000b00213ba0cab3asm4820839wrf.44.2022.06.17.07.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 07:20:11 -0700 (PDT)
Message-ID: <c385ab55-bffc-8185-5d8b-f2fed1dd54a4@gmail.com>
Date:   Fri, 17 Jun 2022 16:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/4] soc: mediatek: add support of MTK_SCPD_STRICT_BUSP
 cap
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220530204214.913251-1-fparent@baylibre.com>
 <20220530204214.913251-3-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220530204214.913251-3-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/05/2022 22:42, Fabien Parent wrote:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This adds support of MTK_SCPD_STRICT_BUSP cap.
> This is required by the mt8365, for the MM power domain.
> 

Please explain better waht this flag is doing.

> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>   drivers/soc/mediatek/mtk-pm-domains.c | 37 ++++++++++++++++++++-------
>   drivers/soc/mediatek/mtk-pm-domains.h |  1 +
>   2 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 90b91b3b19a8..beaa5785fda2 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -263,17 +263,36 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
>   	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
>   
> -	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> -	if (ret)
> -		goto err_pwr_ack;

I think it would help readability if we would enable the clocks only in the case 
that MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUSP) is false. Then we would only need 
to add the same if to the error path of err_disable_subsys_clks, correct?

Regards,
Matthias

> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUSP)) {
> +		/*
> +		 * In few Mediatek platforms(e.g. MT6779), the bus protect
> +		 * policy is stricter, which leads to bus protect release must
> +		 * be prior to bus access.
> +		 */
> +		ret = scpsys_sram_enable(pd);
> +		if (ret < 0)
> +			goto err_pwr_ack;
>   
> -	ret = scpsys_sram_enable(pd);
> -	if (ret < 0)
> -		goto err_disable_subsys_clks;
> +		ret = scpsys_bus_protect_disable(pd);
> +		if (ret < 0)
> +			goto err_pwr_ack;
>   
> -	ret = scpsys_bus_protect_disable(pd);
> -	if (ret < 0)
> -		goto err_disable_sram;
> +		ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> +		if (ret < 0)
> +			goto err_pwr_ack;
> +	} else {
> +		ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> +		if (ret)
> +			goto err_pwr_ack;
> +
> +		ret = scpsys_sram_enable(pd);
> +		if (ret < 0)
> +			goto err_disable_subsys_clks;
> +
> +		ret = scpsys_bus_protect_disable(pd);
> +		if (ret < 0)
> +			goto err_disable_sram;
> +	}
>   
>   	return 0;
>   
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index a3955d960233..5347471bc3c4 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -8,6 +8,7 @@
>   #define MTK_SCPD_SRAM_ISO		BIT(2)
>   #define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
>   #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
> +#define MTK_SCPD_STRICT_BUSP		BIT(5)
>   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>   
>   #define SPM_VDE_PWR_CON			0x0210
