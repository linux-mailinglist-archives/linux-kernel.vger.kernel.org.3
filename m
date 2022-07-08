Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486CA56B457
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiGHITg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbiGHITd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:19:33 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED2804AB;
        Fri,  8 Jul 2022 01:19:31 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r76so2898773iod.10;
        Fri, 08 Jul 2022 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vqCjltQk8I2tU7mx1MrFC3tkT7yAdLDtPhqi15VnAKc=;
        b=keaZZ/15eYgScyXtLOqU1DW2ZKvwxgb58uT0uXkDm5jIXJQnw1n/0S89fkCI+p3V/G
         I0sIrQwXTSg4BniBjndlPmc9l5Lhw7sANIlipdqKv7HYzSD2cpBFxRkcXx6vIOs5xoBl
         GIiJk2KgFd86WsthsePRNLyg5OHAhT/TzdE0wLCMuUySTnNnlT3VRaWKzTgW6xyMoX2B
         lQ9TzDzRRDRuGjC3xhlBxSWMWDgXxNrrvt+6zaCYZAnsnhemVOV2H+YFrK4AtQ+ukhBd
         1/rveWjCrOy+DwbxfcYhGiaugLfvMxRSIyifH0dX9QbrBHsCGnbfqhFhrWzUCzq+GLBw
         6OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vqCjltQk8I2tU7mx1MrFC3tkT7yAdLDtPhqi15VnAKc=;
        b=i2RUhCf6ZpmfNJWdhQGsV6jeX+QkHDxFgpS8NpzNSUWmuRZxM7s6RDks8ZCcku0Kyx
         +A1GDSIrIer4Lptp3ayi84+rvHwilYyDsBbu1sgxNoja1qAXdG2Cx3cZvSK/W0j5vfhb
         AudPWWzGyjLlfUygq/uMauE9HIhtZQQ9hYoa6YG+mMg6VNxJnoACh8q8+a6S4Nrw4UQR
         R2slerPMlUzbRFaF1VVdSzOp/CAr3wYkauwG+C4scuPmUh6uVziJaUljSU5Va2MFJlDI
         ynkELR3DmYHftrB9ZMaEQkl/m1UQdWEMq8EfHTJOWa9b6ZfKEV1o3renpVtYHuwLFq3K
         3i3w==
X-Gm-Message-State: AJIora+yysuJAKKBmdkaP7yej7VJudFHPBJZebD8IfZwBAgIqTyh2V07
        x5+IVa3LoHhPV/I8mrGY1ftRQgtCNpLLLpqQ
X-Google-Smtp-Source: AGRyM1vCl6u+NPkYq/MEqdBUcy3Zpq5zMWpGOh9L9fZ0JMLVZDj8LJqlJjfHREvLIxclxjKUpRXPog==
X-Received: by 2002:a6b:710f:0:b0:675:20a7:84e6 with SMTP id q15-20020a6b710f000000b0067520a784e6mr1276054iog.42.1657268370450;
        Fri, 08 Jul 2022 01:19:30 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r20-20020a5d9b94000000b0066952cfe3e2sm18991505iom.39.2022.07.08.01.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 01:19:29 -0700 (PDT)
Message-ID: <2f2f8bfe-4c7f-d81c-30bf-bcd60b42e245@gmail.com>
Date:   Fri, 8 Jul 2022 10:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: add mdp3 mutex support
 for mt8186
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Xiandong Wang <xiandong.wang@mediatek.com>
References: <20220705122627.2273-1-allen-kh.cheng@mediatek.com>
 <20220705122627.2273-2-allen-kh.cheng@mediatek.com>
 <5916c91b-41a1-c97a-84b4-7d48739a0639@collabora.com>
 <640c1a9b-f8b5-aa89-19af-7d6f5c55eb12@gmail.com>
 <243b30ca-a552-3cb7-8a4e-6e54a56ff60a@collabora.com>
 <55fafa62684e077f75c3b8b192a59df62ad01692.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <55fafa62684e077f75c3b8b192a59df62ad01692.camel@mediatek.com>
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



On 08/07/2022 10:14, allen-kh.cheng wrote:
> Hi Angelo,
> 
> On Thu, 2022-07-07 at 12:59 +0200, AngeloGioacchino Del Regno wrote:
>> Il 07/07/22 12:41, Matthias Brugger ha scritto:
>>>
>>>
>>> On 07/07/2022 10:52, AngeloGioacchino Del Regno wrote:
>>>> Il 05/07/22 14:26, Allen-KH Cheng ha scritto:
>>>>> Add mdp3 mutex compatible for mt8186 SoC.
>>>>>
>>>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>>>> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
>>>>
>>>>
>>>> Please drop this commit. Adding a mdp3-mutex compatible is not
>>>> needed here.
>>>>
>>>
>>> Thanks for checking. We probably would need a fallback compatible.
>>> We can only know
>>> from the HW engineers that can confirm if the IP block is the same
>>> as the disp
>>> mutex or a different one.
>>>
>>> I'll drop both patches for now until things got clear.
>>>
>>
>> They're located in a different iospace from each other, but either
>> the platform
>> data needs to *not be* joined together, or if they're together, I
>> would not like
>> having two different compatible strings for essentially the same
>> thing.
>>
>> I would at this point prefer dropping '-disp' from 'mediatek,mt8186-
>> disp-mutex'
>> so that we would be able to declare two 'mediatek,mt8186-mutex' in
>> devicetree...
>> ...or simply have two mediatek,mt8186-disp-mutex (although logically
>> incorrect?).
>>
>> Cheers,
>> Angelo
>>
> 
> Thanks for your opinion.
> 
> They are two different hardwares for different address spaces.
> 
> I think we drop '-disp' from 'mediatek,mt8186-disp-mutex' will be
> excessive because we also need to modify mutex node in all exited dts
> files.
> 
> I prefer havingg two mediatek,mt8186-disp-mutex.
> 
> ex:
> mutex: mutex@14001000 {
> 	compatible = "mediatek,mt8186-disp-mutex";
> 	..
> }
> 
> mdp3_mutex0: mutex@1b001000 {
> 	compatible = "mediatek,mt8186-disp-mutex";
> 	...
> }
> 
> What do you think?

I think that's an acceptable solution.

Regards,
Matthias

> 
> Best regards,
> Allen
> 
>>> Regards,
>>> Matthias
>>>
>>>>> ---
>>>>>   
>>>>> .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
>>>>>    | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex
>>>>> .yaml
>>>>> b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex
>>>>> .yaml
>>>>> index 627dcc3e8b32..234fa5dc07c2 100644
>>>>> ---
>>>>> a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex
>>>>> .yaml
>>>>> +++
>>>>> b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex
>>>>> .yaml
>>>>> @@ -30,6 +30,7 @@ properties:
>>>>>          - mediatek,mt8173-disp-mutex
>>>>>          - mediatek,mt8183-disp-mutex
>>>>>          - mediatek,mt8186-disp-mutex
>>>>> +      - mediatek,mt8186-mdp3-mutex
>>>>>          - mediatek,mt8192-disp-mutex
>>>>>          - mediatek,mt8195-disp-mutex
>>>>
>>>>
>>>>
>>
>>
> 
