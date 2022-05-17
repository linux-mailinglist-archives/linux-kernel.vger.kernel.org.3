Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E2F529E66
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245434AbiEQJpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245370AbiEQJog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:44:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC2A47AEC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:44:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a5so20139470wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xFt28KVBptJqZXZcy2j7vQR/cUjdtAD4JIr71r3m1NI=;
        b=E3m6vwrzu9qqznwzVA6PVPYb0KrMeGUMjSVxkZTqsqkoJETD7P+FMkRP8hxAtwJf1T
         +JTlB6ue1pkmf/C+vau3LD0gVzqZLmR1DfBgexd16Y44930jLZJskv8nOuaqrl5eOfX9
         2DYv9H5vhLA0P7Mfed8XHdlgeJi+BHdgZdLGv4+kQ5mYbH/u5R6/tHjUgEC4hUYDMZi9
         RA/brVdCvFYAEmssuCwhR5OYP3rDKXwTBgb51nTZXq9wOoQIWWBOt4wm7YM4e/H4Op5H
         +eOKx1Fwv70DJaN8+a7zqwiTAP+CR8cLE7ZN9Et7o3ZnfWDGfCc9hqn4QHD8u/vNuoNB
         mEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xFt28KVBptJqZXZcy2j7vQR/cUjdtAD4JIr71r3m1NI=;
        b=gWI0AqlA/C+AqiH+MX2v5QzBe8rI88OwXvqBBp9vZhEr4M1HzvNUQOOwbhjZ0YiqxJ
         /YL/i9DYVRFqVZV19wSzt06LR0MMsNiU+3HR7oZV7mBUz60YmELKdNzDo1Y2FSY01OVO
         JNt9X4ewzWM53GQyEHyCPyXhcrfctBopVzKspHVMrFBizfdTDv9HIztiNCqBJQQ+AjHk
         HAOQj9UTumBgdwtdOcmjzCLG4LKzX6JihZKlk4Zn6Ts4DiTtScd6t2HoPQS53p+8T9ZF
         PRNe5be+LLEyTHcO1sywPV6pUuNWtXIPP/CAvnZgC40dh3p0cV1BiOGacnqJ3hLdRDjH
         KhWA==
X-Gm-Message-State: AOAM531/72SrNqDbR9pW5Tsc/SIl5PrsR2R7D7rbB869vJ96sB0vAXLU
        U4cQ3ihBw4FgLUJ4QbWR1Ks=
X-Google-Smtp-Source: ABdhPJx1GUr9fffSpx1lpZSn/YrvUVjYuNV7SxnP1mMQRxq4bK1KUpckqXBE/b8Ru/y+ysz1Jxm1MA==
X-Received: by 2002:a05:6000:10d0:b0:20d:7d3:9972 with SMTP id b16-20020a05600010d000b0020d07d39972mr8625180wrx.554.1652780653881;
        Tue, 17 May 2022 02:44:13 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0a5600b00396fbf6f524sm1471019wmq.1.2022.05.17.02.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 02:44:13 -0700 (PDT)
Message-ID: <a8bd608c-d94c-f4a2-e3b1-3381c9098caf@gmail.com>
Date:   Tue, 17 May 2022 11:44:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/5] soc: mediatek: pwrap: Use readx_poll_timeout()
 instead of custom function
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com
References: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
 <20220516124659.69484-2-angelogioacchino.delregno@collabora.com>
 <f8acbc75-970c-62fb-ad0d-914e512104a7@gmail.com>
 <9f197c69-fe04-b636-afb7-8474763c8a3a@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <9f197c69-fe04-b636-afb7-8474763c8a3a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/2022 11:41, AngeloGioacchino Del Regno wrote:
> Il 17/05/22 11:25, Matthias Brugger ha scritto:
>>
>>
>> On 16/05/2022 14:46, AngeloGioacchino Del Regno wrote:
>>> Function pwrap_wait_for_state() is a function that polls an address
>>> through a helper function, but this is the very same operation that
>>> the readx_poll_timeout macro means to do.
>>> Convert all instances of calling pwrap_wait_for_state() to instead
>>> use the read_poll_timeout macro.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> ---
>>>   drivers/soc/mediatek/mtk-pmic-wrap.c | 60 +++++++++++++++-------------
>>>   1 file changed, 33 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c 
>>> b/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> index bf39a64f3ecc..54a5300ab72b 100644
>>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> @@ -13,6 +13,9 @@
>>>   #include <linux/regmap.h>
>>>   #include <linux/reset.h>
>>> +#define PWRAP_POLL_DELAY_US    10
>>> +#define PWRAP_POLL_TIMEOUT_US    10000
>>> +
>>>   #define PWRAP_MT8135_BRIDGE_IORD_ARB_EN        0x4
>>>   #define PWRAP_MT8135_BRIDGE_WACS3_EN        0x10
>>>   #define PWRAP_MT8135_BRIDGE_INIT_DONE3        0x14
>>> @@ -1241,27 +1244,14 @@ static bool pwrap_is_fsm_idle_and_sync_idle(struct 
>>> pmic_wrapper *wrp)
>>>           (val & PWRAP_STATE_SYNC_IDLE0);
>>>   }
>>> -static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
>>> -        bool (*fp)(struct pmic_wrapper *))
>>> -{
>>> -    unsigned long timeout;
>>> -
>>> -    timeout = jiffies + usecs_to_jiffies(10000);
>>> -
>>> -    do {
>>> -        if (time_after(jiffies, timeout))
>>> -            return fp(wrp) ? 0 : -ETIMEDOUT;
>>> -        if (fp(wrp))
>>> -            return 0;
>>> -    } while (1);
>>> -}
>>> -
>>>   static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>>>   {
>>> +    bool tmp;
>>>       int ret;
>>>       u32 val;
>>> -    ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
>>> +    ret = readx_poll_timeout(pwrap_is_fsm_idle, wrp, tmp, tmp,
>>
>> hm, if we make the cond (tmp > 0) that would help to understand the code. At 
>> least I had to think about it for a moment. But I leave it to you if you think 
>> it's worth the effort.
>>
> 
> I would prefer size over readability in this case... if we do (tmp > 0), it would
> be incorrect to keep tmp as a `bool`, we would have to set it as an integer var,
> which is unnecessarily bigger (that's the reason why I wrote it like so!).
> 
> Another way to increase human readability would be to do (tmp == true), but it
> looks a bit weird to me, doesn't it?
> If you disagree about that looking weird, though, I can go with that one, perhaps!
> 

You are right, just leave it as it is.

Regards,
Matthias
