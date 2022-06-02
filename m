Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3F253B623
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiFBJfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiFBJff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:35:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735CF2AA9AA;
        Thu,  2 Jun 2022 02:35:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a2so790190lfg.5;
        Thu, 02 Jun 2022 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rBGjBOMnZl6to9efJaumbeOWSvKP8/DOct/QBdXnYoE=;
        b=jvY/M4TcfKUtycVJEjl3vv3zcqK0vVXzP6oHwxbhveiR6Eve6NDt0Von5+VteqUBV0
         0L333UPalxOSb+vAx5ej9FW4zDL3jiSJBKKI5g/bfbegljG05danKDxYAC1Mawnygsr8
         NfvqH2NN74NnI5rLy+2zi6GU0sJ4y2QMkIhCQuT0rdAnmGP6i+nYifRZZ1QarEQWaWqU
         1sFUjgMVvdhRWoctqpRRBSRSxoYCb/XYfFaItHlctIxH4eSOMldKOv1TbUyAo4DKKvuT
         uI9O7Tb6ZGTcE2JxUT1KvCqoqebUvm2IiT9ek+R0V9Lk4hCNqrOX4e+Amz04wcKyd1yK
         Jadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rBGjBOMnZl6to9efJaumbeOWSvKP8/DOct/QBdXnYoE=;
        b=7GGdRn5q889TtfbhfSX/2lkVjt+toLLjsBzfXA3SoA7EDJY1295dD/4IQGlyzyT10u
         ASm5bOoUdzJLO4UbyTpT4GlmvTFJNz6cGqppX9xw1HtNGxQyKgFkgcH7cHWBoiwG6qr4
         CvNAd4+syu4N3ezpmJtAG6xJNzs98AJfLPNiBPe2FKJCeZVGOIuMR65DkekuAPrJbOXt
         MLdYCzffOKtxAq5TXYS5yaJexiTOssd4SnWVMvUCwt6ZLQ5OnsP2fORI6vBGQehevDMF
         EoBnYyu/cFxXWEbb1H83Wxh47i4j4YK/9sIw/DEfSXFEywuef75EIwpMsg2Ao3luMagR
         Kulg==
X-Gm-Message-State: AOAM530Yy8JAUoW7NBXInmtDnlEZwxcGtiBEIfWN5+4/RfWX2tYfKczl
        pueBwvIiHZapcBmyi1Jjzg3gByEqrQYYr/lWohM=
X-Google-Smtp-Source: ABdhPJwGnEM9jHCmHkWGx92/jl3eJw4zP0SFatjlcRCflAAlB9cVfAhhX5EONP3FSiW4lO0wQLnMioV43pqGQELiTHo=
X-Received: by 2002:a05:6512:2251:b0:478:fc67:b09f with SMTP id
 i17-20020a056512225100b00478fc67b09fmr2833144lfu.196.1654162532575; Thu, 02
 Jun 2022 02:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220531102809.11976-1-peterwu.pub@gmail.com> <20220531102809.11976-7-peterwu.pub@gmail.com>
 <CAHp75Vd8taco19vsDmBcCv8euV1SvwSiY5=P9oMkA6zWsjwXxg@mail.gmail.com>
 <20220602062643.GA13824@cyhuang-hp-elitebook-840-g3.rt> <CAHp75Vd-n=oLnhRCK=pR5ybOZbC6BKXrE2jRdwDbH90E4KYFGA@mail.gmail.com>
In-Reply-To: <CAHp75Vd-n=oLnhRCK=pR5ybOZbC6BKXrE2jRdwDbH90E4KYFGA@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 2 Jun 2022 17:35:15 +0800
Message-ID: <CADiBU3-73ktYfwZD=Dgd+5kWHraOuBkz1=bU_-+NNcxP12gcrQ@mail.gmail.com>
Subject: Re: [PATCH 06/14] leds: mt6370: Add Mediatek MT6370 Indicator support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>, cy_huang <cy_huang@richtek.com>,
        alice_chen@richtek.com, chiaen_wu@richtek.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=9C=
=882=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:18=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Thu, Jun 2, 2022 at 8:27 AM ChiYuan Huang <u0084500@gmail.com> wrote:
> > On Wed, Jun 01, 2022 at 11:48:58AM +0200, Andy Shevchenko wrote:
> > > On Tue, May 31, 2022 at 1:16 PM ChiaEn Wu <peterwu.pub@gmail.com> wro=
te:
>
> ...
>
> > > What indicator?
> > It's RGB curent sink type LED driver (maximum supported current is only=
 24mA).
>
> Make your commit messages a slightly more verbose.
>
OK, will refine the commit message in next.
> ...
>
> > > > +#include <linux/of.h>
> > >
> > > Are you sure this is the correct header? Seems you need
> > > mod_devicetable.h instead.
> > >
> > It's the correct header and be used for the struct 'of_device_id'.
>
> Nope. Run the following command
> $ git grep -n 'struct of_device_id {' -- include/linux/
>
Got it, thanks.
> ...
>
> > > > +struct mt6370_priv {
> > > > +       struct mutex lock;
> > >
> > > Do you use regmap locking?
> > >
> > MFD regmap register already the access lock.
> >
> > This lock is just to guarantee only one user can access the RGB registe=
r
> > part.
> >
> > Sorry, from the comment, do you want us to rename or remove this lock?
>
> My point is, since you have two locks, explain why you need each of them.
>
OK, will leave a comment line to explain the usage of this lock.
> > > > +       struct device *dev;
> > >
> > > > +       struct regmap *regmap;
> > >
> > > > +       struct regmap_field *fields[F_MAX_FIELDS];
> > > > +       const struct reg_field *reg_fields;
> > > > +       const struct linear_range *ranges;
> > > > +       struct reg_cfg *reg_cfgs;
> > > > +       unsigned int leds_count;
> > > > +       unsigned int leds_active;
> > > > +       bool is_mt6372;
> > > > +       struct mt6370_led leds[];
> > > > +};
>
>
> --
> With Best Regards,
> Andy Shevchenko
