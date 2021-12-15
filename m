Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5950847585A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242272AbhLOMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbhLOMEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:04:43 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44679C061574;
        Wed, 15 Dec 2021 04:04:43 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id e3so74781668edu.4;
        Wed, 15 Dec 2021 04:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fh+b0d/G/RYNJXFF40rUlUpI/+ANIUMDQ5PZvslWC18=;
        b=VimX2k1OUuTSuFh7b+jz2yVmjY6UAVEjjMGHQ2T+r+QSTBkkUGDpY4t+8+Y/DE+4Zv
         tSd4YkizUbOZrpSg7AksTfIhhmkR0P4TxgLSxGVZj1iLZghezvQVwdx4BotnfqaiQpbK
         jmHqlny2Kqlr7hy3xnFK3rIflkl9VKp7NU9+Fi5fAI3z6Aq13/vu2aE1w12OX1aY3jW/
         nN00YkRiPRTNTBTVW08HgODKM6B69+FBW31+4kdgfyZytQg59iuKeR8lGVRx+WfLwaXZ
         W0MuRUDQ1gPwSSAHiHSJlQH0z2i/Yv9VY8dAo7f3YVGfENHVsUllDNvl722XJkt/ykeW
         lRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fh+b0d/G/RYNJXFF40rUlUpI/+ANIUMDQ5PZvslWC18=;
        b=PznfActwdFaeGIHlsG8RmEen14T2tISr8W5xQX31fAPhbOFfj6VAzC0W7qcF23l2/M
         oTml2+uOhlCdxkoi2JiNB69u6493ixYVi5Vd8e2PzySdnzz5A7k2AMW/Kjl/wMXVn72c
         +e8GgSqJXSGRE6jckfsbbJ4qRmkPScLDdZsS3vBoRpdUGs8p8ayLtaAg1PZ4/N4eig4c
         NcqeKUoRKhDZKQPGIWvUcZ0XScG+pKMi5RkS0fenIje1dhu53zsI8cmO4k13TZEzilq4
         i/Wit2b9zEWtoRIj7UVeSNt5sTl/CTCvxwSagt5Sf4n4SzWB81XXfz9A1hYKIIi5JXcZ
         xs+w==
X-Gm-Message-State: AOAM532KMfy5DMq8ZnkOxPjpJbGNMN6MAfZMzjJKQN2zgzUjB4tTTOIh
        CyqfulqPpg7Drz87HyJDsB4x1tCVqcyaXcZEGpw=
X-Google-Smtp-Source: ABdhPJzuIm3D6+Txl2/eLyUCM4fAPxpVo3qVrlnl2Ad3iOfoss9AXs0RtMEL+O6o+r9V6jdwQPfGQS/aJppbuCtqhmQ=
X-Received: by 2002:a17:907:75f0:: with SMTP id jz16mr11236403ejc.77.1639569881649;
 Wed, 15 Dec 2021 04:04:41 -0800 (PST)
MIME-Version: 1.0
References: <1639479189-6693-1-git-send-email-wellslutw@gmail.com>
 <1639479189-6693-3-git-send-email-wellslutw@gmail.com> <CAHp75VcnkZmzZE5C5z+kyrJoGRx8t60e_vDrw4HXOocY=Mjqsw@mail.gmail.com>
 <83d865b82e574ab49ae0c5fc160774c0@sphcmbx02.sunplus.com.tw>
In-Reply-To: <83d865b82e574ab49ae0c5fc160774c0@sphcmbx02.sunplus.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Dec 2021 14:03:12 +0200
Message-ID: <CAHp75VcU_2HR2qamGmuYBjXtaG_b55vgAUv20rb7LfPo3q-HYA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pinctrl: Add driver for Sunplus SP7021
To:     =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Cc:     Wells Lu <wellslutw@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:40 AM Wells Lu =E5=91=82=E8=8A=B3=E9=A8=B0 <well=
s.lu@sunplus.com> wrote:

...

> > > +/* SP7021 Pin Controller Driver.
> > > + * Copyright (C) Sunplus Tech/Tibbo Tech.
> > > + */
> >
> > This is wrong style for multi-line comments. Fix it everywhere accordin=
gly.
>
> I'll modify all multi-line comments, for example, as shown below:
>
> /*
>  * SP7021 Pin Controller Driver.
>  * Copyright (C) Sunplus Tech/Tibbo Tech.
>  */
>
> Now, I realized that each subsystem has its own comment style.

Actually there are only two styles:
 - this one (as updated version) for entire kernel with the exception of
 - net / network one (as you used originally)

> > ...
> >
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pinctrl/pinmux.h>
> > > +#include <linux/gpio/driver.h>
> > > +#include <linux/module.h>
> > > +#include <linux/bitfield.h>
> >
> > Keep them in order. Besides that it seems missed a few headers, such as=
 of.h.
>
> I am not sure what order should I keep for inclusions.
> Reversed x'mas tree order? Alphabetic order?

Alphabetical. When you don't see a direct answer the rule of thumb is
to go to the recent contributions and check a few new drivers to see
how they are doing.

> Some reviewers ask to remove unnecessary header files.

