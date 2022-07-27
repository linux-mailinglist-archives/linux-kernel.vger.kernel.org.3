Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF695823DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiG0KJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiG0KJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:09:14 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75529CAC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:09:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a13so19085851ljr.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uuNq9hfTepHAFE0eywf2hpY8DuWFXCPjA0vLmy+cL2Y=;
        b=hRcrD6P42aCD0B448rCI9bv5kCUIWCcmpojo29vmyxbcMy0+g4ExD9urSz7AQlk+M2
         bNVe7+Fgy1GnWbByGZOQ/Ag/AfwQusPqpUQivmPLeri8o3pvVxTe7EMi01YNxT3qUc4C
         jzhszp6GFbBBcicGwNz8VkugOOhygffJOIRWId3r4a2SYxyc8DaxP//ODNNZb58zg9+y
         jCf/U/2IKfLTet7/jk4/aEaI6fTv3BjbjaV23KxqPXJv6symih2qxwqjpwdwg7vN8piS
         7uDrnw/TRX1qEJR2ZuADJNf+ws8GxVKI4UxvN3vCARHVmUapPl5CNMtsSz8ukq1d1KDm
         zFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uuNq9hfTepHAFE0eywf2hpY8DuWFXCPjA0vLmy+cL2Y=;
        b=ph1tTfU/KU1NFb5hNjqTzV73VRm3hx5ajIuxrkEiY7AeRbCfFKyQf0taA7ERqYoY9B
         1QDSBQydQ6FWgRyPRQI3hkQ/wSnFWJjY4riAIMq+m35nEAln2yVXlWVao0tjJc3e2CdM
         Z0R3QU5DQIr5gWGgZcSOYqgmVFGn0r5vHYyH5CR2skdoApmWDEdnYCdLux0HhRPSDl3H
         QXOipAgNPCCVGP4KSfhPXSfvJzS+PW7BPHMskOcvEXGeKIlem1GNwVg/5pUjdythxHJE
         /bjp/0kEsB4rXbMYox4Lr/S9WmLYVjWER5Ph+E2Ba35qspdH7IaukOKa0dDmZByJ5m0d
         YA1g==
X-Gm-Message-State: AJIora+rK86g70O44OFIZoJRy6UhnSTVJ+RrPJYxrfSxwxaKU6l5SyuX
        IpkwiTi0v7VQ0lmfNzLYusFhRQ==
X-Google-Smtp-Source: AGRyM1suc/PKkW1uyphUiV/vWtNfdbJ3RSHOSpNeADbXVSbYHIolqold/1p4v27Nh3Q/P8gVj9+FVg==
X-Received: by 2002:a2e:9193:0:b0:25e:568:6a8a with SMTP id f19-20020a2e9193000000b0025e05686a8amr5303577ljg.166.1658916551822;
        Wed, 27 Jul 2022 03:09:11 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id e14-20020a2e930e000000b0025e0ca6f6b8sm765782ljh.77.2022.07.27.03.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 03:09:11 -0700 (PDT)
Message-ID: <e31e0c1f-4755-704e-8428-93970877d8f5@linaro.org>
Date:   Wed, 27 Jul 2022 12:09:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org>
 <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
 <e64cc15e-b31e-876d-b3cf-b60d255c495b@linaro.org>
 <CA+V-a8u1VW9xaj2KjySyMuegpisLVENO_6uJOpAFZGbKziYLYw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+V-a8u1VW9xaj2KjySyMuegpisLVENO_6uJOpAFZGbKziYLYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2022 12:06, Lad, Prabhakar wrote:
> Hi Krzysztof,
> 
> On Wed, Jul 27, 2022 at 10:54 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 27/07/2022 11:05, Lad, Prabhakar wrote:
>>> Hi Krzysztof,
>>>
>>> Thank you for the review.
>>>
>>> On Wed, Jul 27, 2022 at 9:54 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 26/07/2022 20:06, Lad Prabhakar wrote:
>>>>> Document Renesas RZ/Five (R9A07G043) SoC and SMARC EVK based on this SoC.
>>>>>
>>>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>>> ---
>>>>>  .../devicetree/bindings/riscv/renesas.yaml    | 49 +++++++++++++++++++
>>>>>  1 file changed, 49 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/riscv/renesas.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/riscv/renesas.yaml b/Documentation/devicetree/bindings/riscv/renesas.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..f72f8aea6a82
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/riscv/renesas.yaml
>>>>> @@ -0,0 +1,49 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/riscv/renesas.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Renesas RZ/Five Platform Device Tree Bindings
>>>>> +
>>>>> +maintainers:
>>>>> +  - Geert Uytterhoeven <geert+renesas@glider.be>
>>>>> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>>> +
>>>>> +# We want to ignore this schema if the board is SMARC EVK based on ARM64 arch
>>>>> +select:
>>>>> +  not:
>>>>> +    properties:
>>>>> +      compatible:
>>>>> +        contains:
>>>>> +          items:
>>>>
>>>> I think you should rather ignore the RiscV SoCs, not specific board.
>>>>
>>> You mean to ignore ARM/64 SoCs?
>>>
>>> Agreed just the below enum, should do the trick.
>>>
>>>             - enum:
>>>                 - renesas,r9a07g043u11
>>>                 - renesas,r9a07g043u12
>>>                 - renesas,r9a07g044c1
>>>                 - renesas,r9a07g044c2
>>>                 - renesas,r9a07g044l1
>>>                 - renesas,r9a07g044l2
>>>                 - renesas,r9a07g054l1
>>>                 - renesas,r9a07g054l2
>>>
>>>
>>>>> +            - const: renesas,smarc-evk
>>>>> +            - enum:
>>>>> +                - renesas,r9a07g043u11
>>>>> +                - renesas,r9a07g043u12
>>>>> +                - renesas,r9a07g044c1
>>>>> +                - renesas,r9a07g044c2
>>>>> +                - renesas,r9a07g044l1
>>>>> +                - renesas,r9a07g044l2
>>>>> +                - renesas,r9a07g054l1
>>>>> +                - renesas,r9a07g054l2
>>>>> +            - enum:
>>>>> +                - renesas,r9a07g043
>>>>> +                - renesas,r9a07g044
>>>>> +                - renesas,r9a07g054
>>>>
>>>> Did you actually test that it works and properly matches?
>>>>
>>> Yes I have run the dtbs_check and dt_binding _check for ARM64 and
>>> RISC-V. Do you see any cases where it can fail?
>>
>>
>> Just remove the renesas,smarc-evk2 from
>> arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts. Do you see the
>> error? Not from this schema. The only error you will see is that no
>> matching schema was found.
>>
> I did run the dtbs_check test as per your suggestion (below is the
> log) and didn't see "no matching schema error"
> 

So you do not see any errors at all. Then it does not work, does it?

Best regards,
Krzysztof
