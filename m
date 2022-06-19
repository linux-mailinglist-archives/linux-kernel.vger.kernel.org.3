Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0BF55099E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 12:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiFSK0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 06:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiFSK0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 06:26:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ADAA182
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 03:26:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e2so485917edv.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LMKugXzUXUVai16DUUHT/I5mEbxAHSqoLaxIXVOrxyM=;
        b=Ypl413ms1X3cg1uTpkvLxPrRHtXYDvFbTbPJh/pW9waclQ2x305G/8XKTfmfZGTg4p
         ZkF1fjXlZrNFqa4E80I99muKcunDkKfdT1MfOlQO9ewFp2B+xQFOv29o4Oqe1I0EQ11g
         KHcGSGRlJWXS+Xr07UR3KWzgMbgWfmavvlTWyYZynsiowfHtEDdY+G37PXqAQnJLo9Dx
         gjsO8CeG20WIliM4devWlCjnUKTtdmKfIu5XoWA43+ePILFMOaVa5bX8UMnqTCrXtsFE
         5eMlI9J0mS9URDqR4Fh07BovNViKsoI0w4JT+h+cQu0hKJM7rR+kPDMWFBioXR9h124D
         PMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LMKugXzUXUVai16DUUHT/I5mEbxAHSqoLaxIXVOrxyM=;
        b=aAsP43ar5yJLHJh8nFHHbbR3Kw/RM798ra/YfxoTQOfDVhF2JGJRdhbUdiNVf2mEtp
         3R+vIm3OOZn3ffF9h28sjshM1PLAfkOJGiSv0Zmd9ANRuIJRc1SO3r/ZPmitaU6S4I1b
         taksgeBGvvtYhkLPknQta1Ayemy614ho+4UzpM4hwkudS1UhPP8JGnCtaaRUNFlAk2MY
         VxHFklU3nATxte/RNYE5VtRztcbJAbAoT40Z6joVIxVP4nDSywEfYv86GY1g/0P9fy4B
         4vCLN8Qm3pg0Xi28VAG4mZyO4wtm6pWq6U618TvSNV3MdC0CXBbQfCJBE1kAmUCwjM8u
         50ZQ==
X-Gm-Message-State: AJIora93oT4o5ZlwtMxmVkkJHNEVrDJqUsRg2NivMTgF6e/Mg41zsj14
        TKlTfHKymxk9BGQImtUop6kQUg==
X-Google-Smtp-Source: AGRyM1vSH5zCEmJVebQFtZIwLmV3YNnw42c3pfk+x5krwDe7OONdisSq0NqxbVOphy65AwV4KaNGVA==
X-Received: by 2002:a05:6402:5408:b0:435:60fa:5017 with SMTP id ev8-20020a056402540800b0043560fa5017mr13936929edb.223.1655634398488;
        Sun, 19 Jun 2022 03:26:38 -0700 (PDT)
Received: from [192.168.0.206] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id la5-20020a170907780500b006f3ef214de7sm4434553ejc.77.2022.06.19.03.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 03:26:38 -0700 (PDT)
Message-ID: <d7b6517d-7339-ea2b-8402-fead8eba25f0@linaro.org>
Date:   Sun, 19 Jun 2022 12:26:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add rtq6056 adc support
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     ChiYuan Huang <u0084500@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
 <1655458375-30478-2-git-send-email-u0084500@gmail.com>
 <7a9d3354-164b-e5e5-936b-95de4c4338f9@linaro.org>
 <CADiBU3_wyFLpoy3PU0a-EbGAKoQ9LZMprH5DWnzwo05-Gwa2=Q@mail.gmail.com>
 <279cf4ef-8b41-5e92-73c3-416730038c56@linaro.org>
 <20220618183440.121365d7@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220618183440.121365d7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2022 19:34, Jonathan Cameron wrote:
> On Sat, 18 Jun 2022 19:00:19 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 18/06/2022 08:50, ChiYuan Huang wrote:
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 於 2022年6月18日 週六 上午9:45寫道：  
>>>>
>>>> On 17/06/2022 02:32, cy_huang wrote:  
>>>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>>>
>>>>> Add the documentation for Richtek RTQ6056.
>>>>>
>>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>>>> ---
>>>>>  .../bindings/iio/adc/richtek,rtq6056-adc.yaml      | 57 ++++++++++++++++++++++
>>>>>  1 file changed, 57 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml
>>>>> new file mode 100644
>>>>> index 00000000..6b4e0e0
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml
>>>>> @@ -0,0 +1,57 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056-adc.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: RTQ6056 Bi-Directional Current and Power Monitor with 16-bit ADC
>>>>> +
>>>>> +maintainers:
>>>>> +  - ChiYuan Huang <cy_huang@richtek.com>
>>>>> +
>>>>> +description: |
>>>>> +  The RTQ6056 is a high accuracy current-sense monitor with I2C and SMBus
>>>>> +  interface, and the device provides full information for system by reading
>>>>> +  out the loading current and power.
>>>>> +
>>>>> +  The device monitors both of the drops across sense resistor and the BUS
>>>>> +  voltage, converts into the current in amperes, and power in watts through
>>>>> +  internal analog-to-digital converter ADC. The programmable calibration,
>>>>> +  adjustable conversion time, and averaging function are also built in for
>>>>> +  more design flexibility.
>>>>> +
>>>>> +  Datasheet is available at
>>>>> +  https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: richtek,rtq6056
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  "#io-channel-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +  richtek,shunt-resistor-uohm:  
>>>>
>>>> Use standard properties, so "-micro-ohms". Drop the unit from
>>>> description and drop the ref.
>>>>  
>>> Use richtek.shunt-resistor-micro-ohms?  
>>
>> Yes.
>>
>>> Or the prefix 'richtek,' can be removed?  
>>
>> No, the vendor prefix must stay.
> 
> It's a standard generic binding used in a bunch of IIO and hwmon
> drivers without vendor prefix.  Mind you I can't find a definition
> in any of the top level binding files.  Probably wants to be in
> adc.yaml for IIO.

Indeed, thanks for correcting me. It should be just
"shunt-resistor-micro-ohms" then.


Best regards,
Krzysztof
