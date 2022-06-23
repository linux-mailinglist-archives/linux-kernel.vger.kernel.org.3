Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB85579BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiFWMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiFWMDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:03:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161428E15
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:03:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o10so28204176edi.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=5Ezgso8XivHRRPiT85f6GCzH+pIwsqVbtG8cGrlQS8g=;
        b=cMQrBm9t4OvtqgEY61UcVrKGHscFtURRz/dn5wgBi1BJb+kWQj5nfHMX93bnwAU6Uw
         sm1sHoDxVPS5MZClbNo/WZLZ8S8vXB3AjcFF+4bDEUHdZjt11SMooJvZXHQfkCBrdHB5
         1bpkFhOuU3UPXpJ1E2STcbO+heIgE6KhqFKd5TAUTptCQ06vbXleCU4BwWgYviiucLo4
         I83xIz1Fznt2g60pcYvvp2HtCqcPNQDlQRLd7lj+t9vXfQ9/DwsD6q2IS6GK09gAayj6
         QxHs8a0p6nXv5saFuJPzVoi1I6+vFj3ddbdxAt9GktMgHnsZ7R4+hz7ZRkcyCMLmKktu
         GqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=5Ezgso8XivHRRPiT85f6GCzH+pIwsqVbtG8cGrlQS8g=;
        b=4xSG0KrukNpPEffHEILGJQ39/Id9Jf7m+zb+ia5/+t5m9uxdDDCR4r+wKF6Jzsuh98
         l/fLj/M8fnkpK1pk1tRSC60Fx+h6yh2Wr/bSNmfqNlKo8Ayyyg9bgJsGsGxsFAHz9ehE
         clzjllvx6d+bktwZtGen0yTrA0vQexdzlAK8MIberXUPmxzDPHa5tZTw1adatIFNCDVd
         4NNLuZJ4A5tExKFkoA985WRuhUhRu+kGAs/7gODehRl3OCu6Bz0Lnf/IpKK7ECj6Nikj
         zJrQ97kXEdcyy/Lz9gioEG2DSSsn++JoouodTN2oX9IhgrUdBGDVgLlQJJFFQVBcaKwH
         O2zw==
X-Gm-Message-State: AJIora9jkbcGLdgBlLYG/eLa5zY5keLG7PYNd7UUpQss6oGyMnBdnNxy
        TQ+f+udraWrAvqI3Rx/ZyJ4=
X-Google-Smtp-Source: AGRyM1tZb9uG7JLHZX5PUvW6s58qyiBpeM171hb7gzho2PSP4Nd26URePYk/o2EujwCrP6RRsDDOwQ==
X-Received: by 2002:a05:6402:218:b0:435:dc75:22e with SMTP id t24-20020a056402021800b00435dc75022emr956569edv.3.1655985818144;
        Thu, 23 Jun 2022 05:03:38 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id la10-20020a170907780a00b00722ea7a7aeesm2854255ejc.51.2022.06.23.05.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 05:03:37 -0700 (PDT)
Message-ID: <952582d8-1e02-8407-0f90-d54d327056ad@gmail.com>
Date:   Thu, 23 Jun 2022 14:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 -next] soc: mediatek: SVS: Use the new PM macros
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Jin Xiaoyun <jinxiaoyun2@huawei.com>,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com,
        zhengbin13@huawei.com, gaochao49@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220622013410.2786760-1-jinxiaoyun2@huawei.com>
 <20220623030931.2816013-1-jinxiaoyun2@huawei.com>
 <d17549d3-a111-53b4-4576-2f5b6581c830@gmail.com>
In-Reply-To: <d17549d3-a111-53b4-4576-2f5b6581c830@gmail.com>
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



On 23/06/2022 13:59, Matthias Brugger wrote:
> 
> 
> On 23/06/2022 05:09, Jin Xiaoyun wrote:
>> Use DEFINE_SIMPLE_DEV_PM_OPS() instead of the SIMPLE_DEV_PM_OPS()
>> macro, along with using pm_sleep_ptr() as this driver doesn't handle
>> runtime PM.
>>
>> Fix build error:
>> drivers/soc/mediatek/mtk-svs.c:1515:12: error: ‘svs_resume’ defined but not 
>> used [-Werror=unused-function]
>> drivers/soc/mediatek/mtk-svs.c:1481:12: error: ‘svs_suspend’ defined but not 
>> used [-Werror=unused-function]
>>
>> Signed-off-by: Jin Xiaoyun <jinxiaoyun2@huawei.com>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

I never did give my Reviewed-by for that. Please only add these tags if you got 
it explicetely.

Regards,
Matthias

>> ---
>> v1->v2:
>> - Remove the #ifdef CONFIG_PM guard around the suspend/resume functions
>> - Use DEFINE_SIMPLE_DEV_PM_OPS along with using pm_sleep_ptr()
>> ---
>>   drivers/soc/mediatek/mtk-svs.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
>> index 606a00a2e57d..fae7376bd083 100644
>> --- a/drivers/soc/mediatek/mtk-svs.c
>> +++ b/drivers/soc/mediatek/mtk-svs.c
>> @@ -2381,13 +2381,13 @@ static int svs_probe(struct platform_device *pdev)
>>       return ret;
>>   }
>>
>> -static SIMPLE_DEV_PM_OPS(svs_pm_ops, svs_suspend, svs_resume);
>> +static DEFINE_SIMPLE_DEV_PM_OPS(svs_pm_ops, svs_suspend, svs_resume);
>>
>>   static struct platform_driver svs_driver = {
>>       .probe    = svs_probe,
>>       .driver    = {
>>           .name        = "mtk-svs",
>> -        .pm        = &svs_pm_ops,
>> +        .pm        = pm_sleep_ptr(&svs_pm_ops),
> 
> Why do we need that? From my understanding DEFINE_SIMPLE_DEV_PM_OPS() sets 
> runtime_suspend_fn, runtime_resume_fn and idle_fn to NULL.
> 
> Regards,
> Matthias
> 
>>           .of_match_table    = of_match_ptr(svs_of_match),
>>       },
>>   };
>> -- 
>> 2.25.1
>>
