Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7FA5ACFB0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiIEKK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbiIEKKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:10:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E602C670
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:10:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p16so12440888lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9iZUJ2C+XzNkKLqBt28HLIylkiN68ZpTZ2fgZQtMBpU=;
        b=g075S5okKrDHmJNtm8Ec66J8SgI+LW/7dkJPUaLVxLUIdCMZ7mkZ0uP6vLvlWxfGY3
         GSUj7p9ZQsjq1Liw8ZLR0G3LGJDB8hgK1ItCJL4z40Ai0Z3RlFfsi2nTw9XDVAPSFQBO
         nx3xh9rJN0Vr1VyajPjDDIfxmKvg4tUSm36bdVQy1dMe9JG4yFh2T87fbnpVKflQ/ROp
         N4auuALgoy4s2xWcRD4eVsqjGRHiYcUlFtKZUcH3XH1fVvFHbHbim2J9xrgn/nAAOCeR
         maPHym/1hVHv/AS1eEu/ipimDkb/yAg/mc8e0vAXc4bRxyQLkbSPnqMlPSijxb0mMPjP
         UfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9iZUJ2C+XzNkKLqBt28HLIylkiN68ZpTZ2fgZQtMBpU=;
        b=edPRfA60H64RIlk2UgWhrKhvf4P+XyV4WOO2iMm3iH/xONEpCBmKGbBwBfWSXp5cDL
         kK1Y0yUtJcru5t8NbLKISVdSDRF/BWKFEe6Chsnm19pbnFChBEYg2Da6kDHvWpRo5MmJ
         Hkc8X1mwZ/TZt3XEA+Ak+UpJFYupM7M+Cg7vfZoMGHZSB0EKEN9dlKya73Y6XvDwIr65
         J3dkVmxorlYREUxpCBl1Q7zZIaUgow0eXjvsE09IJGvrfNUux73XTCXWDTn+6Zyj3tls
         Nm65WNNYJdkfTpjtXVgo7rrood/X3eUi4JrFnGX1n0V9QzqMC9txd66qhepXHnf0PCX9
         ZAfg==
X-Gm-Message-State: ACgBeo2JXm+fyXyia94SDulNtH/5tZCvCWUgP5H0B1faf5OIXeCp6vmu
        lQ4EWlrbEtos07gJvvJ4kYGgkw==
X-Google-Smtp-Source: AA6agR54xygcg8U5xob0simsg/0TJd3c+/Trm5Wr5mH6lOfqkDvRVfkz6Tv/7SEAHfrH+2elmOMrXw==
X-Received: by 2002:a05:6512:12c4:b0:494:8373:5678 with SMTP id p4-20020a05651212c400b0049483735678mr8899913lfg.577.1662372620382;
        Mon, 05 Sep 2022 03:10:20 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b0048b365176d9sm1135613lfq.286.2022.09.05.03.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 03:10:19 -0700 (PDT)
Message-ID: <baa9c80a-bc81-03a9-680f-883a54cb4e63@linaro.org>
Date:   Mon, 5 Sep 2022 12:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Content-Language: en-US
To:     Eugen.Hristev@microchip.com, Sergiu.Moga@microchip.com,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        admin@hifiphile.com, Kavyasree.Kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
 <942accc5-70aa-3bb2-63dd-306a39ee5ea4@linaro.org>
 <d1aad8ea-3852-f36b-366b-7aa67d2dd9d5@microchip.com>
 <ec86420c-a210-facd-ab3a-5baf84a736f3@linaro.org>
 <0aba8906-ed30-786e-cff4-6cb70d6e73c5@linaro.org>
 <f2fdaf34-ad66-9e6d-2f11-34171fb7aaa9@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f2fdaf34-ad66-9e6d-2f11-34171fb7aaa9@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 13:31, Eugen.Hristev@microchip.com wrote:
>>>>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..cf15d73fa1e8
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>>>> One more thing - I think this should be in serial directory, not mfd,
>>>>> even though it includes SPI. MFD is just a Linux naming/wrapper device.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>
>>>> I would rather keep it in this directory, since its corresponding driver
>>>> is also in the mfd directory.
>>>
>>> Sorry, but that's poor argument. Driver subsystems match Linux
>>> convention, not necessarily hardware type/naming. Bindings directories
>>> match hardware. MFD bindings are only for MFD wrapper drivers and this
>>> is a serial interface. Not a MFD. You even do not add MFD devices in the
>>> driver but add *always one* device depending on serial feature you want.
>>> This is not even MFD device but regular platform device with children.
>>>
>>> You put it in SoC, though, because all other SoCs store it there...
>>
>> The last one should be:
>>
>> You could put it in SoC, though, because all other SoCs store it there...
> 
> Hi,
> 
> If it this is only a conversion to yaml, why do you want it moved to 
> another dir ?
> Perhaps if you consider SoC or serial as a better place, it should be 
> done through a different patch.
> 
> Also, disputing whether this is really a MFD or not, is not in the scope 
> of this patch.
> 

Because you are converting - thus renaming - the bindings, so this is
the place to put them in proper place. The conversion to DT Schema comes
pretty often with small fixups, so proper location is one of them.
That's quite common case.

Best regards,
Krzysztof
