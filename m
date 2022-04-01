Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3712A4EEB02
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbiDAKLs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Apr 2022 06:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiDAKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:11:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EA618EE83;
        Fri,  1 Apr 2022 03:09:56 -0700 (PDT)
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MeUPU-1o8BXC2q7I-00aWdB; Fri, 01 Apr 2022 12:09:54 +0200
Received: by mail-wm1-f44.google.com with SMTP id i132-20020a1c3b8a000000b0038ce25c870dso3201254wma.1;
        Fri, 01 Apr 2022 03:09:54 -0700 (PDT)
X-Gm-Message-State: AOAM5300FLqhk7MHJ7VpqI0n1lgCekCvKPTQtCjhu8LrWdvuNkUu5jLl
        /WLcIskzT/+p5X3ECJDLQTTviTYpkxZuaNkMhtk=
X-Google-Smtp-Source: ABdhPJyNwn5VW/gR5pIv2np3RCs3K09s4CU+E1aUKrucWrsCjYi+cdzwK6CE+Qjb/zAcZxqYzBm4uCZmD6/ogYdeFHA=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr8009475wmc.94.1648807794169; Fri, 01
 Apr 2022 03:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648714851.git.qinjian@cqplus1.com> <fe4f4c3b0c768d1cd66fb648d74fa302e86787c0.1648714851.git.qinjian@cqplus1.com>
 <CAK8P3a0OGM4aiaE2Nfc=7XGkGwAbnB99-j3PhVUmuA1z2FWeKg@mail.gmail.com> <2fa0ce6048f6449d883e2454ceea9540@cqplus1.com>
In-Reply-To: <2fa0ce6048f6449d883e2454ceea9540@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 Apr 2022 12:09:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a002iHquY4J59omBwxyZjCFFiymqbWKu9GXs-7RVy292g@mail.gmail.com>
Message-ID: <CAK8P3a002iHquY4J59omBwxyZjCFFiymqbWKu9GXs-7RVy292g@mail.gmail.com>
Subject: Re: [PATCH v12 5/9] clk: Add Sunplus SP7021 clock driver
To:     =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:TJfhkoT13owuLxX72+XrftpY4mBmHY8SnpJTLmFFbgEiz/zazDE
 0+0xUB0SCDaAwD9fKPEAG/CGeUezOvORBimaOpZYgdDUo2bQjh+BoEsL8HZxMbXR9rmMyN+
 E+ozx9/Tx/Z7kIQ6DBYE7+CNT/adpH7ygYiL67OP7/vyrDMltZGQQRUrvuT1OW2JWh4b38t
 8Flr20KY+4DRj9VI9VKNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qma4p1Kf2C4=:ai9TLjlnItrZs5x9f3JQbr
 UItuX/jl4qCtpoV8Tq0IfIZjl/sONJ/n4TWDsylw4K7EFoztLJ3gET28E+6hQCkoIncZDfL8o
 UjVhSu2WH0WG7B3sSt+w88aXq0rGcaSlaax3eN8Aqapz9hEXM4LpDoUpx06yEzFGqvXBXuNZ6
 sCFgeBlwoMxeDS8CX3cBnsxgPbEhgY46J/A02mXjVdWndN7ygmPGE3itVERx64ZklYp3jff6+
 B3I8xfr2doWFOgBUVb6NRiszLfPkd5RHSrkf/BDINXxGuDVVMmw0bAWTzzUTw/ueLOgP1MOAL
 +T/n8IOzDSTLQKtI3kn8916AH1vU86P9q/zU8zcmloXzRPk7p8mLpf7yBCvc0sfwTeFxREFay
 ve9lUksIbU2pbYFhfPA8kErNeegXQYz4zrv58FwKLyDW/sm7iqCkX7fRbGYrzDEJZmu8Niczd
 9aw2VB79IsjpJNFlAYMkASH06mrz5UvoIj2b4upFLemnuf5u2ZBgnFjnslFCNQAtO9V101r88
 Sfxv7xtah9RODVSI9BReQ1I+jBYRbmrBwplgBLc3nB1imvEsmpCIy8QihtHF0rhuSavZgW1Qt
 h/UyhI2brQoNnaDBguxiGGsEMYhNuYvW28BF7ONdt2gdvARxSrysMy818GHqbh0SgrjA1Y7Gm
 laHkjs3i3gpih4PEkjMbOcbzIU602/Bh8V4aBMPYeHKEEaoukdFpIhzrEozjOo4R4dhoDLyTL
 +uHj6uNnKjmYRa4B6Gkf9HKrbvso+I0HdrYK63WaRNFjnmlxOkP04lXWMsmoTre0oAQo5Whsa
 spGW+nw5PTTaZd+TQQ1MuPJtHfMpsTQC584JaazZayi0EpspYQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 11:47 AM qinjian[覃健] <qinjian@cqplus1.com> wrote:
> > > +static int sp_pll_enable(struct clk_hw *hw)
> > > +{
> > > +       struct sp_pll *clk = to_sp_pll(hw);
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(clk->lock, flags);
> > > +       writel(BIT(clk->pd_bit + 16) | BIT(clk->pd_bit), clk->reg); /* power up */
> > > +       spin_unlock_irqrestore(clk->lock, flags);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void sp_pll_disable(struct clk_hw *hw)
> > > +{
> > > +       struct sp_pll *clk = to_sp_pll(hw);
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(clk->lock, flags);
> > > +       writel(BIT(clk->pd_bit + 16), clk->reg); /* power down */
> > > +       spin_unlock_irqrestore(clk->lock, flags);
> > > +}
> >
> > What does the spinlock actually protect here? As writel() is posted, it
> > can already leak of of the lock, and the inputs would appear to be
> > constant.
> >
>
> These code is refered from other clk driver.
> But, other driver need read then write, so need lock protected.
> Our  HW is HIWORD_MASKED_REG, means modify bits no need to read, just 1 write only.
> So, the lock is useless.
> Did I right?

If the read-modify-write is done on a different register, then it is
fine to remove
the lock. You can also consider having shadow registers to avoid expensive
r-m-w cycles and just always write the register directly.

> > > +       /* This memory region include multi HW regs in discontinuous order.
> > > +        * clk driver used some discontinuous areas in the memory region.
> > > +        * Using devm_platform_ioremap_resource() would conflicted with other drivers.
> > > +        */
> > > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       sp_clk_base = devm_ioremap(dev, res->start, resource_size(res));
> > > +       if (!sp_clk_base)
> > > +               return -ENXIO;
> >
> > Can you explain this comment in more detail? Generally, the 'reg' properties
> > of drivers should not overlap, so it is supposed to be safe to call
> > devm_platform_ioremap_resource() here.
> >
> > We discussed this in the context of the iop driver that did have overlapping
> > registers with this driver, and that was incorrect. Are there any other drivers
> > that conflict with the clk driver?
>
> I means, I must split up the origin reg region into 4 small pieces,
> and call devm_platform_ioremap_resource() 4 times.
> Did I should follow this way?

It depends. What are those other registers, and what drivers use them?

        Arnd
