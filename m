Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E598454589D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbiFIXWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbiFIXWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:22:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC2A156B6D;
        Thu,  9 Jun 2022 16:22:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id be31so40307151lfb.10;
        Thu, 09 Jun 2022 16:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNn5m4Xk26zmjjZWaXx9gc+yTuD5ZU/xEKvPldY9urA=;
        b=O2nWaeF/P16IAO05RYFD1FqECAJEYzwHKWQzhUb8Wl1SUnpVfCesfyBI8CG7HR77pl
         oqHf7sj6TzPra19Ot9mNHCGB2/PTFHzBupaYcAbtDz+X1psql3wsD5ZfUrU3tzX+zA8Y
         uPSnpAhB+TR7CKbTHRTMJcI+jb21lw45/DKQEQ2yD8HbD8XJ7e5UVidhpdfyqcvYe/bh
         jk1O6NFP7R4mOLVW6O53rhFaXIATQnFrrQNifZqIjBowAeo9EGUrvqKOOld2JV2aa9Sp
         3t3nXamQxUKVmfm66CniAOsKfwdxZiiKr3ZlqAyrjtrMbWJf3xcPxn8OeXYn2ug4zY/t
         b5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNn5m4Xk26zmjjZWaXx9gc+yTuD5ZU/xEKvPldY9urA=;
        b=2wGnH6wloE51k0kqfDs34IBGaJgU5XQnfMJn00WZZlAiVkGwU7+bLiFQniYifHAcVO
         kWvFaFqDolGDMr36gNb+nVuq9Q6XT+gjpki4ewsLiIORmq5lNUWGjtsHLZuwsb5juUIV
         DWsrVhgP6TtTCLkaKyEbKUM/M3OJBQBEXAS0GalhWlKI9Wlz93qkfFLpbXxg5qY7jUJQ
         R+kWZGryBYNPXqVABPKsLFsqkpvNW16Yd1LsHRyXe6bmK42Cp4XlCFZpVh6BhSYP+EC8
         JsUlMvK31mXedl/sEaAvRx5A0qaM9ZfZRVvUTkASZHgZ5MOYh5B+W85vo89p32JMz25K
         lThg==
X-Gm-Message-State: AOAM532vC867lZocxjX296mkNmvWvd4wk6WnIJhCKewu0trK6KSbmmeM
        rgu8Y1Y2QMgh8SpDRP8pmvY6SmET7WYFsFqIjII=
X-Google-Smtp-Source: ABdhPJyj9vLZaljPbA3gWFChXewcit6cy+/TcGFC1IlSTHaMze9MSYP47sdEYio3WJMrJ2QRRDoGLm17Rd36wGtKv88=
X-Received: by 2002:a05:6512:31cf:b0:479:3fd4:420e with SMTP id
 j15-20020a05651231cf00b004793fd4420emr15845925lfe.364.1654816954651; Thu, 09
 Jun 2022 16:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-11-tmaimon77@gmail.com>
 <3aa70c91-d6d7-e2eb-9c45-a1fb0a5751ca@linaro.org> <CAP6Zq1iCJO3AzHnG7RSQ1pyVwayxs+X3iVM4U=6j2k0EgR7psg@mail.gmail.com>
 <CADKL2t523rdOnm=iUNXcw06Soq3NjbJEsEiPwCXdSx3Np-rNDQ@mail.gmail.com>
In-Reply-To: <CADKL2t523rdOnm=iUNXcw06Soq3NjbJEsEiPwCXdSx3Np-rNDQ@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Fri, 10 Jun 2022 02:22:23 +0300
Message-ID: <CAP6Zq1g6XoWmdHPfB+7-EjqRaMfhQD7Zt0J+ChCPTZKykkogsg@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] ARM: dts: nuvoton: add reset syscon property
To:     Benjamin Fair <benjaminfair@google.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
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

Hi Benjamin,

Thanks a lot for your explanation.

will be applied in next patch set

Best regards,

Tomer

On Fri, 10 Jun 2022 at 01:11, Benjamin Fair <benjaminfair@google.com> wrote:
>
> Hi Tomer,
>
> On Thu, 9 Jun 2022 at 14:30, Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > Hi Krzysztof,
> >
> > Thanks for your comments
> >
> > On Wed, 8 Jun 2022 at 13:07, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 08/06/2022 11:56, Tomer Maimon wrote:
> > > > Add nuvoton,sysgcr syscon property to the reset
> > > > node to handle the general control registers.
> > >
> > > Wrong wrapping.
> > it will be very helpful if you could point me what wrong wrapped in
> > the commit message, is it the explanation or the header? or something
> > else?
>
> The commit message body should be wrapped at 72 chars. You can fit
> more on the first line if you reflow:
>
> Add nuvoton,sysgcr syscon property to the reset node to handle the
> general control registers.
>
> > >
> > > Best regards,
> > > Krzysztof
> >
> > Best regards,
> >
> > Tomer
