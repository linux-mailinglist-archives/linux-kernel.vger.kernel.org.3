Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D302953900D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343950AbiEaLsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243849AbiEaLss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:48:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF60980AE
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:48:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n10so26106193ejk.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7bhfywGiVfr9SKmJyu/pt4AMdz2eCKoqLhGa9Sh6I0M=;
        b=gSo7aWDWhBewdtRYI6AhSZGPymEo/Hi7nqlGWSdSvP2WjCmWEIQ3dxM8zVn7wsiwBJ
         f+utlV9IOq45T06qm0yXgSdPV6+0jHV7GxpoedmB2ryz5kWVoatw9I1bcvyhKFBLbA6N
         Me7wv18JM2w/Dk7Q7sGIv4N9/DlnraPh0z4RFgtr9vdWsP/KlHpCQTaPyRtOdlPJJiHb
         w+trMybFM2hrW6X5QUXniCFfJ8rld+V4gwBX7f/TGdkfXKvGnFSuvBAjV3qp4q5qeHYJ
         4gNDfkijE5fRVqIKGGbrCICCmFtsrY537+Ra28E5TbZeITlrWordgRlbyIGzk6K3KP6q
         MSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7bhfywGiVfr9SKmJyu/pt4AMdz2eCKoqLhGa9Sh6I0M=;
        b=qL3sDtgj+p0Yl93nnWKQpaW7WSIxJ++qR7qDKAPkZwDIY3dzN8dBLkUw3BOJSoOa6s
         Mn35tjo+ksmDiT1/owwDbMVIyDM5DhjJ9ymnDtZv7u23jjOUPzMGqlOUys1yhmGW8b/I
         EH/TuEyLToYcS07S67Is2vYmzEXPlC+MCLrsiXMemunbG7ndRxdeKeaIvJbTp4j8rsox
         jN+59+o7A5ZEQG5zw5LI8mXMZJuNzTxOYahSw/KmEKiVTsL8jpE7/pEPHl222dKR+Bpq
         YL8mjBvP94r1e8SFfv1F67bnHr3gTLFyaWoJnCQDNS2/1jlOICnLUZxd7sNlzqBdSbxq
         2Prw==
X-Gm-Message-State: AOAM531ulX9jwlmSbJR7MZ5NEXGsxf/X2XVJdZbC9lBmPRiIzBulzhjc
        NOY/lAP3WCaItQzgxtCEcQ6NLg==
X-Google-Smtp-Source: ABdhPJwcNLd9LnCiYZOXV8MwmtT3ra4raRUTYvS0GEN/xsJdOBcdPNqdR+hvE0rsqf7imJzUMUb6HQ==
X-Received: by 2002:a17:907:2d06:b0:6fe:af0f:2fab with SMTP id gs6-20020a1709072d0600b006feaf0f2fabmr45791538ejc.324.1653997725953;
        Tue, 31 May 2022 04:48:45 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906844600b006fee13caaeasm4878148ejy.190.2022.05.31.04.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 04:48:45 -0700 (PDT)
Message-ID: <a47f5d18-9ecc-a679-b407-799e4a15c6cf@linaro.org>
Date:   Tue, 31 May 2022 13:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: net: Add ICSSG Ethernet Driver
 bindings
Content-Language: en-US
To:     Puranjay Mohan <p-mohan@ti.com>, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com,
        krzysztof.kozlowski+dt@linaro.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, nm@ti.com, ssantosh@kernel.org,
        s-anna@ti.com, linux-arm-kernel@lists.infradead.org,
        rogerq@kernel.org, grygorii.strashko@ti.com, vigneshr@ti.com,
        kishon@ti.com, robh+dt@kernel.org, afd@ti.com, andrew@lunn.ch
References: <20220531095108.21757-1-p-mohan@ti.com>
 <20220531095108.21757-2-p-mohan@ti.com>
 <4ccba38a-ccde-83cd-195b-77db7a64477c@linaro.org>
 <faff79c9-7e1e-a69b-f314-6c00dedf1722@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <faff79c9-7e1e-a69b-f314-6c00dedf1722@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 13:27, Puranjay Mohan wrote:
>>> +examples:
>>> +  - |
>>> +
>>> +    /* Example k3-am654 base board SR2.0, dual-emac */
>>> +    pruss2_eth: pruss2_eth {
>>> +            compatible = "ti,am654-icssg-prueth";
>>
>> Again missed Rob's comment.
> 
> One of Rob's comment was to make the indentation as 4 which I have done.

I clearly do not see indentation of 4, but there is 8 instead.

Let's count:
+    pruss2_eth: pruss2_eth {
+            compatible = "ti,am654-icssg-prueth";
     12345678^

It's 8...

> 
> The second comment was about 'ti,prus'.
> 
> So, ti,prus , firmware-name, and ti,pruss-gp-mux-sel are a part of
> remoteproc/ti,pru-consumer.yaml which I have included with
> 
> allOf:
>   - $ref: /schemas/remoteproc/ti,pru-consumer.yaml#
> 
> So, I thought it is not required to add them again.
> 
> I will add it in next version, if that is how it should be done.
I was referring to the indentation.

Krzysztof
