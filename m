Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9594058EF94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiHJPqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiHJPqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:46:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB4E21251
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:46:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w15so16539717ljw.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=DCCjTYZ0qN8vBfPF1lwOb8EOTQj5fWe2+onwYOWjKsw=;
        b=BNTZtwqIPvOw5SsHSMFNsnlLhZ49JLS1j+DZDiuYlnDZ4zNxuI5qux+fn/wm783Joc
         m6fdIrPnJBco0EhE1TvkXC2uVOudAz3Qz/+T3W1v+Yp8bZusjPHFYuApNfGqg6O3qmc0
         WkON1bYYV/3nx+l+jMkK1p+md86rty447/XrPh0CTuY+w4B9rhsQrMTykBrdYVrGUbx7
         1UBt4hs/6oyTNMhruBx6y8EOsRVrRz3HCjg30qUOe9nD2fQcL/FRyIOZ6TBMTFTIFlXS
         vu2cBYpoly76o4eS85rLv0rQZ/eLprt9bxMplRMq+m/6klWJzinblrjV7uaOH0SvHamZ
         ANsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DCCjTYZ0qN8vBfPF1lwOb8EOTQj5fWe2+onwYOWjKsw=;
        b=YncUrUms3F+58Vy9LMQXketZptA0/z/dCxuO7g7LoDNi3dpIm9E0U2OPtT3cbhtpDA
         GpLQJ7f7fIlEcY3QZjBs7CSlKP1Ks5m9XUqnBeeSeC/vzq3l/5CtQvVU41yLeSuAuoKr
         9ehm3b/VZPSIzcwt1+SMwXOz+BxPiA/EbVom5st54pLgS8gUVFLLpxUZzdyXFdqgc3sn
         Vo3cuVcjfgLbbmbqhmvv2rush5nlHm8QLGVAGhSwKQbD+tGmG+s8oKPfdiWY4pCUXf5x
         SZMhaqygSHviSANxtJzmDja0JD3ISYPdfBT1qVMDAxZFrWcJ/U6qM5lnnW08DEkJpcNl
         tPTA==
X-Gm-Message-State: ACgBeo2uU+drNy5iuwetY+3tAzkvkZndVxLPNAvt17jj2/FDnbw1mQAT
        roaw31QVGz0Om3E33CIxC2SDsA==
X-Google-Smtp-Source: AA6agR5sH0ECkekUtJa3azyuIaHtiF8N4pVi6n1YrHGKr9bBBmKnyPTJAXXs3TI9F7mXBtYTGiz2rA==
X-Received: by 2002:a2e:9e17:0:b0:25d:8897:2a77 with SMTP id e23-20020a2e9e17000000b0025d88972a77mr8720646ljk.441.1660146362059;
        Wed, 10 Aug 2022 08:46:02 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b0048af6242892sm388217lfe.14.2022.08.10.08.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 08:46:01 -0700 (PDT)
Message-ID: <40ca4f73-aed5-3e2a-7fb6-cd3a2cb74cb9@linaro.org>
Date:   Wed, 10 Aug 2022 18:45:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [EXT] Re: [PATCH v3 1/3] dt-bindings: gpio: Add imx scu gpio
 driver bindings
Content-Language: en-US
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
References: <20220810133005.74653-1-shenwei.wang@nxp.com>
 <20220810133005.74653-2-shenwei.wang@nxp.com>
 <ec6fd9eb-f46d-afa9-b08b-15e202b3a624@linaro.org>
 <AM9PR04MB827495CB596427BD86A1522B89659@AM9PR04MB8274.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM9PR04MB827495CB596427BD86A1522B89659@AM9PR04MB8274.eurprd04.prod.outlook.com>
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

On 10/08/2022 18:23, Shenwei Wang wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, August 10, 2022 9:46 AM
>> To: Shenwei Wang <shenwei.wang@nxp.com>; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; linus.walleij@linaro.org; brgl@bgdev.pl;
>> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>
>> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> gpio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev
>> Subject: [EXT] Re: [PATCH v3 1/3] dt-bindings: gpio: Add imx scu gpio driver
>> bindings
>>
>> Caution: EXT Email
>>
>> On 10/08/2022 16:30, Shenwei Wang wrote:
>>> Add binding document for the imx scu gpio driver.
>>>
>>> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
>>> ---
>>>  .../bindings/gpio/fsl,imx-sc-gpio.yaml        | 40 +++++++++++++++++++
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - fsl,imx8qxp-sc-gpio
>>> +      - fsl,imx-scu-gpio
>>
>>
>> This is too generic compatible and it even conflicts with the above...
>> Your driver binds to both without driver data which is even more confusing.
>> Make the compatible specific for one, given SoC.
>>
> 
> Oh, that's my bad. It is a typo. The generic compatible should be "fsl,imx-sc-gpio".  
> So far there is no driver data required for both imx8qxp and imx8dxl, but it might be
> required sometimes later in case the scu firmware is customized for a specified use case.
> That's why I put the generic one here.

That's not a proper reason to add generic one. Either all
implementations are compatible or not. If you are unsure, this should be
assumed as not and just use specific compatible. If you are 100% sure,
then use fallback, not two compatibles, and properly justify it.

Best regards,
Krzysztof
