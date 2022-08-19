Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5017E599C31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349015AbiHSMn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348742AbiHSMnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:43:24 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592FD5F8C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:43:21 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id by6so4398974ljb.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=pKznTXWDR+Kv5wQQVujXep0zxIuY4TU9+ONSWdaXIj0=;
        b=X2S1z8Ms65wvTrKmPx1zZ3BXZ/jEe7vsC1zkUhzletCMhS3LPvh0wLsK/4P3KZzXMB
         NjAAEr2lIP/vb4atBN5tHBFAmNM5awZsEW06f3Qaj2WhXfruiaHRMvKxCzRFqt7oeFmh
         HxaCVBML4Kf1LL6WxE+bSea5/Mfv60uHlhtnqiWWVl3fOQw+fUlzGiUr7UIiJPHCuFod
         5yFGJ6gFOqIspdQYL89Y8PvcOu9Q35LPazGjSaw3ihZZ0taDrkeiWe3/8eAJjE9W8Ch6
         OVWI48njeIbvwNUj5qKAt2ruXfi9dttRjFhBbT7Gv64NxTyO5cCTE8vhmIO2epkZbRyQ
         nXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=pKznTXWDR+Kv5wQQVujXep0zxIuY4TU9+ONSWdaXIj0=;
        b=zPb3J8XXEQD0oINfzlnK4gecb2UOAQ5zK71h4OuxRe7u703N8jsQzTRVD6W5/rLFgB
         /AdOV9ZU890dp/QCG61VZOh2cUxGTiTOnJk7fA8+ctQxgNOn4a2lguPEuqTYDDQ6Hhb6
         FA0wIVGArKXuEKUUQq7EJwtxDfYQFvdDaAQ/4XAYjFwdjN5jF0fTf3sCPKBs2ekHfrRQ
         m25Dfc0JT9cnn0eF0jPqcbS162wnz0fXj2piPgmzqpiePu+B6Bc00hwIZaXmFyuVP+AE
         Q73vUvZEeg9eHTqW52R6VfgCO80MTnpQWbGsEMk7cdmSyNvwsWsHomfE9HlvuzoQjjkI
         SnUQ==
X-Gm-Message-State: ACgBeo1+J9PREMTu/L8yj7/UN7rEVpdGrE76oCet0tc2nDSXXlKw92rG
        /RLe6uSOOX+EfpoWdWc8a6WApw==
X-Google-Smtp-Source: AA6agR52ozPQssGxEMx7KiQ0nCmu0UHipXpj72bnOAWi1YYRjmW1LEVpZTXaQqqkvF5L1ZwhnbVJ6Q==
X-Received: by 2002:a2e:9985:0:b0:25e:c148:dfc4 with SMTP id w5-20020a2e9985000000b0025ec148dfc4mr1958412lji.69.1660912999706;
        Fri, 19 Aug 2022 05:43:19 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048a7d33e0f0sm623640lfo.261.2022.08.19.05.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 05:43:19 -0700 (PDT)
Message-ID: <d2279a7d-bbc3-c772-1f30-251f056341bb@linaro.org>
Date:   Fri, 19 Aug 2022 15:43:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 4/7] dt-bindings: net: dsa: mediatek,mt7530: define
 port binding per compatible
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Sander Vanheule <sander@svanheule.net>,
        =?UTF-8?Q?Ren=c3=a9_van_Dorst?= <opensource@vdorst.com>,
        Daniel Golle <daniel@makrotopia.org>, erkin.bozoglu@xeront.com,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220813154415.349091-1-arinc.unal@arinc9.com>
 <20220813154415.349091-5-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220813154415.349091-5-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
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

On 13/08/2022 18:44, Arınç ÜNAL wrote:
> Define DSA port binding under each compatible device as each device
> requires different values for certain properties.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../bindings/net/dsa/mediatek,mt7530.yaml     | 116 +++++++++++++-----
>  1 file changed, 87 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index cc87f48d4d07..ff51a2f6875f 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -130,35 +130,6 @@ properties:
>        ethsys.
>      maxItems: 1
>  
> -patternProperties:
> -  "^(ethernet-)?ports$":
> -    type: object
> -
> -    patternProperties:
> -      "^(ethernet-)?port@[0-9]+$":
> -        type: object
> -        description: Ethernet switch ports
> -

my comments from v1 apply here

None of the reasons you said force you to define properties in some
allOf:if:then subblock. These force you to constrain the properties in
allOf:if:then, but not define.


> I can split patternProperties to two sections, but I can't directly
> define the reg property like you put above.

Of course you can and original bindings were doing it.

Let me ask specific questions (yes, no):
1. Are ethernet-ports and ethernet-port present in each variant?
2. Is dsa-port.yaml applicable to each variant? (looks like that - three
compatibles, three all:if:then)
3. If reg appearing in each variant?
4. If above is true, if reg is maximum one item in each variant?

Looking at your patch, I think answer is 4x yes, which means you can
define them in one place and constrain in allOf:if:then, just like all
other schemas, because this one is not different.

Best regards,
Krzysztof
