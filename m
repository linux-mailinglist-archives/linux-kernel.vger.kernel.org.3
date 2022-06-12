Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D83547AA5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiFLPIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbiFLPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:08:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CA55EDD8;
        Sun, 12 Jun 2022 08:08:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h23so5345516lfe.4;
        Sun, 12 Jun 2022 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=YSTRMk+mv8/8mRawNcAG/kPCu35wvaQcd0rlFYK138I=;
        b=WZUvQkYJDroUcqOJ8upXuhmIANC6/o+ah0+qcs9McJPFpSN0c28tLw2Wmj64Ar8FrB
         LUmQ5RVuPXK91F6HqDrQajzE/jegZD9LnAUwXt2DreIV7DUKsJUcjt+6TANGzeR//cjS
         AHwa0iznhVsX48AqkojuRRGCeIrm5Wy/w2OVHxWjZHjImnWrfT4P4sixGHu+8R4KRdr0
         JdCaqdEznAqgubv1Gd9OBKCCghkB/86+bGWuBx8YOq3ueTgxDtnwiVHeqZb4SMIt3FMj
         15+lEWVqmCmha3PnTN3LkvMq4p3xOEP0HW3HLHRJPi+68EM2EsVL8D3VSbnfiA/xEGtj
         WmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YSTRMk+mv8/8mRawNcAG/kPCu35wvaQcd0rlFYK138I=;
        b=SqlONAoscFCoRsB6BP4mA6lJjbWvRuKQN+o0qVh77c8ZaEDq9K70ethmaz4258NnOD
         A586qZGySiOBYdLptWcUBBp7fr3oSkY2WYYwYxmm1x+HHUzatID5E9LlBqRCJfIYp8Ru
         n7XqR7UpjR3MjEzevLq8Nwfm1SnYGT045EXerkewiuhAbKzRM0pC3Eqox1Fj6+jkQicZ
         fZJDIISzmOjX82cgaRqrUuAeYy7hfkq9seBf/Bfb9COi6mA4OUS1/Ca4kgDmFN0xMmr1
         paJkG38RI39Ade4y1+rMRJgvCYNyVf5Pu0/pzXGA84kHWcjWHW5THf1cEDiT8Zgz2isj
         ob9A==
X-Gm-Message-State: AOAM533/URyYjd3chh7f8o3eCQ/2WizvHvFS7+lYXxvcMYSVLD8mkApQ
        kCCd+BpNLkY1fl4gQz8FzfI=
X-Google-Smtp-Source: ABdhPJyLgiK/n2xx4Qe5//vI4+DUPK3WLlmcmSPS95xxOHNSYLqB5p+YktGpTd9iX+kUMZKX3EvtNA==
X-Received: by 2002:a05:6512:3d23:b0:478:fa1e:70fe with SMTP id d35-20020a0565123d2300b00478fa1e70femr33703531lfv.530.1655046502168;
        Sun, 12 Jun 2022 08:08:22 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id g2-20020a056512118200b00477c164293csm640383lfr.79.2022.06.12.08.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 08:08:21 -0700 (PDT)
Message-ID: <05c9128d-6228-40e5-ad69-1334a81d786e@gmail.com>
Date:   Sun, 12 Jun 2022 17:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/3] dt-bindings: leds: skyworks,aat1290: convert to
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220607085343.72414-1-krzysztof.kozlowski@linaro.org>
 <d6d1642c-26b4-e4a8-5ae7-c4b952ae6c62@gmail.com>
 <410c5c97-8ff7-2303-5e19-d6053d3779dd@linaro.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <410c5c97-8ff7-2303-5e19-d6053d3779dd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 12:12, Krzysztof Kozlowski wrote:
> On 09/06/2022 22:28, Jacek Anaszewski wrote:
>> Hi Krzysztof,
>>
>> On 6/7/22 10:53, Krzysztof Kozlowski wrote:
>>> Convert the Skyworks Solutions, Inc. AAT1290 Current Regulator bindings
>>> to DT Schema.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> [...]
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/gpio/gpio.h>
>>> +    #include <dt-bindings/leds/common.h>
>>> +
>>> +    // Ct = 220 nF, Rset = 160 kOhm
>>> +    led-controller {
>>> +        compatible = "skyworks,aat1290";
>>> +        flen-gpios = <&gpj1 1 GPIO_ACTIVE_HIGH>;
>>> +        enset-gpios = <&gpj1 2 GPIO_ACTIVE_HIGH>;
>>> +
>>> +        pinctrl-names = "default", "host", "isp";
>>> +        pinctrl-0 = <&camera_flash_host>;
>>> +        pinctrl-1 = <&camera_flash_host>;
>>> +        pinctrl-2 = <&camera_flash_isp>;
>>> +
>>> +        led {
>>> +            label = "flash";
>>
>> Why are you adding label? It is deprecated,
> 
> Eh, so it should be marked as deprecated:true, not just mentioned in the
> description (common.yaml).

I believe so.

>> but has the precedence over
>> new function and color for backwards compatibility, so it would make
>> those unused by the driver now. Please drop the label from this example.
> 
> I synced the example with DTS, but I can drop it. No problem.

Yeah, let's avoid further confusion.

-- 
Best regards,
Jacek Anaszewski
