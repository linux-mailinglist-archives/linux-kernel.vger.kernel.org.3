Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82ED57C700
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiGUI6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiGUI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:58:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C867145F7F;
        Thu, 21 Jul 2022 01:58:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu1so1267472wrb.9;
        Thu, 21 Jul 2022 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=syQ+VpJJB2LIQAUZnYA/zT0AD9MDsCzAI/fzicls730=;
        b=Z2qfSOhdmzD1A8erF2JN5h5MRBchlMjqkznwx2R2kmbyZTKzy68/SBv1VIU55Fq13A
         7pwyP6jI86y7bWlaNTInynXOr6icU/W6sWdD9ZdXSSlBEFiIY6LAdVNqEYNAPiB8wIts
         a66/b/tgTMCk5O1mX4b9o6Y5BYuKADxMpKp2wS44fQVtmOmMcculT4DvgUUt3XeaWQHM
         sr33WKKRdFe/Dh2bz48Xlk/NSIog827Zncr6fWgT3Z9MHwz4z9Y4aiPlJYZYgkEJc2vf
         5V2nxOCtOf1vQqLjgZ78Ey8rFXK8UokfAxj5FcMX2bRZQdac1OE+ycD9ZFiGLBf1K57j
         HTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=syQ+VpJJB2LIQAUZnYA/zT0AD9MDsCzAI/fzicls730=;
        b=5sez+VLehN4tc7Rcesec7aAeMXrhXTM5XEWHGiOII3U5e0mZIcuw9syfnp1/gzspWF
         uJcDdz2fw7NI18NtqQZ2LMP3rIMNzC4A2zDwzBmSai8X0facPxUABS10o3f6lCoZHZi7
         CXGgq7DlCR0jkJt9WIIuGaCpXRcFa4IrPEXI5rTv2rF57DlmUNzH/aAl9O538mn+8GJG
         hjHtZhR+ArfhbAjGa59mMvJUmSqAfBAHqLbLrPa8ry5J/63tHSvkPOxvHQ/mxhLu2DYB
         oHed4+QEMGTHNHOMXCdDF095jPp3UyuARgLEc0Khr2XJwvfov49jTU/EiZ4vXg/smdGc
         ow8g==
X-Gm-Message-State: AJIora8ZpqRizbO7AiGw8C/X6mZCLuVayWQWJebwcGn8enOFozRRnaKY
        DSq5FVJU/bxNSjYcNA/XRmU=
X-Google-Smtp-Source: AGRyM1tOOvMJab+4e1PYs08SdqeCBd+Bl9zzhquyW+88isndfbUjZAJT+iZUKX6XSMHa42tjYZoOSg==
X-Received: by 2002:a5d:5a9d:0:b0:21b:8247:7ec4 with SMTP id bp29-20020a5d5a9d000000b0021b82477ec4mr33511036wrb.561.1658393916178;
        Thu, 21 Jul 2022 01:58:36 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id x5-20020adfdcc5000000b0021d887f9468sm1258931wrm.25.2022.07.21.01.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 01:58:34 -0700 (PDT)
Message-ID: <f8cb0af1-96e2-36e8-474f-421d152117fb@gmail.com>
Date:   Thu, 21 Jul 2022 10:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] thermal: mediatek: control buffer enablement
 tweaks
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Markus Schneider-Pargmann <msp@baylibre.com>
References: <20220720181854.547881-1-aouledameur@baylibre.com>
 <20220720181854.547881-4-aouledameur@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220720181854.547881-4-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/07/2022 20:18, Amjad Ouled-Ameur wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Add logic in order to be able to turn on the control buffer on MT8365.
> This change now allows to have control buffer support for MTK_THERMAL_V1,
> and it allows to define the register offset, and mask used to enable it.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>

Here we will need your Signed-off-by as you are sending the patch :)

Regards,
Matthias

> ---
>   drivers/thermal/mtk_thermal.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 216eb0d61c5b..1dc276f8c4f1 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -283,6 +283,9 @@ struct mtk_thermal_data {
>   	bool need_switch_bank;
>   	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
>   	enum mtk_thermal_version version;
> +	u32 apmixed_buffer_ctl_reg;
> +	u32 apmixed_buffer_ctl_mask;
> +	u32 apmixed_buffer_ctl_set;
>   };
>   
>   struct mtk_thermal {
> @@ -578,6 +581,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
>   	.adcpnp = mt7622_adcpnp,
>   	.sensor_mux_values = mt7622_mux_values,
>   	.version = MTK_THERMAL_V2,
> +	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
> +	.apmixed_buffer_ctl_mask = ~0x37,
> +	.apmixed_buffer_ctl_set = 0x1,
>   };
>   
>   /*
> @@ -1031,14 +1037,18 @@ static const struct of_device_id mtk_thermal_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
>   
> -static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
> +static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
> +				       void __iomem *apmixed_base)
>   {
>   	int tmp;
>   
> -	tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
> -	tmp &= ~(0x37);
> -	tmp |= 0x1;
> -	writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
> +	if (!mt->conf->apmixed_buffer_ctl_reg)
> +		return;
> +
> +	tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
> +	tmp &= mt->conf->apmixed_buffer_ctl_mask;
> +	tmp |= mt->conf->apmixed_buffer_ctl_set;
> +	writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
>   	udelay(200);
>   }
>   
> @@ -1138,8 +1148,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   		goto err_disable_clk_auxadc;
>   	}
>   
> +	mtk_thermal_turn_on_buffer(mt, apmixed_base);
> +
>   	if (mt->conf->version == MTK_THERMAL_V2) {
> -		mtk_thermal_turn_on_buffer(apmixed_base);
>   		mtk_thermal_release_periodic_ts(mt, auxadc_base);
>   	}
>   
