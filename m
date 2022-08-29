Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E9D5A4EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiH2OM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiH2OMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:12:08 -0400
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D07596775;
        Mon, 29 Aug 2022 07:12:06 -0700 (PDT)
Date:   Mon, 29 Aug 2022 16:12:00 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Olliver Schinagl <oliver+list@schinagl.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 resend] dt-bindings: leds: Expand LED_COLOR_ID
 definitions
Message-ID: <YwzJMAaYT/frJLaT@ada.ifak-system.com>
Mail-Followup-To: Olliver Schinagl <oliver@schinagl.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Olliver Schinagl <oliver+list@schinagl.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220819152904.433514-1-oliver@schinagl.nl>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819152904.433514-1-oliver@schinagl.nl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hei Olliver,

Am Fri, Aug 19, 2022 at 05:29:04PM +0200 schrieb Olliver Schinagl:
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

Just noticed you did not send this to neither linux-leds mailing list
nor the LED subsystem maintainer. Maybe you want to do this in v3?

Greets
Alex

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
>  include/dt-bindings/leds/common.h | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> index 3be89a7c20a9..04bf94523ea3 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -22,18 +22,22 @@
>  #define LEDS_BOOST_FIXED	2
>  
>  /* Standard LED colors */
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
> +#define LED_COLOR_ID_ORANGE    11
> +#define LED_COLOR_ID_PINK      12
> +#define LED_COLOR_ID_CYAN      13
> +#define LED_COLOR_ID_LIME      14
> +#define LED_COLOR_ID_MAX       15
>  
>  /* Standard LED functions */
>  /* Keyboard LEDs, usually it would be input4::capslock etc. */
> -- 
> 2.37.2
> 
