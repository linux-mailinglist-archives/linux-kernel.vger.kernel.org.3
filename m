Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E909D58573F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 01:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbiG2XRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 19:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiG2XRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 19:17:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1106948EB6;
        Fri, 29 Jul 2022 16:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCE28B829E0;
        Fri, 29 Jul 2022 23:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B326C43470;
        Fri, 29 Jul 2022 23:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659136659;
        bh=AWtNU1BuOPWuDZZMj03bU56kICItzf4P/swp+T/7PYU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kVg02aonFnSNV2V0ejVRK5UL+W+k5arMXtZ2VItlsph0dFNLzJT8WUhKoAcpmkxiN
         eHp/WzrUCxSzK6yUBHM3YeaMIpkvvyHxAl+ZJfnFtI5r+X9sEBCCqLkalC27o7iI6C
         ikVtvaBa25JvAoKxcLLVYcrX/ay5msDo+69TBst4ic3ikl2/OC9RpnBcbtt8spYGqT
         atmI6eyxPiFOAKHmWU9/xOy1EPn9Lp6gZxDmhG0+mjDegI8GunlA3mbwbqs9UQ2fk7
         xAnsA0/y8mdoDzOeI2vLUOIhK62HnjXw1UJEpyul9eiHzbwRnP8DuBXScNSA+PlX+E
         b8YP/w/AL+Q5A==
Received: by mail-ua1-f52.google.com with SMTP id y22so2206927uay.1;
        Fri, 29 Jul 2022 16:17:39 -0700 (PDT)
X-Gm-Message-State: ACgBeo03IK9MBisnKqJyhitdvt+avyKwDmA/Xew8eORnv3isllFW9c2Y
        pMsyz6QXWXc8RW5AUZVN5l3JYA3ZivlJcVHSLQ==
X-Google-Smtp-Source: AA6agR5OBLe8TV5PHMPmDU9mV4CF7EG/t08Z8OOg3bkxFNj40oxmxovmQJx+tRkW+2cSPfG7372Fk6KrjONetwVjBmQ=
X-Received: by 2002:ab0:2505:0:b0:384:cc62:9a75 with SMTP id
 j5-20020ab02505000000b00384cc629a75mr2389355uan.36.1659136658061; Fri, 29 Jul
 2022 16:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220728190810.1290857-1-robh@kernel.org> <CABb+yY2jV7c8oX7=F=nocfvGrOMHJAYov7zS2nT0=qFoNyoxJQ@mail.gmail.com>
 <CABb+yY0JzztBB+giBu+RCt-dzgwYWF32sCR3WKKP9U5K9UvhxA@mail.gmail.com> <20220729111051.5me4vklrzskvsj4w@bogus>
In-Reply-To: <20220729111051.5me4vklrzskvsj4w@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 29 Jul 2022 17:17:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLwk+=CeDWqXzhrVESzhJnNjOjyR-TtisKGgjMUi7TivQ@mail.gmail.com>
Message-ID: <CAL_JsqLwk+=CeDWqXzhrVESzhJnNjOjyR-TtisKGgjMUi7TivQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mailbox: arm,mhu: Make secure interrupt optional
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 5:10 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jul 28, 2022 at 04:07:45PM -0500, Jassi Brar wrote:
> > On Thu, Jul 28, 2022 at 3:17 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> > >
> > > On Thu, Jul 28, 2022 at 2:08 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > The secure interrupt is only useful to secure world, therefore for NS
> > > > users it shouldn't be required. Make it optional.
> > > >
> > > > This fixes a warning on Arm Juno board:
> > > >
> > > > mhu@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4]] is too short
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/mailbox/arm,mhu.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > > > index bd49c201477d..d9a4f4a02d7c 100644
> > > > --- a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > > > +++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > > > @@ -57,6 +57,7 @@ properties:
> > > >      maxItems: 1
> > > >
> > > >    interrupts:
> > > > +    minItems: 2
> > > >      items:
> > > >        - description: low-priority non-secure
> > > >        - description: high-priority non-secure
> > > >
> > > Do we also want to specify that only the secure-irq is optional
> > > because irqs are directly mapped onto channels in the driver, and only
> > > omitting the secure (last) irq will work.
> > >
> > I could learn why specifying secure irq isn't desirable?
> > No non-secure client node would ask for that secure irq/channel, which
> > will simply lay unused.
> >
>
> Did you mean would or wouldn't ?
>
> Anyways I can insert a module that requests this channel and bring down
> the system as accessing anything configure secure from non-secure side
> on Juno results in system hang/error.
>
> > The programming of the secure channel doesn't care if the mode is
> > indeed secure. It all relies on providing accurate information in the
> > device tree :- the controller provides secure and non-secure channels
> > but only non-secure channels are _used_ in non-secure mode.
> >
>
> In general w.r.t the MHU IP may be yes. But if the secure side configures
> it as secure only and claims the channel which is the case on Juno, any
> attempt to access the same from non-secure side is fatal.
>
> > index f6c55877fbd94..004b1566be74d 100644
> > --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> > +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> > @@ -26,7 +26,8 @@ mailbox: mhu@2b1f0000 {
> >         compatible = "arm,mhu", "arm,primecell";
> >         reg = <0x0 0x2b1f0000 0x0 0x1000>;
> >         interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> > -                <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> > +                <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
> > +                <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> >         interrupt-names = "mhu_lpri_rx",
> >                   "mhu_hpri_rx";

Missing name.

> >         #mbox-cells = <1>;
> >
> > If this works for you, I could submit a proper patch.
> >
>
> No this doesn't work IMO. Yes standalone everything looks fine, but you can
> insert a module requesting this channel and bring down the system. So I am
> not for this change.

Not having the interrupt listed in DT doesn't prevent that. Is this
security by obscurity?

I don't really care which way this is fixed though. I just want the
warning gone. We've all got better things to worry about. The DT not
having the interrupt has been that way for years (presumably) and the
kernel never needs the interrupt, so the schema should reflect
reality. On the flip side, considering it *can* be present already,
there's not really much argument for not having it.

Rob
