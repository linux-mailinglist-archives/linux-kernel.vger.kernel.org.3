Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89B85A68E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiH3Q5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiH3Q5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:57:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F617B02B5;
        Tue, 30 Aug 2022 09:57:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z29so7801828lfb.13;
        Tue, 30 Aug 2022 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4sIm+5RqskE4s5NMNUoHNNOj6uwTL7sHVMyCwXn/6M0=;
        b=Cdn9MKbtWLQt7/yqQyF93sylLXXGpfdAE415lc0maeWe1YHxfpBbvtmoNr7Y2BV/GS
         craDikj9YYOrwka5FF3bW8E1WsR7Ye5+b3H7cmZEPAqdWTGpDmeSxqIXfIWQh6Mmyh0O
         3+GoRngT+f+l55S8DBekoQPhQFh5PZok+TiMCDvpKU2Zwf4LYFWVmu41FjIGzYdIVP4p
         7AUI+T9mf7YX0JsuKWhbUmRS+qJuM/yUCrtHkPjxk958qvI/FG15AKO+IEM8BYooDchU
         7MXCrlCAIZGzWQA6rGHXj0vhXPnhe+KvwJ+JTREYBh8Jd8KItOylqy+Vdr6U2M2W8UMM
         hU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4sIm+5RqskE4s5NMNUoHNNOj6uwTL7sHVMyCwXn/6M0=;
        b=MCjpOcBZ3SkBLsnU9c+FKlVgvdG8q9OIqfIsqUCU1rC6R9a3qquwZW7TjBSoQD/pnf
         UNpUXtFCmiXfrtmh3DokHcF+56IdgzfICbxGieV1693EDJEy4ciYz5WNtIXwHjmHF8Le
         m6tYkYXv5tSFrh5DBXG+jX79AABNlAljVvSvgJFX2G3bjErtFDR9fToeazPZ4kTzhLfc
         3kqPsHrTTW9/mcBlwccm5WMc4RhVCGNXLrXFJacc9Z3pBeef42BlJTk5Qze3wzXOs7ZP
         KbWq0u1sp2QPo1yrd1uxiMRxMGqPck97CEraGNiSOcKrlksr1QAjQYqIw+E/ezzJmETh
         U+jg==
X-Gm-Message-State: ACgBeo3YgfFaoqobAOy2uLzRCr4rA0XCoe3Ndxz1t+SimgdX5oToaJJ2
        vvqurJI2PSIj8DGY0JkLUOM=
X-Google-Smtp-Source: AA6agR4mySH5uXncbBft/rRGekD9KUWU/GQfnwEa9HgTAbH3klbqUjCCgTKL7M0G0TwTRkCRqa4Kaw==
X-Received: by 2002:ac2:43c2:0:b0:494:77ab:b8f2 with SMTP id u2-20020ac243c2000000b0049477abb8f2mr1481226lfl.171.1661878647894;
        Tue, 30 Aug 2022 09:57:27 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id m20-20020a056512359400b00492d1eb41dfsm1659420lfr.240.2022.08.30.09.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 09:57:26 -0700 (PDT)
Message-ID: <c938fa66-6f2f-50e1-58a2-ff27777af037@gmail.com>
Date:   Tue, 30 Aug 2022 18:57:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] dt-bindings: leds: Expand LED_COLOR_ID definitions
Content-Language: en-US
To:     Olliver Schinagl <oliver@schinagl.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Olliver Schinagl <oliver+list@schinagl.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20220830134613.1564059-1-oliver@schinagl.nl>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20220830134613.1564059-1-oliver@schinagl.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ho Olliver,

Thanks for the update.

On 8/30/22 15:46, Olliver Schinagl wrote:
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
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes since v3: Fix typo in purple; Fix whitespacing
> No changes since v2: Re-send with the proper e-mails.
> Changes since v1: Unbreak existing definitions.
>   include/dt-bindings/leds/common.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> index 3be89a7c20a9..9a0d33d027ff 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -33,7 +33,12 @@
>   #define LED_COLOR_ID_MULTI	8	/* For multicolor LEDs */
>   #define LED_COLOR_ID_RGB	9	/* For multicolor LEDs that can do arbitrary color,
>   					   so this would include RGBW and similar */
> -#define LED_COLOR_ID_MAX	10
> +#define LED_COLOR_ID_PURPLE	10
> +#define LED_COLOR_ID_ORANGE	11
> +#define LED_COLOR_ID_PINK	12
> +#define LED_COLOR_ID_CYAN	13
> +#define LED_COLOR_ID_LIME	14
> +#define LED_COLOR_ID_MAX	15
>   
>   /* Standard LED functions */
>   /* Keyboard LEDs, usually it would be input4::capslock etc. */

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
Best regards,
Jacek Anaszewski
