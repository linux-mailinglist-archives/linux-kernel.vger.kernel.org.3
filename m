Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968A85A60C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiH3K2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH3K2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:28:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B5CA0313;
        Tue, 30 Aug 2022 03:28:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bq23so14896160lfb.7;
        Tue, 30 Aug 2022 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=b/nZhE2dp650uWokYI5aEvFvA+EjweB+oPyz5jhQ7To=;
        b=IMmOBMRF7ildEi2x+68UlBrMLKhaNizFH6b5sKnld3AN3qCGFUY6WvTzF/TfYsdV6y
         gyp2ffrBBc1fpXsEH582OuiumAN4O4vBZ3e3RXlFg0ffdhM+3XO3hwjjyGF1nVNwVdfT
         Azv28mftuojHL0gyxJUSq4rqJISWLySDqliqxX3+PNsQio8sDxxhHVeLEnD0vJYgh2lp
         RcMJ+27dRKYGeoOZJr9xnXjcjxE2tfknzHqiiT/IWiM7exhOS3JKxn+kWGwIrG5nPNqE
         IEUyO7m3UbNZaYzZBL08zRN1E16t2BdTxKnzcARz8B/TTLopWYiXxyt8IRMMenFPr2dy
         Dq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=b/nZhE2dp650uWokYI5aEvFvA+EjweB+oPyz5jhQ7To=;
        b=sXPkKwyE8jcPW5xpyWL1d1XRBrCwoaDM8fHIg9iYJ+L86+pPQzdz4RjYAXBwdjw9ur
         SD7RBjACjLf+Qw5tnMZ3BEV0xNYMwZHfaloGY6BEps44hKIMjC9dGvNNwdUlfH1DT1eg
         V4peh970v883udvVFisDDBZoy998lyFmJ4k4YjeuTPadDJ1nngFLoqY577Rq0WUq9bx4
         I91sTM3q7pJT6EXUlKLTcWkUxmtorEQ53/2t22Mc3cUNN6OKQ89QcgZPN/htOgjZxlVh
         mNTp2+6GsfmQ/JdHrLAt6VSVfolJrRzRPQb/DHahfpTCB1vNe498jI+kPDpO+826Qa+E
         va1A==
X-Gm-Message-State: ACgBeo11kjwI3WJpVnvMVPGSB+UWsO0ZUzvu6LGuI6NzBOJUdWAadwFe
        694Ex14Hn3cFAmzrshCThS4=
X-Google-Smtp-Source: AA6agR4ol7l2p4EEDDRFTHZ38xomYM3+zr1fCVdpTRO+ShN8H7kCrp9FJSTGJ2W+oC+5DvL+iHKqfg==
X-Received: by 2002:a05:6512:1385:b0:491:4152:c9d7 with SMTP id p5-20020a056512138500b004914152c9d7mr7742666lfa.675.1661855317663;
        Tue, 30 Aug 2022 03:28:37 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id b24-20020a05651c033800b0025fdf1af42asm1703777ljp.78.2022.08.30.03.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 03:28:36 -0700 (PDT)
Message-ID: <44eec926-b7d0-f8eb-f944-d28e3b35257a@gmail.com>
Date:   Tue, 30 Aug 2022 12:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv2 resend] dt-bindings: leds: Expand LED_COLOR_ID
 definitions
Content-Language: en-US
To:     Olliver Schinagl <oliver@schinagl.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Olliver Schinagl <oliver+list@schinagl.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220819152904.433514-1-oliver@schinagl.nl>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20220819152904.433514-1-oliver@schinagl.nl>
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

Hi Oliver,

On 8/19/22 17:29, Olliver Schinagl wrote:
> In commit 853a78a7d6c7 (dt-bindings: leds: Add LED_COLOR_ID definitions,
> Sun Jun 9 20:19:04 2019 +0200) the most basic color definitions where
> added. However, there's a little more very common LED colors.
> 
> While the documentation states 'add what is missing', engineers tend to
> be lazy and will just use what currently exists. So this patch will take
> (a) list from online retailers [0], [1], [2] and use the common LED colors
> from there, this being reasonable as this is what is currently available to
> purchase.
> 
> Note, that LIME seems to be the modern take to 'Yellow-green' or
> 'Yellowish-green' from some older datasheets.
> 
> [0]: https://www.digikey.com/en/products/filter/led-lighting-color/125
> [1]: https://eu.mouser.com/c/optoelectronics/led-lighting/led-emitters/standard-leds-smd
> [2]: https://nl.farnell.com/en-NL/c/optoelectronics-displays/led-products/standard-single-colour-leds-under-75ma
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
> 
> Changes since v1: Unbreak existing definitions.
> 
> 
>   include/dt-bindings/leds/common.h | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> index 3be89a7c20a9..04bf94523ea3 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -22,18 +22,22 @@
>   #define LEDS_BOOST_FIXED	2
>   
>   /* Standard LED colors */
> -#define LED_COLOR_ID_WHITE	0
> -#define LED_COLOR_ID_RED	1
> -#define LED_COLOR_ID_GREEN	2
> -#define LED_COLOR_ID_BLUE	3
> -#define LED_COLOR_ID_AMBER	4
> -#define LED_COLOR_ID_VIOLET	5
> -#define LED_COLOR_ID_YELLOW	6
> -#define LED_COLOR_ID_IR		7
> -#define LED_COLOR_ID_MULTI	8	/* For multicolor LEDs */
> -#define LED_COLOR_ID_RGB	9	/* For multicolor LEDs that can do arbitrary color,
> -					   so this would include RGBW and similar */
> -#define LED_COLOR_ID_MAX	10
> +#define LED_COLOR_ID_WHITE      0
> +#define LED_COLOR_ID_RED        1
> +#define LED_COLOR_ID_GREEN      2
> +#define LED_COLOR_ID_BLUE       3
> +#define LED_COLOR_ID_AMBER      4
> +#define LED_COLOR_ID_VIOLET     5
> +#define LED_COLOR_ID_YELLOW     6
> +#define LED_COLOR_ID_IR         7
> +#define LED_COLOR_ID_MULTI      8 /* For multicolor LEDs */
> +#define LED_COLOR_ID_RGB        9 /* For multicolor LEDs that can do arbitrary color, including RGBW etc. */
> +#define LED_COLOR_ID_PUPRPLE   10

typo - as already mentioned

> +#define LED_COLOR_ID_ORANGE    11
> +#define LED_COLOR_ID_PINK      12
> +#define LED_COLOR_ID_CYAN      13
> +#define LED_COLOR_ID_LIME      14
> +#define LED_COLOR_ID_MAX       15
>   
>   /* Standard LED functions */
>   /* Keyboard LEDs, usually it would be input4::capslock etc. */

And it seems that change in spacing between definition name and value
is not required, is it? Without that change, it would be easier to
notice what really changes here.

-- 
Best regards,
Jacek Anaszewski
