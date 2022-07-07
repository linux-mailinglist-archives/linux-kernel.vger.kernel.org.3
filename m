Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED2056A0D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiGGLGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiGGLGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:06:37 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9959757263;
        Thu,  7 Jul 2022 04:06:36 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5FD652222E;
        Thu,  7 Jul 2022 13:06:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657191994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOMTg61mj0XRuC1mad9Q2m9pvxC3ABs1KCob0GyzqX8=;
        b=jrIS09cKUGk0QfBZuNnmkROuNY8YnPoeHlWjEWzcaUOXGHahRbxuqsliGO6BBSdA9flz0/
        YS0EKKi9NxPfYsp/kb8RtVGBMiIsy6xfizYcLBp53gAQuX8jhibYL75MgF767HTx8WhZ5E
        XtjRpEM7O9HZMbFUSp6YC5vm1rqiF6s=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 07 Jul 2022 13:06:34 +0200
From:   Michael Walle <michael@walle.cc>
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Cristian.Birsan@microchip.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: kswitch-d10: enable the USB device port
In-Reply-To: <326e23f3-5312-0a0d-500c-a51c1e99c5f1@microchip.com>
References: <20220705130637.1386120-1-michael@walle.cc>
 <20220705130637.1386120-2-michael@walle.cc>
 <32a2193f-aea1-6237-a993-d0ba89cce431@microchip.com>
 <1747f5d89ca65a9e54d95e7dd77c4709@walle.cc>
 <326e23f3-5312-0a0d-500c-a51c1e99c5f1@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8dca499e8f1494e7c54308063dd8f790@walle.cc>
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

Am 2022-07-07 11:18, schrieb Claudiu.Beznea@microchip.com:
> On 06.07.2022 11:57, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the
>> content is safe
>> 
>> Hi Claudiu,
>> 
>> Am 2022-07-06 10:41, schrieb Claudiu.Beznea@microchip.com:
>>> On 05.07.2022 16:06, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>>> know
>>>> the content is safe
>>>> 
>>>> Now that there is driver support for the USB device, enable it.
>>>> 
>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>> ---
>>>>  arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>> 
>>>> diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
>>>> b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
>>>> index 5a6c5f7c371a..d0d26e136c38 100644
>>>> --- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
>>>> +++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
>>>> @@ -200,6 +200,11 @@ &switch {
>>>>         status = "okay";
>>>>  };
>>>> 
>>>> +&udc {
>>>> +       atmel,vbus-gpio = <&gpio 66 GPIO_ACTIVE_HIGH>;
>>> 
>>> Can you also add pinctrl to avoid issues described in:
>> 
>> Do I need a pinctrl node even if I just use it as a gpio?
>> Isn't that handled automatically by the
>> .gpio_request_enable op?
> 
> I cannot say for sure.
> 
> Looking a bit though it I think the issue described in commit I pointed 
> may
> come from the fact that struct gpio_chip::request may be
> gpiochip_generic_request() which may return 0 in case
> list_empty(&gc->gpiodev->pin_ranges) is true. The commit that I pointed 
> was
> introduced after commit 2ab73c6d8323 ("gpio: Support GPIO controllers
> without pin-ranges") but I don't have more knowledge on it.
> 

I'll just add it :) Thanks!

-michael
