Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E625914DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbiHLRfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbiHLRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:34:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03120B2742
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 10:34:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w5so2237479lfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8uJrZnBn1qDS0BGSkvxlFm5HObaIuT1JmBT6UeEISI8=;
        b=dD/l6ku6zx+XntXFItFTEmnxjPOh7xtO3PzebTKXoERAY1KFzerpHTEurH/U4cPCXb
         ipfYy5EaEV0JyN03x7oTT61kxAKNBaZr1a7axIXirT15PlVeqEkW2WejjdeGoRwu12Jd
         cfTEjZ83j/Ji3CUvh/6DJO6IyZvjEfw/6vRqfn+eXw+1PfayDDYpIMxI8d7U7nFsbhNP
         9ykOxvFLQJPG6sXY0zHmVad1ZF3BUKg6TmYvurO307xK2E10kYzBD31vCYz9ZfmOzkSz
         QtFDytLh2ChjbupEchtXx9JyOBj+SpBax51xiSLhLi9cPbP+XkCpAeY1lojB6zrMBQMK
         EXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8uJrZnBn1qDS0BGSkvxlFm5HObaIuT1JmBT6UeEISI8=;
        b=ZMijE1hmcXlZ5RWfI/1kVKo+1zpiM7slKyq2qJ+qG6pfH57N0yT180rQRmqPX//+0A
         lrUod8yNhPPi0QDm7Oq0kP0Azg8rwz/zsD4QXKRlut683lnUWVSNg3exvTEbvSmvWXQc
         lU1XN+zNdTzMfb0d4BUNJ5WMBcABBEQW9pFPY7QwTsQg6Jrd10dpQ+4VmAKMzJxwHCOT
         1HlFDeN2CpJkqU98oXrLTKnbPoAc9BBxsscP8E+1oJ0VLqIwEL7SLQ4xllTF2lcXsOxF
         m/EE3boxbF69T62u31j4hwP06TUsxOC64E4i91G6hA+yPOGnvXhYfMJtCRC4fiNUug0/
         dI4Q==
X-Gm-Message-State: ACgBeo1JbFsPv+E1N7lEI9sEHJtu4F+BdOIX95N3h9sZwmXeQKQInK4l
        NMkWfU0Bc4brLUZI4EMVnryapQ==
X-Google-Smtp-Source: AA6agR5Z4imJ8rDIGTv8h4bUGbzdx3ZYA2/ooRuEuRvdv3ZFUEbAWfC+5GfEzPnGdhWxpAtv0dv/yQ==
X-Received: by 2002:a05:6512:3ca1:b0:48a:fe06:f772 with SMTP id h33-20020a0565123ca100b0048afe06f772mr1667457lfv.80.1660325688321;
        Fri, 12 Aug 2022 10:34:48 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id z18-20020ac25df2000000b0048ad3d1a058sm282580lfq.52.2022.08.12.10.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 10:34:47 -0700 (PDT)
Message-ID: <1715a053-ae68-ea70-b13f-3d25f2354c00@linaro.org>
Date:   Fri, 12 Aug 2022 20:34:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dt-bindings: leds: Expand LED_COLOR_ID definitions
Content-Language: en-US
To:     Olliver Schinagl <oliver@schinagl.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Olliver Schinagl <oliver+list@schinagl.nl>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <7c688821-140b-4b05-651b-337f602dc1fe@schinagl.nl>
 <6ec9eaa1-2bc2-a32f-6685-4a2a645a5a59@schinagl.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6ec9eaa1-2bc2-a32f-6685-4a2a645a5a59@schinagl.nl>
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

On 12/08/2022 17:31, Olliver Schinagl wrote:
> In commit 853a78a7d6c7 (dt-bindings: leds: Add LED_COLOR_ID definitions,
> 
> Sun Jun 9 20:19:04 2019 +0200) the most basic color definitions where
> added. However, there's a little more very common LED colors.

You have messed up commit msg.

Also please do not attach new patches to some old threads. It buries
them deep and makes inbox check not easy.

> 
> While the documentation states 'add what is missing', engineers tend to
> be lazy and will just use what currently exists. So this patch will take
> (a) list from online retailers [0], [1], [2] and use the common LED 
> colors from

Wrap the description.


> there, this being reasonable as this is what is currently available to 
> purchase.


> 
> Note, that LIME seems to be the modern take to 'Yellow-green' or
> 'Yellowish-green' from some older datasheets.
> 
> [0]: https://www.digikey.com/en/products/filter/led-lighting-color/125
> [1]: 
> https://eu.mouser.com/c/optoelectronics/led-lighting/led-emitters/standard-leds-smd
> [2]: 
> https://nl.farnell.com/en-NL/c/optoelectronics-displays/led-products/standard-single-colour-leds-under-75ma
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
> 
> Changes since v1: Unbreak existing definitions.
> 
>   include/dt-bindings/leds/common.h | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/include/dt-bindings/leds/common.h 
> b/include/dt-bindings/leds/common.h
> index 3be89a7c20a9..04bf94523ea3 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -22,18 +22,22 @@
>   #define LEDS_BOOST_FIXED    2
> 
>   /* Standard LED colors */
> -#define LED_COLOR_ID_WHITE    0
> -#define LED_COLOR_ID_RED    1
> -#define LED_COLOR_ID_GREEN    2
> -#define LED_COLOR_ID_BLUE    3
> -#define LED_COLOR_ID_AMBER    4
> -#define LED_COLOR_ID_VIOLET    5
> -#define LED_COLOR_ID_YELLOW    6
> -#define LED_COLOR_ID_IR        7
> -#define LED_COLOR_ID_MULTI    8    /* For multicolor LEDs */
> -#define LED_COLOR_ID_RGB    9    /* For multicolor LEDs that can do 
> arbitrary color,

Also messed up patch. I have doubts that it applies.

> -                       so this would include RGBW and similar */
> -#define LED_COLOR_ID_MAX    10
> +#define LED_COLOR_ID_WHITE      0
Best regards,
Krzysztof
