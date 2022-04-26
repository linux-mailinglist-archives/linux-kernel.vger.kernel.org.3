Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E051021C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352475AbiDZPra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348609AbiDZPr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:47:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ABF7E588
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:44:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y3so16537508ejo.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UtKJOFY/mUl/Tg+ilRJKWK8Hg/J66eiozbJhAIV6Y60=;
        b=jLV2GfQtaAFXgShKWfnQPBv10gJWj1Wth8eM5zWxrMu7NIoIEYujdRm1v89VNTLfMl
         H9L1nEpyFj8p8lxgMCf8PazYAwkO5g+8yxzMxlgwhqcj6L+pq97npcibig1u3tZUt1yy
         uj75ob0ySR8pbD283jo4IPgNG2CBZdpwiVqK/6btGS2YsZluVkkANgqYOoqDG2T7xhbr
         BPeaun7xyknvKbKhYifZse/wwVTGirS1p8CMTHtp5HmkrAtA8HG0ULHbgZQRj+Pi2/Vh
         BI2M+ECtuhci0G7+pXlYg6dpHIgTpc4HnwsoYbCeYP7rRrgikarfx/IWqHSLpdN7pPn0
         52iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UtKJOFY/mUl/Tg+ilRJKWK8Hg/J66eiozbJhAIV6Y60=;
        b=5KD3HWhycOpcvBnn5DMDG5kh1BGi50eXY5bdWVjK/1hWXG0BvTcSTxPkVH2jI7CE+c
         7FBCcrsV9qGpbPXDNqP6J73rp5ow6HUqGqxR9Q8UmBOFm++L/IaSF+soCEak37WGMjd7
         HgybWlNqkqlESUZY+lzX7EmvvQ23531r4e1g2pyea/kePmQWS+n9vl1U7OR9Z2FqFb8f
         NrZSjMG+fryEtTWKM/joBbVSIX9ned5llXJ2XjqmevGjF84JMLaulIpPBNTSomJO6I3E
         6HUM5X8KYFtRHsdRT4CuNhBJJsKI89YH7fg1Dub9STUyrwSG/SEkF667bo9laUwaCqpW
         hurw==
X-Gm-Message-State: AOAM533huQ5kpyjisl4GzKw6c3cYh9J9nAMzVNha4ZFTws0p/SfoXn0u
        8+kbK7Rw15LZp47otbkbYBbASw==
X-Google-Smtp-Source: ABdhPJwxivapUiK2Wt2L37iMSo4dtf4bon9f4q59LEzx+egpPW0vj9YwaSe4VocYKnrvV0mNkFULUQ==
X-Received: by 2002:a17:906:6a23:b0:6f3:7cf8:d586 with SMTP id qw35-20020a1709066a2300b006f37cf8d586mr14479759ejc.360.1650987855860;
        Tue, 26 Apr 2022 08:44:15 -0700 (PDT)
Received: from [192.168.0.251] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r19-20020a17090638d300b006d6e4fc047bsm5163826ejd.11.2022.04.26.08.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 08:44:15 -0700 (PDT)
Message-ID: <0064f937-1f8d-3d1d-4ea1-bb8d24bd605d@linaro.org>
Date:   Tue, 26 Apr 2022 17:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog
 timer binding
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Rob Herring <robh@kernel.org>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-7-nick.hawkins@hpe.com>
 <YmcbCgjD85lIRMSf@robh.at.kernel.org>
 <PH0PR84MB171845F606BC40AD653BEC8888FB9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b9d68100-c6f3-4f58-fe42-63f4cdf1dc50@linaro.org>
 <PH0PR84MB1718D9B549FB0CC6FDDAA19788FB9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR84MB1718D9B549FB0CC6FDDAA19788FB9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 15:52, Hawkins, Nick wrote:
> Apologies, I did miss the comment about the double spacing around the label and the label not being necessary. I will not make this mistake again. I became focused about the comment of mapping an entire register space which indirectly lead me on to the path which I am now having the gxp-timer have the gxp-wdt as a child. To be specific the feedback I was speaking of above was about the gxp-timer which is here: https://lore.kernel.org/all/704ffa56-4bae-fc33-fddf-3e3dd8be0db9@linaro.org/ That is the children must be defined for a simple-mfd device. 

This was comment for this v5, not for previous patches. In this v5, you
have a child of timer, so it has to be defined in timer schema.

This was not a comment whether a child should exist or should not. It
was made under the assumption that you want to have a child node.

> Hence the plan I have now is to remove the hpe,gxp-wdt.yaml entirely and include it in the hpe,gxp-timer.yaml. I assume that is the correct thing to do?

I would follow here the advice from Rob, so since the blocks are mixed
significantly (same address space), then let's assume it's actually one
device with two functions. In such case Rob pointed out that child node
is not necessary.

The implementation might differ, depending how the features are mixed-up
with each other. It might be one driver having timer and watchdog, or
several drivers (usually bound together with a MFD driver which serves
as parents and binds to the OF node).

Best regards,
Krzysztof
