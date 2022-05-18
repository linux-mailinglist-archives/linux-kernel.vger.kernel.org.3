Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058C952B36E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiERHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiERHLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:11:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD7C562D9;
        Wed, 18 May 2022 00:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB1C061015;
        Wed, 18 May 2022 07:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251FBC385AA;
        Wed, 18 May 2022 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652857910;
        bh=xDbFE0Spprs2U7YdvsBPOl3T/7s5OHB5kC9BUHYJM5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fVjUbeFnVy0czhU9IiRCJ6R9/fkwFedj0n94TbXUjcx3oKtrPLYYdjMOtD6mNQl19
         pToz0TS63rzpTYOBrWbAQbJl+70nW7wcMozQ0gHRFu7CFSScBNEz+vpEpFnPd5yFQj
         +cfnk3MUCan9Vat9EkyUFdRTm6dnUqCaO+17Xm6Kp0V2hHYrpXMFE3mtKsBeITDwfH
         QpZ1/qrzDnPHD+T7JNaCODO495SnPwL1fDaI5X12Dgd037sdFLfdFXiv86b0RfpfJ1
         uKxqF7qfOKQZ80+CdlaikAQujCMinn6+tMY2NYwmBfjqiNH2DjV9NCzgRlVzz1Xqu2
         B3o1+CNKCCgbQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nrDqV-00C64y-97; Wed, 18 May 2022 08:11:47 +0100
MIME-Version: 1.0
Date:   Wed, 18 May 2022 08:11:47 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr,
        vadym.kochan@plvision.eu, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
In-Reply-To: <1b29abc6-7428-1528-864f-2a246332f72b@alliedtelesis.co.nz>
References: <20220512042501.3339775-1-chris.packham@alliedtelesis.co.nz>
 <20220512042501.3339775-3-chris.packham@alliedtelesis.co.nz>
 <87wnermc9c.wl-maz@kernel.org>
 <5c01f20a-acd3-da15-081d-7cf878f8a77a@alliedtelesis.co.nz>
 <a69eaf73-8c3c-dfd7-16e5-70460c68877e@alliedtelesis.co.nz>
 <87mtfh6c58.wl-maz@kernel.org>
 <db5c3366-ac81-261b-ff32-3ccf94a930f6@alliedtelesis.co.nz>
 <87mtfgmzgx.wl-maz@kernel.org>
 <1b29abc6-7428-1528-864f-2a246332f72b@alliedtelesis.co.nz>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <157c3bb57a0cf5e153b9b98fb42bad06@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Chris.Packham@alliedtelesis.co.nz, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, kostap@marvell.com, robert.marko@sartura.hr, vadym.kochan@plvision.eu, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-17 23:56, Chris Packham wrote:
