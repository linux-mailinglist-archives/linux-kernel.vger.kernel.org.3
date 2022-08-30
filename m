Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269315A68DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiH3Qz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiH3Qzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:55:52 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E17D6FA39
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:55:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q16so12010600ljp.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Wtbpa/TU/UVvG6l5cM7I57cwKv6TjGE2IRy/n2NlvH8=;
        b=cMRjqV0y4Hw5Gevy9PhVk8bcNnSQ2heXx1mf3hGi/9WUfYrYbbUNC6+x2l0fFIF5bl
         gjJF9k/4icTUHR/na8HOT3AcLhZcnszsdCAn9CDmzo4jV8mitV7k0SCrgFigcGCOfqnf
         hxFG2UvZ8mtG5qerP9EYWBRi03Sj2BqEFfTBlLlyZ+xt6Dyut4HJTZwWoETV12ezZ21q
         pTMWJ8vpPnf0C21NX98FPj+3YG/LVwNecX1OWFd7vjYmFKmRLTXAeaI2FCJXpNyL9VDQ
         YM1+Q9hXiApWt/QSwLbkFuJMKVOHLBqV4Btnc+KIuPpxG0/a+uhpTfv4aHAaHOs78bSz
         K28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Wtbpa/TU/UVvG6l5cM7I57cwKv6TjGE2IRy/n2NlvH8=;
        b=JdrMt7ONweNp76yWAF+X5eujfWaLtGtIZycLD/Zfs6hQGGoym7+8U4qZ3MDkLurOR5
         jAhutP8cztgot6qgjBM6ukOd80h6qr9XVLy645eCvtokG5Rd0u+u8lcFvveO6XOFuX96
         ciepsOTbIBAxN0KV4lKTwP7ibLu5039u0cdH8XUR1xjSVTrA35DPdjHAW41j32MZFaB3
         sKkEvB//mJ3jWUCcPWjArYHYDc7xnT7w2TcdeZeGSRhVI45nAKRfCUNtnNbfkjKb5nFG
         /Kipa+3xMnSwdX3kH/2Rdfc/+M30mwbE1u9l9BD7ODZxwjzG2ydHr76XEs5SxUcIXf43
         Yo6A==
X-Gm-Message-State: ACgBeo2kBwGaBSHtNcEjBuPDWuGiIqWtO35DnKWh9HMtBusKT68HhWVk
        RGfPYHpTAvGjCqmvdjI/LwrPOQ==
X-Google-Smtp-Source: AA6agR7yTClqQKYpNWFYkL+HxX6EKhzfUXFgL84ffTm/hRU1N31ME2ALvGOeJml2kv4XcFnI7BxQeQ==
X-Received: by 2002:a2e:6e09:0:b0:261:be09:6339 with SMTP id j9-20020a2e6e09000000b00261be096339mr6847202ljc.15.1661878548935;
        Tue, 30 Aug 2022 09:55:48 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id u4-20020a2eb804000000b00265ec8ce420sm743371ljo.122.2022.08.30.09.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 09:55:48 -0700 (PDT)
Message-ID: <1065bc99-d73a-9d19-7f09-26cd862fe0c7@linaro.org>
Date:   Tue, 30 Aug 2022 19:55:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/9] dt-bindings: riscv: microchip: document the aries
 m100pfsevp
Content-Language: en-US
To:     Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Daire.McNamara@microchip.com,
        Shravan.Chippa@microchip.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Cyril.Jean@microchip.com,
        Lewis.Hanly@microchip.com, Praveen.Kumar@microchip.com,
        wg@aries-embedded.de, Hugh.Breslin@microchip.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220830101803.1456180-1-conor.dooley@microchip.com>
 <20220830101803.1456180-3-conor.dooley@microchip.com>
 <a3a8e2ba-a6bd-6e66-fd04-e3a46661a34d@linaro.org>
 <27b8aa9e-9173-b40e-8f9c-a53fa5ba36c8@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <27b8aa9e-9173-b40e-8f9c-a53fa5ba36c8@microchip.com>
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

On 30/08/2022 18:25, Conor.Dooley@microchip.com wrote:
> On 30/08/2022 15:37, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 30/08/2022 13:17, Conor Dooley wrote:
>>> Add compatibles for both configurations of the Aries Embedded
>>> M100PFSEVP SOM + EVK platform.
>>>
>>> Link: https://www.aries-embedded.com/polarfire-soc-fpga-microsemi-m100pfs-som-mpfs025t-pcie-serdes
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>>  Documentation/devicetree/bindings/riscv/microchip.yaml | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
>>> index 485981fbfb4b..04ebd48caaa7 100644
>>> --- a/Documentation/devicetree/bindings/riscv/microchip.yaml
>>> +++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
>>> @@ -27,9 +27,12 @@ properties:
>>>
>>>        - items:
>>>            - enum:
>>> +              - aries,m100pfsevp-emmc
>>> +              - aries,m100pfsevp-sdcard
>>
>> Usually sd card is pluggable, so what is the actual difference here? For
>> example this one:
>> https://shop.aries-embedded.de/evaluation-kit/m/m100pfsevp/445/m100pfsevp-250baab
>> has eMMC and SD card...
> 
> Yeah, both are there but it is muxed by the bootloader using a GPIO. For
> icicle this is done by a mux in the FPGA fabric instead. T

Ah, this is still just one MMC controller - either as eMMC or as SD-card?

> w dts were
> needed so that the gpio-hog could be set correctly. Out of curiosity, I can
> have the same compatible in multiple devicetrees right? In that case, it
> would just be "aries,m100pfsevp" here and I could put that in both?
> Would make things easier..

Depends, but I would say for this case rather not. The compatible should
identify the board. If the boards are different, one compatible should
not identify both of them. Imagine U-Boot (or something else) trying to
match the DTS.

Best regards,
Krzysztof
