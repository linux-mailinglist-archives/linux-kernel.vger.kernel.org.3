Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF515456E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbiFIWF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiFIWFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:05:55 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BF91D059C;
        Thu,  9 Jun 2022 15:05:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a29so11549353lfk.2;
        Thu, 09 Jun 2022 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOeHCffuV372EbJXAYWc/lviqk7m6s/B+ydWROpp37s=;
        b=nCCM3BYBo1+7MEh4dfZOwenYdW3FdWjxsgv0yqDIpz9VV3iFdKqqcT00GD7EC0hZay
         3QMWDJXYWNQ9HCybQLI9lfWaWAiZFNjbpvzve6zDHuom4tCwgXPC/bW9taWPqGsyB9qd
         tiOaz3FIOeHK+uXvxUhenwDmUMtHtvlz3xooBJXgVugDjjDyp5gNYA39v+tmNuxeID7j
         c5b5ZCy5ykaWSUUnZx03vmUrGjGqpiKJ8C7yiZrrsKZ0SrLoRWIFbx68VOWNiHCstLlk
         9OejSi/eQlTUVksoTRA9P9PRejjYjAm9G+veXGtX+vrlSGEIIPfnNdFxMVtqZhJs34Io
         F2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOeHCffuV372EbJXAYWc/lviqk7m6s/B+ydWROpp37s=;
        b=5oMhJ+7zjss90cJQ9U1Az1smL7ggOBYZWe7327qciOYS+EQWhWcQgUSgkqj5pY8hrW
         Yn7bpkbe8Srsxjd8uzQnh2X7CQXD6wdmUKiFouuMkD9YBzhvqFKmvPXurlawaOuscurh
         cUSErPfclBXaehUNfwmPbbqYHvJb986coRcJWnB6G1yp9/26nV7lqfe5gExfF+K9w6X2
         BsMbHeEDqKazJ9llENxyD3Y2vgU7qxZTqdfHV/CFTMqfGTHg+3bBFSvT+3nNa2IShRxN
         dOecFFOIttubxrsfvPihUGzR6ajOXqlQ6ZmBWUahNwxs+0QLvr+1iXrZtj5WHWlC5KEw
         qvyA==
X-Gm-Message-State: AOAM532VbvwzBP5W4bJmIdwVlqSIOFc3yb+2mAZQZCegxyzAMYt5WAJU
        AbCEKrCB7snqVJ+z6dX3bCl3UIhApNgdOnQFDlQ=
X-Google-Smtp-Source: ABdhPJy7HQGPzX29VtP/5HICmZcW/yT7cNfN6mgrWFgHKY8Ie6tmKsatLiQzneX/RfDiiTH3JWNsiJND+Hk6+CN6iso=
X-Received: by 2002:a05:6512:128a:b0:479:2f81:1c4f with SMTP id
 u10-20020a056512128a00b004792f811c4fmr17508569lfs.668.1654812351083; Thu, 09
 Jun 2022 15:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-13-tmaimon77@gmail.com>
 <add025b6-c622-b204-d39e-67b31878d37f@linaro.org>
In-Reply-To: <add025b6-c622-b204-d39e-67b31878d37f@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Fri, 10 Jun 2022 01:05:40 +0300
Message-ID: <CAP6Zq1iDbB+X5QPE4Nsqk4nV41bZiVzQZExS1pQTuKEBz-iYew@mail.gmail.com>
Subject: Re: [PATCH v2 12/20] dt-bindings: reset: npcm: Add support for NPCM8XX
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Sorry, but I thought the fix is only to add an explanation to the
dt-binding file as was done in V2.

The NPCM8XX binding is done in the same way as the NPCM7XX and both
use the same reset driver and use the same reset method in upstreamed
NPCM reset driver.

Can you please explain again what you suggest to do?


On Wed, 8 Jun 2022 at 13:11, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/06/2022 11:56, Tomer Maimon wrote:
> > Add binding document and device tree binding
> > constants for Nuvoton BMC NPCM8XX reset controller.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../bindings/reset/nuvoton,npcm-reset.yaml    |  13 +-
> >  .../dt-bindings/reset/nuvoton,npcm8xx-reset.h | 128 ++++++++++++++++++
> >  2 files changed, 140 insertions(+), 1 deletion(-)
> >  create mode 100644 include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
> >
> > diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
> > index c6bbc1589ab9..93ea81686f58 100644
> > --- a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
> > +++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
> > @@ -9,9 +9,20 @@ title: Nuvoton NPCM Reset controller
> >  maintainers:
> >    - Tomer Maimon <tmaimon77@gmail.com>
> >
> > +description: |
> > +  The NPCM reset controller used to reset various set of peripherals.
> > +  Please refer to reset.txt in this directory for common reset
> > +  controller binding usage.
> > +
> > +  For list of all valid reset indices see
> > +    <dt-bindings/reset/nuvoton,npcm7xx-reset.h> for Poleg NPCM7XX SoC,
> > +    <dt-bindings/reset/nuvoton,npcm8xx-reset.h> for Arbel NPCM8XX SoC.
> > +
> >  properties:
> >    compatible:
> > -    const: nuvoton,npcm750-reset
> > +    enum:
> > +      - nuvoton,npcm750-reset        # Poleg NPCM7XX SoC
> > +      - nuvoton,npcm845-reset        # Arbel NPCM8XX SoC
> >
> >    reg:
> >      maxItems: 1
> > diff --git a/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
> > new file mode 100644
> > index 000000000000..5b3b74534b50
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
> > @@ -0,0 +1,128 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
>
> Again - ignored comment from v1.
>
> > +/*
> > + * Copyright (c) 2022 Nuvoton Technology corporation.
> > + * Author: Tomer Maimon <tmaimon77@gmail.com>
> > + */
> > +
> > +#ifndef _DT_BINDINGS_NPCM8XX_RESET_H
> > +#define _DT_BINDINGS_NPCM8XX_RESET_H
> > +
> > +/* represent reset register offset */
> > +#define NPCM8XX_RESET_IPSRST1                0x20
> > +#define NPCM8XX_RESET_IPSRST2                0x24
> > +#define NPCM8XX_RESET_IPSRST3                0x34
> > +#define NPCM8XX_RESET_IPSRST4                0x74
> > +
> > +/* Reset lines on IP1 reset module (NPCM8XX_RESET_IPSRST1) */
>
> Again - ignored comment from v1. My last message was quite clear, wasn't it?
>
> https://lore.kernel.org/all/4a69902f-a545-23a1-1430-e5ece16997e9@linaro.org/
>
> You ignored several of previous comments, so:
>
> NAK.
>
> Best regards,
> Krzysztof

Appreciate your time and comments.

Best regards,

Tomer
