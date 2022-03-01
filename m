Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DA84C84FC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiCAH03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiCAH0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:26:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8841E7C16A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:25:41 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p4so6989214wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Zxhvlxb6rqKJn2KYtqWngJ9OaqRjUdTtwI4QitwqQQA=;
        b=c+lXxE/6gmZRFmKit0QbHGNwYSt2dtm/VEu+bBheELDImS3q6BqtExuU2RokcAh0+u
         eTd9V5oM/zclJhaFyhFtSGAmVwIavyglIxrdF+P6QeJKPrLN/2kAvsfJdTxhq/NI8Ql3
         heqK/wtv0fnGo78K2+cA1uac2bCfiluMaxpN0CPgYW54cr2jkizMrFnILdnSwasPDaEF
         i824xyzzGkXUP6r/nXhMZrM34+G17BQEp2cI9Uw8+46+MyGRwgV2+57YHO5Qu8eeFptc
         zb2pnfCYJ+IsbhHBT0EiEOudxr3Gj+sEqV+zO/gtpmkG+gkc0u1VZGVwJpMNPI7rIyOs
         DpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zxhvlxb6rqKJn2KYtqWngJ9OaqRjUdTtwI4QitwqQQA=;
        b=wpAJvBieFhtzXqhn4yC0smj0NCY/QduuhmRdQh1pIKAta1KsknaxViphz461whUB8B
         sfS1C4VsAz1xANMOcbOyJGVQVv723u9E3V8TalAcDpf8MAT97e6lVDv//yWeL0KFajwu
         osqptU1ks5VD/NPlWgUapA05gHETq08v1H13qnY4ef8SVXu6WyeJb25Kq6brJwvn/wNu
         wNEUAcFzqjn8A1clbMJsI4FRGYVWR6HocY9TL2XQB5dxzZhZBQ3isbE+pEzY4f756eMI
         sJ3Gd+hX8cER1cAUPaPwYYPNYtvq9jGwG9zlvPbX/SFwD7KeuZPAL6Lgdpb5rNOYX1yc
         WNhg==
X-Gm-Message-State: AOAM531siHzT3/x0LrxVv9wXMqZtiBFCy1hzLV6LSTzdTOqiG6AuCCIR
        SkEeZ58SVGYd0+Wl28XVL5E=
X-Google-Smtp-Source: ABdhPJy2m46mxTpEB8OWzY6kpD1xUzJwTkawiRbU4OHDtrb8HDjJTFmfD4Sj8fJWVfSUhMM26Cj6Ow==
X-Received: by 2002:a05:600c:2282:b0:381:1938:b182 with SMTP id 2-20020a05600c228200b003811938b182mr15866841wmf.147.1646119539842;
        Mon, 28 Feb 2022 23:25:39 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b00380ead5bc65sm1875632wmq.29.2022.02.28.23.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 23:25:39 -0800 (PST)
Message-ID: <470ec036-b402-2cc2-94b9-75ebaff342fc@gmail.com>
Date:   Tue, 1 Mar 2022 08:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] soc: mediatek: mtk-infracfg: Disable ACP on MT8192
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        linux-mediatek@lists.infradead.org
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Fan <Nick.Fan@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20220215184651.12168-1-alyssa.rosenzweig@collabora.com>
 <e93b12d6-5c7b-2ad6-47e5-c1311d95cba2@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <e93b12d6-5c7b-2ad6-47e5-c1311d95cba2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi all,

On 17/02/2022 11:40, AngeloGioacchino Del Regno wrote:
> Il 15/02/22 19:46, Alyssa Rosenzweig ha scritto:
>> MT8192 contains an experimental Accelerator Coherency Port
>> implementation, which does not work correctly but was unintentionally
>> enabled by default. For correct operation of the GPU, we must set a
>> chicken bit disabling ACP on MT8192.
>>
>> Adapted from the following downstream change to the out-of-tree, legacy
>> Mali GPU driver:
>>
>> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2781271/5 
>>
>>
>> Note this change is required for both Panfrost and the legacy kernel
>> driver.
> 
> Hello Alyssa,
> the v2 note should not get inside the commit message, even though they should be
> on the patch to provide context.
> Look at the example...
> 