So that reviewers are right and maybe wrong (see below for the
details), I don't see those reviews so I can't judge.

> So I removed all unnecessary header files if compilation
> completes without any errors or warnings.

Have you checked how deep and sudden the header inclusion went?

> I suppose <linux/of.h> has included by other inclusion.

Of course and it's wrong in your case. No header from above guarantees
that. See below.

> Need I add <linux/of.h> or other inclusions back?

The rule of thumb is that you have to include all headers you are a
direct user of.
There are some that guarantee inclusion of others, like
bits.h is always included if you use bitmap.h  (via bitops.h) or
compiler_attributes.h is always provided by types.h.

You have to find a golden ratio here (yes, it's kinda knowledge that
doesn't come at once, needs to have some experience).

...

> > > +       val =3D (reg & BIT(bit_off)) ? 1 : 0;
> >
> > !!(...) may also work, but it's rather style preference.
>
> The return value is integer 0 or 1, not Boolean.

Yes, and it's exactly what has been suggested. It's a C standard
allowed trick. With the -O2 compiler gives you the same code for both
(at least on x86).

...

> > > +       reg =3D readl(spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_MASTER=
 +
> > > + reg_off);
> >
> > I noticed a potentially big issue with this driver. Are you sure it's b=
rave enough to do
> > I/O without any synchronisation? Did I miss a lock?
>
> Do I need to add spin_lock() for all gpio operation functions?
> Please teach me what operation functions I need to add lock or
> all operation functions need lock?

I don't know. You need to answer this question, it's your code. And
you know how it's supposed to be used etc, etc.

...

> > > +       reg =3D readl(spp_gchip->gpioxt2_base + SPPCTL_GPIO_OFF_OD +
> > > + reg_off);
> >
> > You may create an I/O wrappers to achieve a much better to read code (n=
o repetition of
> > this arithmetics, etc).
>
> I think this is the simplest in-line form:

No, it's harder to read and easy to mistake what the base and / or
offset is used, what value, etc.

> "spp_gchip->gpioxt2_base" is base address.
> SPPCTL_GPIO_OFF_OD is register offset to base of OD (open-drain) register=
s.
> reg_off is register offset to an OD register (SP7021 has 7 OD registers t=
otally).
>
> Need I add macros (wrappers) for accessing registers?
>
> For example,
>
> #define SPPCTL_GPIO_OD(off)     (spp_gchip->gpioxt2_base + SPPCTL_GPIO_OF=
F_OD + off)
>
> reg =3D readl(SPPCTL_GPIO_OD(reg_off));
>
> or
>
> writel(reg, SPPCTL_GPIO_OD(reg_off));
>
>
> Mr. Linus Walleij told me that he likes in-line (direct) form, instead of=
 macro
> because in-line form has better readability (No need to jump to other fil=
e for
> reading macros).
>
> Could you please share me with your idea?

It's an idea that is used in zillions of the drivers (and not via macros).

static inline spp_readl(struct ... *spp, u32 offset)
{
  return readl(...);
}

Same for _writel() and so on.

...

> > Perhaps to show only requested ones? In such case you may use
> > for_each_requested_gpio() macro.
>
> I'd like to keep showing status of all GPIOs.
> This helps us know status of all GPIOs when debugging hardware issue.

Since it's a pin control driver, the pin control debug callback can
show this. For GPIO I would rather not be bothered with not requested
pins. But it's your decision.

...

> > > +       gchip->parent =3D            &pdev->dev;
> >
> > > +       gchip->of_node =3D           pdev->dev.of_node;
> >
> > Drop this dup. GPIO library already does it for you.
>
> But when I removed the two statements, I found both 'gchip->parent' and
> 'gchip->of_node' are always 0. No one helps set it.
>
> Do I miss doing somethings?

Yes, I put blank lines around the dup and left context (as a first
line) to show why the second one is a dup. When you miss something,
read the implementation code. It's open source at the end!

...

> > > +       dev_dbg(pctldev->dev, "%s(%d, %ld, %d)\n", __func__, pin,
> > > + *configs, num_configs);
> >
> > Noise. Better to consider to add necessary tracepoints to pin control c=
ore.
>
> What should I do?
> Should I remove it?

I wouldn't expect these to be in the production-ready driver. And
since you are committing to drivers/pinctrl and not to drivers/staging
I consider that you are trying to push this code as production-ready.

...

> > > +       dev_dbg(pctldev->dev, "%s(%d)\n", __func__, offset);
> >
> > Noise. And so on, so on...
>
> Should I remove dev_dbg? Or modify it?
> But it will not print out anything in normal run, only for debugging.

See above.

...

> > > +       dev_dbg(pctldev->dev, "%s(%d), f_idx: %d, g_idx: %d, freg: %d=
\n",
> > > +               __func__, selector, g2fpm.f_idx, g2fpm.g_idx,
> > > + f->freg);
> >
> > No need to use __func__, and especially in case of _dbg / _debug. It ca=
n be enabled at
> > run-time with help of Dynamic Debug.
>
> Should I need to remove all __func__ in this driver?

As the first step, the second one is to remove 90%+ of these messages
as I explained above.

