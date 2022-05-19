Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B032E52CAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiESEHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiESEH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:07:27 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58240B2240;
        Wed, 18 May 2022 21:07:26 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ec42eae76bso44575147b3.10;
        Wed, 18 May 2022 21:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXXEFVAWdcfsrBLBj8ao5DIb64QepPVvyxaMhKzXSz4=;
        b=bw96tcbU3b3bKXOLcOF/AgAkk7wRQZDJDDAW9NCIvo1kFnjx0ziKDZV5+njUSSrKHL
         nMUcqVxWv4O/HOLGLqgSw2tPsLor49noYVmEC2cUOF7sUum+XgVsz/chJvloyE/7Mhpp
         A6/xy8c41g993gjpNoXpRTxlGrLpRWFlUFjmWQ/JZbOFm8WhFX/m46d+SR19VSr+JqvJ
         2gGXdgRBUxXf900CZ22iErlthvQIHmWwQtfGwYTgpRVVoPoCmoQKsNiRDAvsHwMfbDZ5
         EoxNS1V6DGWwOCk4Ip9ckDnlX1RFHZG/PDmPKGA7jHOP/7l/cifjH05BjVLlyJ63oqnW
         aSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXXEFVAWdcfsrBLBj8ao5DIb64QepPVvyxaMhKzXSz4=;
        b=DsxFlMOwjrmXNzsr1NbiDgEN+ZZMbCvSGttOVcx4bIZSJmqmvn9pkfKZfiiCNGUwG/
         SuINhQU+hEFSjPL5LuuL+hS9qR0SCzrW9FL+R5sF2aV78Gwpf7LCZOEgdOuDA2647jcZ
         XNtqBaIoidh8UcVOjoMJaxANYSsyYUi8hyZxmiGmU/oYFEFytCzU//fIlqwRVkLg24w2
         vnkRnjpZf2kPYxPC/DRQyVj50EGQPTWWqQ2WUqb2MoSRqBtLWQfP2QL9GGcT5djm5PGE
         zt7qE4mpBSyb/LrHqPcakokvCodOv2HGRFi6NpeedgLfvZ8OFHo4zFODb3VONQZX05EQ
         H0dA==
X-Gm-Message-State: AOAM530RqoQzXbdVT/VVfbBzVBqQUhVhTONWl1eqam94l3KG+ptpoKwB
        HVCrIZrayn6iJZANpPFMfOifT4M3muGHzPkis4Y=
X-Google-Smtp-Source: ABdhPJxbJGkHPtjXLEwwOw4PHTO9ghyGHE/Mv303/T+yUZFJOG3isNuJYeet9Pv4Y+XInrhWvxXsWOCPupkmjHSn/Oo=
X-Received: by 2002:a0d:c101:0:b0:2ff:5824:e8a8 with SMTP id
 c1-20020a0dc101000000b002ff5824e8a8mr2562737ywd.413.1652933245601; Wed, 18
 May 2022 21:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75VeyU4Ox76wz9VfT8qEKHsE1eAo2iw27Lro1tmjJB0npMg@mail.gmail.com>
In-Reply-To: <CAHp75VeyU4Ox76wz9VfT8qEKHsE1eAo2iw27Lro1tmjJB0npMg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 19 May 2022 05:07:00 +0100
Message-ID: <CA+V-a8tp0T=ojr3hB-QacOvV5sCZ29YXspPzKSSpGHUA8_1XDA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Renesas RZ/G2L IRQC support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Wed, May 18, 2022 at 10:10 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, May 18, 2022 at 9:29 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Hi All,
> >
> > The RZ/G2L Interrupt Controller is a front-end for the GIC found on
> > Renesas RZ/G2L SoC's with below pins:
> > - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI
> >   interrupts
> > - GPIO pins used as external interrupt input pins out of GPIOINT0-122 a
> >   maximum of only 32 can be mapped to 32 GIC SPI interrupts,
> > - NMI edge select.
> >
> >                                                              _____________
> >                                                              |    GIC     |
> >                                                              |  ________  |
> >                                       ____________           | |        | |
> > NMI --------------------------------->|          |  SPI0-479 | | GIC-600| |
> >              _______                  |          |------------>|        | |
> >              |      |                 |          |  PPI16-31 | |        | |
> >              |      | IRQ0-IRQ7       |   IRQC   |------------>|        | |
> > P0_P48_4 --->| GPIO |---------------->|          |           | |________| |
> >              |      |GPIOINT0-122     |          |           |            |
> >              |      |---------------->| TINT0-31 |           |            |
> >              |______|                 |__________|           |____________|
> >
> > The proposed patches add hierarchical IRQ domain, one in IRQC driver and
> > another in pinctrl driver. Upon interrupt requests map the interrupt to
> > GIC. Out of GPIOINT0-122 only 32 can be mapped to GIC SPI, this mapping is
> > handled by the pinctrl and IRQC driver.
>
> Where is the explanation on why valid_mask can't be used instead?
>
The .valid_mask option is one time setting but what I need is
something dynamic i.e. out of 392 GPIO pins any 32 can be used as an
interrupt pin. Also with this patch we also save on memory here [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/kernel/irq/irqdomain.c?h=next-20220518#n153

Cheers,
Prabhakar
>
> --
> With Best Regards,
> Andy Shevchenko
