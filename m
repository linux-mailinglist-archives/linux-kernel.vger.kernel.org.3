Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E075A5EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiH3I4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiH3I4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:56:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6767D7BB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:56:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v16so10517238wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IQsYoJcJj+hrRt1cv36jHySIhXkSA0/HItyBCk3yloI=;
        b=hVpKlmQSZ1poDiEgiEMuQb1JBdOXqUi05gHmK5W4i0sbjvZXOqtB2hR9/liRY4tSp4
         nHKHFaukNBtGFOaqCCPATK+yCTPjOWsXYezL9CG1oninUcN+rcJ+RSDSM9mox2x/77Bl
         iXGLwYKE9wzwSCY6b0EH/mZR+OP8pjJ6n3Gn6cxb4lm/Dr/HyNmDoaf+uAFZBBfjGH4m
         KkRzQHjnLyijGX2Idr0u2NxhMCpzo12U3Kkz+Y1roEqjRDP+iY+8RN+Rw7cWqB+cYj+V
         Ic3dj06WuQPG7iCsRYrNnt+MkN/GrfCibH6zkOp62dFoxckjOhtZn12VGYZY2oZNHTjA
         Crgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IQsYoJcJj+hrRt1cv36jHySIhXkSA0/HItyBCk3yloI=;
        b=jKMyQcL1oWncsOl4BhruL0hlyyNt3rJJ83IzMcJmAPj/lCg9rJPWOaLPVzJe8B71QN
         qwTyMmukWqe89E4C0Y3HAP/VNehBPrV2BWxXJ9DenYXkXjCCto+OrNzfcKXEQJfofQdo
         txSuvZL00J0SeH3jUvlZ5tTOEtD4S7eR7f6pUMJ3q5IVtM1z0E9ghy4+MpQ9bYIK94Ry
         ZnvIPxLVjAbnkS1BNDBSyB1HnNWwXRNjrxpOZZXmcWX5yxl2z4bf6hKTOH2/4wySxjDB
         /G+WNATcz6pXNuJ5SMyDr8PHK1Btba3f4ZdFPpGUruy9MqFD5y6G6WfS7N2JBb5ho49P
         68Jw==
X-Gm-Message-State: ACgBeo0elff+iAvFU6I7xLXkJdyr0hIsuKj5IGxkmnVwLX7i0wT/+b1M
        Teojah+DUsM0TcGmUQYCCiQDYjz8p+U=
X-Google-Smtp-Source: AA6agR4w6N5w3ZMDmfqrj94y8/JEIVQqlq8DKQ3N+FsJmqb6FNHnL33qPTQTuhl6g94rqWakjwryPg==
X-Received: by 2002:a05:6000:156b:b0:222:c789:cb2d with SMTP id 11-20020a056000156b00b00222c789cb2dmr8426597wrz.197.1661849767619;
        Tue, 30 Aug 2022 01:56:07 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600c354d00b003a5f4fccd4asm11950542wmq.35.2022.08.30.01.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 01:56:06 -0700 (PDT)
Message-ID: <80280240-8769-ea25-6348-b5f60d34ef5f@gmail.com>
Date:   Tue, 30 Aug 2022 10:56:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] soc: mediatek: mtk-svs: Explicitly include bitfield
 header
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220829204439.3748648-1-nfraprado@collabora.com>
 <5a8a2b0d-fa7c-e8c6-bb04-152f8c17aa76@gmail.com>
 <ea7b7b08-cb9a-b6a3-bc7a-050616696e89@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <ea7b7b08-cb9a-b6a3-bc7a-050616696e89@collabora.com>
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



On 30/08/2022 10:06, AngeloGioacchino Del Regno wrote:
> Il 30/08/22 09:37, Matthias Brugger ha scritto:
>>
>>
>> On 29/08/2022 22:44, Nícolas F. R. A. Prado wrote:
>>> Commit a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros
>>> where possible") introduced the use of FIELD_GET and FIELD_PREP macros,
>>> which are defined in the bitfield header. Add an explicit include for it
>>> so we're sure to have the symbols defined independently of the config.
>>>
>>> Fixes: a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros 
>>> where possible")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>
>>> ---
>>>
>>>   drivers/soc/mediatek/mtk-svs.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
>>> index 64dba9f830f3..f67f3e971653 100644
>>> --- a/drivers/soc/mediatek/mtk-svs.c
>>> +++ b/drivers/soc/mediatek/mtk-svs.c
>>> @@ -3,6 +3,7 @@
>>>    * Copyright (C) 2022 MediaTek Inc.
>>>    */
>>> +#include <linux/bitfield.h>
>>>   #include <linux/bits.h>
>>
>> What do we need the bits.h for?
>>
> 
> bits.h has the definition for GENMASK(h, l), used in this file :-)
> 

Right, seems that some other include includes bits.h as well, as compilation 
does not break. But we probably don't want to rely on that for the future.

Applied thanks.

> Cheers,
> Angelo
> 
>> Regards,
>> Matthias
>>
>>>   #include <linux/clk.h>
>>>   #include <linux/completion.h>
> 
> 