...

> > Looking into this rather quite big function why you can't use what pin =
control core provides?
>
> No, we cannot use functions pin-control core provides.
> Please refer to dt-bindings document, "pinctrl/sunplus,sp7021-pinctrl.yam=
l".
> We have more explanation there.

Fine, can you reuse some library functions, etc? Please, consider
refactoring to make it more readable.

...

> > > +       sppctl->groups_name =3D devm_kzalloc(&pdev->dev, sppctl_list_=
funcs_sz *
> > > +                                          SPPCTL_MAX_GROUPS *
> > > + sizeof(char *), GFP_KERNEL);
> >
> > Ditto. And check some interesting macros in overflow.h.
>
> I'll modify code to use devm_kcalloc().
>
> I'll modify sizeof() to use type of variable, that is:
>         sizeof(*sppctl->groups_name)
>
> Please teach me what macros should I check?
> There are many macros in overflow.h.

Do your homework, it's not me who makes this contribution :-)
Hint: something about multiplication.

...

> > > +       if (IS_ERR(sppctl->moon2_base)) {
> > > +               ret =3D PTR_ERR(sppctl->moon2_base);
> > > +               goto ioremap_failed;
> >
> > What is this for? Use return dev_err_probe() directly.
>
> There are 5 devm_ioremap_resource() in this function.
> To avoid from duplication, goto an error-handling when ioremap failed.

What error handling? You have the same point which does the same for
them, I don't see duplication avoidance. See below as well.

> > > +       }

...

> > > +ioremap_failed:
> > > +       dev_err_probe(&pdev->dev, ret, "ioremap failed!\n");
> >
> > This doesn't bring any value,
>> besides the fact that API you have used already prints a
> > message.

(1)

> I'll modify code to as shown below (error-handling here):
>
> ioremap_failed:
>         return dev_err_probe(&pdev->dev, ret, "ioremap failed!\n");
> }
>
> Is this ok?

No.

> If not, please teach me how to modify.

Read again what I wrote in (1).

> > > +       pdev->dev.platform_data =3D sppctl;
> >
> > Don't we have special setter for this field?
>
> I know platform_set_drvdata() function is used to set "dev->driver_data".
> I cannot find a function to set "dev->platform_data".
> Please teach me what function should I use to set "dev->platform_data"?

Ah, now I even may say that the above assignment is simply wrong.
It's not designed for what you think it's for. Use different ways.

...

> > > +       dev_info(&pdev->dev, "SP7021 PinCtrl by Sunplus/Tibbo Tech.
> > > + (c)");
> >
> > No value.
>
> This shows that pinctrl driver has probed successfully.
> Many drivers show this kind of information.

And there is no value in this information.

> Do I need to remove it? Or change to dev_dbg(...).

Neither in this case.

Explain the point "why?". In general you have to explain each line of
your code "why are you doing this or that?".

...

> > > +#ifndef __SPPCTL_H__
> > > +#define __SPPCTL_H__
> >
> > This header misses the inclusions such as bits.h.
> > And I believe more than that.
>
> Some reviewers ask to remove unnecessary header files.

What do you mean by this in this case. This is a clear miss of bits.h
here as you use macros from it. Imagine if you include this file
somewhere where bits.h hasn't found its mysterious ways.

> I removed all unnecessary header files if compilation completes
> without any errors or warnings.
>
> If compilation has done successfully,

So what? It doesn't mean the code is bad in one way or another, :-)

> does it mean all
> necessary inclusions has included well?

> Besides, before private header files are included,
> Linux or system header files will be included.
> No need extra inclusion here, right?

See above.

...

> > > +/* FIRST register:
> > > + *   0: MUX
> > > + *   1: GPIO/IOP
> > > + *   2: No change
> > > + */
> >
> > For all comments starting from here and for similar cases elsewhere:
> >  - why it is not in kernel doc?
> >  - what the value that add?
> > (Some of them so cryptic or so obvious)
>
> The comment explains usage of 'enum mux_f_mg'
> The 'enum' is only used in the driver.
> It helps programmers to remember or look-up the define of the enum.
> Need we add this kind of comment to kernel doc?

Why not?

> > > +static const struct sppctl_grp sp7021grps_spif[] =3D {
> > > +       EGRP("SPI_FLASH1", 1, pins_spif1),
> > > +       EGRP("SPI_FLASH2", 2, pins_spif2)
> >
> > Here and everywhere else, leave a comma if it's not a terminator entry.
>
> The constant array 'sp7021grps_spif[]' is declared and initialized
> to have 2 elements. 'EGRP("SPI_FLASH2", 2, pins_spif2)' is the
> latest element.
> Why do we need to add 'comma' for the latest element of an array?

To avoid the churn in the future when it will be expanded. Believe I
saw this kind of "proves" that this or that won't ever be expanded and
then... you may picture what happens.

> If we add extra comma, the array will have one more element.

Yes, with touching the "last" one here. Please, add commas where it's
not a crystal clear a termination (which is not in many cases, usually
arrays with NULL entry or enums with MAX value at the end).

--=20
With Best Regards,
Andy Shevchenko
