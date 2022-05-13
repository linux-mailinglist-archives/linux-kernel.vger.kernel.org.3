Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C919B52631D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiEMNvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382017AbiEMNmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:42:32 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349EBBE0B;
        Fri, 13 May 2022 06:42:31 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s30so15350946ybi.8;
        Fri, 13 May 2022 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVSV/AblZY396bQwg7Kf9zjiyu4vW5yj0nxgxQP4FHE=;
        b=eAdM95f+OmqPUQiS4QQN+Xrm6uqyU1Z3OIS2MK/LX6cVyRMbr7bsGedHauH1S1CHtA
         amKUX8lK3zm71J7xJ5V27aX25u+fMqI2ui1e4XthznVQ/0KsZ5HwFjNIgDhR6WH9vR0q
         XtwC4kQhxlpf+5EekYSNi7qfxb1+BJoM3UGeny7PZtKWMURz6F5DObL+v+GB63ulswYs
         8sYPRWUjmzSlwaGifmUbngFzSfeQzpSO+ij2FpxEtEzJ273jALWUzQwrPz+zeM0fJ0VI
         Vb2XzTu6nMUuz+YUVcAzi+AFyWmVnXOFFY6MxVPZ4V7YG8WcLU3Vh65ayPVgQrQl01ig
         bolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVSV/AblZY396bQwg7Kf9zjiyu4vW5yj0nxgxQP4FHE=;
        b=4RKfXyptSO3ZjTBlMYWWhkcwfEo/x24C+ng7/FfOtBcMTHklzUny13UMAjmHlZkFAS
         Ojo/XceoWFYiXUzhkiZNJi80sOlkNUXyhKdd3a4IWyF1KhX1dWkXrdSphS/UGfWee+8K
         oQ1WwGxywCSRKhSbzm+gaTyBqwHG2wtoLa17UuRmyeeajolQi8cfKDqUROcu7pJO/Rdi
         hzXY1q4p5NIsClNrmMMu/fpqJkw14v0DbM6z1W9WsRKeCrlWKk22HCQNj4/2VxemJ2DC
         VGQSN4M9wCBqceH0uG9iMoa5IAVSqhb3zA3nD4sC1PBKJgHP96ctbQwIsqipOvzNn8Hq
         UW+w==
X-Gm-Message-State: AOAM530hoSpRl1nAqRswPvVtpk7VP5ORIKsWLFB6GpzCwS99Cx2AO0uY
        OTBZnEB8SnCIxf7uBXp6aq83v6mqlDcDyXTk8PQ=
X-Google-Smtp-Source: ABdhPJz9dj+JwKYsFAih6d907sBseviSqnt8EC9F4FjmdyzAh6mhMRBcIMwP0v+xpQXJyfnVUGbmrfPqChBBEsQYZYM=
X-Received: by 2002:a25:bfce:0:b0:648:963b:1ccb with SMTP id
 q14-20020a25bfce000000b00648963b1ccbmr5025903ybm.417.1652449350423; Fri, 13
 May 2022 06:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB59221ADFC86483FE2C8765C486CB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s4RfNSXCHG5xo4LhkHw09aj2wFnH0iCDos_ysunV1+5g@mail.gmail.com>
 <OS0PR01MB5922D4C79DE916F5715B610E86CB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59222A7E4DF42FB7557F757886CA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59222A7E4DF42FB7557F757886CA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 13 May 2022 14:42:04 +0100
Message-ID: <CA+V-a8vVSnBb66AbAeg4+U-aSaj5BugGQ0FBTZJNdUnb=C641g@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 7:12 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Biju Das
> > Sent: 12 May 2022 18:59
> > To: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; Geert
> > Uytterhoeven <geert+renesas@glider.be>; Linus Walleij
> > <linus.walleij@linaro.org>; Thomas Gleixner <tglx@linutronix.de>; Marc
> > Zyngier <maz@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> > Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Bartosz Golaszewski
> > <brgl@bgdev.pl>; Philipp Zabel <p.zabel@pengutronix.de>; linux-
> > gpio@vger.kernel.org; linux-kernel@vger.kernel.org; linux-renesas-
> > soc@vger.kernel.org; devicetree@vger.kernel.org; Phil Edworthy
> > <phil.edworthy@renesas.com>
> > Subject: RE: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain
> > to handle GPIO interrupt
> >
> > Hi Prabhakar,
> >
> > > Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ
> > > domain to handle GPIO interrupt
> > >
> > > Hi Biju,
> > >
> > > Thank you for the review.
> > >
> > > On Thu, May 12, 2022 at 6:35 AM Biju Das <biju.das.jz@bp.renesas.com>
> > > wrote:
> > > >
> > > > Hi Prabhakar,
> > > >
> > > > Thanks for the patch.
> > > >
> > > > > Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > Subject: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ
> > > > > domain to handle GPIO interrupt
> > > > >
> > > > > Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.
> > > > >
> > > > > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can
> > > > > be used as IRQ lines at given time. Selection of pins as IRQ lines
> > > > > is handled by IA55 (which is the IRQC block) which sits in between
> > > > > the
> > > GPIO and GIC.
> > > >
> > > > Do we need to update bindings with interrupt-cells on [1] like [2]
> > > > as it
> > > act as parent for GPIO interrupts?
> > > >
> > > Yes interrupt-controller and interrupt-parent needs to be added. I'm
> > > wondering if "interrupt-cells" is not required. If the pin is an
> > > interrupt it will be passed as an GPIO.
> >
> > It is same as external interrupt case right?
> >
> > For eg:- Ethernet PHY case,
> >
> >      interrupt-parent = <&irqc>;
> >      interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> >
> > if you use GPIO, it will be like this right?
> >
> >      interrupt-parent = <&pinctrl>;
> >      interrupts = <RZG2L_GPIO(1, 0) IRQ_TYPE_LEVEL_LOW>;
>
> FYI,
>
> Previously, I have tested ADV HPD interrupt with below changes while investigating [1]
>
> interrupt-parent = <&pinctrl>;
> interrupts = <RZG2L_GPIO(2, 1) IRQ_TYPE_EDGE_FALLING>;
>
Right, #interrupt-cells=<2> , where the first cell is the GPIO pin and
the second cell is the flag.

Cheers,
Prabhakar
