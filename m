Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1E953B5DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiFBJSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiFBJSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:18:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE053701;
        Thu,  2 Jun 2022 02:18:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id me5so8233104ejb.2;
        Thu, 02 Jun 2022 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0d9LPcPl2z82dxOAeBz8oaTNCeFfF1mrJ8xfIO9HyHE=;
        b=lfLh9e2Zec+kRfUbieDqxaSJGfE2gK5tVDQL4/AlpgVcAAIBNipxqiaQ9KaF31NRoL
         p4XLfqqfzJDaVnItedh+uY7WOZo9GWfO9EDs7Kwtb9g1ep7F/2s8jmC8C+5HKoB8mmqm
         5+MnNkvj0n3QFu1KLRgu4qmE4FZpPqT/FxCabwWRio16T/tBO5n8YQs39umvhQZU1izc
         kmND1i4pFf63FZslDTQd5TX2paKc+iavMXEEIfxzCgFARk5C9xBN1i2j5XO5tazLpbL3
         wIlyYfmxX1H8YiEs73O3/gKRJfzGSjM99weIY/3wRiXAWXYqSVXb5yR9RaF0dJyLJck3
         HKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0d9LPcPl2z82dxOAeBz8oaTNCeFfF1mrJ8xfIO9HyHE=;
        b=cyeok4LVFsdO0DNXsuUE0UImQfxvFOwMGCPhdctFrhGtkhqzr9JLqijDHPEW7Z+lFv
         t7pXhQjnasw3UTDqdmp/tfCKcFkYupsS4eIMdctFOHIPZ2LcRR6bZBgImHeOjMyljmM/
         pYN/JbtDRmIi7uTBBgMuLBR8JoIcT5LjO+T/KWZf2RY9+ep7Q/jiER7+KFEzqCWhDbQP
         I+xFeMDq+N3ZDDCcxJLoGVZl4kPg4UW9BZc4FNEx+yk+Ma1lMvJwUMG6aN4mHn5CJez6
         ai4rULChngwaunakkHLAGlv6YjOcbk6JONzdtOrKRH7WFmgkByrO7/nKTEylVc6Uo3WH
         6wrA==
X-Gm-Message-State: AOAM5301P6DGapNiS7JRDlVh4DtJhOJsWnwmkv1/pXkv8nDEA5CuyIF0
        biwhgRFBbzFoTFKBJ319hdqCC5dDpmSiYJopJFg=
X-Google-Smtp-Source: ABdhPJxRg1MZXl/SkbIUuNBrRuGNQldHFdLPZxE+GhC/BiCEKh8oflGlAj5dFnKQFyQ9Ns7hxKjhAhvcKy/fq3rTsjo=
X-Received: by 2002:a17:907:6e04:b0:6f4:d6f3:c72a with SMTP id
 sd4-20020a1709076e0400b006f4d6f3c72amr3415411ejc.636.1654161497069; Thu, 02
 Jun 2022 02:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220531102809.11976-1-peterwu.pub@gmail.com> <20220531102809.11976-7-peterwu.pub@gmail.com>
 <CAHp75Vd8taco19vsDmBcCv8euV1SvwSiY5=P9oMkA6zWsjwXxg@mail.gmail.com> <20220602062643.GA13824@cyhuang-hp-elitebook-840-g3.rt>
In-Reply-To: <20220602062643.GA13824@cyhuang-hp-elitebook-840-g3.rt>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Jun 2022 11:17:40 +0200
Message-ID: <CAHp75Vd-n=oLnhRCK=pR5ybOZbC6BKXrE2jRdwDbH90E4KYFGA@mail.gmail.com>
Subject: Re: [PATCH 06/14] leds: mt6370: Add Mediatek MT6370 Indicator support
To:     ChiYuan Huang <u0084500@gmail.com>
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
        Helge Deller <deller@gmx.de>, cy_huang@richtek.com,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 8:27 AM ChiYuan Huang <u0084500@gmail.com> wrote:
> On Wed, Jun 01, 2022 at 11:48:58AM +0200, Andy Shevchenko wrote:
> > On Tue, May 31, 2022 at 1:16 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:

...

> > What indicator?
> It's RGB curent sink type LED driver (maximum supported current is only 24mA).

Make your commit messages a slightly more verbose.

...

> > > +#include <linux/of.h>
> >
> > Are you sure this is the correct header? Seems you need
> > mod_devicetable.h instead.
> >
> It's the correct header and be used for the struct 'of_device_id'.

Nope. Run the following command
$ git grep -n 'struct of_device_id {' -- include/linux/

...

> > > +struct mt6370_priv {
> > > +       struct mutex lock;
> >
> > Do you use regmap locking?
> >
> MFD regmap register already the access lock.
>
> This lock is just to guarantee only one user can access the RGB register
> part.
>
> Sorry, from the comment, do you want us to rename or remove this lock?

My point is, since you have two locks, explain why you need each of them.

> > > +       struct device *dev;
> >
> > > +       struct regmap *regmap;
> >
> > > +       struct regmap_field *fields[F_MAX_FIELDS];
> > > +       const struct reg_field *reg_fields;
> > > +       const struct linear_range *ranges;
> > > +       struct reg_cfg *reg_cfgs;
> > > +       unsigned int leds_count;
> > > +       unsigned int leds_active;
> > > +       bool is_mt6372;
> > > +       struct mt6370_led leds[];
> > > +};


-- 
With Best Regards,
Andy Shevchenko
