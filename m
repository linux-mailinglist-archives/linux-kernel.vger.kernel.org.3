Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE1585236
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiG2PSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiG2PSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:18:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A491A459B6;
        Fri, 29 Jul 2022 08:18:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l23so9082186ejr.5;
        Fri, 29 Jul 2022 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+O4lYrHKgUVBwG7qSHfHs7iGGU+8cpiows8bQnp47A=;
        b=iveYsw9mfb3TzlP217SkKdM8vhrxKjUYrNfzgYbuYBUXSGtrXzXcXsNxrjWQOWj8lF
         pk4i1Y1W3nMdxvvxLqvuwLn3ExoJdomPX4ptRDy6molLoNo3afguxqLSuIKyfdFaw7dN
         21wXn65Hi2DRNdStp4I9KcH0pkYh/QUpj8Yi6oJ3ZBkGvPHDO3jNHm/Hf75xAz+5/75c
         XTPAzEirzqP333zWg7zi4N+PTpIQzHMw8AiwVonscJzWPRN1HV6zup32hSIzeDy00iEN
         YHSdpEdKKdQphUiUeC+tDxTymqeN9geL4w82qSMt+SiYyxo2IGE4FgTbIONM5GtYqd4C
         hDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+O4lYrHKgUVBwG7qSHfHs7iGGU+8cpiows8bQnp47A=;
        b=20z88Uc47dgOYIDaGCztv7SMscZp4n7fMs6JV+BlstWMQS0qFisK442iI8d7lCJ12T
         pqOsjKHgeQ9N785u8FGk3Pz8vd9zXsFpALEplO/GOfBj5KBFEvwLFrMm+v1WpuSo/eO4
         ArmMx7fzI46wRR0N0XJFYf0UPaedEqBc18LCpv7GOMgwl+oFYk0PjDyRi1p/fZ66lk3Y
         VPYAaunoCZA4/mccGohI5liGaz+Vor39RlxlHH58VBYjWHZWep/ULNrLO8hpwVXHVWtZ
         K4aKDAga1SKXPSRvAujzuIyApZT0LnzrMaYWez1FSW/LMR5Y/g4ToN9jmsW6IU0CxYy3
         GrnA==
X-Gm-Message-State: AJIora8oACBawbQlRzIGD541VLgo2IL7GTkDe+HBmnn2dor/vCh7iJFo
        YsOjp4hMJoM5BoaAQBZBgx0f7gxXNObTvxXc7M2o/zLFZIU=
X-Google-Smtp-Source: AGRyM1vvb6+mchGfXjJRTp1+ZGCw0IVKg00+3XBmmlF9Pb4aCHqrZLOxWAB0WyiGzDvJXgA99OQomfsv0OGHwMOaoTw=
X-Received: by 2002:a17:907:2722:b0:72b:735a:d3b4 with SMTP id
 d2-20020a170907272200b0072b735ad3b4mr3180478ejl.363.1659107895813; Fri, 29
 Jul 2022 08:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220728190810.1290857-1-robh@kernel.org> <CABb+yY2jV7c8oX7=F=nocfvGrOMHJAYov7zS2nT0=qFoNyoxJQ@mail.gmail.com>
 <CABb+yY0JzztBB+giBu+RCt-dzgwYWF32sCR3WKKP9U5K9UvhxA@mail.gmail.com> <20220729111051.5me4vklrzskvsj4w@bogus>
In-Reply-To: <20220729111051.5me4vklrzskvsj4w@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 29 Jul 2022 10:18:04 -0500
Message-ID: <CABb+yY1=cppy9QAN=cLWmhvmYrQ5QpY5adE+nRev1rVrtp-QUw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mailbox: arm,mhu: Make secure interrupt optional
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 6:10 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Thu, Jul 28, 2022 at 04:07:45PM -0500, Jassi Brar wrote:

> > >
> > I could learn why specifying secure irq isn't desirable?
> > No non-secure client node would ask for that secure irq/channel, which
> > will simply lay unused.
>
> Did you mean would or wouldn't ?
>
I mean what's written.

> Anyways I can insert a module that requests this channel and bring down
> the system as accessing anything configure secure from non-secure side
> on Juno results in system hang/error.
>
Why go to those lengths? These are already simpler options available  ;-)
1)   while (1) ;      // preferably in some atomic context
2)   *((int *) 0) = 0;   // you might want to iterate over offset for
guaranteed results
3) Slightly more work, but you also have the opportunity to erase your
storage device


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
> >         #mbox-cells = <1>;
> >
> > If this works for you, I could submit a proper patch.
>
> No this doesn't work IMO.
>
If you _really_ tested and faced an error, please share it.

> Yes standalone everything looks fine, but you can
> insert a module requesting this channel and bring down the system.
>
If anyone other than a super-user is able to do that, then you have a
serious security problem at hand.
If you do that as a super-user, have fun.

cheers.
