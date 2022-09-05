Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B85D5AD72E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiIEQM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiIEQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:12:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0B0550BC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:12:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bt10so13766118lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rrWMFV+N+f8aARUW0ZNrAlxPcv8JN7PD06T7jx57Q7s=;
        b=SS3wEpx17GrNgX9Fc+X/k3B/9tRMakRxRbH8xMVvVDq2ZdruXjZG7LTGx+p+6x1mMu
         jepfNNJGN6O3or1m/v60nbMJcuavuaBqS1W9ZbCI7/Ya5z3pgt0zpvsfZ+Vf0Gm/heYu
         eczsXHy88W6Mg1JHIpbb0P7YNYSyzRYzGs+l0DVwXxSOlLg2rcR5CeqOo6OzBjLvGMqL
         DrJTFyVARk/EwFRMAPsXNAFdKReDopalSto5lm+nfMqaF87QF8hAYfYpMcjonMW2EaP1
         wK9l1oULRf5bFySVuoLUYG40Bgn4zumjoEnRwUzL7guqlm2k3GdQGr1Y8UYGB929y+Qm
         M9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rrWMFV+N+f8aARUW0ZNrAlxPcv8JN7PD06T7jx57Q7s=;
        b=2XuqrAHKZQkfjQqhh2agY7JQPLV2MC9sQ/TCDPNXU+yL9JsPjRDVk++T0tFcFWukVl
         DlLL2qRwLeV9UEptZjqlSc/rAuBu7g4I21vuGFrftHSzl8YFCrxpcdGahux44cf4dPDA
         QVu7FTz1DFT3uJpyr7onuqq3Tdc6YcW04NXRztTzQD+szL4SyYwu9RC/e1rZXh9vOJ7P
         XkUcHjXRvVqhwuoDF7+4Ok2+ObbqL93oWYLbEVjKB5kuFJskoJK2i7StVMO2YEifdG7U
         6YjlHS+O6zNdSeK6zXSDXe6nFRzfngq0bT3g+XjbkSrq/pCCZpG+pEo8ZoToCFoT7Lka
         FEDA==
X-Gm-Message-State: ACgBeo1SGb1Kg7lLpIHtFkaQ7UDowAhnXUJYSOLri880ANTRU5rO4AzD
        fS0r4yk0Ba7e6VRbieNU+vKBKw==
X-Google-Smtp-Source: AA6agR5YbCPHG0VF+WgTYH8U/Qyjr4JX1+miUiqvPBNw4ceg3bXl8ITHJX7z4VES5+HrNXJDFKZYSw==
X-Received: by 2002:ac2:5ccd:0:b0:495:79c7:f2f7 with SMTP id f13-20020ac25ccd000000b0049579c7f2f7mr3651296lfq.647.1662394338923;
        Mon, 05 Sep 2022 09:12:18 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f19-20020ac25333000000b0048a9a756763sm1235025lfh.19.2022.09.05.09.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 09:12:18 -0700 (PDT)
Message-ID: <80abf192-0313-aade-7780-604f4c9c6810@linaro.org>
Date:   Mon, 5 Sep 2022 18:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Content-Language: en-US
To:     Sergiu.Moga@microchip.com, lee@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        admin@hifiphile.com, Kavyasree.Kotagiri@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
 <942accc5-70aa-3bb2-63dd-306a39ee5ea4@linaro.org>
 <d1aad8ea-3852-f36b-366b-7aa67d2dd9d5@microchip.com>
 <YxYI8/bprIV2wd1c@google.com>
 <d6a498e7-838b-addf-bc7f-81e6805806d3@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d6a498e7-838b-addf-bc7f-81e6805806d3@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 17:22, Sergiu.Moga@microchip.com wrote:
> On 05.09.2022 17:37, Lee Jones wrote:
>>
>> On Fri, 19 Aug 2022, Sergiu.Moga@microchip.com wrote:
>>
>>> On 18.08.2022 11:39, Krzysztof Kozlowski wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> On 17/08/2022 10:55, Sergiu Moga wrote:
>>>>> Convert at91 USART DT Binding for Atmel/Microchip SoCs to
>>>>> json-schema format.
>>>>>
>>>>> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
>>>>> ---
>>>>>    .../bindings/mfd/atmel,at91-usart.yaml        | 190 ++++++++++++++++++
>>>>>    .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
>>>>>    2 files changed, 190 insertions(+), 98 deletions(-)
>>>>>    create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>>>>    delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..cf15d73fa1e8
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>>>> One more thing - I think this should be in serial directory, not mfd,
>>>> even though it includes SPI. MFD is just a Linux naming/wrapper device.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> I would rather keep it in this directory, since its corresponding driver
>>> is also in the mfd directory.
>>
>> Looks like a UART driver to me.
>>
>> Which MFD driver does this pertain to?
>>
>> --
>> Lee Jones [李琼斯]
> 
> Hi,
> 
> It's this one: drivers/mfd/at91-usart.c[1]
> 
> 
> [1] 
> https://elixir.bootlin.com/linux/v6.0-rc4/source/drivers/mfd/at91-usart.c

Which is not a "real MFD driver" because it probes exactly one child
(depending on the chosen serial protocol). Aren't MFD supposed to have
more then one child?


Best regards,
Krzysztof
