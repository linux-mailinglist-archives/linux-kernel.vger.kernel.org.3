Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA74569AA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiGGGmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGGGmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:42:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6F72A256
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:42:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a11so21045613ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hnjLXi2LmIH+UgfU8ixxSLckYEWNRqYn9cqFQwLWQeE=;
        b=toYNMIhjw3zUKrvNpHagoGcH5EtKQz4DGr2meqexVDX6IzpASPVmaA9hb/FPlHmm5c
         bhxOBegO/QSUri9ZpZxGXnCF+Pr3j2by7xFPCDMlixXs3pI0K605Ik5jWv9EZuQ8hmFe
         PRF+C9x3npyTVL/6pVpnQNVI/mYDFFmgHaGcKjsIFd3ta7fp4s9OpyWQ54Cxm9gwfRsH
         txmp4WFaKf37H4dS10OmzLPLHF7YAQqIK0RkFJoHGj4IB4I/VDzJVmweG5lB7TcwOCMB
         nrpr3W8IHE0owATfnb7aOBEuJZ1g99CKYJayxFFo41Mj52TFIixz+dtOJxfI2cP+D8Hu
         BFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hnjLXi2LmIH+UgfU8ixxSLckYEWNRqYn9cqFQwLWQeE=;
        b=ee3aZQUdoAB7sdFGghxa8ny7DurJJHjpy+y/6RP51f/8ZP0AThNsJ3GuqLCY9+h7Dx
         A8P3SH0BOyqucY5PHrquF5gQPiNP4rYTiTRViKNtPC5pLuXP+aqIjyeIlTv8kwLlNIc9
         DQ8TPRTj28qaNNzSlq4yRrwPcCmjsE3XphawqfO9lLysbc8zU9PHC8J8cyepepZ3FC2I
         Ur2+m+lnbH+56jVwmjCyk0aTrOMxyMbMcP0Y+U7CcNyUYI9igUIicDFBwvP5pGNBoHap
         AObFDsafnK/kYU7IcU2y1jRwk5lN3c8aeFpBcwyQNlGpZ7DrqT1vV09B9OOearS3Ur2f
         fGwg==
X-Gm-Message-State: AJIora8I483ALtDlUxuQo0x3NZE6siNEcUesVWy4OnyRNJ1RNiufy0vn
        Yr4XYMVKcjN6rtfFnKkv5xsHmg==
X-Google-Smtp-Source: AGRyM1uDdSjYPsmbKdg3GRGvmgEpINkxNaKizM6XnuV48C+ytoXH4X21JeE7++9G2phIVJaKly/nXA==
X-Received: by 2002:a2e:3a05:0:b0:25d:3be2:afcb with SMTP id h5-20020a2e3a05000000b0025d3be2afcbmr5687106lja.188.1657176137674;
        Wed, 06 Jul 2022 23:42:17 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id v12-20020a2e87cc000000b00258e91823f3sm6654704ljj.31.2022.07.06.23.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 23:42:17 -0700 (PDT)
Message-ID: <1a180643-e688-f577-7313-a59b944f9466@linaro.org>
Date:   Thu, 7 Jul 2022 08:42:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Content-Language: en-US
To:     Kavyasree.Kotagiri@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        UNGLinuxDriver@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220706110619.71729-1-kavyasree.kotagiri@microchip.com>
 <20220706110619.71729-2-kavyasree.kotagiri@microchip.com>
 <fca15370-f977-687a-ff62-22ae43046b58@linaro.org>
 <PH0PR11MB487299A211568CC3614682BC92839@PH0PR11MB4872.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR11MB487299A211568CC3614682BC92839@PH0PR11MB4872.namprd11.prod.outlook.com>
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

On 07/07/2022 07:29, Kavyasree.Kotagiri@microchip.com wrote:
>>> Convert the Atmel flexcom device tree bindings to json schema.
>>>
>>> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>>> ---
>>> v6 -> v7:
>>>  - Change filename to atmel,sama5d2-flexcom.yaml
>>>  - Add #address-cells, #size-cells to flexcom node - Fixed warnings.
>>>
>>> v5 -> v6:
>>>  - Removed spi node from example as suggested by Rob and
>>>    also pattern properties(spi dt-bindings conversion to yaml patch is under
>> review).
>>>    Once that is accepted, I will add back spi example through new patch.
>>>
>>> v4 -> v5:
>>>  - Fixed indentations.
>>>
>>> v3 -> v4:
>>>  - Corrected format of enum used for compatible string.
>>>
>>> v2 -> v3:
>>>  - used enum for compatible string.
>>>  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
>>>  - fixed dtschema errors.
>>>
>>> v1 -> v2:
>>>  - Fix title.
>>>
>>>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 74
>> +++++++++++++++++++
>>>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 ----------------
>>>  2 files changed, 74 insertions(+), 63 deletions(-)
>>>  create mode 100644
>> Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
>> flexcom.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-
>> flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-
>> flexcom.yaml
>>> new file mode 100644
>>> index 000000000000..864f490ffb83
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-
>> flexcom.yaml
>>> @@ -0,0 +1,74 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mfd/atmel,sama5d2-flexcom.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Atmel Flexcom (Flexible Serial Communication Unit)
>>> +
>>> +maintainers:
>>> +  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>>> +
>>> +description:
>>> +  The Atmel Flexcom is just a wrapper which embeds a SPI controller,
>>> +  an I2C controller and an USART. Only one function can be used at a
>>> +  time and is chosen at boot time according to the device tree.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - atmel,sama5d2-flexcom
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  "#address-cells":
>>> +    const: 1
>>> +
>>> +  "#size-cells":
>>> +    const: 1
>>> +
>>> +  ranges:
>>> +    description:
>>> +      One range for the full I/O register region. (including USART,
>>> +      TWI and SPI registers).
>>> +    items:
>>> +      maxItems: 3
>>> +
>>> +  atmel,flexcom-mode:
>>> +    description: |
>>> +      Specifies the flexcom mode as follows:
>>> +      1: USART
>>> +      2: SPI
>>> +      3: I2C.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [1, 2, 3]
>>> +
>>
>> As pointed out by Rob's bot - why do you not allow the protocol-specific
>> children here? spi, serial etc?
>>
> usart/serial, spi and i2c dt-bindings are in .txt format. So, I cannot refer them here. Like I mentioned in v5 -> v6 changes description, spi dt-bindings conversion is under discussion. For now, I am removing child nodes from example. I will add it through new patch once below bindings are accepted:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20220629125804.137099-1-sergiu.moga@microchip.com/

No one talks about example. Your schema does not allow any child nodes
now, which is not correct. You must describe these children - even if
their schema is not ready. In such case just type:object, description
and maybe compatibles.

I don't understand why you cannot refer to them here.

Best regards,
Krzysztof
