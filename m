Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7A453F7B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbiFGH4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiFGH4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:56:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DD2CC140
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:56:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id s12so26275796ejx.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C8YP1cEzC8FEy1cpmzx9rDcPUNRhyGSItme8uhv4fGQ=;
        b=sr+27sd4DqbmnPpwJ/lzVsNAArv8N8yoQmCz4VyfJinf5Klvk7GFZi4XHbBn9jsMX7
         ruSTEGorxKAAZQGsfeRaTAIl3w2EDJcClJ8AKMigakCDi8+/8cBhxn8rNujIi1ppYkHN
         Fl/O+3m8Cze9/fj2jbN7WLX4FLexTon7cKd4PXOFz2+oTPWmRtUcyA8b6uyDn8CO0+dP
         DHF5FnMRgj/0sQxzgWubiqCRVpd3OuMSL0COzLMrT3JXcjTn5CN3QAxWKOru+GszHZQp
         NPe2I4ePQyDKaN4eeHqMNZYyEKDItGf4DZJ9VJDrslHL/QFbAhSS8xbCudnCdLWEW+G4
         Gwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C8YP1cEzC8FEy1cpmzx9rDcPUNRhyGSItme8uhv4fGQ=;
        b=H/imjxRfqiy35c6jblOSvpvnFV5qE3yLli/joQPVpuBpLHuoFzpFjkfG7szrJ5/S5X
         TwzgkLgBBK0+IfdKNfOgfm5Qex9rq25MxtRECWaRyRoZvTMR5l0bqNodgoG0yBZy9NxD
         QzhmXuxgFBZ1vEVdQ35VhyWg+E8iQvgrgXiGW7nVRS+o6IHw7apAO8t8eTqtqXTwVyfN
         GmZ4HAy3x5KRu8wVMMT5GBrbkAf+eChvE2V0j5bL2UPrxw4ITxJFkqtzmRT1z2AA8Rns
         jhnsPeTz8UsFDSyk5lkMlQzPsu2joWsk0Tav8iFvhEU/2B3hz5r0QEOoThD1OpWz7FTu
         9X3g==
X-Gm-Message-State: AOAM532/4aigOO3Gl/NtGWb3wcgrIW1J9ZXW7D3S0yP+uzBaxEqEltAb
        5OoxBS84kVJLnXdD/mXtpDR6wQ==
X-Google-Smtp-Source: ABdhPJyiZAlWo7Vx/LkHmost5qEinMsSgDsnErUy4IHlpBkrUDNIUU3DcFmJZ06jfmN3iGe8eVgfdA==
X-Received: by 2002:a17:907:7f91:b0:6ff:c1a:2e8e with SMTP id qk17-20020a1709077f9100b006ff0c1a2e8emr24305881ejc.70.1654588562088;
        Tue, 07 Jun 2022 00:56:02 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906154200b006f3ef214dd2sm7160834ejd.56.2022.06.07.00.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 00:56:01 -0700 (PDT)
Message-ID: <33ceeaa0-2f1b-8562-a6b8-cfcc9dcb31e4@linaro.org>
Date:   Tue, 7 Jun 2022 09:56:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible
 string for lan966x
Content-Language: en-US
To:     Kavyasree.Kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, UNGLinuxDriver@microchip.com
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
 <20220603121802.30320-3-kavyasree.kotagiri@microchip.com>
 <1764f3ce-608f-e55c-d977-18fb95e4a0fe@linaro.org>
 <CO1PR11MB48656331826CDEA9DFB6A11092A29@CO1PR11MB4865.namprd11.prod.outlook.com>
 <ed469c4d-cbf3-2f54-743b-a22c0c120df1@linaro.org>
 <CO1PR11MB4865CA9098EA7E1C052823D792A59@CO1PR11MB4865.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CO1PR11MB4865CA9098EA7E1C052823D792A59@CO1PR11MB4865.namprd11.prod.outlook.com>
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

On 07/06/2022 09:54, Kavyasree.Kotagiri@microchip.com wrote:
>>>>> LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1
>> in
>>>>> flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
>>>>> can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage
>>>> depends on
>>>>> functions being configured.
>>>>>
>>>>> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>>>>> ---
>>>>>  .../bindings/mfd/atmel,flexcom.yaml           | 21 ++++++++++++++++++-
>>>>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>>>> b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>>>>> index 221bd840b49e..6050482ad8ef 100644
>>>>> --- a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>>>>> @@ -16,7 +16,9 @@ description:
>>>>>
>>>>>  properties:
>>>>>    compatible:
>>>>> -    const: atmel,sama5d2-flexcom
>>>>> +    enum:
>>>>> +      - atmel,sama5d2-flexcom
>>>>> +      - microchip,lan966x-flexcom
>>>>
>>>> Your new v1 is here worse than old v2, where this was just simple
>>>> extension of existing enum. Why did you change it?
>>>>
>>> I introduced new compatible string for lan966x and also I have new DT
>> properties
>>> "microchip,flx-shrd-pins" and "microchip,flx-cs-names".
>>
>> v1 also had the new compatible, hadn't it? The difference is in the enum
>> - before you did not modify this line. Less code in the diff...
>>
> Yes, previous patch series also had new compatible which introduced new mux DT properties in atmel-flexcom.yaml and mux driver.
> As part of review comments from Peter Rosin on driver part, Mux implementation is dropped. Please ignore previous patch series. Now, flexcom chip-select support is done in atme-flexcom.c driver. So, I started new patch series now which introduced new DT properties "microchip,flx-shrd-pins" and "microchip,flx-cs-names" and driver changes only in atmel-flexcom.c driver.

We talk only about the hunk here, not about other properties.

Best regards,
Krzysztof
