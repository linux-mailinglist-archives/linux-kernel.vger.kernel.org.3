Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF8150B3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445929AbiDVJSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445924AbiDVJQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:16:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BED51E73;
        Fri, 22 Apr 2022 02:13:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bv16so10090797wrb.9;
        Fri, 22 Apr 2022 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=MaE3GXyvHmqVxToj1PrhkmxenvkXCbYA8oJuVzgMVWA=;
        b=kznRNsvQX84099UN4iJsrnjEmeF4UCzhOiY3ZgjjIYOt6CNO2SFACmKweUpT0rN/WP
         f1jyNSGwObAIlvfQwn3EyMjQwkqVwRZB7q2ODhuBT2mqHTSBlW1PedWWgb+GJUt8HMj4
         w1wxfi9fkDBpCi38wECyA13iPOr3UJ7JQbx1Z+StsIcpIWsvvcMLPv9eWm2Df9adND1+
         cCv6T9GtLOOLzqv4Foy54M8BvEyICEa8E+hZFH7byrw2pp5s0CE9OihcyalW5D9x2aQQ
         QDAJkAOkKAhWUzfm5dZ5Zo6AxeNXafWTuyH3bB9et1g8C4rpxsGcGCaubOYTcuAdgIBi
         vU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MaE3GXyvHmqVxToj1PrhkmxenvkXCbYA8oJuVzgMVWA=;
        b=6Vajg0UJYTntGOTDxHL0XPhm3AoIIAz9tC75SRevr8WnDhgN53lVBM0D66XDOlq08c
         XMwevPpdE3oqBVsDsyKCMc44G6ZfwdcXDGMn3nSEVOPsenh3D/Xu81KCZBS7NJqajCYK
         f0C3Vtma4HTZ2ntFWjGjkN7aK/w1KuLti2vQfCAfc7h2ealh/ll9TwyLNpoTjwuzf2p0
         Yjagvx4fwpoENtRFi4xCZRSLYbY6aX4602X1OliAvlQ5xf0j5KdZR8WmEc0/0+J8wDLh
         SQON384JofTfk0MQwfKRhu02Sb0mmcoPHLb19nsf8We430y8vFb9hZJaB/cq4J/GyytE
         iVOw==
X-Gm-Message-State: AOAM533PVohoEzyoJYL1GA/1qDMe/T0Y4QuZkJgqpeUAxdYhqC/3Xodq
        y+hKgBuoEidyqo4JMrSlJpI=
X-Google-Smtp-Source: ABdhPJwjOvr2Z0NMSnDaa6MLjmARYQmBC/rlBknEZ0hCAQB2/hoMy8dQYTuQr3iI9l4fnajMagMZJw==
X-Received: by 2002:a5d:6211:0:b0:1ef:85dd:c96b with SMTP id y17-20020a5d6211000000b001ef85ddc96bmr2831151wru.456.1650618809425;
        Fri, 22 Apr 2022 02:13:29 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038ece66f1b0sm1238159wms.8.2022.04.22.02.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 02:13:28 -0700 (PDT)
Message-ID: <234d411c-1386-d661-71e3-f1f30f5cbf36@gmail.com>
Date:   Fri, 22 Apr 2022 11:13:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: mt8183-kukui: align SPI NOR node name with
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220407142143.293740-1-krzysztof.kozlowski@linaro.org>
 <165044570803.75184.17759035800452933385.b4-ty@linaro.org>
 <38f29c29-e3c2-240a-23a0-509c4febf1ca@gmail.com>
 <f7c5c3f9-0083-c0b0-dc49-e66139268312@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <f7c5c3f9-0083-c0b0-dc49-e66139268312@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 21/04/2022 10:01, Krzysztof Kozlowski wrote:
> On 20/04/2022 14:35, Matthias Brugger wrote:
>>
>>
>> On 20/04/2022 11:10, Krzysztof Kozlowski wrote:
>>> On Thu, 7 Apr 2022 16:21:43 +0200, Krzysztof Kozlowski wrote:
>>>> The node names should be generic and SPI NOR dtschema expects "flash".
>>>>
>>>>
>>>
>>> Looks like no one wants to take this, so let me take care of it.
>>>
>>
>> First thing would have been a ping on the patch, don't you think?
> 
> And what does it change? The operating-points clean up [1] was sent in
> August last year, then in this April, and you responded only when I
> wrote pick-up. The Google cros-ec clean up was sent in Feb and two weeks
> later pinged [2].
> 

That I answered to the pick-up is just plain coincidence that I had some time to 
look into the patches. Sorry for being unresponsive. I'm happy that you care 
about MediaTek patches. If you think there will more patches in this cycle or 
future cycles, we can also agree on you taking the patches and send me a pull 
request later. I only want to avoid any merge conflicts, that's all.

> Pinging and resending apparently does not help. It's okay, happens, we
> are all extra busy and we all pretty often do it as part of
> community/hobby/spare time.
> 
>> Anyway as I
>> said the last time, if you take DTS patches for mediatek
> 
> I don't want to take the patches for Mediatek. But I also don't want to
> resend and ping each one of them because it did not work in the past.
> 
>> , I'd need a stable
>> branch I can merge so that we don't have any merge conflicts in the end.
> 
> Can you just pick the patch?
> 

I pushed it to v5.18-next/dts64 [1]

Let me know if there are other patches that you want me to take.

Regards,
Matthias


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.18-next/dts64

> 
> [1]
> https://lore.kernel.org/all/?q=%22arm64%3A+dts%3A+mediatek%3A+align+operating-points+table+name+with+dtschema%22
> 
> [2]
> https://lore.kernel.org/all/?q=%22arm64%3A+dts%3A+mt8183%3A+align+Google+CROS+EC+PWM+node+name+with+dtschema%22
> 
> Best regards,
> Krzysztof
