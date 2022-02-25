Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB734C4AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbiBYQgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243080AbiBYQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:36:47 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8209920A96F;
        Fri, 25 Feb 2022 08:36:15 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 12so7950055oix.12;
        Fri, 25 Feb 2022 08:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=niaOyKFRTLM4nq6p91pTJy+BgOVTpwhZEheiPnsTKW0=;
        b=njphU4SgCOeE1f6MWWYJwpInbIET4zmkTohQOWwD4Q9qCNfs4RqdFN5jbmZzafN8Pc
         VNlUi8NwVsvtHA/EBjWVVHawtRv2OZSHx9mO690DMac36GHIwN3fRPu/uTvdQ4zBv4wr
         /1gY0YjmPEDvlZpkurRE0d3cmltJEW2yGJxp9QO853qYRiUL0gO1IdG/8Y6/ev/QIGk7
         +qMHuZNl0I6VClkELq1oGpNlicuIrTcMsvrVlBc1tK06KRlqxhDQkrotroFmZTyyOq12
         zLP8FqeY09VQg58xpGa5DSoaxibdmLLLksHZviHqSNogHNPvvZ1KgGQJZJHTaELY4Dub
         +GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=niaOyKFRTLM4nq6p91pTJy+BgOVTpwhZEheiPnsTKW0=;
        b=FB2KFrhBsFLOzPs1KGoIzr9EAUYKVd5rZFkFjP4f7s8rCyi/s9VCaMIOk6gGZ/fyGy
         e7DpyyWyBqFi0HuNgSXiTuH4bjT61Fzd4884NXMRBRDl4uGI7i+K2FFsX3PWxkra046Q
         aek9XDTZT1ALXNzCe3e7Uz/QGJC1Jtbac5ngdSzJctDr91B2KDvLUtwWLONKrEemGESF
         kRsxeyObEkOGyNrri38Zt42wSVKPElptMSwEoU3LPSls1E5pn0y4vP0dsACogQ7hVRlV
         X+7B7qCwa4QXNFhVcaUTzkKI1iZbENza9luMJ/Vv7zUT2xLMsmbvA+TelloLh++T+/vx
         91Iw==
X-Gm-Message-State: AOAM531KP4c8C1xLis6nr61kC80HPrqP8IxvFK5WAhPfdJa85kc8D2tB
        qoQhto+NkoUwHe3NSqv5Y2rtEwXOSTc=
X-Google-Smtp-Source: ABdhPJwGU24ldVXUVF0yTKU6iyVpDQgNrpuF3eu0sc35FMtjpWmbCQaUXCpa0iDMVke9oEjrTSJaDA==
X-Received: by 2002:a05:6808:d46:b0:2d7:27c0:17d3 with SMTP id w6-20020a0568080d4600b002d727c017d3mr81864oik.84.1645806974885;
        Fri, 25 Feb 2022 08:36:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k13-20020a056830150d00b005af8c9f399esm1275129otp.50.2022.02.25.08.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 08:36:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3501d9dd-b3d4-525b-995c-520b637f712f@roeck-us.net>
Date:   Fri, 25 Feb 2022 08:36:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [4/4] watchdog: mediatek: mt8186: add wdt support
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, wim@linux-watchdog.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org, p.zabel@pengutronix.de
Cc:     runyang.chen@mediatek.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
 <20220216014505.28428-5-rex-bc.chen@mediatek.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220216014505.28428-5-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 17:45, Rex-BC Chen wrote:
> From: Runyang Chen <runyang.chen@mediatek.com>
> 
> Support MT8186 watchdog device.
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mtk_wdt.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 4577a76dd464..fe5a2ecba97a 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -11,6 +11,7 @@
>   
>   #include <dt-bindings/reset/mt2712-resets.h>
>   #include <dt-bindings/reset/mt8183-resets.h>
> +#include <dt-bindings/reset/mt8186-resets.h>
>   #include <dt-bindings/reset/mt8192-resets.h>
>   #include <dt-bindings/reset/mt8195-resets.h>
>   #include <linux/delay.h>
> @@ -80,6 +81,10 @@ static const struct mtk_wdt_data mt8183_data = {
>   	.toprgu_sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
>   };
>   
> +static const struct mtk_wdt_data mt8186_data = {
> +	.toprgu_sw_rst_num = MT8186_TOPRGU_SW_RST_NUM,
> +};
> +
>   static const struct mtk_wdt_data mt8192_data = {
>   	.toprgu_sw_rst_num = MT8192_TOPRGU_SW_RST_NUM,
>   };
> @@ -419,6 +424,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
>   	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
>   	{ .compatible = "mediatek,mt6589-wdt" },
>   	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
> +	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
>   	{ .compatible = "mediatek,mt8192-wdt", .data = &mt8192_data },
>   	{ .compatible = "mediatek,mt8195-wdt", .data = &mt8195_data },
>   	{ /* sentinel */ }

