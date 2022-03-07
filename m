Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFB44CFDA2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbiCGMFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiCGMFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:05:43 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D86EB09;
        Mon,  7 Mar 2022 04:04:48 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DE1A62223A;
        Mon,  7 Mar 2022 13:04:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646654686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nG3Uult3QUrmEBI/29xWk62uJTgK9WBGo1PMeAJ45F8=;
        b=YCgWV+5UVQYW7R0+/OxWFQk9C2NjAxvrmB0LjDT0Iv1x6Fh2XdYhzuBAyuO25xwq5v7zpW
        3znUg7wmgpXhOzQsA9KGdJXXrl2dHFJv+0ph9kOSPcB1LBvG+xqZgeI1dEVGr3QUMDwZpf
        KbPrFlq8dkrDMRcfUaGAo6h+nfo/sDg=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 07 Mar 2022 13:04:45 +0100
From:   Michael Walle <michael@walle.cc>
To:     Claudiu.Beznea@microchip.com
Cc:     Kavyasree.Kotagiri@microchip.com, Nicolas.Ferre@microchip.com,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, alexandre.belloni@bootlin.com
Subject: Re: [PATCH v1 3/6] ARM: dts: lan966x: add all flexcom usart nodes
In-Reply-To: <bf005cd2-4c83-1552-8282-d229eacc51f3@microchip.com>
References: <20220303160323.3316317-1-michael@walle.cc>
 <20220303160323.3316317-4-michael@walle.cc>
 <a33f0c73-df49-5a22-14b3-0059f7d6b827@microchip.com>
 <2e0aefc90a80bdf13df0e59857c52ca7@walle.cc>
 <bf005cd2-4c83-1552-8282-d229eacc51f3@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <219ffd086373c453d5d0aad897cd2d41@walle.cc>
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

Am 2022-03-07 12:53, schrieb Claudiu.Beznea@microchip.com:
> On 04.03.2022 13:01, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the
>> content is safe
>> 
>> Hi,
>> 
>> thanks for the quick review.
>> 
>> Am 2022-03-04 09:30, schrieb Claudiu.Beznea@microchip.com:
>>> On 03.03.2022 18:03, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>>> know
>>>> the content is safe
>>>> 
>>>> Add all the usart nodes for the flexcom block. There was already
>>>> an usart node for the flexcom3 block. But it missed the DMA
>>>> channels.
>>> 
>>> And it would be good to go though a different patch.
>> 
>> sure
>> 
>>>> Although the DMA channels are specified, DMA is not
>>>> enabled by default because break detection doesn't work with DMA.
>>>> 
>>>> Keep the nodes disabled by default.
>>>> 
>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>> ---
>>>>  arch/arm/boot/dts/lan966x.dtsi | 55
>>>> ++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 55 insertions(+)
>>>> 
>>>> diff --git a/arch/arm/boot/dts/lan966x.dtsi
>>>> b/arch/arm/boot/dts/lan966x.dtsi
>>>> index a7d46a2ca058..bea69b6d2749 100644
>>>> --- a/arch/arm/boot/dts/lan966x.dtsi
>>>> +++ b/arch/arm/boot/dts/lan966x.dtsi
>>>> @@ -92,6 +92,19 @@ flx0: flexcom@e0040000 {
>>>>                         #size-cells = <1>;
>>>>                         ranges = <0x0 0xe0040000 0x800>;
>>>>                         status = "disabled";
>>>> +
>>>> +                       usart0: serial@200 {
>>>> +                               compatible =
>>>> "atmel,at91sam9260-usart";
>>> 
>>> Are the usart blocks in lan966x 1:1 compatible with what is is 
>>> sam9260?
>>> In
>>> case not it may worth to have a new compatible here, for lan966x, 
>>> such
>>> that
>>> when new features will be implemented in usart driver for lan966x the
>>> old
>>> DT (this one) will work with the new kernel implementation.
>> 
>> During my review of the inital dtsi patch, I've asked the same 
>> question
>> [1]
>> and I was told they are the same.
>> 
>> At least this exact usart compatible is already in this file. I was
>> under
>> the impression, that was the least controversial compatible :)
> 
> OK.
> 
>> 
>> But you'll need to tell me if they are the same or not, I don't have
>> any clue what microchip has reused.
> 
> From software point of view comparing registers should be good, as far 
> as I
> can tell. All AT91 datasheet should be available. I though you have 
> checked
> one against LAN966. At the moment I don't have a DS for LAN966. I'll 
> find
> one and have a look.

So my train of thought was like: even if the registers are the same I
cannot be sure that it is the exact same IP and will behave the same.
Therefore, it is something only microchip can answer.

You can find the registers at
https://microchip-ung.github.io/lan9668_reginfo/reginfo_LAN9668.html

I'm not aware of any "classic" datasheet.

-michael
