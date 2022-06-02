Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC4153B8F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiFBM0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiFBM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:26:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4A42985B6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:26:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q1so9635180ejz.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 05:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l0e+QqCCjFx8f2OLbKQ+40o0Vy08QxD2mn2l44RhFqk=;
        b=Nog3DQYN4J+cB/fbmluiaMsCH/GEsYKtdT45PVLBiw2jKYQkdhhVUysv0ef7qxi5IW
         aE8WpuDdI6v/NncvujJcJ4EYi8xwKg7+DxNzdA5fl9LrHbBpppRImfqFr8Jq8ZT48aTX
         PM/01Xa8gaQOW1DTj9IAkZWZNeJhBN3zuY9ralaG7fd3uNY4Q+0rRFiLcIlCZtvU9KOW
         b/q6MlU24eUHFojZjVgH24tBtY3Pm/BW7XnaFMNMoLOUSIYEvb46JFbJSFz+CLoqK77A
         OOnr4Kw9TL/sqpX2+7szIKKFHDvMHBcJyMeDrthV16bc99bfngWqbXiC522v8fdsJoYh
         jxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l0e+QqCCjFx8f2OLbKQ+40o0Vy08QxD2mn2l44RhFqk=;
        b=BySQ18NI/Gh5foqTyHlknT+Fn5bZ3vbZaaY9KKYpAchXr/3b5u8VZ+fs9o/fXPufgp
         E72hQVEVvQpBgEjwDKCPMlHtKbjmL7HiDV8EaDD1jwOhfzcEYqImPzgfxufp2qghiaGZ
         gIQ8jtYQuv/YeAjagasUExtiuptsdH94bMhGoCUu1yWieYmcpKoAmx+GeaqQWDMkytWV
         pLwKjRoorUBmHTe3CEN0Ubtw6OzMBD7t70NaSJ5gHqIVQIRTic2/07K4TDdlGV1IM7gh
         uC0p0ivOr3PolhCSxpqAV7B3NfCElE58tYCKBKjHn6jMtnQG+tUMLrScBhTACn7IY/zu
         8RtA==
X-Gm-Message-State: AOAM5323DySTR7yyCbLu0Ad2k7Aek++8OHRu4fqU98bwumub6vr9r5/q
        qVnr0y01BB7HYdBAl28Nmhhwlvw2a8GsoBVE
X-Google-Smtp-Source: ABdhPJyJKtUxGXFMU3/LbZTcWeEqPqvfdbUMPT0Dy5tDfhr7+6snoslGd5TY/yGd2/qhA/NuG5+fVw==
X-Received: by 2002:a17:907:97c7:b0:6fe:f7eb:be67 with SMTP id js7-20020a17090797c700b006fef7ebbe67mr4169542ejc.559.1654172767738;
        Thu, 02 Jun 2022 05:26:07 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j10-20020a170906830a00b006f3ef214dc0sm1684967ejx.38.2022.06.02.05.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 05:26:07 -0700 (PDT)
Message-ID: <2c610d82-65bf-60c8-05f3-434eaa1cfc8b@linaro.org>
Date:   Thu, 2 Jun 2022 14:26:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1] dt-bindings: dsp: mediatek: add mt8186 dsp document
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422071534.15653-1-tinghan.shen@mediatek.com>
 <c0a188e5-8a8c-d4a3-5a3d-9b9dd85d8f44@linaro.org>
 <eb4deff1a01c09783518bbaff8fe4e4c4ca6fa5b.camel@mediatek.com>
 <591767ee-e349-7a17-a9e9-b95d0500c7c1@linaro.org>
 <774c075ca4ad815c88be755cfb51889a171e835d.camel@mediatek.com>
 <9e3f5586-59fa-42cc-770c-b8694b4f2bf3@linaro.org>
 <a1140bd47cbd68436d0b9e147c2d6d6327ac092e.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a1140bd47cbd68436d0b9e147c2d6d6327ac092e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 13:53, Tinghan Shen wrote:
> Hi Krzysztof,
> 
> On Thu, 2022-06-02 at 12:45 +0200, Krzysztof Kozlowski wrote:
>> On 02/06/2022 12:19, Tinghan Shen wrote:
>>> Hi Krzysztof,
>>>
>>> On Thu, 2022-06-02 at 09:40 +0200, Krzysztof Kozlowski wrote:
>>>> On 02/06/2022 08:44, Tinghan Shen wrote:
>>>>>>> +  mbox-names:
>>>>>>> +    items:
>>>>>>> +      - const: mbox0
>>>>>>> +      - const: mbox1
>>>>>>
>>>>>> These should be rather some meaningful names, e.g. "rx" and "tx".
>>>>>
>>>>> The mbox name has to align with the adsp ipc driver.
>>>>> The adsp ipc driver is using 'mbox%d' for mailbox channels.
>>>>>
>>>>>
>>>>>
>>>
>>>
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=9db69df4bdd37eb1f65b6931ee067fb15b9a4d5c__;!!CTRNKA9wMg0ARbw!1TmempNkQhC5QuLBhyfWo_AC97MoLuWipsGV-LPaW9RKNPheU7Bgc-eboNi1JA1nC5I$
>>>>>  
>>>>>
>>>>> 	chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
>>>>>
>>>>> 	/* ...snip... */
>>>>>
>>>>> 	adsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
>>>>>
>>>>> Is it ok to continue using these names?
>>>>
>>>> It is a bit confusing... how did that driver got merged recently without
>>>> bindings? Why bindings are separate?
>>>>
>>>> The bindings always come together in one patchset with the driver
>>>> implementing them. Bindings are though a separate patch, yet still
>>>> followed by the driver which uses them.
>>>>
>>>> I do not see any compatibles in that driver, which suggests there is no
>>>> other binding using it. If that's correct, then you need to change the
>>>> driver.
>>>>
>>>
>>> The mtk-adsp-ipc driver's sole function is to encapsulate the operations 
>>> of mailbox framework from adsp ipc users. The mtk-adsp-ipc is not defined 
>>> in the dts file and we don't need it to be defined. The creation of mtk-adsp-ipc 
>>> device is requested by adsp ipc users via the use of 'platform_device_register_data'[1].
>>>
>>> the driver implemented the mailbox framework is 'mtk-adsp-mailbox'[2]. it has 
>>> corresponding hardwares and a yaml file[3] to describe it.
>>
>> I don't understand how is this related. We talk here about the
>> mbox-names for this bindings file. You replied, that these bindings are
>> already used by something, but now you say that they are not? So why do
>> you need to change anything in any driver?
>>
>> Simple question - do the bindings here "add mt8186 dsp document" are
>> used by any specific Linux driver already?
> 
> This bindings, 'add mt8186 dsp document', are used by the SOF sound driver of MT8186[1]. 
> 
> I'm sorry for miss leading you in previous reply. I was thought that you're 
> asking why the mtk-adsp-ipc driver got merged without bindings. So, I tried 
> to explain why mtk-adsp-ipc doesn't have bindings.

Then my question is kind of still valid:
How did "mt8186 SOF" driver got merged recently without bindings? Why
bindings are separate?

You cannot just sneak in usage of bindings in a driver, then submit
bindings and say "we already have an user!". No, the bindings come with
the driver. Always.

Linked patch [1] brings undocumented compatible mediatek,mt8186-dsp, so
you should see big fat warning when running checkpatch. So this points
that you did not run checkpatch which is another not acceptable
submission. :(

[1]
https://lore.kernel.org/all/20220422055659.8738-2-tinghan.shen@mediatek.com/


Best regards,
Krzysztof
