Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E79C58F137
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiHJRIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiHJRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:08:28 -0400
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C554B61D51;
        Wed, 10 Aug 2022 10:08:26 -0700 (PDT)
Received: from [10.2.12.48] (unknown [10.2.12.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 847CD1862968;
        Wed, 10 Aug 2022 19:08:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1660151304; bh=DR6WV+9fjwKtyYwDokBzRKdbXzafPGQnd0E5u0WYmSo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=pvogSSnDLPpPySIL6smb1kDVbQZYZUNxvxZaW2N7EnSJHXgD/WyMcamsfBkHOwkY3
         r01rcr1+YZ0PxmQiLjrUDPt9/WtotLLB70bblsZ0j9T+hpedfAtm0vB0bN5hCOrqQv
         5/Q7bGTx8usvhyxGozRM/XGPHGKDzJWqZAt9YClU=
Message-ID: <49ade311-76b6-4520-3a8c-fe38f1ee2a52@schinagl.nl>
Date:   Wed, 10 Aug 2022 19:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: leds: Expand LED_COLOR_ID definitions
Content-Language: nl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <e38b3875-752b-0746-d6fd-0d1f537d242f@linaro.org>
From:   Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <e38b3875-752b-0746-d6fd-0d1f537d242f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,

On 10-08-2022 15:27, Krzysztof Kozlowski wrote:
> On 10/08/2022 14:07, Olliver Schinagl wrote:
>> In commit 853a78a7d6c7 (dt-bindings: leds: Add LED_COLOR_ID definitions,
>> Sun Jun 9 20:19:04 2019 +0200) the most basic color definitions where
>> added. However, there's a little more very common LED colors.
>>
>> While the documentation states 'add what is missing', engineers tend to
>> be lazy and will just use what currently exists. So this patch will take
>> (a) list from online retailers [0], [1], [2] and use the common LED
>> colors from
>> there, this being reasonable as this is what is currently available to
>> purchase.
>>
>> Note, that LIME seems to be the modern take to 'Yellow-green' or
>> 'Yellowish-green' from some older datasheets.
>>
>> [0]: https://www.digikey.com/en/products/filter/led-lighting-color/125
>> [1]:
>> https://eu.mouser.com/c/optoelectronics/led-lighting/led-emitters/standard-leds-smd
>> [2]:
>> https://nl.farnell.com/en-NL/c/optoelectronics-displays/led-products/standard-single-colour-leds-under-75ma
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
>>    include/dt-bindings/leds/common.h | 28 ++++++++++++++++------------
>>    1 file changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/dt-bindings/leds/common.h
>> b/include/dt-bindings/leds/common.h
>> index 3be89a7c20a9..1d9b955267cc 100644
>> --- a/include/dt-bindings/leds/common.h
>> +++ b/include/dt-bindings/leds/common.h
>> @@ -22,18 +22,22 @@
>>    #define LEDS_BOOST_FIXED    2
>>
>>    /* Standard LED colors */
>> -#define LED_COLOR_ID_WHITE    0
>> -#define LED_COLOR_ID_RED    1
>> -#define LED_COLOR_ID_GREEN    2
>> -#define LED_COLOR_ID_BLUE    3
>> -#define LED_COLOR_ID_AMBER    4
>> -#define LED_COLOR_ID_VIOLET    5
>> -#define LED_COLOR_ID_YELLOW    6
>> -#define LED_COLOR_ID_IR        7
>> -#define LED_COLOR_ID_MULTI    8    /* For multicolor LEDs */
>> -#define LED_COLOR_ID_RGB    9    /* For multicolor LEDs that can do
>> arbitrary color,
>> -                       so this would include RGBW and similar */
>> -#define LED_COLOR_ID_MAX    10
>> +#define LED_COLOR_ID_WHITE      0
>> +#define LED_COLOR_ID_RED        1
>> +#define LED_COLOR_ID_YELLOW     2
>> +#define LED_COLOR_ID_BLUE       3
>> +#define LED_COLOR_ID_AMBER      4
>> +#define LED_COLOR_ID_GREEN      5
>> +#define LED_COLOR_ID_VIOLET     6
>> +#define LED_COLOR_ID_PUPRPLE    7
>> +#define LED_COLOR_ID_ORANGE     8
>> +#define LED_COLOR_ID_PINK       9
>> +#define LED_COLOR_ID_CYAN      10
>> +#define LED_COLOR_ID_LIME      11
> 
> All this is a incompatible bindings change, so shortly ABI break. You
> cannot change defines. Feel free to add new ones.
Yep, I realized this the moment I got your message, I was even thinking 
about it, and figured, 'its internal defines, so should be fine' but of 
course, backwards compatibility with old DT's indeed. In hindsight, this 
probably could have been better as a string in the dt itself instead.

I'll re-spin it, which will make the order a bit wonky, but so be it.

Thanks, and sorry.
> 
> Best regards,
> Krzysztof
