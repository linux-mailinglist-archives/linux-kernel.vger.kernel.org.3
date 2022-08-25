Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562E95A1210
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbiHYN2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242550AbiHYN2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:28:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AD7AE218
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:28:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay12so10268402wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KfGKO4gRVHDia7DffjyPAcJcjBq+6O29TGohmEixT6E=;
        b=gfhg0I9DGV8Q5gc55jPTx1jSwtM6UtBeNZSqgS5SWaysdaYZhB5W6OJmrHN1Hgl8pO
         5t70mJDysooDK0BRriyZC3Cx6EyYXnVaRaFFMmbkQkN2Wa82MlXllExcYe9JLKkdQ9cT
         kGhJIAw1J9733Ydo8rWumKglDarKtv/90YLt+ZkvFru9P8A88NLDkGPLHZ2qks4YV05q
         KHu1NarUTSz6Wk9hj2kDD6S5o6cYZao4NTnRrJFWkSIsWvXeaFAF8Wqmxkxfhq5QlpHV
         fuSXfcjtlTyW/Qav46x2cqqtyDUyMOEVEk+UcY1hrOyOhCSdIXkXPBIr/pxuh56f04/x
         B1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KfGKO4gRVHDia7DffjyPAcJcjBq+6O29TGohmEixT6E=;
        b=yPHJeFqBS2OrkGJedbZ+Wk+uNJFU4BH+LViAvkKVKWzB+yl2GE3hZbLPhak/Cb6HWH
         ESlpXJ8gDbOleUg7IG+dH+EntrkZLjECl8nLPmRwwxGD4w7CuPNLmXNJg1KZeDiHYfOJ
         Z45iYUWRPAOJh2F78/wAbsYzBym5JHRmAl4ZKbzlW8k+H9pYxg466XMJvz4H9oMLN8g/
         Fl9uba5BtSJQ8TXKAThhGudJ/6+ZZyjDMqjvfra1vTrgzh7GW3yI3zgIsXftGsuPTjnY
         hgURuvvA9o9MwVqo/4l5sLTKPh/rTx6I/+jYaxraxUMofWP6hELAW9R+N44EXl193j3j
         PzJQ==
X-Gm-Message-State: ACgBeo2ho6pLELpx+4Yb2zHC3G4mQ1ArtUwqK7668NEddwCdOl+8haq8
        Bl2q0M08cVLlA/47uZhX3d8=
X-Google-Smtp-Source: AA6agR5a9Ai7VYX7KZ47qWIsUFrlG3Kqel4VjkZPZEG/YVdHcomsm8Mjah2kQb/Q9rfYRRDpbLy+IA==
X-Received: by 2002:a1c:4c18:0:b0:3a5:3ddd:2f29 with SMTP id z24-20020a1c4c18000000b003a53ddd2f29mr2360318wmf.91.1661434095307;
        Thu, 25 Aug 2022 06:28:15 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b003a5f3de6fddsm5620850wms.25.2022.08.25.06.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:28:14 -0700 (PDT)
Message-ID: <20ad18de-0db0-c1fa-55e5-ad0897269876@gmail.com>
Date:   Thu, 25 Aug 2022 15:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/6] soc: mediatek: mtk-svs: Remove hardcoded irqflags
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
 <20220726141653.177948-4-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220726141653.177948-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/07/2022 16:16, AngeloGioacchino Del Regno wrote:
> The interrupt flags are specified in devicetree: forcing them into
> the driver is suboptimal and not very useful.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   drivers/soc/mediatek/mtk-svs.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index ee990acfc2d5..fcf246a6bb07 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -262,7 +262,6 @@ static const u32 svs_regs_v2[] = {
>    * @rst: svs platform reset control
>    * @efuse_parsing: svs platform efuse parsing function pointer
>    * @probe: svs platform probe function pointer
> - * @irqflags: svs platform irq settings flags
>    * @efuse_max: total number of svs efuse
>    * @tefuse_max: total number of thermal efuse
>    * @regs: svs platform registers map
> @@ -280,7 +279,6 @@ struct svs_platform {
>   	struct reset_control *rst;
>   	bool (*efuse_parsing)(struct svs_platform *svsp);
>   	int (*probe)(struct svs_platform *svsp);
> -	unsigned long irqflags;
>   	size_t efuse_max;
>   	size_t tefuse_max;
>   	const u32 *regs;
> @@ -294,7 +292,6 @@ struct svs_platform_data {
>   	struct svs_bank *banks;
>   	bool (*efuse_parsing)(struct svs_platform *svsp);
>   	int (*probe)(struct svs_platform *svsp);
> -	unsigned long irqflags;
>   	const u32 *regs;
>   	u32 bank_max;
>   };
> @@ -2680,7 +2677,6 @@ static const struct svs_platform_data svs_mt8192_platform_data = {
>   	.banks = svs_mt8192_banks,
>   	.efuse_parsing = svs_mt8192_efuse_parsing,
>   	.probe = svs_mt8192_platform_probe,
> -	.irqflags = IRQF_TRIGGER_HIGH,
>   	.regs = svs_regs_v2,
>   	.bank_max = ARRAY_SIZE(svs_mt8192_banks),
>   };
> @@ -2699,7 +2695,6 @@ static const struct svs_platform_data svs_mt8183_platform_data = {
>   	.banks = svs_mt8183_banks,
>   	.efuse_parsing = svs_mt8183_efuse_parsing,
>   	.probe = svs_mt8183_platform_probe,
> -	.irqflags = IRQF_TRIGGER_LOW,
>   	.regs = svs_regs_v2,
>   	.bank_max = ARRAY_SIZE(svs_mt8183_banks),
>   };
> @@ -2743,7 +2738,6 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
>   	svsp->banks = svsp_data->banks;
>   	svsp->efuse_parsing = svsp_data->efuse_parsing;
>   	svsp->probe = svsp_data->probe;
> -	svsp->irqflags = svsp_data->irqflags;
>   	svsp->regs = svsp_data->regs;
>   	svsp->bank_max = svsp_data->bank_max;
>   
> @@ -2782,8 +2776,7 @@ static int svs_probe(struct platform_device *pdev)
>   	}
>   
>   	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
> -					svsp->irqflags | IRQF_ONESHOT,
> -					svsp->name, svsp);
> +					IRQF_ONESHOT, svsp->name, svsp);
>   	if (ret) {
>   		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
>   			svsp_irq, ret);
