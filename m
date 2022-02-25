Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C0D4C4662
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbiBYNbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiBYNbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:31:06 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7722028AF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:30:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r10so4562493wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lA2TP6CXnlLRSiUK4WuPdeporQ2L4M6GD5lx0NO6PQU=;
        b=jfcbeqL8MF74iesJD4f9WkENFN6gHWlm5NRnNSy21oLv68q42M+RM/g03RLJjftCrY
         1MnsGFGR1/702EbAVX4qSUm6vWKPZsA9jrzGxZ2sKXX2is/EeWroS9K7/nNqTzWFbuGt
         5NNE/EubRjt4a1OBZmHQBrqYx/nnuubo8pJsvQJ6LWmBkgskqKPFIrDALXkXeA13f/e3
         fKWU6p1OFJUFqTNr/ogZCTXcVCSSokEBTKmjeSTjg07p1weFw1gRhHyAcobWNzcLyuvD
         GxfBLnzh7Y6Vw7+3NN6zpyc425TGczN4SyXmOsuhFg0utykQ7UctTb/v0LKcWE1v7o7N
         JBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lA2TP6CXnlLRSiUK4WuPdeporQ2L4M6GD5lx0NO6PQU=;
        b=lqoZxZDyUbsfZv0kP3FhpN39a9u13TgtHQrHRN7xur+Et11aJR6/dsH6NTVW3j1Hd0
         OX6JH8KnNwQko1Kt6txU8emrkEuZgHcWXek2aqAg7NwyRH96d3XyzXaq/AA1MiY0bx86
         Pw1Db6SlIdIy4qdr6c2HOWbK8hr4FvAwrkliDkZ1J2bT56tD9eo1O0MK1o2xgY03pZEn
         w35WUBfctZW5UDNoH7i2g53TPr0eg4uuCOYxpP90tdDm/hRVWTytBmUc/1HZe+IDZPsY
         ITfFns6/qguW8s8Ra5KMLiPCLYIDMVicAepcvg2wIfBD9KgVy73KWAtjc6E3jhBTIwFm
         ulnQ==
X-Gm-Message-State: AOAM533p+CjoZ3kNZsHOn/e1+6qE+36SnGNvnr8Rk6niKqOs4kCrK2qH
        FQUDZHFtbo02yu/ip1W3xTC+Xw==
X-Google-Smtp-Source: ABdhPJwT0WUHtuYGjF9O8jhr71xo+SAK8uWisAaVd6Ax6WpsUVRXWcgZytTdKjc+kPLjyT4akwwsXA==
X-Received: by 2002:adf:914f:0:b0:1ed:bb92:d0cc with SMTP id j73-20020adf914f000000b001edbb92d0ccmr6209493wrj.297.1645795832576;
        Fri, 25 Feb 2022 05:30:32 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id g7-20020a5d5407000000b001e2628b6490sm2365250wrv.17.2022.02.25.05.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:30:32 -0800 (PST)
Message-ID: <888120c8-f45c-ce4a-56e7-7b68c2014a68@linaro.org>
Date:   Fri, 25 Feb 2022 13:30:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 1/3] dt-bindings: nvmem: make "reg" property optional
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220218070729.3256-1-zajec5@gmail.com>
 <20220218070729.3256-2-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220218070729.3256-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/02/2022 07:07, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Most NVMEM providers have cells at hardcoded addresses however there are
> some exceptions. Some devices store cells layout in internal structs
> using custom formats.
> 
> It's important to allow NVMEM consumers to still reference such NVMEM
> cells. Making "reg" optional allows defining NVMEM cells by their names
> only and using them with phandles.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Rob Herring <robh@kernel.org>


Applied thanks,

--srini
> ---
>   Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index 43ed7e32e5ac..3bb349c634cb 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -60,9 +60,6 @@ patternProperties:
>               description:
>                 Size in bit within the address range specified by reg.
>   
> -    required:
> -      - reg
> -
>   additionalProperties: true
>   
>   examples:
