Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30F146224E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhK2UlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhK2UjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:39:15 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF60C08ED6C;
        Mon, 29 Nov 2021 09:13:43 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id k37so46574908lfv.3;
        Mon, 29 Nov 2021 09:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=VTatKi9nLjKf/ouxwhMrze6+WUP0SdgQqfY3/ZOFly0=;
        b=lf2lo7e6Oo6F1oAeqlYLJBN4TBBFyrGcFYIfSly83M+PSNlk7YCljNt6JsKHAzM5x1
         lOjNwPIIy88h0CXdbmCG8jsf8eLRifr4poWmtoNQcJlf4K6udZpen4ELhBp9bxIoHuVQ
         8HquW3qTwIyckbUxFVek0PzeNxD5M/gKgoR23W3WG+0bHVWHKullaQZC6j72AwDnj65W
         SkAuFB49AbNjre9/ZN3HXVsqwvxqV80txNQG44tjQPwtxWMFsnNaHhpGZXX18NUbjp3F
         XObIWnIygWyRSl6OnNGt2eqrAj9yCS/Vyk1knJ5xJAArofjhg8MU5Af+Cxczb6q4PvaG
         kjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=VTatKi9nLjKf/ouxwhMrze6+WUP0SdgQqfY3/ZOFly0=;
        b=j0+FpRFaPoiXjDu43aBYlIMha3SsnB4MXZ07Lb7rqVyLWTa8yzMF+0BmZg3NvvvUQb
         L2rB3sV6l/O/4v2W96hAHEZfUVl0y2hzRgzUfoPtMHao2mqfw+P8rGqEoqqwuaXC9gir
         Z6G3e43AwleoVcih6Q0p0i0yv77HSACBvRTKJZSUsbybqKqaoMV2nmqjjftWWmfcwqOu
         SHms/g5xxhpz3j192LEN0FMapAjY5UajBY9FcUwjdYAESyBfe7p6ziJDrVm5MgqA7req
         AEbKc9PFGFaPcQGsXcrsKFfEv6yNkVlKfor7HK5ZUiMYXiLBXUnugUL10Dcsq5sUV5Us
         xxZQ==
X-Gm-Message-State: AOAM532WuCwz5Jdezo4gZWmn62Dnl0AhnkFzeMCXvNEOx5iVDk/1DEXX
        93uaSKuLQdc8EAZM+AV8FAk=
X-Google-Smtp-Source: ABdhPJza825v6DwnUXQa0o2zoVz4Mcoj+1EcfWGapApxnoNOdyBNHJsWR1/ZuaHOmTRwEnOwV0uODw==
X-Received: by 2002:a05:6512:ace:: with SMTP id n14mr20426920lfu.53.1638206021365;
        Mon, 29 Nov 2021 09:13:41 -0800 (PST)
Received: from [10.0.0.115] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id b13sm1406433lfc.79.2021.11.29.09.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 09:13:40 -0800 (PST)
Message-ID: <4cb46c35-0279-bef2-46dd-d9fb6901688c@gmail.com>
Date:   Mon, 29 Nov 2021 19:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        "Yadav, Pratyush" <p.yadav@ti.com>
References: <20211126050228.6257-1-j-choudhary@ti.com>
 <64426bc9-1160-97c6-4714-4201b8f7a81c@gmail.com>
 <a7bc460f-abf4-1d64-6416-5b50dc15d184@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v3] ASoC: dt-bindings: davinci-mcasp: convert McASP
 bindings to yaml schema
In-Reply-To: <a7bc460f-abf4-1d64-6416-5b50dc15d184@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/11/2021 13:21, Jayesh Choudhary wrote:
> 
> 
> On 29/11/21 12:23 pm, Péter Ujfalusi wrote:
>>
>>
>> On 26/11/2021 07:02, Jayesh Choudhary wrote:
>>> Convert the bindings for McASP controllers for TI SOCs
>>> from txt to YAML schema.
>>
>> Can you CC the sound/soc/ti/ maintainer next time, I have found this
>> patch in my Spam folder...
> 
> Okay. Also, I will add this file in the MAINTAINERS file under the
> heading 'TEXAS INSTRUMENTS ASoC DRIVERS'

