Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4830E58883A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiHCHs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiHCHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:48:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33962559B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:48:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t1so25223992lft.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=naQWXtnatP1uIx9793tQXrMdRUdYtFxkHdnpkeiVoxk=;
        b=L/DGiGxJ0daSgKwBdyF3RxzXNufOyCdsVFi6qGXOELIBlS5cJIws0RKxA8JmAWXkro
         xLJ3aMvzHay9C4yhQDJEpRt77XSqkCf5PbUJzQqr9Abxlu6X865XdReOKXbnhikxDG0i
         eeZp9vJOf127Wt6dWmrNZZlo2oFKIIYJQ995eZ1kDR9Y4dKwz0oVXM/6IF4Nt+vhwViz
         Eo1kSuKGGYdjWwB8qATV6MYYAzxlhwaWFQ4Yko72wDkxeQ38GJdrejJ3lZBibflxZOf5
         LFquxzorZrfiIIyPEHFPExDVnaRQFtqkSSnEfmh0Ko2gHq13Dlhd2hpwcbvycnoyP3eS
         +2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=naQWXtnatP1uIx9793tQXrMdRUdYtFxkHdnpkeiVoxk=;
        b=Bymym+c9/+IycTnQZ88HdaO06WCXIrnwrsClIWmlVXYBLuW5wkjZV4Tu+Tex4bmq0Z
         YlwF51lHKxtP1UMyNJ7DaX2LIUKD5+omDdqVQWhkypZe4OC31/iw2y/os1uvBJvra8Ca
         4WXk/fz2+QXbEKFe/UY8cjdxdO8LJIlMpNhJZM/fOKotSDK7AKERJJMjIgxEFJhKotFZ
         RGFm3V3sedg7Lr/ZR+zNC4YwAA4op/WoFjhzTUsl9g1DXC1181xSCE2QoSUGXvJXYHdO
         gAcTQ3r/Vh77/3a5LYRu2cofJ/yOgX+RJX+djZbrePvO1UMAsYL2PeVhAb71XV4mBp1E
         CCpQ==
X-Gm-Message-State: AJIora+IdJQnlCU7q4BnebICeidtYM8Y12eOvCgMJznYbmXK70/k1jVC
        g6DVflm/BXzSAGOQVnfmxzDhaw==
X-Google-Smtp-Source: AGRyM1t/ppcl0v01ORP/WV9e1oXDN1ERgXE1IHJZkeBiD+mqElAfO61Ag9deMVZ1tOqFI7ZVWb7eug==
X-Received: by 2002:a19:e007:0:b0:481:c74:37b7 with SMTP id x7-20020a19e007000000b004810c7437b7mr8607075lfg.439.1659512901288;
        Wed, 03 Aug 2022 00:48:21 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id y17-20020a2e3211000000b0025e4e7c016dsm1026745ljy.16.2022.08.03.00.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 00:48:20 -0700 (PDT)
Message-ID: <dab84439-9d09-c7d1-35ab-ea02d69d40ec@linaro.org>
Date:   Wed, 3 Aug 2022 09:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
Content-Language: en-US
To:     naga sureshkumar <nagasuresh12@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor.dooley@microchip.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-2-nagasuresh.relli@microchip.com>
 <6d36b192-9e63-ec13-5583-22b81c99c18b@linaro.org>
 <Yuki3jpCSJDdXcWA@sirena.org.uk>
 <dc7bca02-5eb3-3b33-8911-a950b630f197@linaro.org>
 <CAH_iE_3xfyPi4B+WopmZdFStQHeTb=31MqLs+aG12R=28yDuVg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAH_iE_3xfyPi4B+WopmZdFStQHeTb=31MqLs+aG12R=28yDuVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2022 08:59, naga sureshkumar wrote:
> Hi Krzysztof,
> 
> On Wed, Aug 3, 2022 at 11:42 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 02/08/2022 15:13, Mark Brown wrote:
>>> On Tue, Aug 02, 2022 at 10:52:25AM +0200, Krzysztof Kozlowski wrote:
>>>> On 01/08/2022 11:42, Naga Sureshkumar Relli wrote:
>>>
>>>>> -    enum:
>>>>> -      - microchip,mpfs-spi
>>>>> -      - microchip,mpfs-qspi
>>>>> +    oneOf:
>>>>> +      - description: Microchip's Polarfire SoC SPI controller.
>>>>> +        const: microchip,mpfs-spi
>>>>> +      - description: Microchip's Polarfire SoC QSPI controller.
>>>
>>>> Useless descriptions - they repeat compatible. Just keep it as enum and
>>>> skip descriptions. What value do they bring?
>>>
>>> Someone not familiar with the full Microchip product line might not be
>>> aware of the expansion of mpfs, it's not blindingly obvious.
>>
>> Then it should be explained in title/description of the binding, not in
>> compatible. This is the usual way of providing some text description,
>> not for each compatible by repeating the compatible text.
> Ok. In the next version I will update the bindings like below
> 
> -title: Microchip MPFS {Q,}SPI Controller Device Tree Bindings
> +title: Microchip FPGA {Q,}SPI Controllers
> +
> +description:
> +  SPI and QSPI controllers on the Microchip PolarFire SoC and they are based
> + on the "soft"  fabric IP cores.
>  oneOf:
>        - items:
> +          - const: microchip,mpfs-qspi
> +          - const: microchip,coreqspi-rtl-v2

This piece should have its own explanation and preferably in its own
commit. As I mentioned before, you change existing compatible so it
should be explained.

Best regards,
Krzysztof
