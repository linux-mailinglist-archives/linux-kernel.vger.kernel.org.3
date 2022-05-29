Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF75537036
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 09:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiE2H42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 03:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiE2H4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 03:56:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD58F6B01A
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 00:56:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id rs12so15576732ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9Fjad3LX2aqxciPw2yV6zusBnHTW7flMH7X7AKKAAN8=;
        b=vCaGBnbnghKnd5Rf/AmhufBmSAT4HtZxG9WjzXW6O+xpmm1O0a8YF7jYgVpCqlXM06
         deCg4hDfdjR1XgeVfLYDLNfFhXzZBxJV/MilI6YoO5er/Y1nbHDRJqqGgXx5aPVOeUV0
         k9NCz1zZYdS0aaV0TsxR/4y4F7EG2vBUOrgeAgjG7gO7FE42ymMQh3KmCT3+H5WEY18K
         w1Kp8FoOjEtb4Fa7LGuQWjCEmZjQKVrPlcn1m955KooaIip+cyKNMlaSHamwgSmyiSyH
         8Y8IWK/vrfsqwnzHWHeWz7xKd3nSXinPGoSOrbxf9Cp6kX+eT1ZhZymO15ASd+cNbnra
         r4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Fjad3LX2aqxciPw2yV6zusBnHTW7flMH7X7AKKAAN8=;
        b=ceCk3ZLmU+61d2tvZSBzrcIIUbVQBJS0C85MRDoM1hPpt8h3DcG8tb5r9p+bMi3WrO
         5+Lj+H7HwXISOJ0N/8koyZ5Nqisf4VcA5CtVdEZggPhG/jI0nrE3MzDtRUwL61fliSLE
         CBFjjxQ6FkiTH9Uo5zbtTfpLhTpHn92CzPM+a/7Vsznu751dZikH6F8CJstimi2xgc0T
         P0ujjK72ixwWaTxo442O+2pWF4Kb3LrAjVA5iNnTk3Oixi3ZT7RMHgF0HTgKrvof3TNu
         N/DUQ31+jMWPWHiK1zUVWcgEGY1jx4yOmT392ou6l5xDY7MrNbh/bL8P+U3Kwc3mjp8k
         Xgeg==
X-Gm-Message-State: AOAM531xX9+/wqXkUVedKrgIG6MwzAz7QCajGtdDxj7QMjWFBgwt4c1V
        fQgX5skhc9JYyCVCVgxN48xrWA==
X-Google-Smtp-Source: ABdhPJyflOjbgX4GOExtfXwyBcjXcLFyIx/pSjp1Ue/1JoaXzZYJFhChA7jnWgudb+UDsk3Nl1ZQnw==
X-Received: by 2002:a17:907:2d29:b0:6fe:c413:d9a4 with SMTP id gs41-20020a1709072d2900b006fec413d9a4mr32366509ejc.694.1653810979449;
        Sun, 29 May 2022 00:56:19 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z1-20020a1709060ac100b006f3ef214de1sm2930593ejf.71.2022.05.29.00.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 00:56:18 -0700 (PDT)
Message-ID: <3c3e7995-ebb4-f57b-eb9f-834a0d55b5ea@linaro.org>
Date:   Sun, 29 May 2022 09:56:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
 <20220523113029.842753-2-peng.fan@oss.nxp.com>
 <c2882212-aa1e-4614-c982-43e6c793b34a@linaro.org>
 <DU0PR04MB9417F22B607C95BDAB84C01488D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <f42f4b45-f8cb-8855-8814-5dfaaf446d4a@linaro.org>
 <DU0PR04MB941718AEF4D3DF64F3E551B888D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <5bcbf7d3-daa8-6f00-6743-3d0328a82980@linaro.org>
 <DU0PR04MB9417CD64522CF6D1B395D66588D89@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417CD64522CF6D1B395D66588D89@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2022 03:47, Peng Fan wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 2022年5月26日 20:08
