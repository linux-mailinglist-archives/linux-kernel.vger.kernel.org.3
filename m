Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164455A5EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiH3Iz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiH3IzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:55:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B624248D8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:55:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq23so14591089lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+UvLvbgT2Zui3dc1nSjVMEP7pMNlkVdd9jqNIs17BfU=;
        b=Dw+66UNfQkNVVxxPIQh8WDJVbiIytGrZ9vJzfgk1pjQuY++ecRLu/+MdnFJ6lXIIPm
         y1ybkTIbaHHKNRu1/5tj6mPVSRTL2mnvHCU+wn+EgJqSQUSFHpBJLZLy01pd+VyDoBY8
         1X6ftO1JW1ZUX5Y9q3A7xkpT5Ry2IApKm/+H6UKXdEqTaLRYcFX8izWL3jB6HSiVD4Qn
         UinKxa4jjf1T8/m0rohyZQtp/7iG1mQoNqTieeHv3zkFdTo9oNgwBm6mx8hf4lYMV38+
         WA8/6inh4vFOa0aicBc+9yXPOu8QIJS24VcrV4AWDxQMamQZTCWryetvwvuHEJK+UYy1
         JKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+UvLvbgT2Zui3dc1nSjVMEP7pMNlkVdd9jqNIs17BfU=;
        b=UsCec9A+BWQSLLnwTwBMDHk2jZo6pzNPuMU69S7nBtPkUpid2n8kr6vtI2BInlNpPi
         AKdKaHDpauduQZPu4CPhvZpu/tyUhTKT/Cd2PCN4KNBRf4cRIgoABQnMQNMM6h8WE0g/
         WgOxmIJgbPbeCbrommR13A2+d0KT0LyGaliHx+ewnwJ8MGTor8XeMscFm7cOVkvrIMD2
         thtqpjSF8TroQotn4FLUEH4LotwuJRC9eW1hIy+TpikNKfqsQFRuXtt6j420fRgy07Mq
         4CGgxz9oSdYCM+gFQ0A08TYz2FuMdUUfT53gZ1YDDH7dhtLx5Q8Fx5xO6apgrqnFg8Oy
         PHLQ==
X-Gm-Message-State: ACgBeo201kNSWv/7U8hHfmGx+Kunalrniqoe4nDelKcrcJANGTjk233X
        SV0oih6JkpJixR/U8TVpSzERqw==
X-Google-Smtp-Source: AA6agR6+yGiJ3sGnhuUci8DqyywsOI+3JgBkGbBsVGWFdN9xfAoGQp8Rw+OUHAieWlShpc49z+1BzA==
X-Received: by 2002:a05:6512:104f:b0:494:736a:8332 with SMTP id c15-20020a056512104f00b00494736a8332mr1592996lfb.683.1661849721902;
        Tue, 30 Aug 2022 01:55:21 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05651c231300b00261e7e7b698sm1687565ljb.123.2022.08.30.01.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 01:55:21 -0700 (PDT)
Message-ID: <97f710b2-98b1-76d4-668a-526bca018453@linaro.org>
Date:   Tue, 30 Aug 2022 11:55:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] dt-bindings: leds: Expand LED_COLOR_ID definitions
Content-Language: en-US
To:     Olliver Schinagl <oliver@schinagl.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Olliver Schinagl <oliver+list@schinagl.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220830084454.1133369-1-oliver@schinagl.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830084454.1133369-1-oliver@schinagl.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 11:44, Olliver Schinagl wrote:
> In commit 853a78a7d6c7 (dt-bindings: leds: Add LED_COLOR_ID definitions,
> Sun Jun 9 20:19:04 2019 +0200) the most basic color definitions where
> added. However, there's a little more very common LED colors.
> 
> While the documentation states 'add what is missing', engineers tend to
> be lazy and will just use what currently exists. So this patch will take
> (a) list from online retailers [0], [1], [2] and use the common LED colors from
> there, this being reasonable as this is what is currently available to purchase.
> 
> Note, that LIME seems to be the modern take to 'Yellow-green' or
> 'Yellowish-green' from some older datasheets.
> 
> [0]: https://www.digikey.com/en/products/filter/led-lighting-color/125
> [1]: https://eu.mouser.com/c/optoelectronics/led-lighting/led-emitters/standard-leds-smd
> [2]: https://nl.farnell.com/en-NL/c/optoelectronics-displays/led-products/standard-single-colour-leds-under-75ma
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
