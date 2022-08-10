Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4796958ED2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiHJN2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiHJN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:27:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390622F002
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:27:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r17so21200252lfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=A9njV9Wd5j4Tt7cBK2yBVlLiJECu8pNJ+UKf3q169rs=;
        b=A1YnTNU/tXEgPPkW95fDzSourvKOy2h4fLkuTNNBC/d7IOzaYLnKkGHJW9Dj8KfPzg
         8jbuXgbj3FICAPdnQMMyt6bfJmNYiWCMVyOnEVGbN+nmRSW4m4YhYmUymW6BMnBT1DOs
         UzXe77bN2VTSc8Ztbl1WF2Wqy8q/XCtkaOWCMivUc867UZMfy4mopsPEFwT60tu5GUAD
         Bej/UA1jXADKfTbG6Hs1JLiMBXsTsyOKa4qq4oHT+KjDCFkDhBSsQFDiQ/+kchveP5qc
         XmxLmqtdl1p4cABF1vb2A1nthLHhTJT+l1rq5Z8ntjQKzsDjgynpYf5NyiB/SHH0sj7f
         70Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=A9njV9Wd5j4Tt7cBK2yBVlLiJECu8pNJ+UKf3q169rs=;
        b=oz1RhPqDj360Z0bw5sytv+bNzXszWqKbYGNWq1MWjsfHETvV/2e3Lj+gEbnyMtHIJk
         yXizpPyOeVgul/s+vv9FNK/NEu0RUjKj1w/oFV4BW0qozzkLZmh2X8oCFNh/hN8cXxEf
         hymCIxwxaLfy4si5igcEZa5aFl5YdjUoMJaRB8wWZyekY6YqccAjK78KWHnunQsPyg89
         hMO1abzXLKAQDq+I5HJ/jO0UwSJ0Sc2ia7UKOpfhqlfBzwOlHuv1sbY/XsSy2GSKPWZ3
         gOt/sNXgaJJKHy4h9z9jVeVL0lG7IAwuqAt0zq2wWJoid3qd+wOj7snuJzTKs2ehhL0X
         /IhA==
X-Gm-Message-State: ACgBeo1uadfbaqVNLs/CQGbNrJa7WeVCgFIHcmIWqPHc7mkmIF2F9Y24
        Z++lq39oc7r/7jSbvynLP4kwzA==
X-Google-Smtp-Source: AA6agR7gdKGUPqOZtIOmuMxG9hUtd77+hqn7UpKKuaH3yA91oPAasOF2z+VuFpQi6e9rPYXcgYQi+g==
X-Received: by 2002:a19:4314:0:b0:48a:da65:2a66 with SMTP id q20-20020a194314000000b0048ada652a66mr8825944lfa.257.1660138065583;
        Wed, 10 Aug 2022 06:27:45 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id w17-20020a05651c119100b0025e491bd803sm412426ljo.55.2022.08.10.06.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 06:27:44 -0700 (PDT)
Message-ID: <e38b3875-752b-0746-d6fd-0d1f537d242f@linaro.org>
Date:   Wed, 10 Aug 2022 16:27:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: leds: Expand LED_COLOR_ID definitions
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7c688821-140b-4b05-651b-337f602dc1fe@schinagl.nl>
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

On 10/08/2022 14:07, Olliver Schinagl wrote:
> In commit 853a78a7d6c7 (dt-bindings: leds: Add LED_COLOR_ID definitions,
> Sun Jun 9 20:19:04 2019 +0200) the most basic color definitions where
> added. However, there's a little more very common LED colors.
> 
> While the documentation states 'add what is missing', engineers tend to
> be lazy and will just use what currently exists. So this patch will take
> (a) list from online retailers [0], [1], [2] and use the common LED 
> colors from
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
>   include/dt-bindings/leds/common.h | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/include/dt-bindings/leds/common.h 
> b/include/dt-bindings/leds/common.h
> index 3be89a7c20a9..1d9b955267cc 100644
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
> -                       so this would include RGBW and similar */
> -#define LED_COLOR_ID_MAX    10
> +#define LED_COLOR_ID_WHITE      0
> +#define LED_COLOR_ID_RED        1
> +#define LED_COLOR_ID_YELLOW     2
> +#define LED_COLOR_ID_BLUE       3
> +#define LED_COLOR_ID_AMBER      4
> +#define LED_COLOR_ID_GREEN      5
> +#define LED_COLOR_ID_VIOLET     6
> +#define LED_COLOR_ID_PUPRPLE    7
> +#define LED_COLOR_ID_ORANGE     8
> +#define LED_COLOR_ID_PINK       9
> +#define LED_COLOR_ID_CYAN      10
> +#define LED_COLOR_ID_LIME      11

All this is a incompatible bindings change, so shortly ABI break. You
cannot change defines. Feel free to add new ones.

Best regards,
Krzysztof
