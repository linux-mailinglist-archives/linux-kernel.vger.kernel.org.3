Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8EE5997D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347774AbiHSIrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347755AbiHSIrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:47:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCD6C6FE1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:47:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a9so5240542lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=2BIoy1M8A0rRrH0tn3bSeIeYW/rETi9BBL+JwsRpCCs=;
        b=erMtm3Dq+6NNg/t96Z2Mv0CU3VUE1mOa8n5A6nrGYIfVe5PkNecJOz36mXgiiWmcN9
         8dlaji7sB6hnbn17o2qUOGGOH2zdCPlY+tuO33hVTO3fNxtme43MMm8cedsC5z5AS1NO
         6EWDWOgJbapbowtQK72ZBKM1c+woUNl2VtklMND+Q+pzPxjjM+GBm/ch+tzXCJ2/wxKl
         VJLpTkYPitEbQuLkNiQsYtNXfp1qQCsyuz+wY4zG1ocmFNSSu/kgRA063Mnly6sxoi5q
         BrL6cAJidJBDJdei14nUMrMGjfzGSwt64Hlc0q7A0LCqx6/UERU8IuQfXdPK9wYEPUVQ
         tgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2BIoy1M8A0rRrH0tn3bSeIeYW/rETi9BBL+JwsRpCCs=;
        b=pB5mhZ9SU1aIYYvzStxPzXU5dqUnalpYfcp6q6TQY5C78JhV68gYCZnz6XvSqbiYuM
         EOuxi6yELOXzW5NhNHRGKHcfYA3C2h7t4Id3m/eAUzVXZJkPKlMJGl6Z2Cr8xNYyp34j
         a+AoaslePx148a0jQTHgPwSgX3e0SCO+q310NygF2qGx/vTNC7a3EfOHcv1K7YokdO4h
         UJXYIzwyhfX+Bd79klznGllnbjZBNOek++xTuwYt/iWQ4UgSEG9LKvqPupwalYaeOLj5
         uaijN5OIOeESK90K9ng8JAhY/k7wikXBLjFnHHnF5ETwhSys8LbslLZp7GvMpuDwK5hc
         gBdw==
X-Gm-Message-State: ACgBeo1Un2TLIV+isDLdOtWIAeltnWyVM+6mBqRFAkxmAY25fe+FUVH1
        xOn2qCRBsP0Ih6M7xOe5mBES0w==
X-Google-Smtp-Source: AA6agR6Pc0sEIBMPS2jfk3o6KO1NlURYtLObz6ZX4+MDhFAP6r0djwefsu/vbv0h6nxQXUeREJHtTw==
X-Received: by 2002:a05:6512:3fa2:b0:48a:16df:266f with SMTP id x34-20020a0565123fa200b0048a16df266fmr2075802lfa.414.1660898856143;
        Fri, 19 Aug 2022 01:47:36 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b0048d20e3333csm555053lfr.242.2022.08.19.01.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 01:47:35 -0700 (PDT)
Message-ID: <ec86420c-a210-facd-ab3a-5baf84a736f3@linaro.org>
Date:   Fri, 19 Aug 2022 11:47:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Content-Language: en-US
To:     Sergiu.Moga@microchip.com, lee@kernel.org, robh+dt@kernel.org,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d1aad8ea-3852-f36b-366b-7aa67d2dd9d5@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 11:38, Sergiu.Moga@microchip.com wrote:
> On 18.08.2022 11:39, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 17/08/2022 10:55, Sergiu Moga wrote:
>>> Convert at91 USART DT Binding for Atmel/Microchip SoCs to
>>> json-schema format.
>>>
>>> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
>>> ---
>>>   .../bindings/mfd/atmel,at91-usart.yaml        | 190 ++++++++++++++++++
>>>   .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
>>>   2 files changed, 190 insertions(+), 98 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>> new file mode 100644
>>> index 000000000000..cf15d73fa1e8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>> One more thing - I think this should be in serial directory, not mfd,
>> even though it includes SPI. MFD is just a Linux naming/wrapper device.
>>
>> Best regards,
>> Krzysztof
> 
> I would rather keep it in this directory, since its corresponding driver 
> is also in the mfd directory.

Sorry, but that's poor argument. Driver subsystems match Linux
convention, not necessarily hardware type/naming. Bindings directories
match hardware. MFD bindings are only for MFD wrapper drivers and this
is a serial interface. Not a MFD. You even do not add MFD devices in the
driver but add *always one* device depending on serial feature you want.
This is not even MFD device but regular platform device with children.

You put it in SoC, though, because all other SoCs store it there...

Best regards,
Krzysztof
