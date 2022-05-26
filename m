Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6B2534ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbiEZMIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiEZMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:08:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD01966AD5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:08:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gh17so2636985ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=djaXZvKnQ48OkK/XXFXcCAtGydBecmNA8ztZBz8O8C0=;
        b=B7bKYNL3NKxnfWA7VWZz4UmFeTe3x68RQORyEnkm/BdZCx1XebjX31Yk8CZDkah/g0
         P+U8liuUMu7jPILg21Z/KX5VeWh6PP/XPz3p/CWY8ljnS05J3jUBZxGPmyFDWwlCSbCa
         b4I39CLOBG+KfGHNrWVlML2KZJU6MCgtk5r7P3zylVJJm2LrVC++uHBDugBB2ZHPDJYr
         AecB7iWy/c7y8wKrhSm2pUm4xIdUt3hy/mAFbdHs0Zr3WOFCix2OFMqNIMsPF9DP4qrw
         XUn+DHwVanhrLQMoUAqIkeFrWjRcdYf/Bs4+slPsV27akWBdHW9uMfllZ4QqjBb6u0/K
         h9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=djaXZvKnQ48OkK/XXFXcCAtGydBecmNA8ztZBz8O8C0=;
        b=FIOZIB4NZKYAtoQ1M4cz5iPlMaIexQjU85Vz/r3TBBfUUSI4bSp/j8KmhwmtY9f0JS
         8ykKzoyeJeH8xxBMceitxkTjQatgBenEjJ4gSz5hiWIPG999VGvtr724vCPFT+OHU88F
         iZawciXEUA9ZI+JGXcs4sJAg+hy12RP/6EdIIJcxFA0usPgh3IifubXxWMtNlbN2TgW1
         xs4rbIoal33jAGyPQ+gkNbWAp+CfD/KaIhFrBlV5qZywN+PxjgoFCuY8pBXYXi3ymJgu
         qV/2oBRGQ+6zRTZwGnsrItzHPprOWfXxJCZ2ayK6NxHDgpZjykTz68yNlb52JxaiS8HU
         gGdQ==
X-Gm-Message-State: AOAM531+ZmhYutowXHHJ+siyNG9BKny20ihuSrY2+C4n9acwB1Q3VYL7
        9uKzqk7yytvWmgyepfLQWDPjhw==
X-Google-Smtp-Source: ABdhPJzBiozFQoOEfgdUuTji2WDG3/g4GQcDomYSSDDDagDRvXyQOsy/n250JZCuXQ+xqdY0jps9og==
X-Received: by 2002:a17:907:8a03:b0:6fe:c10d:4bf8 with SMTP id sc3-20020a1709078a0300b006fec10d4bf8mr23014549ejc.308.1653566894204;
        Thu, 26 May 2022 05:08:14 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s16-20020a056402521000b0042bd6630a14sm745106edd.87.2022.05.26.05.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 05:08:13 -0700 (PDT)
Message-ID: <5bcbf7d3-daa8-6f00-6743-3d0328a82980@linaro.org>
Date:   Thu, 26 May 2022 14:08:12 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB941718AEF4D3DF64F3E551B888D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2022 14:07, Peng Fan wrote:
>> Subject: Re: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
>>
>> On 24/05/2022 12:37, Peng Fan wrote:
>>>> Subject: Re: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93
>>>> SRC
>>>>
>>>> On 23/05/2022 13:30, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
>>>>> resets and power gating for mixes.
>>>>>
>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>> ---
>>>>>  .../bindings/soc/imx/fsl,imx93-src.yaml       | 88
>>>> +++++++++++++++++++
>>>>>  include/dt-bindings/power/imx93-power.h       | 11 +++
>>>>>  2 files changed, 99 insertions(+)
>>>>>  create mode 100644
>>>>> Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>>>>
>>>> File should be in respective subsystem, so probably power/reset?
>>>
>>> ok, will put under power.
>>>
>>>>
>>>>>  create mode 100644 include/dt-bindings/power/imx93-power.h
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>>>>> b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..d45c1458b9c1
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>>>>> @@ -0,0 +1,88 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>>>> +---
>>>>> +$id:
>>>>> +> > +title: NXP i.MX9 System Reset Controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - Peng Fan <peng.fan@nxp.com>
>>>>> +
>>>>> +description: |
>>>>> +  The System Reset Controller (SRC) is responsible for the
>>>>> +generation of
>>>>> +  all the system reset signals and boot argument latching.
>>>>> +
>>>>> +  Its main functions are as follows,
>>>>> +  - Deals with all global system reset sources from other modules,
>>>>> +    and generates global system reset.
>>>>> +  - Responsible for power gating of MIXs (Slices) and their memory
>>>>> +    low power control.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - const: fsl,imx93-src
>>>>> +      - const: syscon
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  slice:
>>>>
>>>> Why do you need this subnode, instead of listing domains here?
>>>
>>> I follow
>>> Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
>>>
>>> There are several slices in SRC, just like there are many pgcs in gpcv2.
>>
>> Wait, but you have only one slice and you do no allow more of them. 
> 
> Slice is just a group node that could include many child nodes,
> such as 
> slice {
>   mediamix {
>   };
>   mlmix {
>   };
> }
> 
> The same
>> as for gpcv2 - there is only one pgc. What's the point of that node?
> 
> There are many pgcs, pgc is just a group node there,
> See arch/arm64/boot/dts/freescale/imx8mp.dtsi.

So this does not explain my question at all. Why do you need "slice" (or
pgc) node? You have only one slice in this device, so this is some
indirect layer without meaning...


Best regards,
Krzysztof
