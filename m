Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489BD58141B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiGZNZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiGZNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:25:43 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88537FC4;
        Tue, 26 Jul 2022 06:25:42 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id p132so17030782oif.9;
        Tue, 26 Jul 2022 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9W7JF3IrfXSv6HnR9aCy5G+yL4VgTUQ6ChNgjcsQI/8=;
        b=bZp2M2MhWF4fUgtzDycyJtCGnccS7zhqB/ugkSS8ntWH3CMg9E/LzEu1Jo3kb/MpTZ
         IgDi2K4VcGD8U/63u5WGcIBBsF3wkEMdw8H8Xc5w+ruI8Ap1Ljm2rorfsO+qlYdu+NFv
         sE9j1+1PohyJPN69w1+vqO3WsLLg3y6emIxGfwxZ3A5MeaF6bSSY8Z9hx3cAf4HiY2dP
         UXrcU/gCrrZhfFebtvdSkyROHwkGxKbZmImpBwvFyYmCB+2WtdIrxQSuWT+sEiawQopl
         zysqx2i6oNELoSZRheokx3eCJdeYAz1M0qouwmbpe+eRtVwu5LkV0Mq5wPW9buXkZG2C
         THBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9W7JF3IrfXSv6HnR9aCy5G+yL4VgTUQ6ChNgjcsQI/8=;
        b=njFL3X9f3qfzrxIsd6/1OI8g/jZmyEIqND7xX3fG4K/5or9Nd0ufuS0FzZ+6vuJ8Jb
         S6b1zs0UqlgL6ME3isaIcWvPuSQ6lidJSVRdR9at/xk/7c2iVvvsc+E/aUgrbtbf70vD
         O3L3wYIglw6Bh0pI0M3fo3ayhG8hyN4xSQTbReYgYz5OuVZPJtxp+bUaWRqhgcC4Sf7n
         0eiH2DgGU+6knCpth/wgKPTyiBfNGWndzm8JERyo4tXnJEEgPwafeZr+Tp8nDlbS7sMR
         2qUxZjKmV8x8wftNgNKh00NkSeKLfXMcPtXcKf0XIRNXpcjeMvIE/3EhxjcvqoOjz1VH
         UoDg==
X-Gm-Message-State: AJIora8pybm+Lz0ZlEGTFHyvpdjUolf8uDTJznwkajAilzh2nE5LSVkV
        XDi9wB+jk9hulfRTiu1iFBE=
X-Google-Smtp-Source: AGRyM1vue6vjDJ0Mb8htpAGM3ajVE5K9yi5DBca3z27whgvhv09UeHHoAibRm/+ZRNKhMLXD0eo8uQ==
X-Received: by 2002:a05:6808:124a:b0:32c:45f0:5011 with SMTP id o10-20020a056808124a00b0032c45f05011mr7883176oiv.217.1658841940214;
        Tue, 26 Jul 2022 06:25:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n8-20020a056870240800b0010d7242b623sm7343024oap.21.2022.07.26.06.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:25:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fc64285e-30c7-44b1-e264-839944105185@roeck-us.net>
Date:   Tue, 26 Jul 2022 06:25:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] watchdog: mtk_wdt: Move mt6589-wdt fallback compatible to
 end of list
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220726062057.320342-1-wenst@chromium.org>
 <91613700-3335-7499-1b48-3d88edd9da36@collabora.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <91613700-3335-7499-1b48-3d88edd9da36@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/26/22 01:37, AngeloGioacchino Del Regno wrote:
> Il 26/07/22 08:20, Chen-Yu Tsai ha scritto:
>> The watchdog facility in the MediaTek SoCs are all the same, but the
>> hardware block also contains a reset controller, which differs in the
>> number of resets used between different SoCs. This difference is
>> supported with of_device_get_match_data() supplying the number of reset
>> lines for the newer compatible strings. The original mt6589-wdt only
>> covers the watchdog facility.
>>
>> of_device_is_compatible(), and by extension of_device_get_match_data(),
>> works by going through the given list of compatible strings sequentially,
>> and checks if any of the device node's compatible strings match.
>>
>> To avoid early matching on the "mediatek,mt6589-wdt" fallback compatible,
>> which only provides watchdog functionality and no reset controller, move
>> the fallback entry to the end of the list, so that other, more specific
>> compatible strings have a chance at getting matched.
>>
>> Fixes: c254e103082b ("watchdog: mtk_wdt: mt8183: Add reset controller")
>> Fixes: adc318a34066 ("watchdog: mt8192: add wdt support")
>> Fixes: 8c6b5ea6ac68 ("watchdog: mediatek: mt8195: add wdt support")
>> Fixes: 4dbabc4d9e8c ("watchdog: mediatek: mt8186: add wdt support")
>> Fixes: 711a5b25bac9 ("watchdog: mtk_wdt: mt7986: Add toprgu reset controller support")
>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> Uhm, I don't think that this is an issue?
> 
> Ordering precedence is given to the list that you specify in devicetree, that's why
> "the second one" is a fallback, meaning: ("impossible" example below)
> 
> compatible = "mediatek,mt8195-wdt", "mediatek,mt8183-wdt", "mediatek,mt6589-wdt";
> 
> This gets walked as per the order in which you wrote the compatibles, so:
> * Check match for mt8195-wdt, does not exist?
>   * Check match for mt8183-wdt, exists!
>   * Put everything into dev->of_node (having mediatek,mt8183-wdt only!)
> 
> __of_device_is_compatible() gets dev->of_node and compares that to all of the
> possible matches.
> 
> struct device_node for this device hence does *not* contain any of the other
> compatibles that we specified in devicetree, so it does *not* contain any of
> "mediatek,mt8195-wdt", or "mediatek,mt6589-wdt", because we have previously
> successfully matches 8183.
> 
> I don't think that I've misinterpreted this flow, but if I have, let's pull
> in devicetree people and check with them?
> 

I don't see the problem either. The fallback needs to be listed last in the
compatible property. If it isn't, having it last in struct of_device_id
won't help either.

> Cheers,
> Angelo
> 
>> ---
>>
>> This change complements the removal of the fallback compatible from the
>> bindings and DTSI files [1].
>>

If the fallback isn't listed in the dtsi files, it won't match at all,
no matter where it is located in struct of_device_id.

Guenter

>> [1] https://lore.kernel.org/linux-mediatek/20220721014845.19044-1-allen-kh.cheng@mediatek.com/
>>
>>   drivers/watchdog/mtk_wdt.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
>> index e97787536792..3d5a239b93ba 100644
>> --- a/drivers/watchdog/mtk_wdt.c
>> +++ b/drivers/watchdog/mtk_wdt.c
>> @@ -425,12 +425,13 @@ static int mtk_wdt_resume(struct device *dev)
>>   static const struct of_device_id mtk_wdt_dt_ids[] = {
>>       { .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
>> -    { .compatible = "mediatek,mt6589-wdt" },
>>       { .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
>>       { .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
>>       { .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
>>       { .compatible = "mediatek,mt8192-wdt", .data = &mt8192_data },
>>       { .compatible = "mediatek,mt8195-wdt", .data = &mt8195_data },
>> +    /* Fallback compatible string must be last entry */
>> +    { .compatible = "mediatek,mt6589-wdt" },
>>       { /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
> 
> 