>> To: Peng Fan <peng.fan@nxp.com>; Peng Fan (OSS) <peng.fan@oss.nxp.com>;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; sboyd@kernel.org;
>> mturquette@baylibre.com; shawnguo@kernel.org; s.hauer@pengutronix.de
>> Cc: Aisheng Dong <aisheng.dong@nxp.com>; l.stach@pengutronix.de;
>> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
>> <linux-imx@nxp.com>; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
>>
>> On 24/05/2022 14:07, Peng Fan wrote:
>>>> Subject: Re: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93
>>>> SRC
>>>>
>>>> On 24/05/2022 12:37, Peng Fan wrote:
>>>>>> Subject: Re: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93
>>>>>> SRC
>>>>>>
>>>>>> On 23/05/2022 13:30, Peng Fan (OSS) wrote:
>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>
>>>>>>> Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
>>>>>>> resets and power gating for mixes.
>>>>>>>
>>>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>>>> ---
>>>>>>>  .../bindings/soc/imx/fsl,imx93-src.yaml       | 88
>>>>>> +++++++++++++++++++
>>>>>>>  include/dt-bindings/power/imx93-power.h       | 11 +++
>>>>>>>  2 files changed, 99 insertions(+)  create mode 100644
>>>>>>> Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>>>>>>
>>>>>> File should be in respective subsystem, so probably power/reset?
>>>>>
>>>>> ok, will put under power.
>>>>>
>>>>>>
>>>>>>>  create mode 100644 include/dt-bindings/power/imx93-power.h
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>>>>>>> b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..d45c1458b9c1
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>>>>>>> @@ -0,0 +1,88 @@
>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
>>>>>>> +1.2
>>>>>>> +---
>>>>>>> +$id:
>>>>>>> +> > +title: NXP i.MX9 System Reset Controller
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - Peng Fan <peng.fan@nxp.com>
>>>>>>> +
>>>>>>> +description: |
>>>>>>> +  The System Reset Controller (SRC) is responsible for the
>>>>>>> +generation of
>>>>>>> +  all the system reset signals and boot argument latching.
>>>>>>> +
>>>>>>> +  Its main functions are as follows,
>>>>>>> +  - Deals with all global system reset sources from other modules,
>>>>>>> +    and generates global system reset.
>>>>>>> +  - Responsible for power gating of MIXs (Slices) and their memory
>>>>>>> +    low power control.
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    items:
>>>>>>> +      - const: fsl,imx93-src
>>>>>>> +      - const: syscon
>>>>>>> +
>>>>>>> +  reg:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  slice:
>>>>>>
>>>>>> Why do you need this subnode, instead of listing domains here?
>>>>>
>>>>> I follow
>>>>> Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
>>>>>
>>>>> There are several slices in SRC, just like there are many pgcs in gpcv2.
>>>>
>>>> Wait, but you have only one slice and you do no allow more of them.
>>>
>>> Slice is just a group node that could include many child nodes, such
>>> as slice {
>>>   mediamix {
>>>   };
>>>   mlmix {
>>>   };
>>> }
>>>
>>> The same
>>>> as for gpcv2 - there is only one pgc. What's the point of that node?
>>>
>>> There are many pgcs, pgc is just a group node there, See
>>> arch/arm64/boot/dts/freescale/imx8mp.dtsi.
>>
>> So this does not explain my question at all. Why do you need "slice" (or
>> pgc) node? You have only one slice in this device, so this is some indirect layer
>> without meaning...
> 
> There is not only one slice, there are many slices. I use a slice node to group
> all the slices, as below:
> src: system-controller@xxx {
>   xxxxx
>   slice {
>      media: slice@0 {
>      }
>      ml: slice@1 {
>      }
>      ddr: slice@2 {
>      }
>   }
>   xxxxx
> }
> 
> With a slice node there, it will be also be easy for specific driver to know
> specific node.

I understand that, you repeat and repeat the same description of what
you are doing, but that still does not explain my first question - why
do you need superficial slice property containing all the slices?


Best regards,
Krzysztof
