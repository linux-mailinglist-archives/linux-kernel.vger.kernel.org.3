Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAFE57E370
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiGVPKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiGVPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:10:12 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E5462D9;
        Fri, 22 Jul 2022 08:10:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r186so4684532pgr.2;
        Fri, 22 Jul 2022 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YVg6xk0ns/bX90Xit3i5w/DtXugnCkyCcpIxJMAM3pA=;
        b=LL5FZE977jrCB5ZAgNVPkQDR4/zpHzx8vl/KlVv89Pe1NocPWaX76UmoR1r5p6Ca6P
         op3OoDkvbpyqjPWqKa6LPArhGHmdOGKtxpJbobn57bzFg8wmkOKWvPaP8WfO3UAJjsCS
         1P2L4SlX26Czd/zDZwj81/x3FvJ9fsu3eL0V5pZK3HjIkl6QAEpLht26PZmuWs3BehYL
         aYQH8vR48dD7Lglb3mPRibz9j1sMU3zzo4NybsTQrlZe1r7Yd3bD5NuGFZzx4y+GrDVP
         xZe7jhahb4KAHNC/W4pziGwc4ii18RZHNW6la63aRzQLCrE0GZ+GeckuGcSlR+utztZ2
         4zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YVg6xk0ns/bX90Xit3i5w/DtXugnCkyCcpIxJMAM3pA=;
        b=fiD3m3omMflfrx6HkAx2v2AIcvYK1kmzVSoHDkfy2sQsUiCxXjznbV0fFOuZrUyNiF
         26txfRIK3QgHIY/sDRfIf3Z5WAiJh1mbvf8c4c/TufEhHIqtPNgiO93UhYEanWjpdh8O
         CPwh8flWSaD9rLQVY80ISGtwSh1dTqk6iHDqO8OZfB60zEt422WznkZFU1TPNUJSrV8L
         oM728FrV38bWxCqaYQgCuh3OF4rPnt1dzMy51ul6+8stfEkKeVCCEZwrpv0NAetTjQMl
         +mHYenopuzZ7MqYa5KxYAzlPwDWmaESJilM/tiO7haevSFR9KFEZiHbO5Y0zPtf4zHZN
         lLSA==
X-Gm-Message-State: AJIora/EFP4yvJe9wG5vuilusRDvMcbHQZk07aLqs+PJzlLV62BLyL4K
        vB8XM9nA46abZ3o/DrYz2/Y=
X-Google-Smtp-Source: AGRyM1sXMPWj4vJ6IC9x5Q7CbBRfVblVD/pWaxIOirjZAfLC4CR2biym7nnpldjD3PGRhQgq5y17/A==
X-Received: by 2002:a05:6a00:815:b0:52b:295a:fad with SMTP id m21-20020a056a00081500b0052b295a0fadmr458346pfk.62.1658502610253;
        Fri, 22 Jul 2022 08:10:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w184-20020a6230c1000000b0052b84ca900csm4024677pfw.62.2022.07.22.08.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 08:10:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cdc16106-0687-ae2b-0a42-c1f04cc8032a@roeck-us.net>
Date:   Fri, 22 Jul 2022 08:10:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] [3/3] watchdog: mediatek: mt8188: add wdt support
Content-Language: en-US
To:     Runyang Chen <Runyang.Chen@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220722072316.582-1-Runyang.Chen@mediatek.com>
 <20220722072316.582-4-Runyang.Chen@mediatek.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220722072316.582-4-Runyang.Chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 00:23, Runyang Chen wrote:
> From: Runyang Chen <runyang.chen@mediatek.com>
> 
> Support MT8188 watchdog device.
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mtk_wdt.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index f0d4e3cc7459..ce7dc96bfa4b 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -13,6 +13,7 @@
>   #include <dt-bindings/reset/mt7986-resets.h>
>   #include <dt-bindings/reset/mt8183-resets.h>
>   #include <dt-bindings/reset/mt8186-resets.h>
> +#include <dt-bindings/reset/mt8188-resets.h>
>   #include <dt-bindings/reset/mt8192-resets.h>
>   #include <dt-bindings/reset/mt8195-resets.h>
>   #include <linux/delay.h>
> @@ -90,6 +91,10 @@ static const struct mtk_wdt_data mt8186_data = {
>   	.toprgu_sw_rst_num = MT8186_TOPRGU_SW_RST_NUM,
>   };
>   
> +static const struct mtk_wdt_data mt8188_data = {
> +	.toprgu_sw_rst_num = MT8188_TOPRGU_SW_RST_NUM,
> +};
> +
>   static const struct mtk_wdt_data mt8192_data = {
>   	.toprgu_sw_rst_num = MT8192_TOPRGU_SW_RST_NUM,
>   };
> @@ -431,6 +436,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
>   	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
>   	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
>   	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
> +	{ .compatible = "mediatek,mt8188-wdt", .data = &mt8188_data },
>   	{ .compatible = "mediatek,mt8192-wdt", .data = &mt8192_data },
>   	{ .compatible = "mediatek,mt8195-wdt", .data = &mt8195_data },
>   	{ /* sentinel */ }

