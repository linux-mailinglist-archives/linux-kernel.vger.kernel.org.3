Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9092B53A4A1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350464AbiFAMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbiFAMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:13:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C7E5B8A4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:13:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gi33so3359247ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iEYtWp/LKb36SgGQwS/VUb0SqQ4BTyw6Z9DZqPloy2w=;
        b=KI1YSwJ5NVgkhhxRyYF1WU1VmQ/YirVw2zh8eWHIDNr4jEA+8iWjWpYQ6N/rdawohU
         VNyFR84uUb7KIVgXjKbgTDF1hGx2y6B3gqmKz6gaM8X47kuE1za98vnBcQtMHz5sh8RJ
         9nWotHcO2Vkg9t+RUrTR5eTcvVuou63xhAxiTHmewnHXNmgXKx4gWmAIX5R8iCh2ptBv
         zgkNLX711IO+OXKh9bnkkJ39wclq2wOIfZ7fJm7i1y0F/1BOUhM3tlqW13uQ6tFi+XOA
         FUOCuoY4MvTUz7CXF8zqmihOheV39ZQ6cuXV98lDC1blKVV3zT/5FrvwSfw+hHQ7umZ8
         9zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iEYtWp/LKb36SgGQwS/VUb0SqQ4BTyw6Z9DZqPloy2w=;
        b=zEl2Fk2ws6x9mQYgXsUTQ7/z567+DxsxpzHI0ns5ID8E3MxgkHFV4a6cSmvo4PyJHY
         89bT+X0ndNmh43bXj+zvBRUOCiQ9qpxSP/moSNZcv6gZMmyFvdjaA21O2S7fwatmqGFA
         3E0S+DDiscaZZfFT3R3JI7vQlT9lngDbU8IQR9tRUauXs57gwaGLlKA0gR+8QGUX0S4L
         fFMiQwXT1H5c+XEPa1Cg0cPBs1cC87lZj/oP1rdQFrMre0EPoCDd6DMWgAz81OpV3uv4
         aWSNUDGzzatq4/Am9EUkmLhM6QLkcTYi6Uhi4Gsnf1YMKbjP5CSJGxF4L1jVO27LCiK+
         PQBw==
X-Gm-Message-State: AOAM531VLRWWpkXdc9RwTkGml4uM/Pr5DxzePEL53hRbia6QCbFxCcrt
        Wnluph8zNOb11Ub8puM8RKGMlQ==
X-Google-Smtp-Source: ABdhPJzOeICvQJzeUzWrX839CyQrkzHvsjKHXi5k+dcTQUUPsq9TjITyptkGvqhUagJTJ56hQ2ZOhA==
X-Received: by 2002:a17:907:7ea9:b0:6fe:d412:ec2c with SMTP id qb41-20020a1709077ea900b006fed412ec2cmr43626906ejc.613.1654085632761;
        Wed, 01 Jun 2022 05:13:52 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id iy5-20020a170907818500b006fecb577060sm631323ejc.119.2022.06.01.05.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 05:13:52 -0700 (PDT)
Message-ID: <805ba97f-9e7f-d492-653b-1488f3d0dc0d@linaro.org>
Date:   Wed, 1 Jun 2022 14:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/8] dt-bindings: interconnect: imx8m: Add bindings for
 imx8mp noc
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "djakov@kernel.org" <djakov@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Abel Vesa <abel.vesa@nxp.com>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
 <20220601094156.3388454-2-peng.fan@oss.nxp.com>
 <cf90d9aa-1ba9-9619-35b7-8c2de436fc12@linaro.org>
 <DU0PR04MB9417380EC27688B3DFB9326388DF9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417380EC27688B3DFB9326388DF9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 14:06, Peng Fan wrote:
>> Subject: Re: [PATCH 1/8] dt-bindings: interconnect: imx8m: Add bindings for
>> imx8mp noc
>>
>> On 01/06/2022 11:41, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> i.MX8MP features same NoC/NIC as i.MX8MM/N/Q, and use two compatible
>>> strings.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml     | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
>>> b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
>>> index b8204ed22dd5..0923cd28d6c6 100644
>>> ---
>>> a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
>>> +++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yam
>>> +++ l
>>> @@ -26,16 +26,22 @@ properties:
>>>      oneOf:
>>>        - items:
>>>            - enum:
>>> +              - fsl,imx8mp-nic
>>
>> Please order the entries alphabetically, so 8mp goes after 8mm.
>>
>>>                - fsl,imx8mn-nic
>>>                - fsl,imx8mm-nic
>>>                - fsl,imx8mq-nic
>>>            - const: fsl,imx8m-nic
>>>        - items:
>>>            - enum:
>>> +              - fsl,imx8mp-noc
>>
>> ditto
>>
>>>                - fsl,imx8mn-noc
>>>                - fsl,imx8mm-noc
>>>                - fsl,imx8mq-noc
>>>            - const: fsl,imx8m-noc
>>> +      - items:
>>> +          - const: fsl,imx8mp-noc
>>> +          - const: fsl,imx8m-noc
>>> +          - const: syscon
>>
>> This is a bit confusing - why this is also fallbacked as syscon?
> 
> I thought to give some flexibility for drivers to access the
> address through syscon. But it could be removed, I could
> fix in V2.

Please remove, unless you really need it. No one should poke someone's
else registers in general :)


Best regards,
Krzysztof
