Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7D53DCE3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351190AbiFEQL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiFEQLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:11:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A41DA40
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:11:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z7so15848540edm.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DhEMuP67p9l6gHaYEp6fnXGttVPME12T6ktP3AWQge0=;
        b=QNXO7F2FkAsGFQCNld2QcAUPn6alhVgigX1dmDbd3ZX+iuVaRjFFYKE3PoXy+jEf02
         JCwnrg27lTHCMbi9hzQ6/3N6eMHqvmCIi81ChzbJj10KWxjmla2XHf5bN+4wlxf7H9/q
         GCARFpWO8PaL7R256uVWtKXy0LSuU68cEdjmNigxHstq77ClMLVZstnQcdo7ci53pib3
         Ke0GneWLIa4M511qgIiRFOz64sHvhTlw47c0nURg3tnCRwpcKfyF+K+GNTeGNR3VodqT
         FoeBXabKxL2WtDlBgzGLnTd+Z9RRD0N9wWzUn0EhsEr5yoxPV7GtmxuoisKHVsN+dU8J
         eGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DhEMuP67p9l6gHaYEp6fnXGttVPME12T6ktP3AWQge0=;
        b=ITr5x0x5LYgyn39iOova4t44LZFCQzCotfQpw5/22V+pLstsfXTY7Swm+yfSZ/qBem
         grGxlWiTNXPWI+jIV8ffe2a1BUs6QhkhPXxgX4bKQexoWhfcB5V2DEL4LfVDkc4h6tBf
         zXNlTPp6TAyogYwMGzA0f17ifDQAMrSG4wJLuteisvzphnKZ8tHMIgQs3JeWKxqxZwes
         FWJXcupZL+NI6K79dfdRIbxKsdxkqbmGFloNotDm0QLUaIUVrvS+0Xpre1Q34O9MrPDB
         rIxHPmCd49IblOIYd3+1Ijgdwk1OJToqhfKN2xYEFXqSs92Nnfgd93dEmGFlRnX5RsG2
         u8EQ==
X-Gm-Message-State: AOAM5327XscdvUeMV9xsCI48EWTUAI/NO8rduy6mYKte50Tpar4lrL6z
        gKr8eIm1AksBLFab+cMkKK+SHA==
X-Google-Smtp-Source: ABdhPJzf1aRfWMqPIN0vUwQ81NF3efT2xr/E6L8kvihJxDqoLLshcwR5HZpZDT/Uorsouy9/KTw7mg==
X-Received: by 2002:a05:6402:380f:b0:42b:27aa:d4cb with SMTP id es15-20020a056402380f00b0042b27aad4cbmr22449447edb.211.1654445482544;
        Sun, 05 Jun 2022 09:11:22 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a22-20020aa7d916000000b0042dd4f9c464sm6934675edr.84.2022.06.05.09.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 09:11:22 -0700 (PDT)
Message-ID: <12096a2c-98c3-9e77-785f-808cc3e1a0e4@linaro.org>
Date:   Sun, 5 Jun 2022 18:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: backlight: rt4831: Add the new property
 for ocp level selection
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Helge Deller <deller@gmx.de>, cy_huang <cy_huang@richtek.com>,
        lucas_tsai@richtek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
 <1653534995-30794-2-git-send-email-u0084500@gmail.com>
 <1c7ab94c-a736-c629-bd8c-8a974803e2b9@linaro.org>
 <CADiBU39jZ6TdYZoH80m4R-X2_fUXZOvDA4yUd_TQdPzBJLE+JA@mail.gmail.com>
 <076d53d3-6062-686f-8e45-14c5f936bbf6@linaro.org>
 <20220602135604.GA2194286-robh@kernel.org>
 <e3aa9c7e-bf2d-dd55-8b3f-ca51f569771d@linaro.org>
 <CADiBU3-dN0vtQBEqvVLFCUp4-MkhLbQRkOiCet+fO8WfkEW4MQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADiBU3-dN0vtQBEqvVLFCUp4-MkhLbQRkOiCet+fO8WfkEW4MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 17:31, ChiYuan Huang wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 於 2022年6月2日 週四 下午9:58寫道：
>>
>> On 02/06/2022 15:56, Rob Herring wrote:
>>> On Thu, May 26, 2022 at 12:32:12PM +0200, Krzysztof Kozlowski wrote:
>>>> On 26/05/2022 10:13, ChiYuan Huang wrote:
>>>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 於 2022年5月26日 週四 下午4:06寫道：
>>>>>>
>>>>>> On 26/05/2022 05:16, cy_huang wrote:
>>>>>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>>>>>
>>>>>>> Add the new property for ocp level selection.
>>>>>>>
>>>>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>>>>>> ---
>>>>>>>  .../bindings/leds/backlight/richtek,rt4831-backlight.yaml         | 8 ++++++++
>>>>>>>  include/dt-bindings/leds/rt4831-backlight.h                       | 5 +++++
>>>>>>>  2 files changed, 13 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
>>>>>>> index e0ac686..c1c59de 100644
>>>>>>> --- a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
>>>>>>> @@ -47,6 +47,14 @@ properties:
>>>>>>>      minimum: 0
>>>>>>>      maximum: 3
>>>>>>>
>>>>>>> +  richtek,bled-ocp-sel:
>>>>>>
>>>>>> Skip "sel" as it is a shortcut of selection. Name instead:
>>>>>> "richtek,backlight-ocp"
>>>>>>
>>>>> OK, if so, do I need to rename all properties from 'bled' to 'backlight' ?
>>>>> If  only this property is naming as 'backlight'. it may conflict with
>>>>> the others like as "richtek,bled-ovp-sel".
>>>>
>>>> Ah, no, no need.
>>>>
>>>>>>
>>>>>>> +    description: |
>>>>>>> +      Backlight OCP level selection, currently support 0.9A/1.2A/1.5A/1.8A
>>>>>>
>>>>>> Could you explain here what is OCP (unfold the acronym)?
>>>>> Yes. And the full name is 'over current protection'.
>>>>
>>>> Thanks and this leads to second thing - you encode register value
>>>> instead of logical value. This must be a logical value in mA, so
>>>> "richtek,bled-ocp-microamp".
>>>
>>> We already have common properties for setting current of LEDs. We should
>>> use that here I think.
>>
>> It might not be exactly the same. We have "led-max-microamp" which is
>> the maximum allowed current. I guess over-current protection level  is
>> slightly higher (e.g. led-max-microamp + 1). IOW, led-max-microamp is
>> something which still can be set and used by system/hardware. OCP should
>> not.
>>
> Yap, you're right.

So I am right or Rob?

> From the modern backlight IC design, it uses the boost converter architecture.
> This OCP level is to limit the inductor current when the internal MOS
> switch turn on.
> Details can refer to the below wiki link
> https://en.wikipedia.org/wiki/Boost_converter
> 
> And based on it, OVP is used to limit the inductor output voltage.
> Each channel maximum current is based on the IC affordable limit.
> It is more like as what you said 'led-max-microamp'.
> 
> So boost voltage level may depend on the LED VF.
> The different series of LED may cause different boost voltage.
> 
> RT4831's OVP/OCP is not just the protection, more like as the limit.

This suggests Rob is right, so let's use led-max-microamp property?

Best regards,
Krzysztof
