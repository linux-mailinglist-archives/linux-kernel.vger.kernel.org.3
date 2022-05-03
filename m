Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BA8518C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbiECStI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241639AbiECStA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:49:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED061FCF0
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:45:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a1so20885241edt.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G8p7yldKtTr1PNOn8wgGIMMVK/LhdITnIisacE3JNHw=;
        b=YGDEzllOPX0H7yHdt3Cd+P/OufKVIhQ9fVyXiIjA6hOhBxwJV1tHelxKWqvzp/oE8/
         W8V0LDSTLA3y0/gw38XOZvhpv5JZ1wd3859Hw2dSVJL1NP63+1exFvVWv0mPnOGswUoB
         kFxj5ZtfXJX//arKuEKnBzN03av8B/XppcLxPHn0ydki3x/aritvrQK1QeR/aOTp8Ar/
         NDGa4XlR+d/rYfB4+Pl/aQLDtbdxPgE3z8XYryZLoOyn93bzz3OvkRi2UMndCNUEG2vN
         uUOIgRxzfs7VQY2tEijbizsu/S/algodvp5heTlR3482b0BmF2s6I5V+wR+SxD4jY376
         kDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G8p7yldKtTr1PNOn8wgGIMMVK/LhdITnIisacE3JNHw=;
        b=x0jFwFVrR5uem9V+k9VknByhKhnO1E7GM9N+9uyjQucaOdgy1zbwrzjDBO/jUJeidW
         m2R5pQlIqL/Et6hLiRAR2mwRoeODIg1mWkuMVKC6ly7G/Y+SaNJxyt2iIeX8EHvC9e/j
         eJ1onlH9yEqeyM0CSQGz97ASrxdBczHfGPEeGwLer+3Q2UD3TNkL8ufoK3HZj6/74rVZ
         zD2wpqCYnScfQDDj6Nsrp8eX4/ICB0k+QQH2YfeboMes4Y7abTA5bHbmyk/cqWCpqKH/
         ewhFnBH1ysZjfg0GFEqcAtKqJkM81CIKgVIse+mqgfofBfbAcIJe/B4+VP9zdfTHf3UT
         iDUg==
X-Gm-Message-State: AOAM530682LuXAigX+1CNOXgCdUElgur0j5Ee4FfBHIRI+WLxYXsO4Rh
        Xw0Tk4vWh/g3Jn1ONvN3j9pG2w==
X-Google-Smtp-Source: ABdhPJzI5A1uJNgod3x8D6YTKaAahyJjif8qzzhmrGUNRzQTxJzrMZfdsh/nkKu29nRLM9x/jCMPIw==
X-Received: by 2002:a05:6402:42d4:b0:416:5cac:a9a0 with SMTP id i20-20020a05640242d400b004165caca9a0mr19742244edc.86.1651603525309;
        Tue, 03 May 2022 11:45:25 -0700 (PDT)
Received: from [192.168.0.206] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ia17-20020a170907a07100b006f3ef214de6sm4862679ejc.76.2022.05.03.11.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 11:45:24 -0700 (PDT)
Message-ID: <4ff1354e-07c6-5518-879d-1ad55f04e22a@linaro.org>
Date:   Tue, 3 May 2022 20:45:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
References: <20220503042242.3597561-1-swboyd@chromium.org>
 <20220503042242.3597561-2-swboyd@chromium.org>
 <2280875f-fbd8-0dfd-5a0a-1d7fceb856e4@linaro.org>
 <CAD=FV=UEBi9dctmhaAi1z+c+Sj5gtcRrc3FRW294T55dTiAidQ@mail.gmail.com>
 <cd1da207-1f15-f3f1-7190-56b983e75024@kernel.org>
 <CAD=FV=XHNuvhekh=hepGePftaMXnDJGeJP=Lg8VfqmGdKt7HEA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=XHNuvhekh=hepGePftaMXnDJGeJP=Lg8VfqmGdKt7HEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 18:14, Doug Anderson wrote:
> Hi,
> 
> On Tue, May 3, 2022 at 8:54 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 03/05/2022 17:46, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Tue, May 3, 2022 at 8:42 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 03/05/2022 06:22, Stephen Boyd wrote:
>>>>> If the ChromeOS board is a detachable, this cros-ec-keyb device won't
>>>>> have a matrix keyboard but it may have some button switches, e.g. volume
>>>>> buttons and power buttons. The driver still registers a keyboard though
>>>>> and that leads to userspace confusion around where the keyboard is.
>>>>
>>>> (...)
>>>>
>>>>>
>>>>> +if:
>>>>> +  properties:
>>>>> +    compatible:
>>>>> +      contains:
>>>>> +        const: google,cros-ec-keyb
>>>>> +then:
>>>>> +  allOf:
>>>>> +    - $ref: "/schemas/input/matrix-keymap.yaml#"
>>>>> +  required:
>>>>> +    - keypad,num-rows
>>>>> +    - keypad,num-columns
>>>>> +    - linux,keymap
>>>>
>>>> else:
>>>>   properties:
>>>>     function-row-phsymap: false
>>>>     google,needs-ghost-filter: false
>>>>
>>>> Because these are not valid for the non-matrix-keyboard case, right?
>>>
>>> Isn't that implicit because this file has `unevaluatedProperties: false` ?
>>
>> But they are evaluated here, aren't they?
> 
> Only if the "if" test, though? 

No, they are evaluated always. They are listed directly in properties,
not in "if", therefore they will be considered as always evaluated.

> ...ah, or is this a difference between
> "unevaluatedProperties" and "additionalProperties" ?




Best regards,
Krzysztof
