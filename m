Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1648C578352
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiGRNMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiGRNMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:12:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBCE26133;
        Mon, 18 Jul 2022 06:12:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id e28so19212412lfj.4;
        Mon, 18 Jul 2022 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zW26rBi6b5NN34eoig0+xNjNcL1nw0bdLAbSIFvoRIE=;
        b=VDc+hawylJ1zylNGVUYcDnTYJ5BDNvP6SNt/pZv5L8zGwE7bLN2jlb+jl24dCIzOJg
         /qINBIfTEdI7hlT6H+zr9LpZZinoWT9nb7EzrkOhUqRKLEt+/CnTsYIC/wiN9smwzAWs
         9gEtr+aMDBlE5CXqlbMEadnEU2IRWEvBYdJ6m0ynMQVpQzVYGIHv9FzDW+lXV75+g7fe
         EEmYb6j5A52TUOsLWUPT/cLBOmcBY5aQ1CYsuLUf45AB+s0LBby5UFulbTHohUcbFrLa
         wcfkM6cOeJt2H3JkYTqEIu4azf6fNf4eVs7ecLK6YSWPTRLl2o6ffyhhhqEnjb8hNgbw
         ClNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zW26rBi6b5NN34eoig0+xNjNcL1nw0bdLAbSIFvoRIE=;
        b=ZkC6eYcIqzmQttV+OMNINHeSHjJHvR7pzwukNLWB8AdRlARymO7MFkUCQD2jLDCx8b
         8o97/tq3Dmcoll+yqJ+6lE++ZyNP2zbKZQSv/2eVmxzcp/hN0SXyScIXmx6OwUt+qYYW
         yRtUS7dJSHijTPQHX0hsjg5XBCCq+phSXoRT/eadP3duYdGUjiG6e9TUt04/C44Imw+h
         WFcxJN5/754uC64ZLfDOfwmwIWwN3jk5kj7Ys2LeU3aWHchpoFDXGQwGgTmQSZRpsJx+
         0DYfFlIwKYlKgxQvY5ITpizjN0K3QqCKaZiKPjOhEhp8L4R6b2wwIUva7eQ1Yxy9F6Pn
         2VeA==
X-Gm-Message-State: AJIora/CYP1ERaY6LMTETmNLdUMV4HTAaOnQsiDiHQqfkSh1mKBQ5Eo6
        1g/r217So7K4lKgEoZvPtURZPswwHcrof6qRh6A=
X-Google-Smtp-Source: AGRyM1t6IrwnDXUKp8lX11UQjAriHARn8Ym+LJnivDfcR8D10MSoiFmXI75SX/xW6Wsks/l98Uqn/fXPBufvxFAHerE=
X-Received: by 2002:a05:6512:1190:b0:48a:19d5:ef23 with SMTP id
 g16-20020a056512119000b0048a19d5ef23mr10573130lfr.401.1658149964876; Mon, 18
 Jul 2022 06:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220706165406.117349-1-tmaimon77@gmail.com> <CACPK8Xd0n5cpsCJ6guPzEj8JfXkz_ERzU3VdXW-Xx2QX8ssNKg@mail.gmail.com>
 <CAK8P3a0Ojf1hm5Q2FJZEGLygku+qkPmKnKpBD8eAZPeRZtb=gw@mail.gmail.com> <CAK8P3a3Dh+wTyPYhvv5c-wsqMK24ZgqPWHw2C7xuFh9vL53XfA@mail.gmail.com>
In-Reply-To: <CAK8P3a3Dh+wTyPYhvv5c-wsqMK24ZgqPWHw2C7xuFh9vL53XfA@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 18 Jul 2022 16:12:33 +0300
Message-ID: <CAP6Zq1iCai5hSWVyeMg+xcgBXj0mdq7mcQrQfNmDFh15Q2y_-g@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] Introduce Nuvoton Arbel NPCM8XX BMC SoC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Joel Stanley <joel@jms.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
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
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Qin Jian <qinjian@cqplus1.com>
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

Hi Arnd,

Appreciate you taking care of this!

Are these questions direct to me or Joel?

On our side we will be happy that you will start to merge Arbel
NPCM8XX without the clock driver, hopefully the NPCM8XX clock driver
will ACK soon and maybe you can merge it as well.

What do you say Joel?

Thanks a lot

Tomer

On Mon, 18 Jul 2022 at 14:28, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jul 8, 2022 at 3:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Jul 8, 2022 at 8:50 AM Joel Stanley <joel@jms.id.au> wrote:
> > > Are you happy with a cross tree new soc branch for this series? If so
> > > I can put them in a branch and get some build coverage before sending
> > > them out.
> > >
> > > (I notice the clock and reset changes are waiting on acks still)
> >
> > Yes, I think we should merge the parts that are reviewed already, but I'd
> > leave out the clk (4/16) and reset (9/16) patches in this case.
> >
> > Krzysztof has reviewed the binding changes, so I don't mind having
> > the DT nodes added in the soc tree even if the two drivers are still
> > missing.
> >
> > I would do the same thing for the sunplus SP7021 platform that
> > Qin Jian has been posting, as this is also waiting for a final Ack
> > on the clk driver.
> >
> > I would put both of the new platforms into a single branch in the
> > SoC tree, separate from the usual dt/drivers/soc/defconfig
> > branches. I was already planning to pick npcm8xx up myself,
> > but if you can do a pull request, that would be even better.
>
> I see there is now a v9 of the series, let me know if I should
> apply some or all of those, or if I should wait for a pull request
> from you.
>
> I've just merged the Sunplus sp7021 support leaving out the
> clock driver in order to make progress on that one, and
> we can do the same thing here if there is still ongoing discussion
> about some of the drivers. It would be nice to not wait too long
> though, as we are already past -rc7.
>
>       Arnd
