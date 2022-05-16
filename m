Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C997352885C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245100AbiEPPSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiEPPSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:18:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990393BBE1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:18:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gh6so29452891ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uxc1EEZZN9XC0ZN9vHSl5EkxKkFP8gfHegm9oB3GxA8=;
        b=qpZZ8TAszik3sPrA20jwi+fpzDYTA/LNak6uSY1rlEWO9Qt1CO4o8OWr3yyUjcBSnT
         1hsvIj41mxjvlWR/WdIWDGiM4RJWASvys/QUAdp69Z/5Brko8SEGIZ9I05M2ihKi7L0A
         IDiINA7xwRn0YbI9djW+srmOdP31xhwBi3RSiGqyog0yx5lUK3b6zMbjJSEtsx3QqZfp
         PhPoHoYjriPmvprDeiylkcOYgCxnXtT8mU147yvud4+pE9isnA9/ZwijZe7cZxzhnRpK
         Ldhpgs4Z/cgDfYMAEZU9gII4mnVUE0yUHvXXzJCefO3Afc+LW61i0iHkUFdfKExYj/Bm
         FArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uxc1EEZZN9XC0ZN9vHSl5EkxKkFP8gfHegm9oB3GxA8=;
        b=fMZZbI3VcnV96T+PPcQSiRgvrtfGoMqnccO+kbWccf8x88qAcpha4VICJXl1UQZ00w
         UBqkOgBGVRk+KsKAY/o6vWbRtw4kGaT82n+G2YQ7IlR6otTKHb7KoC5wK23IxX/4Fc3T
         kFbJffWMd1b3Ziawr6tUN5A12Zwt19GIZAXKFLo12Qw64lvC2eP0YA/NFEMKiSt7gtzd
         zptMRezcmcQXimoTeFvif2R9PRyFYOe02f1BzfGxmBcnEESO1WFdvewKcSphq28okA0+
         N2voMMbyeWTqcg8uWlcwDCjjqHbxl00VjaxWH7ftFgSFgR0LmiC5GEpEz7CW3uRKDt/X
         e5bA==
X-Gm-Message-State: AOAM532Zv3X91QJBhkoGEuDRJ5ocm6QT25kCUjTB0QlCEmm6VoEyk74C
        X/YwgbZulMTzwwKIRNSCdTlG/g==
X-Google-Smtp-Source: ABdhPJw4qAnLHxMA2xzrQr8zb4moNWR6Cth9S9WbMTdZY6Or4pmF7GQKRSZ4xhw281GADg2352uulg==
X-Received: by 2002:a17:907:7745:b0:6f3:674a:339 with SMTP id kx5-20020a170907774500b006f3674a0339mr15501849ejc.207.1652714325231;
        Mon, 16 May 2022 08:18:45 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h9-20020a50cdc9000000b0042617ba63d5sm5427301edj.95.2022.05.16.08.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:18:44 -0700 (PDT)
Message-ID: <81d94ea8-9d0f-785b-07aa-fe9c9093ad73@linaro.org>
Date:   Mon, 16 May 2022 17:18:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: pruss: Update bindings for K3
 AM62x SoCs
Content-Language: en-US
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220427072703.4898-1-kishon@ti.com>
 <20220427072703.4898-2-kishon@ti.com>
 <53212a3b-d02c-ab5e-6b5c-e19d359c7c2b@linaro.org>
 <dcce6737-5881-a703-67f0-59c5f55f1cd1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dcce6737-5881-a703-67f0-59c5f55f1cd1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 14:33, Kishon Vijay Abraham I wrote:
> Hi Krzysztof,
> 
> On 28/04/22 11:48, Krzysztof Kozlowski wrote:
>> On 27/04/2022 09:27, Kishon Vijay Abraham I wrote:
>>> Update the PRUSS bindings for the PRUSSM instance present in
>>> AM625 SoC.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> index 64461d432004..cf13e5179657 100644
>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> @@ -69,6 +69,7 @@ properties:
>>>        - ti,am654-icssg   # for K3 AM65x SoC family
>>>        - ti,j721e-icssg   # for K3 J721E SoC family
>>>        - ti,am642-icssg   # for K3 AM64x SoC family
>>> +      - ti,am625-pruss   # for K3 AM62x SoC family
>>>  
>>
>> Looks like out of order (although for some reason before it was also
>> misordered...).
> 
> These are really in the chronological order of the introduction of SoCs.
> Isn't that okay to have?

You mean order of release on the market of order of adding files here?
The first is ok, the latter would mean there is no order at all.

It's a nit, so I don't expect to change it. It just increases our
chances for conflicts...


Best regards,
Krzysztof
