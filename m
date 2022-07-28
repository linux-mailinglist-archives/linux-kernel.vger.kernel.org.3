Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2258658478B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiG1VIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiG1VH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:07:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB60F6D554;
        Thu, 28 Jul 2022 14:07:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sz17so5181115ejc.9;
        Thu, 28 Jul 2022 14:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZXtt/QofZDC7zUBwIWTxL7PY3McEogGdP7WygPZyc0=;
        b=K0WElrLXF9gteDIH0IgTF0SkihqpeO2+7ttRzCUdN6AHdyEYH7EF7ZHQyKGodloZEU
         jREZarlI9W81gfzl9cAahqf8B9KI8HKM5cVHjU2PU05aoCxrtI2SFYl1Izor/FrGwTwN
         8iUJ//j3rKtlMzD5406DgJQR6rKywPaV7hODOxp20dd4Q1R1q111VzTsV7lQg0hBjGZT
         vslGtHmCRWOf6CuydcUfGWzrSncIzOHWcN2y/uRr4y1/n+LPcnny2Pd7M452awo3Y5fD
         Ak+EaZ8pJeJ5krSd0Ub2DJ70kEqAZnR/oAKMDFTHXSYA+XdViuNChTANv23OqkmoreWe
         a4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZXtt/QofZDC7zUBwIWTxL7PY3McEogGdP7WygPZyc0=;
        b=fqLXblvMeNb7P1yxgkRAS2U5BUXzLoh0MQXpwkGGOHC9BEJY6Us5Bspz7iYAb8gqDT
         paDtdnnlFcmSjNI7YF3zHe394SnOr3sHRe7wReuSFwnnCeck66Azq2KF0sgxd5N9jjwh
         R+Wtk9kAyQT8urhSZlZ5BpV9HMckPCRJnrvVBt+XbnmLd6My2JmAh7qYPws8FMqYq9Oh
         KEaCW/WN29KOSa9dGD28STk8WvspZB6Af10BSnLeWkXJUhMpcakt8GnWd8kOZGMH+mct
         C5SFaWH4R1K2gzWcjJU0/zdjZlTaFREGHP5Nxew5g71gNJc8ZsqI8qRly58lqwh7Dt3J
         lUcA==
X-Gm-Message-State: AJIora9diOLZ+TZXnvZEFAshUW7JLggNUS2RZEwlQW2DC64riY/ZLh2J
        7sIYeqwAGdVl4aPMGAso4qOcUAoadPIEweCsCHg=
X-Google-Smtp-Source: AGRyM1vHwsO7bWnYPOgUVw6s/I0ThIB1PnCnsiig6YntbHlaTBXWTNPcvD6bTVITaR8ENfdsYfE1XxnsXSkG13vQLwo=
X-Received: by 2002:a17:907:2722:b0:72b:735a:d3b4 with SMTP id
 d2-20020a170907272200b0072b735ad3b4mr521562ejl.363.1659042477105; Thu, 28 Jul
 2022 14:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220728190810.1290857-1-robh@kernel.org> <CABb+yY2jV7c8oX7=F=nocfvGrOMHJAYov7zS2nT0=qFoNyoxJQ@mail.gmail.com>
In-Reply-To: <CABb+yY2jV7c8oX7=F=nocfvGrOMHJAYov7zS2nT0=qFoNyoxJQ@mail.gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 28 Jul 2022 16:07:45 -0500
Message-ID: <CABb+yY0JzztBB+giBu+RCt-dzgwYWF32sCR3WKKP9U5K9UvhxA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mailbox: arm,mhu: Make secure interrupt optional
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

On Thu, Jul 28, 2022 at 3:17 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> On Thu, Jul 28, 2022 at 2:08 PM Rob Herring <robh@kernel.org> wrote:
> >
> > The secure interrupt is only useful to secure world, therefore for NS
> > users it shouldn't be required. Make it optional.
> >
> > This fixes a warning on Arm Juno board:
> >
> > mhu@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4]] is too short
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mailbox/arm,mhu.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > index bd49c201477d..d9a4f4a02d7c 100644
> > --- a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > +++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > @@ -57,6 +57,7 @@ properties:
> >      maxItems: 1
> >
> >    interrupts:
> > +    minItems: 2
> >      items:
> >        - description: low-priority non-secure
> >        - description: high-priority non-secure
> >
> Do we also want to specify that only the secure-irq is optional
> because irqs are directly mapped onto channels in the driver, and only
> omitting the secure (last) irq will work.
>
I could learn why specifying secure irq isn't desirable?
No non-secure client node would ask for that secure irq/channel, which
will simply lay unused.

The programming of the secure channel doesn't care if the mode is
indeed secure. It all relies on providing accurate information in the
device tree :- the controller provides secure and non-secure channels
but only non-secure channels are _used_ in non-secure mode.

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi
b/arch/arm64/boot/dts/arm/juno-base.dtsi
index f6c55877fbd94..004b1566be74d 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -26,7 +26,8 @@ mailbox: mhu@2b1f0000 {
        compatible = "arm,mhu", "arm,primecell";
        reg = <0x0 0x2b1f0000 0x0 0x1000>;
        interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
-                <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+                <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+                <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-names = "mhu_lpri_rx",
                  "mhu_hpri_rx";
        #mbox-cells = <1>;

If this works for you, I could submit a proper patch.

thanks.
