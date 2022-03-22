Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A5D4E4863
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiCVVkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbiCVVkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:40:41 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9D95E747;
        Tue, 22 Mar 2022 14:39:10 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D984422205;
        Tue, 22 Mar 2022 22:39:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647985148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4r6vLaven55dK5umy3WWTE/9sCNUfcL0n7ze3I+7DM=;
        b=ctAGNtYfe8CwjY/aTkifNRWAwYZy8sRj6XRwTET4GJv47XFDI1JT3Ms31A9dLRq09wGtPg
        JptzSQE/WfiU+5hcXkZ9e1AW9hGGKTNlF0W7qSkPYYdgLcnh+kUbaR8n2P47o+KQfHmCAR
        1b2bUtWP+H5SGkLgXF8A9QsvGv/LbWI=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 22 Mar 2022 22:39:07 +0100
From:   Michael Walle <michael@walle.cc>
To:     Claudiu.Beznea@microchip.com
Cc:     Kavyasree.Kotagiri@microchip.com, Nicolas.Ferre@microchip.com,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, alexandre.belloni@bootlin.com
Subject: Re: [PATCH v1 3/6] ARM: dts: lan966x: add all flexcom usart nodes
In-Reply-To: <3e17aa8b-f6e5-e2c1-bd1d-8950d23c3e49@microchip.com>
References: <20220303160323.3316317-1-michael@walle.cc>
 <20220303160323.3316317-4-michael@walle.cc>
 <a33f0c73-df49-5a22-14b3-0059f7d6b827@microchip.com>
 <2e0aefc90a80bdf13df0e59857c52ca7@walle.cc>
 <bf005cd2-4c83-1552-8282-d229eacc51f3@microchip.com>
 <219ffd086373c453d5d0aad897cd2d41@walle.cc>
 <3e17aa8b-f6e5-e2c1-bd1d-8950d23c3e49@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d7d17a2156a9591ad4c19ef912189a98@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-03-18 13:17, schrieb Claudiu.Beznea@microchip.com:
> On 07.03.2022 14:04, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the
>> content is safe
>> 
>> Am 2022-03-07 12:53, schrieb Claudiu.Beznea@microchip.com:
>>> On 04.03.2022 13:01, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>>> know
>>>> the
>>>> content is safe
>>>> 
>>>> Hi,
>>>> 
>>>> thanks for the quick review.
>>>> 
>>>> Am 2022-03-04 09:30, schrieb Claudiu.Beznea@microchip.com:
>>>>> On 03.03.2022 18:03, Michael Walle wrote:
>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>>>> know
>>>>>> the content is safe
>>>>>> 
>>>>>> Add all the usart nodes for the flexcom block. There was already
>>>>>> an usart node for the flexcom3 block. But it missed the DMA
>>>>>> channels.
>>>>> 
>>>>> And it would be good to go though a different patch.
>>>> 
>>>> sure
>>>> 
>>>>>> Although the DMA channels are specified, DMA is not
>>>>>> enabled by default because break detection doesn't work with DMA.
>>>>>> 
>>>>>> Keep the nodes disabled by default.
>>>>>> 
>>>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>>>> ---
>>>>>>  arch/arm/boot/dts/lan966x.dtsi | 55
>>>>>> ++++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 55 insertions(+)
>>>>>> 
>>>>>> diff --git a/arch/arm/boot/dts/lan966x.dtsi
>>>>>> b/arch/arm/boot/dts/lan966x.dtsi
>>>>>> index a7d46a2ca058..bea69b6d2749 100644
>>>>>> --- a/arch/arm/boot/dts/lan966x.dtsi
>>>>>> +++ b/arch/arm/boot/dts/lan966x.dtsi
>>>>>> @@ -92,6 +92,19 @@ flx0: flexcom@e0040000 {
>>>>>>                         #size-cells = <1>;
>>>>>>                         ranges = <0x0 0xe0040000 0x800>;
>>>>>>                         status = "disabled";
>>>>>> +
>>>>>> +                       usart0: serial@200 {
>>>>>> +                               compatible =
>>>>>> "atmel,at91sam9260-usart";
>>>>> 
>>>>> Are the usart blocks in lan966x 1:1 compatible with what is is
>>>>> sam9260?
>>>>> In
>>>>> case not it may worth to have a new compatible here, for lan966x,
>>>>> such
>>>>> that
>>>>> when new features will be implemented in usart driver for lan966x 
>>>>> the
>>>>> old
>>>>> DT (this one) will work with the new kernel implementation.
>>>> 
>>>> During my review of the inital dtsi patch, I've asked the same
>>>> question
>>>> [1]
>>>> and I was told they are the same.
>>>> 
>>>> At least this exact usart compatible is already in this file. I was
>>>> under
>>>> the impression, that was the least controversial compatible :)
>>> 
>>> OK.
>>> 
>>>> 
>>>> But you'll need to tell me if they are the same or not, I don't have
>>>> any clue what microchip has reused.
>>> 
>>> From software point of view comparing registers should be good, as 
>>> far
>>> as I
>>> can tell. All AT91 datasheet should be available. I though you have
>>> checked
>>> one against LAN966. At the moment I don't have a DS for LAN966. I'll
>>> find
>>> one and have a look.
>> 
>> So my train of thought was like: even if the registers are the same I
>> cannot be sure that it is the exact same IP and will behave the same.
>> Therefore, it is something only microchip can answer.
>> 
>> You can find the registers at
>> https://microchip-ung.github.io/lan9668_reginfo/reginfo_LAN9668.html
>> 
>> I'm not aware of any "classic" datasheet.
> 
> You can find all AT91 datasheet on Microchip web site [1].
> 
> Simple register comparison b/w register mapping at [2] and SAMA5D2
> datasheet [3] (which uses the same compatible),  SAM9X60 datasheet [3] 
> and
> SAMA7G5 datasheet (not public at the moment) brings up a difference at
> register FLEX_US_CR (bits 16, 17) which are not available on SAMA5D2,
> SAM9X60 or SAMA7G5. Unless this is a mistake on documentation at [2] I 
> say
> it needs a new compatible.

I can't follow you here. These bits are already used in the current UART
driver and are supported on the LAN966X. So if anything, SAMA5D2, 
SAM9X60
and SAMA7G5 need a new compatible, no?

-michael

> Kavya, could you confirm this?
> 
> Thank you,
> Claudiu Beznea
> 
> [1] https://www.microchip.com/
> [2] 
> https://microchip-ung.github.io/lan9668_reginfo/reginfo_LAN9668.html
> [3] 
> http://ww1.microchip.com/downloads/en/devicedoc/ds60001476b.pdf#G22.2193277
> [4]
> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAM9X60-Data-Sheet-DS60001579E.pdf
> 
>> 
>> -michael
