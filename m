Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA4E548378
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbiFMJoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbiFMJoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:44:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D5311179
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:44:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o16so6388420wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u5xXrnLk8hPXTTCgmE1G5BVTn8vjO1QNkaM0LsIMZ/M=;
        b=RnT9p3BnlZcKJ+9k77nktxR/mJdxoTKVTVzhRpnkeIPreRviuXH/pJvtT/tkYSSeTG
         2kqdGIWDkK33N/EnIu8qFX4zCH97K1WVrgzY3D5cFiMZ690o1Gjt8UZ4AlSNUO3AAJCP
         oHpD36BMy81sPCjqu4ZGYnY/0FNWgSN9FwTdzpUdkXc+zJfvcyn8keKpliZITc/sRCy3
         ncyHaYf4uX1Crdh2N52HC1EiAKtzcta2dTpGbcTJS/jj1sW4XMTqb0aWxgTqKG2Txcm5
         Zz7pAvKrNGsjnEZbdcqhQ/X/Geb4TBYjxZF6Tmf+rh4ax9jbo5smw9C3twR4SaA6G0aW
         bFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u5xXrnLk8hPXTTCgmE1G5BVTn8vjO1QNkaM0LsIMZ/M=;
        b=G+1t6fbeeX/Ro++k78XAy+JfECOiSedQyUo4wmG3SY5ScO76LRWouwE6QJVJVdkxSB
         Ir2RpZ6WNxMS4yepYwslSNvLMQAProZ7l0sjElPilDsfar4oW8vJ2yqiHPkR3tXlf9sN
         pKTBSpNkbfCzbe68uj+g/QVK3nqGIFrL2SOKuAEnnEySjFdasURgTXGMISzmfIMdB+Tg
         8miSQBmyqaT0Zglrjy7lNm/l/csEdeqI/OWHnSc0m5pGjZl6jP+Nt1dUFxXehyoOqxA9
         2vMhhxr1kUogtr8jbJeyV3z+lPOrapL/d6c/ftIagaoFY2+dlozO3nvDS3+NyY6hU542
         qdPw==
X-Gm-Message-State: AOAM5312uN3gvBBNkZvW01u5cBkAFQvC309b/vNsZdj0b67C4DEel2jx
        C4iypfv4rFHuzAHtFIk+gMU3ig==
X-Google-Smtp-Source: ABdhPJzoBeEFaoVtayPoYOl8lsPHAw5X904LIdYL9UKaIUafLUSDbNfAQiWgXvz8QJEfh/DA+IizhQ==
X-Received: by 2002:a05:6000:15c1:b0:218:468b:4c01 with SMTP id y1-20020a05600015c100b00218468b4c01mr36804058wry.60.1655113440581;
        Mon, 13 Jun 2022 02:44:00 -0700 (PDT)
Received: from [10.227.148.193] (80-254-69-65.dynamic.monzoon.net. [80.254.69.65])
        by smtp.gmail.com with ESMTPSA id m185-20020a1c26c2000000b003974d0d981dsm12823357wmm.35.2022.06.13.02.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 02:44:00 -0700 (PDT)
Message-ID: <4ee7e805-d4ed-a765-6b5f-c78183a64fe7@linaro.org>
Date:   Mon, 13 Jun 2022 11:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/3] media: dt-binding: media: Add rockchip-vepu
 binding
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220514133604.174905-1-frattaroli.nicolas@gmail.com>
 <20220514133604.174905-2-frattaroli.nicolas@gmail.com>
 <440a7dc6-7ec4-d7a9-0c56-3b3dc15b79d0@linaro.org>
 <1885873.U9Vi27CkfU@archbook>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1885873.U9Vi27CkfU@archbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2022 17:05, Nicolas Frattaroli wrote:

>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: aclk
>>> +      - const: hclk
>>
>> Since these are new bindings, it would be good to follow DT convention
>> and not add common "clk" prefix to clocks. Just like DMA is "tx" not
>> "txdma". However clock names "a" and "h" are also not good and maybe
>> this is already shared implementation?
> 
> This is indeed a shared implementation. Theoretically I could change
> the driver for this one case but that seems pointless, especially
> since "aclk" and "hclk" are the usual clk names for AXI and AHB on
> ARM as far as I understand. I think I've been told before that those
> two clocks should always be called aclk and hclk.
> 

ok


Best regards,
Krzysztof
