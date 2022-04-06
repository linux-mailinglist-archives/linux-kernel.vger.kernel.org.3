Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEAB4F5E72
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiDFM4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiDFMzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:55:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430AF2F6536
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:57:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n6so2758797ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7oGdqe4edvqr+iYfJInFHVmb7+U6NUbqblozp3XrpQg=;
        b=i+U889ubHp/vqD39N9mGHzSBxDkleyQwz/NKD0dqRtQCXOhQn3Be6msm33/4hP8WDQ
         z//23cjvUb+fkkceiSyT7T08AqIo5FDX3UurpydepsVA13l5Tghgh949AbE1vo/0vpMS
         MunVwbnQlqlray9rykp3K4cZu09MwZYvYgxR7ZLSaXY0RdRxmlrb94cBBclWn8AZLD+I
         GklRqWwbXTQebvLfyShnONpxJdDb4dEZplwAwS55peWNy77EAcMiCpeHmX5qK+U30fnQ
         MkpxHFM8PcP5yg0wFjXJWB4ONKi+TXcIZ6EE3CVbb9yyWs+LFbKmQMKadXfJWkgtGIiH
         2QNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7oGdqe4edvqr+iYfJInFHVmb7+U6NUbqblozp3XrpQg=;
        b=Tu+4Phm6qUaJgsyzOlE1ECRoL1Z+GMkPMPKNU0mPLqMzKh2NPnR7mxQLskSzcjW4Rn
         lQ2DqYaCSWbCCYfVzLcEdrCbYcmamgJjce2/g1gTGwCLOQcDHjr9M8jnvSzDBHy3IqB1
         x/O0r/WSMbiHguVGVWXO4iw+Tul1NSsFoeZEcee5GdMVSfYdSJcNn0oOKsy8wPdpEwe4
         4f8cpioNmIm5LxDnjcSfQ72d8+xSczTZ2GW/DKokAC/KAXqeb5B8UhZ26SyhrkeXGNx9
         30moYG5cWr6ujoe0l8ugo1YGVNvtuLHEIFn3MPmbeadppjOZYe+mLv0GIvTt8WZ7pBgP
         7OAQ==
X-Gm-Message-State: AOAM532BjYx2Wc1bFUXYzxIkr1mF50U5in59G4MV5ap14yBzCI21uL2H
        Usjgt4myv5yO/jTofE1fUQykIA==
X-Google-Smtp-Source: ABdhPJw2YtGOMiUak58GFk63SIktW16kDe4il6YrYPXGz8jzb5j689+r7WfODo7WQ8xkLk7+CqqeKg==
X-Received: by 2002:a17:906:698a:b0:6ce:b983:babf with SMTP id i10-20020a170906698a00b006ceb983babfmr7573228ejr.553.1649235442532;
        Wed, 06 Apr 2022 01:57:22 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906340400b006d077e850b5sm6331152ejb.23.2022.04.06.01.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:57:22 -0700 (PDT)
Message-ID: <750c1f9e-6a53-16d5-390e-f9f81fa23afd@linaro.org>
Date:   Wed, 6 Apr 2022 10:57:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 04/14] dt-bindings: arm: mediatek: document WED binding
 for MT7622
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>, Arnd Bergmann <arnd@arndb.de>
Cc:     Networking <netdev@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220405195755.10817-1-nbd@nbd.name>
 <20220405195755.10817-5-nbd@nbd.name>
 <d0bffa9a-0ea6-0f59-06b2-7eef3c746de1@linaro.org>
 <e3ea7381-87e3-99e1-2277-80835ec42f15@nbd.name>
 <CAK8P3a1A6QYajv_HTw79HjiJ8CN6YPeKXc_X3ZFD83pdOqVTkQ@mail.gmail.com>
 <08883cf4-27b9-30bf-bd27-9391b763417c@nbd.name>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <08883cf4-27b9-30bf-bd27-9391b763417c@nbd.name>
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

On 06/04/2022 10:32, Felix Fietkau wrote:
> On 06.04.22 10:29, Arnd Bergmann wrote:
>> On Wed, Apr 6, 2022 at 10:18 AM Felix Fietkau <nbd@nbd.name>
>> wrote:
>>> On 06.04.22 10:09, Krzysztof Kozlowski wrote:
>>>> On 05/04/2022 21:57, Felix Fietkau wrote:
>>>>> From: Lorenzo Bianconi <lorenzo@kernel.org>
>>>>> 
>>>>> Document the binding for the Wireless Ethernet Dispatch core
>>>>> on the MT7622 SoC, which is used for Ethernet->WLAN
>>>>> offloading Add related info in mediatek-net bindings.
>>>>> 
>>>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org> 
>>>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>>> 
>>>> Thank you for your patch. There is something to
>>>> discuss/improve.
>>>> 
>>>>> --- .../arm/mediatek/mediatek,mt7622-wed.yaml     | 50
>>>>> +++++++++++++++++++ 
>>>>> .../devicetree/bindings/net/mediatek-net.txt  |  2 + 2 files
>>>>> changed, 52 insertions(+) create mode 100644
>>>>> Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml
>>>>
>>>>
>>>>> 
Don't store drivers in arm directory. See:
>>>> https://lore.kernel.org/linux-devicetree/YkJa1oLSEP8R4U6y@robh.at.kernel.org/
>>>>
>>>>
>>>> 
Isn't this a network offload engine? If yes, then probably it should be
>>>> in "net/".
>>> It's not a network offload engine by itself. It's a SoC component
>>> that connects to the offload engine and controls a MTK PCIe WLAN
>>> device, intercepting interrupts and DMA rings in order to be able
>>> to inject packets coming in from the offload engine. Do you think
>>> it still belongs in net, or maybe in soc instead?
>> 
>> I think it belongs into drivers/net/. Presumably this has some kind
>> of user interface to configure which packets are forwarded? I would
>> not want to maintain that in a SoC driver as this clearly needs to
>> communicate with both of the normal network devices in some form.
> The WLAN driver attaches to WED in order to deal with the intercepted
>  DMA rings, but other than that, WED itself has no user
> configuration. Offload is controlled by the PPE code in the ethernet
> driver (which is already upstream), and WED simply provides a
> destination port for PPE, which allows packets to flow to the
> wireless device.

Thanks for clarification. I still wonder about the missing drivers as I
responded to your second bindings:
https://lore.kernel.org/all/20220405195755.10817-1-nbd@nbd.name/T/#m6d108c644f0c05cd12c05e56abe2ef75760c6cef

Both of these compatibles - WED and PCIe - are not actually used. Now
everything is done inside your Ethernet driver which pokes WED and
PCIe-mirror address space via regmap/syscon.

Separate bindings might have sense if WED/PCIe mirror were ever
converted to real drivers.

Best regards,
Krzysztof
