Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A312750BFA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiDVSIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiDVSF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:05:59 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A921183B0;
        Fri, 22 Apr 2022 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650650029; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36SBTaNp7dcTwurtvjqe7McQ+kB/vBW59yh6tlX/7i8=;
        b=BPNDxQt/o50fWYfoDGVkwMu81csPM+9pmWJwPV3spGu9npSLkECl3pJuHungufYWLRFOC7
        5Nrr0lLYcWZUeG4e+7vJR9j1YAGDLBrQ9UG1WEGQiiMjBhUN7BGGOEV/cwIpPYvSAXhIZV
        CQWPYwr4aCSh1qE2gE3q4eszxbJPM8Y=
Date:   Fri, 22 Apr 2022 18:53:39 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/2] mips: dts: ingenic: x1000: Add PWM device tree
 node
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, robh+dt@kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Message-Id: <FP5RAR.CXCRD56PL7G72@crapouillou.net>
In-Reply-To: <YmLT1VA8ZL57CQkO@orome>
References: <20220224234133.15708-1-aidanmacdonald.0x0@gmail.com>
        <20220224234133.15708-2-aidanmacdonald.0x0@gmail.com>
        <YmLT1VA8ZL57CQkO@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Le ven., avril 22 2022 at 18:12:05 +0200, Thierry Reding=20
<thierry.reding@gmail.com> a =E9crit :
> On Thu, Feb 24, 2022 at 11:41:34PM +0000, Aidan MacDonald wrote:
>>  Copied from the jz4740 devicetree and trimmed to 5 timers, which
>>  is what the hardware supports.
>>=20
>>  Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>  ---
>>   arch/mips/boot/dts/ingenic/x1000.dtsi | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>=20
> However I don't see this upstream yet, neither in Linus' tree nor in
> linux-next. Paul, do you still have this on your radar?

I don't have a tree so that would be a patch for Thomas (Cc'd) to go=20
through the linux-mips tree.
(Note to Thomas: patch 1 is already applied in the pwm tree)

The changes look good though, so:

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

>=20
> Thierry
>=20
>>=20
>>  diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi=20
>> b/arch/mips/boot/dts/ingenic/x1000.dtsi
>>  index 8bd27edef216..0dcf37527c8e 100644
>>  --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
>>  +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
>>  @@ -127,6 +127,19 @@ wdt: watchdog@0 {
>>   			clocks =3D <&tcu TCU_CLK_WDT>;
>>   			clock-names =3D "wdt";
>>   		};
>>  +
>>  +		pwm: pwm@40 {
>>  +			compatible =3D "ingenic,x1000-pwm";
>>  +			reg =3D <0x40 0x80>;
>>  +
>>  +			#pwm-cells =3D <3>;
>>  +
>>  +			clocks =3D <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>,
>>  +				 <&tcu TCU_CLK_TIMER2>, <&tcu TCU_CLK_TIMER3>,
>>  +				 <&tcu TCU_CLK_TIMER4>;
>>  +			clock-names =3D "timer0", "timer1", "timer2",
>>  +				      "timer3", "timer4";
>>  +		};
>>   	};
>>=20
>>   	rtc: rtc@10003000 {
>>  --
>>  2.34.1
>>=20


