Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA157CC89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiGUNtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiGUNtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:49:40 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19036313
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:49:38 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j26so1911025lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Df5PaXBQvWi3ElHoTsEdWiLtMQ6HsSl/JnMKyaUxUZw=;
        b=u/jvunMnyd49xDidrkd2IjPWAeumQ8e8y/ZLGpFdZyEHxSJEMo2CR8SUicSbdC74NE
         JMb7LSsarT5VL72kvSyrJo9Nv5G9/KfHABcXTLUO7U6qIMBfWsJa4I91DCLXglTvcafB
         fNp40vmMAN5kmvqf1PzUVuQHws+ep/jtnM/oswkgfBbOXM8pihXM81a9zOatRFYovNkp
         nxkqdts7DyqcEMvNwIk6EtaHnV40krQtd8xHHxqt+HKytqXQsTa1soVCwJXesGyXdmKW
         /p/4P4PvZ/Qc4YH2R0uSC6ECgSR1yStB8saq+ayFfYAKxkBsFySs77mV6/ouRJjO/aSs
         NCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Df5PaXBQvWi3ElHoTsEdWiLtMQ6HsSl/JnMKyaUxUZw=;
        b=b0QUBDfpD8bkkt6Fmu4BlO0lZaA445YKyW86sSmKhuYPqnhDTxMEO/1X5kQikQjWnC
         eJzQOe2nUrnGjMK8UXRePUhCtK5G7YvJkjGH24q8d3iIRaTPKMBf3cXgZk/ybKx9JZdn
         U4UuA9cfsllVwmnIDQxr/f1r2de6H6hAjKb8L8o9koIpRciRdHOHMFZDTOBe9YLekPOy
         mLVvJp5AG1AP3KTHRMBDqi1254/FesaVO7bioQi849OrgMv571G7S2eeQYmIF7dBcL0o
         CE9q4FsI5Tcahi3yX9xTHHnBPPNqZ9uUBndC37tDjf4bbSYIo5dQX2qHWPcUy3V9LTHZ
         Hfyw==
X-Gm-Message-State: AJIora94CD6w5BlWq1OVp7gbAxj7u0MUZGKalptNEk+nlFmHo+zX//Tp
        Wec+ZkL/6Drhxe/tdzYQKFB3Xw==
X-Google-Smtp-Source: AGRyM1thiRH/aj+PE2hEZO3seebses8tiG7Wdmeu6aB+i44xAKChmd5OawfeBgmZpsvVxmmTUcXReg==
X-Received: by 2002:a2e:a591:0:b0:25d:7366:3344 with SMTP id m17-20020a2ea591000000b0025d73663344mr19932544ljp.242.1658411376877;
        Thu, 21 Jul 2022 06:49:36 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id a8-20020a2eb548000000b0025a6e47056csm518302ljn.124.2022.07.21.06.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 06:49:36 -0700 (PDT)
Message-ID: <b0f7dadc-fa40-c192-9c37-c8150c0d6929@linaro.org>
Date:   Thu, 21 Jul 2022 15:49:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 3/7] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
References: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
 <20220719055054.3855979-4-peng.fan@oss.nxp.com>
 <27ab24ec-61c7-cafb-6665-a16c58808649@linaro.org>
 <DU0PR04MB941796A54DC4932E5A58F4B0888F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <9c1735bf-3f29-4bf1-f7cf-f9e211c505ac@linaro.org>
 <DU0PR04MB94172A78F8E9E74FC842F22B88919@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB94172A78F8E9E74FC842F22B88919@DU0PR04MB9417.eurprd04.prod.outlook.com>
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

On 21/07/2022 12:38, Peng Fan wrote:
>> Subject: Re: [PATCH V3 3/7] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
>>
>> On 19/07/2022 11:58, Peng Fan wrote:
>>>>> +        interconnects:
>>>>> +          items:
>>>>> +            - description: G1 decoder interconnect
>>>>> +            - description: G2 decoder interconnect
>>>>> +            - description: VC8000E encoder interconnect
>>>>> +
>>>>> +        interconnect-names:
>>>>> +          items:
>>>>> +            - const: g1
>>>>> +            - const: g2
>>>>> +            - const: vc8000e
>>>>
>>>> Include interconnects+names in list of all properties and disallow
>>>> them for other variants.
>>>
>>> I not understand well about
>>> " Include interconnects+names in list of all properties ", could you
>>> please explain a bit more?
>>>
>>> And there is already an "if" to check whether the compatible contains
>>> " fsl,imx8mp-vpu-blk-ctrl" to make sure the interconnect valid for
>>> i.MX8MP, so it is not valid to other variants.
>>
>> Defining properties in some if: clause is not really readable and
>> maintainable. The properties should be defined in top-level properties:.
> 
> Maybe I should also include i.MX8MM interconnect and make it
> a separate patch, then i.MX8MP/i.MX8MM just use their own
> names just like other properities. In final, as below:
> 
> Tow patch:
>   1. Add interconnect property for i.MX8MM VPU BLK CTRL
>   2. Add i.MX8MP VPU BLK CTRL dt bindings
> 
> In top-level:
> + interconnects:
> +    maxItems: 3
>  
> +   interconnect-names:
> +      maxItems: 3
> 
> For i.MX8MM
> +        interconnects:
> +          items:
> +            - description: G1 decoder interconnect
> +            - description: G2 decoder interconnect
> +            - description: H1 encoder interconnect
> +
> +        interconnect-names:
> +          items:
> +            - const: g1
> +            - const: g2
> +            - const: h1
> 
> For i.MX8MP:
> +        interconnects:
> +          items:
> +            - description: G1 decoder interconnect
> +            - description: G2 decoder interconnect
> +            - description: VC8000E encoder interconnect
> +
> +        interconnect-names:
> +          items:
> +            - const: g1
> +            - const: g2
> +            - const: vc8000e
> 
> How do you think?

I don't understand what is the question here to me. Shall I tell you
what to do or not to do with iMX 8MM? I don't know. I am not a
maintainer of that SoC.


Best regards,
Krzysztof
