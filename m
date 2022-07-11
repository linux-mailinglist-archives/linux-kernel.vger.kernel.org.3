Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE1556D81E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiGKIcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiGKIca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:32:30 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246771EC4D;
        Mon, 11 Jul 2022 01:32:29 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e69so7595628ybh.2;
        Mon, 11 Jul 2022 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rfksFWyKzK95Tycdc7144qcD0Ffw/6KuO+4RVJtE6Fc=;
        b=RchMSnxfLG2NEh8IKskAz8Sy6KjFd8TNjrt3OVhUV5ljw9MgQ2zE9eok3KhI9QK6Pg
         cd6QLOSTJs9PoGcNXHQtJbPsDE4sUP2zyh2WU5JrMaidC0lBf+gpcPAB89XZwjI60uqH
         4bEZpAlJSePjwMpMzUQiA7eJD6VPzMOA+qZIEmOniHCRZ8Yme84kCUR5/RNQDlrYI/Cf
         8m9QRYcqfKt89unKU5U0jgsMNJV5q8KiBXt6ZbTtqp6XaF0WP/zVrpDg2wafDbXVpqoY
         3aOTlp881tacjNs82RuKf4JsXfmR6apbkQ2DAy7w9/Y8NU2ksg+5n8LuSKi2Z/BqFDSB
         Xd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rfksFWyKzK95Tycdc7144qcD0Ffw/6KuO+4RVJtE6Fc=;
        b=yM6Lt+SXcRh+jdzBBgfw5WmiJbvX8+KcNLBE74FWk7o/CLLqBeZanQDDa6P7JYAQBf
         T2KOaDtyTT3Xcu1WqZ6QsKtNaCGSNZ9p3yHafUx1mRb6oOdOfJ9HVid4OI2HfOWnKInj
         +dl1RcETXMUM2EHjs/osJogJ02btDKk1R92cIxEAH9LiLvPkkNed5D6PFsrSQtQ2Ocyb
         JB1c/uUE4lQslza7lWKc8weFZOgybBSmAxi3LM8RZZ+Gel6eFDXh/RcIlwOHTopQxCgh
         9PE6Zlap5lAITFw9aJkoPI4Nwi/Eqrk3oq2Xuk1WUw3qJq5qOjP5+ai4OSnHEyJdsUOt
         7gzA==
X-Gm-Message-State: AJIora9FO7iMP237hVW5g36hpd/aWMWUJNBTYB7Nl8tNTuuIgpVvZnXW
        QSlQFku8CuWo2qPz0IQhe4rpZXYam6Z/n3/YJlhcJFotEX/qXg==
X-Google-Smtp-Source: AGRyM1sbThsfSVigEKUUzo4aJ6yvcK3MNEtbYQ/gm8rY3wCg3Wd6ubTN8V4QF9eUhSeFNM8A0ub9U4MTMGDWKZFx52o=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr16403993ybg.460.1657528348125; Mon, 11
 Jul 2022 01:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220708195510.2951661-1-horatiu.vultur@microchip.com>
 <20220708195510.2951661-2-horatiu.vultur@microchip.com> <CAHp75VdPi8rT_EJd8L8-waAkH_Lm947WVKMLHjjW5MpFW9A06Q@mail.gmail.com>
 <20220711064950.3fqhuat3b23uabkj@soft-dev3-1.localhost>
In-Reply-To: <20220711064950.3fqhuat3b23uabkj@soft-dev3-1.localhost>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 10:31:50 +0200
Message-ID: <CAHp75Vdny6Q3iyO1_Qyz7C+AZ268xRixL6GvCE93f_vfS3bESw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: ocelot: Fix pincfg for lan966x
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kavyasree.kotagiri@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 8:45 AM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
> The 07/08/2022 23:58, Andy Shevchenko wrote:
> > On Fri, Jul 8, 2022 at 10:10 PM Horatiu Vultur
> > <horatiu.vultur@microchip.com> wrote:

Please, remove unneeded context when replying!

...

> > > +       struct ocelot_match_data *data;
> >
> > Any specific reason why this is not const?
> >
> > > +       data =3D (struct ocelot_match_data *)device_get_match_data(de=
v);
> >
> > And here you drop the qualifier...
> >
> > I would recommend making it const and dropping the cast completely.
>
> If I make this const, but then few lines after I will get the following
> warnings:
>
> drivers/pinctrl/pinctrl-ocelot.c:1983:13: warning: assignment discards =
=E2=80=98const=E2=80=99 qualifier from pointer target type [-Wdiscarded-qua=
lifiers]
> 1983 |  info->desc =3D &data->desc;
>      |             ^
> drivers/pinctrl/pinctrl-ocelot.c:1984:20: warning: assignment discards =
=E2=80=98const=E2=80=99 qualifier from pointer target type [-Wdiscarded-qua=
lifiers]
> 1984 |  info->pincfg_data =3D &data->pincfg_data;
>      |                    ^
>
> Of course I can make also info->desc and info->pincfg_data const but
> then I will get the following warning:
>
> drivers/pinctrl/pinctrl-ocelot.c: In function =E2=80=98ocelot_pinctrl_reg=
ister=E2=80=99:
> drivers/pinctrl/pinctrl-ocelot.c:1723:53: warning: passing argument 2 of =
=E2=80=98devm_pinctrl_register=E2=80=99 discards =E2=80=98const=E2=80=99 qu=
alifier from pointer target type [-Wdiscarded-qualifiers]
> 1723 |  info->pctl =3D devm_pinctrl_register(&pdev->dev, info->desc, info=
);
>      |                                                 ~~~~^~~~~~
> In file included from include/linux/gpio/driver.h:10,
>                  from drivers/pinctrl/pinctrl-ocelot.c:10:
>                       include/linux/pinctrl/pinctrl.h:166:26: note: expec=
ted =E2=80=98struct pinctrl_desc *=E2=80=99 but argument is of type =E2=80=
=98const struct pinctrl_desc *=E2=80=99
> 166 |     struct pinctrl_desc *pctldesc,
>     |     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
>
> > > +       if (!data)
> > > +               return -EINVAL;

This is not good. Any chances to make it const?

One way is to copy data in a newly allocated buffer (devm_kmemdup() for tha=
t).

--=20
With Best Regards,
Andy Shevchenko
