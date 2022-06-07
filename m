Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522C053F6D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbiFGHFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiFGHFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:05:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880BCD31AF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:05:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o10so21690320edi.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 00:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BQmziczRlu4giJiB7sNu/ZlEzEr9Mm6i5Ea2AKg1doc=;
        b=RGKDXTEzT+sIu2kJCj6V4RryzKlQrpqgkkWGV2UfTFsqJLnH4OYHPbs7juZ/LGfkb7
         NAoolvK+4wJSbbv1pRpEuRu9NQX8m1yQwHbNHaMh3nycf8ToPKLAAedRKIOB6INDjcnd
         0/SSlg7k4K+buKbabYwrPTrHIyQ1o8xMEQMWUik9nCsLZ1U4iI/xWL2HEG5s8CZpO2Ks
         tNJe4qQOiKQVKDM+gEuqEt4g2+tqfVkbNB0NVaqxioTmjLPasdHZAd2fjGgwzgGFoHPT
         XuLTWgFav9m67PdWE1e/F9Rr2M2QjVfS/G0mSngSkr3ipFBmZBHRr/OVyb6w24igYAvC
         KQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BQmziczRlu4giJiB7sNu/ZlEzEr9Mm6i5Ea2AKg1doc=;
        b=Jdhj2I+JW1WpvIdfpuPgHPBzNeqiiJhy05DX9w6Wm7w7Nx5xO4x1XuuY1LvsAYhiXs
         VqXPhhNWi8ZG0BW3jeUDFOL30+tFkEiPHXUPARJFqlunpoitlMhEVOJEbXH+H6Wftaav
         lNQe7X398Sshn3jiBf+DgXHa5EHzwk3AD9ZwlI4ZOz/IZ15PJ053O56h/eCGWnTdhTYH
         kk3K5hJrLL2cmBpoXh9GQDcGP9aBFgy/fdrjk/fMIIhIvg+2pazC9QWpWOU2h4oTwYlb
         SoxR+r1NmLe6LgRZcHWuVcMb4ZK8fwrcq8r0P6jxno3X9eQFC0AIPReeGxXu4l2LbTId
         jtAw==
X-Gm-Message-State: AOAM531SNw6Ic+2gkHghX3EKna3HBEV1vpVFdXFjz9hB+5CmHXUJUqz/
        BN0iFpqa1nie8yMikiyp+ZSs4w==
X-Google-Smtp-Source: ABdhPJyTgM2tnhmubkgkYsjgL5jB1r5EwXYL9sIzsbiOUGgOZTdIAAjPXL6NW+g53GNT2TnbSLFG2Q==
X-Received: by 2002:a05:6402:4411:b0:42b:a773:4800 with SMTP id y17-20020a056402441100b0042ba7734800mr32124908eda.37.1654585538993;
        Tue, 07 Jun 2022 00:05:38 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067f0100b006feba31171bsm7371213ejr.11.2022.06.07.00.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 00:05:38 -0700 (PDT)
Message-ID: <ed469c4d-cbf3-2f54-743b-a22c0c120df1@linaro.org>
Date:   Tue, 7 Jun 2022 09:05:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible
 string for lan966x
Content-Language: en-US
To:     Kavyasree.Kotagiri@microchip.com, robh+dt@kernel.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, UNGLinuxDriver@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
 <20220603121802.30320-3-kavyasree.kotagiri@microchip.com>
 <1764f3ce-608f-e55c-d977-18fb95e4a0fe@linaro.org>
 <CO1PR11MB48656331826CDEA9DFB6A11092A29@CO1PR11MB4865.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CO1PR11MB48656331826CDEA9DFB6A11092A29@CO1PR11MB4865.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2022 15:28, Kavyasree.Kotagiri@microchip.com wrote:
>>> LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1 in
>>> flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
>>> can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage
>> depends on
>>> functions being configured.
>>>
>>> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>>> ---
>>>  .../bindings/mfd/atmel,flexcom.yaml           | 21 ++++++++++++++++++-
>>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>> b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>>> index 221bd840b49e..6050482ad8ef 100644
>>> --- a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>>> @@ -16,7 +16,9 @@ description:
>>>
>>>  properties:
>>>    compatible:
>>> -    const: atmel,sama5d2-flexcom
>>> +    enum:
>>> +      - atmel,sama5d2-flexcom
>>> +      - microchip,lan966x-flexcom
>>
>> Your new v1 is here worse than old v2, where this was just simple
>> extension of existing enum. Why did you change it?
>>
> I introduced new compatible string for lan966x and also I have new DT properties 
> "microchip,flx-shrd-pins" and "microchip,flx-cs-names".

v1 also had the new compatible, hadn't it? The difference is in the enum
- before you did not modify this line. Less code in the diff...


Best regards,
Krzysztof
