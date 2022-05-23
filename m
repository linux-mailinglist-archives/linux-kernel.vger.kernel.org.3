Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281A0531CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbiEWSDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241450AbiEWRfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:35:52 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B14E87236;
        Mon, 23 May 2022 10:29:00 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2f83983782fso156035727b3.6;
        Mon, 23 May 2022 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pu7kA7BiPR6LthJjBkUziE8M6jqnojq51OxPzrVcphU=;
        b=URSiuUGoGO3JCqofa503NBbXZCppX+kd0jyfNgid7GavBJnWTdYTll2AnIYKUZIIDw
         KlRJJxpw0jBP/l/nHc6km/NpvKaj31rx3CIWVaIUcCnmJnSsW9ugJASugudhz6UtdQ28
         +ye8S6RXSMH4S8Ojht13kQhUHt9WSFBDHqvgTti/7ZH4BQPYPpcSlv10wAOGQj19SQVj
         YoApnskHYU5hLpXstzqraqJ432RyS976BFs5KoCIuCQZtaII/1KzgUq4dMhvhfb79RDW
         H2B9SdCPToyIZn83gQBwRK1W8640K96RxgNaeIkF8VPlq4AaLeXIgoCthfJw2/YOVYZT
         Keuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pu7kA7BiPR6LthJjBkUziE8M6jqnojq51OxPzrVcphU=;
        b=REPt84xbAu3UzZWdQBufMoHFlkuov0BTXpYA1gGOpn5UEt6kjdR8XQL4MA8H+w5DRO
         fz+zoSOkCXlEOwGMhAGGt4juxq20/qS6qST0YgazG18kdoNlCvsXy4lgqyUPozVTcztX
         VuoQQT17Wso07G8QzhhIELhcrKLy7U5n0n4pWBABR6Hicistc2uKP2nNSOrIQpXY7Nwj
         hfjp/xKJIjGtbbdHFWDwWEuKU158s+1v2T6nojc1J65e30Y9x1X7L5AT+0cNEBL/Nsiz
         O1mgcRKIQ0OWkoc90rZo6c86Phz9vYycZzX2Q4H+I4Wol5Doae85j07I4z9ePR7wbM9j
         69dA==
X-Gm-Message-State: AOAM533zDlNE0MxhXDCdvZmgo/xa9z/h8JSVoST395aA5CWlXOG1t/DH
        BUJDjzTHAEtbLw6w+pIm9IjbQD7WpMyQTbr5Cvk=
X-Google-Smtp-Source: ABdhPJxDs+59pRGXFmcBcQcFS44LBGAfsQ6rdmIsiuTkv64/aRcW5tYZpKs/8vzNVZV/FX9+JakJXhsg9J3VLCScjeg=
X-Received: by 2002:a0d:c101:0:b0:2ff:5824:e8a8 with SMTP id
 c1-20020a0dc101000000b002ff5824e8a8mr24483755ywd.413.1653326910187; Mon, 23
 May 2022 10:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VeyU4Ox76wz9VfT8qEKHsE1eAo2iw27Lro1tmjJB0npMg@mail.gmail.com>
 <CA+V-a8tp0T=ojr3hB-QacOvV5sCZ29YXspPzKSSpGHUA8_1XDA@mail.gmail.com> <OS0PR01MB5922A0C8F58C5A4221A57F1F86D09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922A0C8F58C5A4221A57F1F86D09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 23 May 2022 18:28:04 +0100
Message-ID: <CA+V-a8vKNBf78mLzu_RJjj-vWMvw7fAdZ=oA1V--UYYcL2FdnA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Renesas RZ/G2L IRQC support
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

Hi Biju,

On Thu, May 19, 2022 at 7:58 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
> > Subject: Re: [PATCH v4 0/7] Renesas RZ/G2L IRQC support
> >
> > On Wed, May 18, 2022 at 10:10 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Wed, May 18, 2022 at 9:29 PM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > The RZ/G2L Interrupt Controller is a front-end for the GIC found on
> > > > Renesas RZ/G2L SoC's with below pins:
> > > > - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI
> > > >   interrupts
> > > > - GPIO pins used as external interrupt input pins out of GPIOINT0-122 a
> > > >   maximum of only 32 can be mapped to 32 GIC SPI interrupts,
> > > > - NMI edge select.
> > > >
> > > >
> > _____________
> > > >                                                              |    GIC
> > |
> > > >                                                              |
> > ________  |
> > > >                                       ____________           | |
> > | |
> > > > NMI --------------------------------->|          |  SPI0-479 | | GIC-
> > 600| |
> > > >              _______                  |          |------------>|
> > | |
> > > >              |      |                 |          |  PPI16-31 | |
> > | |
> > > >              |      | IRQ0-IRQ7       |   IRQC   |------------>|
> > | |
> > > > P0_P48_4 --->| GPIO |---------------->|          |           |
> > |________| |
> > > >              |      |GPIOINT0-122     |          |           |
> > |
> > > >              |      |---------------->| TINT0-31 |           |
> > |
> > > >              |______|                 |__________|
> > |____________|
> > > >
> > > > The proposed patches add hierarchical IRQ domain, one in IRQC driver
> > > > and another in pinctrl driver. Upon interrupt requests map the
> > > > interrupt to GIC. Out of GPIOINT0-122 only 32 can be mapped to GIC
> > > > SPI, this mapping is handled by the pinctrl and IRQC driver.
> > >
> > > Where is the explanation on why valid_mask can't be used instead?
> > >
> > The .valid_mask option is one time setting
>
> One question, if it is one time setting, Is it possible to use .valid mask to invalidate
> invalid gpio lines?(ie, currently gpio range is 392, but there is only 123 GPIOs
> present in the SoC, not sure this call back can be used to invalidate the non-supported GPIOS??).
>
Yes can be added, I will include it in the next version.

Cheers,
Prabhakar