OK, thank you. I'm sure I have missed some other binding document...

>>> Adds additional properties 'clocks', 'clock-names', 'power-domains',
>>> '#sound-dai-cells',
>>
>>> 'num-serializer'
>>
>> Which use was removed by 1427e660b49e87cd842dba94158b0fc73030c17e
> 
> The dts file of arm SOCs is not updated and was generating an error in
> dtbs_check. I will remove this property.

Yes, that dts file was added 2 years after the num-serializer got removed...

> 
>>
>>> and 'port'
>>
>> And what this "port" is?
> 
> The mcasp node in the file 'arch/arm/boot/dts/am335x-sl50.dts' has this
> as child node.

Right, it is there if McASP is used via the graph card.

>>> +
>>> +  tdm-slots:
>>
>> description?
> 
> I will add description.
> 
>>
>>> +    maxItems: 1
>>> +
>>> +  serial-dir:
>>> +    description:
>>> +      A list of serializer configuration
>>> +      Entry is indication for serializer pin direction
>>> +      0 - Inactive, 1 - TX, 2 - RX
>>
>> You should mention that _all_ AXR pins should be present in the array,
>> even if they are no in use.
>>
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    minItems: 1
>>> +    maxItems: 16
>>
>> a McASP could have up to 25 AXR pins...
>>
> 
> Will update the description and the maximum.
> 
>>> +    items:
>>> +      minimum: 0
>>> +      maximum: 2
>>> +      default: 0
>>> +
> 
> 
>>> +
>>> +  tx-num-evt:
>>
>> description?
>>
>>> +    maxItems: 1
>>> +
>>> +  rx-num-evt:
>>
>> description?
>>
>>> +    maxItems: 1
>>> +
>>> +  dismod:
>>
>> description?
>>
> 
> For the above three properties, is the description in the txt file
> sufficient?

I would add a bit more detail than just 'FIFO levels'

>>> +
>>> +  sram-size-playback:
>>> +    maxItems: 1
>>
>> should be dropped, not used
>>
>>> +
>>> +  sram-size-capture:
>>> +    maxItems: 1
>>
>> not used, please drop
>>
> 
> Okay.

Thanks

> 
>>> +
>>> +  interrupts:
>>> +    minItems: 1
>>> +    items:
>>> +      - description: TX FIFO interrupt
>>> +      - description: RX FIFO interrupt
>>
>> The 'common' does not deserve a description?
>>
> 
> Will add this.

Great

> 
> 
>>> +  gpio-controller: true
>>> +
>>> +  "#gpio-cells":
>>> +    const: 2
>>> +
>>> +  function-gpios:
>>> +    maxItems: 1
>>
>> This is not McASP property, it was an example on how to use a pin as
>> GPIO from the outside...
>>
> 
> Okay. will remove function-gpios.
> 
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>> +    maxItems: 3
>>> +
>>> +  clock-names:
>>> +    minItems: 1
>>> +    items:
>>> +      - const: fck
>>> +      - const: ahclkx
>>> +      - const: ahclkr
>>
>> I can not find any use in the code for ahclkx/r?
>>
> 
> Some arm SOCs had additional clocks in the DT nodes.

It looks like dra7 family have it. On those the AHCLK x/r have other
source option than from outside (ATL for example).
I'm not certain if they are absolutely needed, but there were something
about the optional clocks...

Tony, can you recall?

>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - reg-names
>>> +  - dmas
>>> +  - dma-names
>>> +  - interrupts
>>> +  - interrupt-names
>>> +  - serial-dir
>>> +  - op-mode
>>> +  - tdm-slots
>>
>> The last three is not needed if the McASP is used only as GPIO.
>> The dmas and interrupts should not be needed in this case, but I think
>> it is not taken care of atm.
>>
>> The tdm-slots is ignored for DIT mode
>>
> 
> These were mentioned in txt file as required.
> In light of this new knowledge, I will remove 'serial-dir', 'op-mode'
> and 'tdm-slots'.

Yes, I know.
The trick is that serial-dir  op-mode and tdm-slots only needed when
audio is used and tdm-slots is only needed in I2S mode.
I would check the dmas and interrupts, but from the hardware pow they
are not needed in GPIO only mode.

-- 
Péter
