Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA144E4E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiCWIit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiCWIil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:38:41 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A99B13D71;
        Wed, 23 Mar 2022 01:37:12 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id dr20so1331918ejc.6;
        Wed, 23 Mar 2022 01:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=2uwWKangGrfoNqiPlNGeHQBRLV7j3l1qJ3zQHU/H6fU=;
        b=GQ1L73waSRYfPH5ts+D9PciPM/VMlW00UjnQsAN9e4aZS/OBUtp3e03akDCjDM7fL6
         dwz36aH0NzX7OZ0CECHoRkCR2uxNh3TYnm1VSvyBR+OVjxeoh+Q2XLPGxT7NJrHv/Dpy
         QsKWn/4wOnZq/NdFZvwFSe5fwIOX2YiDqe3b0n2GJ92x7Pm0eJJTSVtPhZJL7KSh95eI
         bohTpQHNlPlVuRuthLHneZRdLVcXAGoo4r0zhE457PGtr0AvhU0GBAA8melmHLmqBy5U
         7i8Nr7srGasyCv5EIzXdvgw5gjHBu+/GlFY4LzGD2PZb+iE6w7jsuhs+nnBHfj9Yatfz
         e4IA==
X-Gm-Message-State: AOAM533i8Wgw1xHhi9nh/TTGS093NxbLW9g0owKWS59M5xrha5FvyTr5
        jgRlgoZgAqUOspUTjxKU4SUU1KN89oAQhA==
X-Google-Smtp-Source: ABdhPJx8Z6gP0ujGPYONx0mp8t8f7WVWrxoGqsdueiAH/ANAeGjjooorJgxwu+9tMzipbAWKORJ4DQ==
X-Received: by 2002:a17:906:c148:b0:6e0:2196:9251 with SMTP id dp8-20020a170906c14800b006e021969251mr11945441ejc.180.1648024630977;
        Wed, 23 Mar 2022 01:37:10 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id go40-20020a1709070da800b006dfc3945312sm6458473ejc.202.2022.03.23.01.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 01:37:10 -0700 (PDT)
Message-ID: <6dbeda18-a11c-609d-7a8f-bf2e6f27aea7@kernel.org>
Date:   Wed, 23 Mar 2022 09:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v11 2/9] dt-bindings: reset: Add bindings for SP7021 reset
 driver
Content-Language: en-US
To:     =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
References: <cover.1647928315.git.qinjian@cqplus1.com>
 <55db801055793f43678e902395913330ecb8fbbf.1647928316.git.qinjian@cqplus1.com>
 <a7194fbf-8423-9b49-1443-68dd33e23783@kernel.org>
 <678d1f84d9d240b9983f9d3b82db17d4@cqplus1.com>
In-Reply-To: <678d1f84d9d240b9983f9d3b82db17d4@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 02:54, qinjian[覃健] wrote:
>>> +examples:
>>> +  - |
>>> +    rstc: reset@9c000054 {
>>> +      compatible = "sunplus,sp7021-reset";
>>> +      #reset-cells = <1>;
>>> +      reg = <0x9c000054 0x28>;
>>
>> I asked you to put the reg after compatible in all DTS code and
>> examples. If you do not agree with a comment, please respond. Ignoring
>> it is not cooperative.
>>
> 
> Your  reply: https://lore.kernel.org/all/d3ac3e2f-71fd-b2b4-7c7e-bb43c681d14e@canonical.com/
>>> +  - |
>>> +
>>> +    clkc: clock-controller@9c000000 {
>>> +      compatible = "sunplus,sp7021-clkc";
>>> +      #clock-cells = <1>;
>>> +      reg = <0x9c000000 0x280>;
>>
>> In DTS code, please put reg after compatible. In all your examples and
>> DTS patches.
>>
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> I see your review-tag. So, I misunderstand your comments.
> Did you means 'reg' must directly after the 'compatible', like this?
>     clkc: clock-controller@9c000000 {
>       #clock-cells = <1>;
>       compatible = "sunplus,sp7021-clkc";
>       reg = <0x9c000000 0x280>;

You moved now compatible so not. First goes compatible, then goes reg.

clock-controller@.... {
  compatible = ....;
  reg = ...;
  here goes the rest;
}

My review tag was conditional because I asked to change the code. Such
review tag should be used by you if you implement what I asked for.

Best regards,
Krzysztof