> On 17/05/22 18:42, Marc Zyngier wrote:
>> On Mon, 16 May 2022 22:56:44 +0100,
>> Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:
>>>>>>> Please fix your firmware to program CNTFRQ_EL0, and
>>>>>>> remove this useless property.
>>>>>> I'm kind of at the mercy of what Marvell have provided for ATF. I 
>>>>>> am
>>>>>> working on the bootloader portion in parallel and am getting 
>>>>>> things
>>>>>> ready for submitting the u-boot support upstream. I was hoping to
>>>>>> leave ATF alone I can at least see if they haven't fixed this 
>>>>>> already
>>>>>> (the original dtsi I started with was fairly old) and if they 
>>>>>> haven't
>>>>>> I'll raise it via their support system.
>>>>> Seems to work fine without the clock so I'll drop it.
>>>> Thanks. If you can, please verify that this is set on both CPUs (I
>>>> have seen plenty of firmware only setting it on CPU0 in the past).
>>> The arch_timer interrupts are counting up on both CPUs and things
>>> generally seem to be getting scheduled (I don't have much of a 
>>> userland
>>> at the moment so it's not exactly a stress test). Do you think that 
>>> is
>>> sufficient to say the clock property is unnecessary and whatever
>>> firmware I have is working as expected.
>> No, the counter always count, and CNTFRQ_EL0 is only an indication of
>> the frequency for SW to find out. You can directly read CNTFRQ_EL0
>> from userspace on each CPU and find whether they have the same value.
> 
> Here's my test program
> 
> $ cat CNTFRQ_EL0.c
> #include <stdio.h>
> #include <stdint.h>
> #include <inttypes.h>
> 
> int main(int argc, char *argv[])
> {
>          uint64_t val;
> 
>          asm volatile("mrs %0, CNTFRQ_EL0" : "=r" (val));
>          printf("CNTFRQ_EL0 = %" PRIu64 "\n", val);
> 
>          return 0;
> }
> 
> And running on the RD-AC5X board
> 
> [root@linuxbox tmp]# taskset 0x1 ./CNTFRQ_EL0
> CNTFRQ_EL0 = 25000000
> [root@linuxbox tmp]# taskset 0x2 ./CNTFRQ_EL0
> CNTFRQ_EL0 = 25000000

Great. So the DT attribute was only cargo-culted by MRVL,
and they don't realise what that's for...

Thanks for going the extra mile and checking this!

> 
>> 
>>>>>>> You are also missing a PPI for the EL2 virtual timer which is 
>>>>>>> present
>>>>>>> on any ARMv8.1+ CPU (and since this system is using A55, it 
>>>>>>> definitely
>>>>>>> has it).
>>>>>>> 
>>>>>>> [...]
>>>>>> Will add.
>>>>> I assume you're talking about the 5th PPI per the
>>>>> timer/arm,arch_timer.yaml ("hypervisor virtual timer irq").
>>>> Indeed.
>>>> 
>>>>> Helpfully
>>>>> Marvell don't include the PPI interrupt numbers in their datasheet. 
>>>>> But
>>>>> then I also notice that none of the other boards that have a
>>>>> "arm,armv8-timer" provide a 5th interrupt either, have I 
>>>>> misunderstood
>>>>> something?
>>>> This was only recently added to the DT binding, but the interrupt
>>>> definitely exist at the CPU level for anything that implements 
>>>> ARMv8.1
>>>> and up. AFAIK, the M1 is the only machine to expose this interrupt 
>>>> in
>>>> DT, but this doesn't mean the interrupt doesn't exist on all the 
>>>> other
>>>> systems that have the same architecture revision.
>>>> 
>>>> If you have contacts in Marvell, maybe try and find out whether they
>>>> have simply decided not to wire the interrupt (I wouldn't be
>>>> surprised). In this case, please add a comment.
>>> I've reached out via their customer support portal. So far they just
>>> want to know why I'm refusing to use their out of date SDK (maybe I
>>> should direct them at some of Jon Corbet's presentations :P).
>> The fact that they are asking is already saying everything there is to
>> know, sadly...
>> 
>>> These integrated chips are sometimes a bit problematic because the
>>> support goes via the Switching group but these questions are really
>>> about IP blocks that have been taken from the SoC group. It may take 
>>> a
>>> while before I get a response from someone that actually knows the
>>> internals.
>> Fair enough. Until then, please drop a comment in the DT indicating
>> that the fate of this PPI is unknown. If you eventually find out, just
>> add it to the DT (it is easy to add things, much harder to remove
>> them).
> 
> I'll include the following in the next round
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-98dx25xx.dtsi
> b/arch/arm64/boot/dts/marvell/armada-98dx25xx.dtsi
> index 88edc741c008..7a3693a2ad04 100644
> --- a/arch/arm64/boot/dts/marvell/armada-98dx25xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-98dx25xx.dtsi
> @@ -63,6 +63,7 @@ timer {
>                               <GIC_PPI 8 IRQ_TYPE_LEVEL_HIGH>,
>                               <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>,
>                               <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +                            /* PPI for EL2 virtual timer is 
> undocumented */
>          };
> 
>          pmu {

Looks good, thank you.

         M.
-- 
Jazz is not dead. It just smells funny...
