Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953E05A657F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiH3Ntu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiH3NtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:49:02 -0400
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5140B1037F5;
        Tue, 30 Aug 2022 06:46:41 -0700 (PDT)
Received: from [10.2.12.24] (unknown [10.2.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 5C7DE186AE54;
        Tue, 30 Aug 2022 15:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1661866837; bh=QkP2rkDehwBSgpkLqWhg0SK62w0hxaRkEmx2wFzDvpY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=f6ABrVy6bO3nlMdiBhuXoDGeIXTsdsKNSqq+xT3bRsvVp39Vb+AezWjHr2IjF9MDa
         +wX7JY3ODlzt0oXnXVBkxEX/bkM1S4OUK0HvgISfKki9AiJSiYbkUi5egAJCld+PCp
         2iJnOSari/WzosWMx/jJWLHcAvX9kgU2vVvoEnSA=
Message-ID: <f9e6e452-0e00-785c-1f4f-43f7754ab720@schinagl.nl>
Date:   Tue, 30 Aug 2022 15:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCHv2 resend] dt-bindings: leds: Expand LED_COLOR_ID
 definitions
Content-Language: en-US
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
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
 <44eec926-b7d0-f8eb-f944-d28e3b35257a@gmail.com>
From:   Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <44eec926-b7d0-f8eb-f944-d28e3b35257a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-2022 12:28, Jacek Anaszewski wrote:
> Hi Oliver,
>
> On 8/19/22 17:29, Olliver Schinagl wrote:
>> In commit 853a78a7d6c7 (dt-bindings: leds: Add LED_COLOR_ID definitions,
>> Sun Jun 9 20:19:04 2019 +0200) the most basic color definitions where
>> added. However, there's a little more very common LED colors.
>>
>> While the documentation states 'add what is missing', engineers tend to
>> be lazy and will just use what currently exists. So this patch will take
>> (a) list from online retailers [0], [1], [2] and use the common LED colors
>> from there, this being reasonable as this is what is currently available to
>> purchase.
>>
>> Note, that LIME seems to be the modern take to 'Yellow-green' or
>> 'Yellowish-green' from some older datasheets.
>>
>> [0]: https://www.digikey.com/en/products/filter/led-lighting-color/125
>> [1]: https://eu.mouser.com/c/optoelectronics/led-lighting/led-emitters/standard-leds-smd
>> [2]: https://nl.farnell.com/en-NL/c/optoelectronics-displays/led-products/standard-single-colour-leds-under-75ma
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
>>
>> Changes since v1: Unbreak existing definitions.
>>
>>
>>    include/dt-bindings/leds/common.h | 28 ++++++++++++++++------------
>>    1 file changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
>> index 3be89a7c20a9..04bf94523ea3 100644
>> --- a/include/dt-bindings/leds/common.h
>> +++ b/include/dt-bindings/leds/common.h
>> @@ -22,18 +22,22 @@
>>    #define LEDS_BOOST_FIXED	2
>>    
>>    /* Standard LED colors */
>> -#define LED_COLOR_ID_WHITE	0
>> -#define LED_COLOR_ID_RED	1
>> -#define LED_COLOR_ID_GREEN	2
>> -#define LED_COLOR_ID_BLUE	3
>> -#define LED_COLOR_ID_AMBER	4
>> -#define LED_COLOR_ID_VIOLET	5
>> -#define LED_COLOR_ID_YELLOW	6
>> -#define LED_COLOR_ID_IR		7
>> -#define LED_COLOR_ID_MULTI	8	/* For multicolor LEDs */
>> -#define LED_COLOR_ID_RGB	9	/* For multicolor LEDs that can do arbitrary color,
>> -					   so this would include RGBW and similar */
>> -#define LED_COLOR_ID_MAX	10
>> +#define LED_COLOR_ID_WHITE      0
>> +#define LED_COLOR_ID_RED        1
>> +#define LED_COLOR_ID_GREEN      2
>> +#define LED_COLOR_ID_BLUE       3
>> +#define LED_COLOR_ID_AMBER      4
>> +#define LED_COLOR_ID_VIOLET     5
>> +#define LED_COLOR_ID_YELLOW     6
>> +#define LED_COLOR_ID_IR         7
>> +#define LED_COLOR_ID_MULTI      8 /* For multicolor LEDs */
>> +#define LED_COLOR_ID_RGB        9 /* For multicolor LEDs that can do arbitrary color, including RGBW etc. */
>> +#define LED_COLOR_ID_PUPRPLE   10
> typo - as already mentioned
Sorry, I did not receive your earlier mail it seems, or it's not showing 
up in the thread; well caught!
>
>> +#define LED_COLOR_ID_ORANGE    11
>> +#define LED_COLOR_ID_PINK      12
>> +#define LED_COLOR_ID_CYAN      13
>> +#define LED_COLOR_ID_LIME      14
>> +#define LED_COLOR_ID_MAX       15
>>    
>>    /* Standard LED functions */
>>    /* Keyboard LEDs, usually it would be input4::capslock etc. */
> And it seems that change in spacing between definition name and value
> is not required, is it? Without that change, it would be easier to
> notice what really changes here.
>
Yes, you are correct, I initially had LimeGreen there, which made it 
longer, as I later found out, that LimeGreen could actually just be Lime 
as much, I forgot to 're-shorten it. The fixed diff for v4 does look as 
expected! thanks for that one.

