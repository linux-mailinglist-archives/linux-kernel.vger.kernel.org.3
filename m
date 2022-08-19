Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E044F599D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349516AbiHSN4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349510AbiHSN4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:56:17 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70F7100951
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:56:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x10so4612028ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7wKbTinwLLhyC/6cSb9XNE1uZn1Os1hcFfqjEzJyPxE=;
        b=k52lhCtLZm/1ReDEzS87+JWzXQ8IGW5O1J2BzGcgq6lPRxjdq8sXJcdUGFOscjGycm
         h7R/PgkjM8d+HMeGzuR//aFOvtd9K4S1ZNFcP1g3MnWgKohVJY9fNPb+Wq+mHmaArZgS
         y+hBFaeaJLSIMrCwhHSx0btBYgRTTSHK52heJVS33/EYMXaxW0rlgmlue5KnjohLvqwT
         LcEuxo3VO4RkpRzwA6eA6PjJ3B0PwWxrbOiSKpdQagIhbllut9DCos+l9D2zPZgnf3PL
         xCa9vite+tpqkI+gfa1T4auJNCAc02QJfo/N/N1jPuiijHFmN0jn1enkdadlgnMj1bKa
         bTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7wKbTinwLLhyC/6cSb9XNE1uZn1Os1hcFfqjEzJyPxE=;
        b=YP08aZTlfbxogMy1K9a5rpswRvA9t4Dgx6WhsR7UkdXIxg7TXPYzMO50EfJ917TMlB
         LwyD3u7jfqL5ZC087wvcpqr09oxvGzU/IWwkNJvt6j+KoLb6B0HerXyJKdQOFFoVGV06
         EBYmPlsXxGNBsx1DmSYqAt7j53vLUknpb49fLJKPjLai5s5k4dVVydcV0jvJIByFlUul
         jdVplV9W1Qizv7i8ARHv8Lkev1TT4CKn6PfR5uK+yJhdS2bLg04HNrmVEjU0kxVGj79G
         wva3oKQTsqZ/PK12HjAH4p479KFmNQ8EPN5QkJlOu87ctdprmQbKUIp8kvi8ALxtHXo+
         3uaQ==
X-Gm-Message-State: ACgBeo3xI3MQQArd3lGtW6Uj9/r2qo7rgH5dcr/B51qvtxHCY8aR7QlJ
        2Qgk22vD464X8tk+ndZZ1vbYI8lvbiMvBE0I
X-Google-Smtp-Source: AA6agR46YW+0l7LgxUwuaGr0IASRdKw2I3+qnYWru5NiSpKYlerSSWgXiXMKZEktADcRTcfxSqmc9w==
X-Received: by 2002:a2e:9346:0:b0:261:8a31:b40c with SMTP id m6-20020a2e9346000000b002618a31b40cmr2087216ljh.267.1660917374078;
        Fri, 19 Aug 2022 06:56:14 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id w16-20020a19c510000000b00491aee1c4a5sm648010lfe.168.2022.08.19.06.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 06:56:13 -0700 (PDT)
Message-ID: <803b9823-3fde-c4fc-8431-79677212684b@linaro.org>
Date:   Fri, 19 Aug 2022 16:56:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 3/4] dt-binding: perf: Add Amlogic DDR PMU
Content-Language: en-US
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220817113423.2088581-1-jiucheng.xu@amlogic.com>
 <20220817113423.2088581-3-jiucheng.xu@amlogic.com>
 <0a10f55c-1e91-de8d-74c1-e2778841b7fc@linaro.org>
 <81452c8a-623c-3668-2411-fd7c39dc4280@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <81452c8a-623c-3668-2411-fd7c39dc4280@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 16:44, Jiucheng Xu wrote:
> 
> On 2022/8/18 16:25, Krzysztof Kozlowski wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 17/08/2022 14:34, Jiucheng Xu wrote:
>>> Add binding documentation for the Amlogic G12 series DDR
>>> performance monitor unit.
>>>
>>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
>> (...)
>>
>>> +
>>> +  interrupts:
>>> +    items:
>>> +      - description: The IRQ of the inside timer timeout.
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    pmu {
>>> +        #address-cells=<2>;
>>> +        #size-cells=<2>;
>>> +
>>> +        pmu@ff638000 {
>>> +
>> No need for blank line.
>>
>>> +            compatible = "amlogic,g12a-ddr-pmu";
>>> +            reg = <0x0 0xff638000 0x0 0x100>,
>>> +                  <0x0 0xff638c00 0x0 0x100>;
>>> +            interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
>>> +        };
>>> +    };
>> With above fixed:
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thanks for your valuable comments and I learn a lot from them.
> 
> One more question, do you mean after modify the above two places
> 
> I could resubmit V6 as the final patch which include your reviewed tag?

Yes.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540


Best regards,
Krzysztof
