Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2909569D71
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiGGI1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiGGI05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:26:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9041A3BB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:26:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h17so12068734wrx.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=QTKsDc0N/t7R2FE7e8qc9b6f62szw20LTPOT6cDttmI=;
        b=HyIH7xk6yru9oy170K9g2hvgVus86Ui4axzJlhxfhcliJroS1jnyBoVRj4ODf7WNYA
         Ly800IqWmeVLmbjCEBNNXPbMVnz22YErTPPKsFhcRQXrAXGtMSAbl+5p3TCRL/JpXMye
         TEv7EhT8dG3VKbRQZgzc87k2mkmm9ZAdSNN1y4xoI3NGqDVTVQ1mHzS6Xmu1cZkiOwLr
         84LowuZVRAX6B5RZ0jcB/8uo1Jo7lHfQNwxE97Y2W7f+hGYR10ZeTt/NjYOButhf4VD6
         k0p7UpKWV5SyxHaBSgbkARVDkc1/CL3FNPglG0F3zIg9HEAO6LUJppCQT0kF3OPVMwmg
         iCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=QTKsDc0N/t7R2FE7e8qc9b6f62szw20LTPOT6cDttmI=;
        b=K+MY5Tad8snq7nBpgIasL6TdDKUZQbGW1egT2yKe06wmyZfutmGRroOgUj+QAJ4/KK
         Xleg0ADNiHkwF9Ld0w7k2MMuUrUh15+qeJZI27H6f/5cygLOYIdeWnD9SYgrmVCQN9qc
         y+Krg0dYJqGq8xvuR8r4otNh63PMJi+Zd/RrTIboJ1MWz2ETJ/AE3n0NLdKAswHb66o2
         g3fLZZ4Tf6luXqBzIQD2tfsFuWASZFlzA9lLojam531LnPIO/F7BeHd+yELwgnbhUuW5
         KGku5bcISrsPK7SR+3NM9ta3zk9HJliowifpoWs1vHcvEMom9Qu0TSEYjFo+4N22IEi0
         am8Q==
X-Gm-Message-State: AJIora9DYS+ab+esIup4QdTxHU4C00UzGqPCyA+elRCenyPesN9rEBOT
        0wLmrCqTgIPBfaZKrmqn/LA=
X-Google-Smtp-Source: AGRyM1tS+6lW63F88bR6HiGjHZ5SprOSCNjOdDOL1OoF+m3XQ5fOHIjiZGDgv7z3ySy8RO9u5xquXg==
X-Received: by 2002:adf:f20e:0:b0:21d:8aa6:69da with SMTP id p14-20020adff20e000000b0021d8aa669damr47390wro.66.1657182414269;
        Thu, 07 Jul 2022 01:26:54 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4a50000000b0021d7d251c76sm3852686wrs.46.2022.07.07.01.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 01:26:53 -0700 (PDT)
Message-ID: <95151159-19fc-891f-65dc-2b66e2b96357@gmail.com>
Date:   Thu, 7 Jul 2022 10:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
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
 <952582d8-1e02-8407-0f90-d54d327056ad@gmail.com>
In-Reply-To: <952582d8-1e02-8407-0f90-d54d327056ad@gmail.com>
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



On 23/06/2022 14:03, Matthias Brugger wrote:
> 
> 
> On 23/06/2022 13:59, Matthias Brugger wrote:
>>
>>
>> On 23/06/2022 05:09, Jin Xiaoyun wrote:
>>> Use DEFINE_SIMPLE_DEV_PM_OPS() instead of the SIMPLE_DEV_PM_OPS()
>>> macro, along with using pm_sleep_ptr() as this driver doesn't handle
>>> runtime PM.
>>>
>>> Fix build error:
>>> drivers/soc/mediatek/mtk-svs.c:1515:12: error: ‘svs_resume’ defined but not 
>>> used [-Werror=unused-function]
>>> drivers/soc/mediatek/mtk-svs.c:1481:12: error: ‘svs_suspend’ defined but not 
>>> used [-Werror=unused-function]
>>>
>>> Signed-off-by: Jin Xiaoyun <jinxiaoyun2@huawei.com>
>>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> I never did give my Reviewed-by for that. Please only add these tags if you got 
> it explicetely.
> 
> Regards,
> Matthias
> 
>>> ---
>>> v1->v2:
>>> - Remove the #ifdef CONFIG_PM guard around the suspend/resume functions
>>> - Use DEFINE_SIMPLE_DEV_PM_OPS along with using pm_sleep_ptr()
>>> ---
>>>   drivers/soc/mediatek/mtk-svs.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
>>> index 606a00a2e57d..fae7376bd083 100644
>>> --- a/drivers/soc/mediatek/mtk-svs.c
>>> +++ b/drivers/soc/mediatek/mtk-svs.c
>>> @@ -2381,13 +2381,13 @@ static int svs_probe(struct platform_device *pdev)
>>>       return ret;
>>>   }
>>>
>>> -static SIMPLE_DEV_PM_OPS(svs_pm_ops, svs_suspend, svs_resume);
>>> +static DEFINE_SIMPLE_DEV_PM_OPS(svs_pm_ops, svs_suspend, svs_resume);
>>>
>>>   static struct platform_driver svs_driver = {
>>>       .probe    = svs_probe,
>>>       .driver    = {
>>>           .name        = "mtk-svs",
>>> -        .pm        = &svs_pm_ops,
>>> +        .pm        = pm_sleep_ptr(&svs_pm_ops),
>>
>> Why do we need that? From my understanding DEFINE_SIMPLE_DEV_PM_OPS() sets 
>> runtime_suspend_fn, runtime_resume_fn and idle_fn to NULL.
>>

As I didn't see any response from you on that, I went ahead and applied
20220622175649.1856337-1-nathan@kernel.org

Regards,
Matthias

>> Regards,
>> Matthias
>>
>>>           .of_match_table    = of_match_ptr(svs_of_match),
>>>       },
>>>   };
>>> -- 
>>> 2.25.1
>>>
