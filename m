Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E8E566FF1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiGENxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiGENw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:52:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB37724BC4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:29:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f39so20571420lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 06:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nm39JYdQM+q8N5iGyMJZ3ZEAI23zDoboAxiMAO40uUM=;
        b=udGUtSgkajAnkhEyqk7ar7DfDYjlb4YWY9RyPC4WJL1ggtFfPId+Q4QPaVWWN8GyA7
         X5vF9eoyUBgK2TCl6BpcW2dmuY/WB833gaJ+qc2Am6yq3WcFf2s9xKlfGmZDzEHPEkpt
         HK2EiYg1e/knqI51+CkSOkpmd2pg8K0oHE8mUjkhoyNln3kwi9YTJidxXCCZgfhMpY7q
         Py0LV7ZX4Tg49G15GwD0Q9w8+8E9kgynu8O3uJvU1qL/4/d87dA52bMSbAtk5d5A1H4k
         n4b5fdtCwW6HLSJ+xBNEfccCMMeDC2OLt+UiVDWXp+iUXUtgjqY53ZRDjEMJllIyxHU1
         t50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nm39JYdQM+q8N5iGyMJZ3ZEAI23zDoboAxiMAO40uUM=;
        b=f+3wWNWfPxJMkgQxr16DlJ7IOS1o0e38XejCOT8kFQPTXrVqrwXW90ee+km886B7W3
         J4yqRzVin3Ia2gl1xvAYfjn1DlSrN6V/ic2ACDPCQ8tCORsyFyy8vrc9PwRXPjUxp8Ub
         PiPb4Bh7BTE1lSUKOrmpi/t/7yNSlQm+ISQ0bzZg0p/xSDEdHMzS9cKOIUB1DGQqe0Um
         tE2aedwCQE10AFKXs2taH8W3bx99EjQDTwa6wKYm8qpV1/5RoNfYKzZ21YU/l7Qqq+9V
         Kbr5/a9dN+kVjoY6bChviPDovCQJIkgyHDl8S/MLG7gfpRNcZNAyOmv4dqhiTpUr8Yaq
         HqMQ==
X-Gm-Message-State: AJIora/qLaaCSWNC7qKMyGylTikJwrNk3dvQaMX7rTAWAeCx5lwWvVBw
        jjoloREC/MOa5yyPVjVwVppGfQ==
X-Google-Smtp-Source: AGRyM1sFPLaAdklVt4AOZzb5+W6MkZnClfUpNahuDGeZX17BWf4bYDslbDazHFxrWGPTkQhHAXb1Zw==
X-Received: by 2002:a05:6512:3f12:b0:47f:51de:d067 with SMTP id y18-20020a0565123f1200b0047f51ded067mr22027281lfa.146.1657027753981;
        Tue, 05 Jul 2022 06:29:13 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b0047f933622c8sm5710456lfc.163.2022.07.05.06.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 06:29:13 -0700 (PDT)
Message-ID: <f33ad190-f5c7-d9fa-088b-5538ab1f4d59@linaro.org>
Date:   Tue, 5 Jul 2022 15:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Content-Language: en-US
To:     Han Xu <han.xu@nxp.com>, Bough Chen <haibo.chen@nxp.com>,
        "ashish.kumar@nxp.com" <ashish.kumar@nxp.com>,
        "yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "singh.kuldeep87k@gmail.com" <singh.kuldeep87k@gmail.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "zhengxunli@mxic.com.tw" <zhengxunli@mxic.com.tw>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
 <1657012303-6464-7-git-send-email-haibo.chen@nxp.com>
 <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
 <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <59d360ef-5374-c7a7-2995-854ab3715b25@linaro.org>
 <DU2PR04MB87747C9A8F18D8300461D6B197819@DU2PR04MB8774.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU2PR04MB87747C9A8F18D8300461D6B197819@DU2PR04MB8774.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 15:19, Han Xu wrote:
>>>>> +  nxp,fspi-dll-slvdly:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description: |
>>>>> +      Specify the DLL slave line delay value.
>>>>
>>>> What are the units?
>>>
>>> Do you mean here need to give more detail explain about this properity?
>>>
>>> How about change like this?
>>>    Specify the DLL slave line delay value. The delay target for slave delay line is:
>> ((nxp,fspi-dll-slvdly+1) * 1/32 * clock cycle of reference clock (serial root clock).
>>
>> This would be good.
>>
>>> The range of this value is 0~16.
>>
>> This needs to go to schema instead as "maximum: 16".
>>
>> But still the question is - what are the units used in this "delay"? ms? us?
> 
> HI Krzysztof,
> 
> According to the formula, the range should be 0~15, 16 should do nothing or no delay.

Sure, just add some constraint.

> 
> The unit should be clock phase. In other words, the delay can be in range of 1/32~1/2 clock cycle.

So we probably misunderstood each other... looking at the driver it also
explains the confusing. You encoded here register value which is pretty
often wrong approach.

This should be instead meaningful value for the user of the bindings, so
usually using one of property units:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

I think you could use here clock cycles or clock phase, but then it has
to be obvious it is that unit.

Best regards,
Krzysztof
