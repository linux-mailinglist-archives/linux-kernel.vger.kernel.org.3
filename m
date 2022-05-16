Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4AE528853
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245093AbiEPPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244900AbiEPPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:17:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C783BBC0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:17:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i19so29300252eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3sD24ADSpY+FG8GR80WnIHxbXm2W1DgeNYS3rlutivw=;
        b=fIpuK62/EPP9kXXOVRySMpiDCY9ccMhXfI8OKjbIC1VesbtlSR372VUmRAHtiXYnsM
         khCT6FLTYqi+ZMXlrWpLxTHDThLspaNqcY23nvcrampkw9gCHhWDjF5BpEg7fYfNs9ZL
         RH9v2IKTaxqlXLVKz2xcyuSQdPFaCvni9HbH/lIeX72fOhiRd5eqt7aTrJmkMaEqtgXS
         6lETQrYMhh6nXCksjiwwh6WXFz/H2mspmcMUbKBe524YEjI1NxNhX/g/srlwbBv8v5s+
         O+J4SvKkU2aOxe+SmXbeBipqqdI3pqv5mBSzW3fkHvNkV1yXEZ7q4ifNJsISCSQiJnFC
         29zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3sD24ADSpY+FG8GR80WnIHxbXm2W1DgeNYS3rlutivw=;
        b=ERZLTmaBFZstY6G9o2ttDIbzY0Sz4xCp5exoMO2SCqTfbqHqWmtv6SJOEZKbGJiHC8
         6YU1xgJ+LCXbxOl40ui2+7H3AZlpLkZ8k6XEX16NMqIyNu5w4kppbtjHPXycFTXPTiHi
         67OolKuGn9SsCKQqlMiUnBZuNBgKh7wEs7vN13qeg0W78mgNA+KwFLCGYGKfkPQJlQHq
         O0NDQWSvtd37Kn6KtbbSQ9qNHfmDaE2LV+BZ/O1M4hD/XhF4sY3Z754NptOzEQpxCYIr
         5u/K40PCeiChH4IgCuiBzGny+ILb3P5iRSwxAMAabrx144/loirODuGVieky11aiyY+V
         BeMQ==
X-Gm-Message-State: AOAM530vAHKP2o61Mi4YrPDDXeiGTDM2AehZXA6IactSmOuJq4MLlwDy
        Fq6v42LJGs3Wb9gbFv2f2pyDgbsLOUeZfn2N
X-Google-Smtp-Source: ABdhPJyaD5kEQjyHQ7iOklYUqDPw7XmHfgloDo7ukO8//+fm6SbAxBFYCrvdZ4Jeu/iwlnAzcAODsA==
X-Received: by 2002:a17:907:161f:b0:6f4:378a:c2d8 with SMTP id hb31-20020a170907161f00b006f4378ac2d8mr16336413ejc.289.1652714226443;
        Mon, 16 May 2022 08:17:06 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e10-20020a056402330a00b0042617ba6386sm5264186eda.16.2022.05.16.08.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:17:02 -0700 (PDT)
Message-ID: <6d8fff45-012b-b545-0d38-ec38a42326df@linaro.org>
Date:   Mon, 16 May 2022 17:17:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: pru: Update bindings for K3
 AM62x SoCs
Content-Language: en-US
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Suman Anna <s-anna@ti.com>, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220427083509.14458-1-kishon@ti.com>
 <20220427083509.14458-2-kishon@ti.com>
 <7bc6fb49-ae7e-d270-b2a4-a14a1d933d61@linaro.org>
 <de237f2c-6630-2f63-e1da-915ab55a1a7c@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <de237f2c-6630-2f63-e1da-915ab55a1a7c@ti.com>
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

On 16/05/2022 14:35, Kishon Vijay Abraham I wrote:
> Hi Krzysztof,
> 
> On 28/04/22 11:48, Krzysztof Kozlowski wrote:
>> On 27/04/2022 10:35, Kishon Vijay Abraham I wrote:
>>> Update the PRU remoteproc bindings for the PRU cores on AM62x SoCs.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>>> index d7c3a78e37e6..e351550b012c 100644
>>> --- a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>>> @@ -47,6 +47,7 @@ properties:
>>>        - ti,j721e-pru    # for PRUs in K3 J721E SoC family
>>>        - ti,j721e-rtu    # for RTUs in K3 J721E SoC family
>>>        - ti,j721e-tx-pru # for Tx_PRUs in K3 J721E SoC family
>>> +      - ti,am625-pru    # for PRUs in K3 AM62x SoC family
>>
>> Looks like out of order.
> 
> yes, this is out of sync with the existing format binding. I'll send a
> patch fixing it.

I meant, you introduce it out-of-order. So this patch should be modified
and new compatible added in some better place.


Best regards,
Krzysztof
