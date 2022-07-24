Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F6F57F44A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 11:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiGXJHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiGXJHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 05:07:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E27165A8;
        Sun, 24 Jul 2022 02:07:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t1so13866080lft.8;
        Sun, 24 Jul 2022 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twHHobYLA9lRy1K5OK4RAuGFOI4ai78W7xr1iypX7js=;
        b=VUAVlC4793nwMj0kejd/LhnswSxMM1OmuJnU+Y7zuLWh8lITr/u5/kEmAjG8nOedw1
         3D8L48ZYToS9vbVLlbDtBLTuHeAgwUX75/c7/F1jEtQZmDwoYOq59g9/Lvh3Rz0n9KxE
         VZ1VQFUJLTG+Lgc3XAVicvaSEWojoQxVrcXTAnh1vSxZolGik5ggF6+NI+LDZvLilTv+
         czXZLmxjbN3FhsuRqAy5kOBufRBN6cIoCSUTAQardjBDcYSpf3bVH5I94V4qB1lpCdOH
         jDf/QBEvPtpnaszZW7KcMkQzFl5sCmSyTA9WplsVWipGLd4rmk+asNaSMk7N7qf2ot5s
         AWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twHHobYLA9lRy1K5OK4RAuGFOI4ai78W7xr1iypX7js=;
        b=sZVGnbMXPj+CDknV38b4KBWevIf1fw/rmmOUuKAFwajE2uspw2E1FZdh8PUV8bSy11
         rdND8T8A2e4PJcryu+nr9DVKDfRztD7e8ld+/SV+lKpYsUR+CkorkWmo/mhJ25S3A3JZ
         aF+ohJzVoVmnaQiW1nQ6ZkOn6BL0TUbjThkuEVdjJ2UlFmr2vguQ6xCmZq0Aw3uU553U
         ratiHYtvb7GjNoEfWrGlAEkO7FtBsTsgo4qmZWExcv7agZeKAb3g+89lXAxx9LfPQN8h
         SbfFWIVefy9j3xJ58As5PmVp5dsoDN6UWB/T3I63gqoJxC14RHhMYaGGHlV8I8PPYt05
         Ki6g==
X-Gm-Message-State: AJIora85jSXeCZk7DRWp+IusOtq+ZH/mlubCXbKqZPtZaLo8G+xtMzws
        6y+X1sNumBatb1J3kaDvaEwA9TGK3vGsBRYfBAo=
X-Google-Smtp-Source: AGRyM1vDCtTZd7D/kRrJ5xi2dNk8sTtQOjt4UXxL6XCbt6MQn01Nys6x/RDb3QuYl6R/HvowptRbbh75st7Lo99vuaw=
X-Received: by 2002:a05:6512:693:b0:48a:7c23:1896 with SMTP id
 t19-20020a056512069300b0048a7c231896mr2976280lfe.111.1658653626041; Sun, 24
 Jul 2022 02:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220711123519.217219-1-tmaimon77@gmail.com> <20220711123519.217219-5-tmaimon77@gmail.com>
 <20220711195544.70A30C34115@smtp.kernel.org> <CAP6Zq1ie_RgJ_9S3ftoVJ=eJHX1xR4_O_czKZghNPKVEFOzC8Q@mail.gmail.com>
 <20220718191454.5B5D3C341C0@smtp.kernel.org> <CAP6Zq1ju08GSjNnEG+zDUC8W6aQMJxd5He7QJxy9++hTy0Dc7A@mail.gmail.com>
 <20220723030226.8E43CC341C6@smtp.kernel.org>
In-Reply-To: <20220723030226.8E43CC341C6@smtp.kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 24 Jul 2022 12:06:54 +0300
Message-ID: <CAP6Zq1gUvMFG9BNObVNLpVgbMRpV7e--HFxknP8kvL4nGk8Hsw@mail.gmail.com>
Subject: Re: [PATCH v8 04/16] clk: npcm8xx: add clock controller
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Hancock <robert.hancock@calian.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas G leixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nancy Yuen <yuenn@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        SERIAL DRIVERS <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for your detailed explanation!

On Sat, 23 Jul 2022 at 06:02, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2022-07-19 03:04:43)
> > On Mon, 18 Jul 2022 at 22:14, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > >
> > > So the clk and reset driver should be the same driver, or one driver
> > > should register the other and use the auxiliary bus to express the
> > > relationship. That way we know that the drivers are tightly coupled and
> > > aren't going to stomp over each other.
> > I think it is very problematic to use the same driver for the reset
> > and the clocks also because The NPCM reset driver is an old driver
> > that was used also to the older NPCM BMC SoC so it will be problematic
> > to use the clock and reset driver in the same space.
> > indeed the reset and clocks are using the same memory region but they
> > are not using the same registers, is it not enough?
> > Please be aware that the NPCM reset driver is checking that it is
> > using the reset registers before calling I/O functions.
>
> To put it simply, platform device drivers should use platform device
> APIs. The platform device APIs hide the fact that the firmware is ACPI
> or DT or nothing at all. The usage of of_address_to_resource() is
> problematic.
>
> After converting that to platform APIs you'll get janitor style cleanups
> trying to convert to devm_platform_ioremap_resource(). We'll have to
> discuss this again when that happens, even if there's a comment in the
> code indicating we can't reserve the IO space because there's another
> driver. These problems have happened in the past, fun times!
>
> Furthermore, in DT, reg properties aren't supposed to overlap. When that
> happens it usually indicates the DT is being written to describe driver
> structure instead of the IP blocks that are delivered by the hardware
> engineer. In this case it sounds like a combined clk and reset IP block
> because they piled all the SoC glue stuff into a register range. Are
> there more features in this IO range?

No, this range only combined the reset and clock together, but it
combined in a way that we cannot split it to two or even three
different registers...

I do see a way to combine the clock and the reset driver, the NPCM
reset driver is serving other NPCM BMC's.
Should we use regmap to handle the clock registers instead of ioremap?

Best regards,

Tomer