I think the most obvious would be to disable the ACP in the boot firmware. But 
as we can't control that, we will need to work around it. So:
Patch applied. I fixed the commit message by deleting the v2 note.

Thanks everybody for figuring out what to do about that.

Regards,
Matthias

>>
>> v2: Move the change from clk-mt8192.c to mtk-infracfg.c (Robin).
>> Although it does not make sense to add this platform-specific hack to
>> the GPU driver, it has nothing to do with clocks. We already have
>> mtk-infracfg.c to manage other infracfg bits; the ACP disable should
>> live there too.
>>
>> Co-developed-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>> Cc: Nick Fan <Nick.Fan@mediatek.com>
>> Cc: Nicolas Boichat <drinkcat@chromium.org>
>> Cc: Chen-Yu Tsai <wenst@chromium.org>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> 
> v2: Move the change from clk-mt8192.c to mtk-infracfg.c (Robin).
> 
> ^^^ put it here, after the "---" :)
> 
> Anyway,
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
>>   drivers/soc/mediatek/mtk-infracfg.c   | 19 +++++++++++++++++++
>>   include/linux/soc/mediatek/infracfg.h |  3 +++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/soc/mediatek/mtk-infracfg.c 
>> b/drivers/soc/mediatek/mtk-infracfg.c
>> index 0590b68e0d78..2acf19676af2 100644
>> --- a/drivers/soc/mediatek/mtk-infracfg.c
>> +++ b/drivers/soc/mediatek/mtk-infracfg.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/export.h>
>>   #include <linux/jiffies.h>
>>   #include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>>   #include <linux/soc/mediatek/infracfg.h>
>>   #include <asm/processor.h>
>> @@ -72,3 +73,21 @@ int mtk_infracfg_clear_bus_protection(struct regmap 
>> *infracfg, u32 mask,
>>       return ret;
>>   }
>> +
>> +static int __init mtk_infracfg_init(void)
>> +{
>> +    struct regmap *infracfg;
>> +
>> +    /*
>> +     * MT8192 has an experimental path to route GPU traffic to the DSU's
>> +     * Accelerator Coherency Port, which is inadvertently enabled by
>> +     * default. It turns out not to work, so disable it to prevent spurious
>> +     * GPU faults.
>> +     */
>> +    infracfg = syscon_regmap_lookup_by_compatible("mediatek,mt8192-infracfg");
>> +    if (!IS_ERR(infracfg))
>> +        regmap_set_bits(infracfg, MT8192_INFRA_CTRL,
>> +                MT8192_INFRA_CTRL_DISABLE_MFG2ACP);
>> +    return 0;
>> +}
>> +postcore_initcall(mtk_infracfg_init);
>> diff --git a/include/linux/soc/mediatek/infracfg.h 
>> b/include/linux/soc/mediatek/infracfg.h
>> index d858e0bab7a2..fcbbd0dd5e55 100644
>> --- a/include/linux/soc/mediatek/infracfg.h
>> +++ b/include/linux/soc/mediatek/infracfg.h
>> @@ -229,6 +229,9 @@
>>   #define INFRA_TOPAXI_PROTECTEN_SET        0x0260
>>   #define INFRA_TOPAXI_PROTECTEN_CLR        0x0264
>> +#define MT8192_INFRA_CTRL            0x290
>> +#define MT8192_INFRA_CTRL_DISABLE_MFG2ACP    BIT(9)
>> +
>>   #define REG_INFRA_MISC                0xf00
>>   #define F_DDR_4GB_SUPPORT_EN            BIT(13)
> 
> 
