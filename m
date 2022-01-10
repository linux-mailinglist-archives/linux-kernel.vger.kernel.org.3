Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6F3489F67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbiAJSn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbiAJSn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:43:27 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ED6C06173F;
        Mon, 10 Jan 2022 10:43:27 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i5so3717675edf.9;
        Mon, 10 Jan 2022 10:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ktWa16PHInydFUoIdRaEpmLgiNbk/GAQbHlU2gA4X+E=;
        b=UTXtWU1SRqUKoqId3SFiqE+nwbfvzrdqPFdxJ3sOtpxCyoIPidhNNA8K8bghcoxZCC
         2I9ijhlFlXmzrnn5xZYPqYZ559Nb/ZV5Hv18LjpdD2BhgfpmqTe0SHRcifNKMBYdk93+
         H2jkGwqi5lQC9Wkz2t4v3VNhIbJ5cy7f31io8h7EhfLLUr5ghVUsXR0ycifnk7Q0X47/
         3eiHLA3GEz4mpaBWLti7DSqzyDa/Q+RotIrMGjDKdwYkc9LxbDSoLKzNs/TwhBYHurqq
         C9/+d194NKXMuhWlJ28506frmgoX45QbXDhhBJjTZiJwMwi7JzW/hL1P66yBu0fMNb6v
         Hjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ktWa16PHInydFUoIdRaEpmLgiNbk/GAQbHlU2gA4X+E=;
        b=2zWp0NfpH9A0kpKGcLpRuz4ar0KYRvojzrjoCyQ0100ZtJURwIyGlNV0usycI9znMR
         O6YEj6fFN3MunH36DWrHQ746piCfEy0gevMPnwwM5V+UQwWxkuS958qe0RWcdT88+/c2
         hn1O+HTzsIaYvkt6ZgaXFKq743TtgViwqxXfkoSn+QMxmj5DCkUldyaCxM7g4MBezejd
         Va17yjREj8/EKDrZokq4k0wPvlj0LgpVwe2iLtTTcJi7YqRnymW3+N/95KoxMOmAFYOj
         C9xiAv/4LhJJcTcLmuuCgT38/j8irxN6xm6kOYOopHECZebqo4/9v5YRLAGp6oqSRNcZ
         N3yw==
X-Gm-Message-State: AOAM531CnYPMxdMMYGmdP49lnXoQ40/HlKxeWckyAPImyOLBMkijxbqd
        AteqNz/UdKNsLeYcJYt95Lw779wfLnvcNAKNnoU=
X-Google-Smtp-Source: ABdhPJw5NQ7WwbPQ44x/U8u6NJGKgs389IA8RlqoWZDkV1dVdAXLxnBzvO3aB0TappuObRxAgwj8FO3hxsKoz899Jk0=
X-Received: by 2002:a05:6402:4c5:: with SMTP id n5mr985184edw.122.1641840205797;
 Mon, 10 Jan 2022 10:43:25 -0800 (PST)
MIME-Version: 1.0
References: <1640331779-18277-1-git-send-email-wellslutw@gmail.com>
 <1640331779-18277-3-git-send-email-wellslutw@gmail.com> <CAHp75Vd3iMM+NteJXP_mMAyw5momk3xzp1Y2GX-YJZfFSAwo9A@mail.gmail.com>
 <f87b21407ed44630a86b2661deab4a58@sphcmbx02.sunplus.com.tw>
In-Reply-To: <f87b21407ed44630a86b2661deab4a58@sphcmbx02.sunplus.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Jan 2022 20:41:37 +0200
Message-ID: <CAHp75VcPB_K6RD8tnMarwGCeaOKcQ_knxvKEW9WNn_4ce41szw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pinctrl: Add driver for Sunplus SP7021
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

On Tue, Dec 28, 2021 at 5:38 PM Wells Lu =E5=91=82=E8=8A=B3=E9=A8=B0 <wells=
.lu@sunplus.com> wrote:

...

> > > +       bool "Sunplus SP7021 PinMux and GPIO driver"
> >
> > Why bool and not tristate?
>
> Pinctrl driver is selected by many drivers in SP7021 platform.
> We never build it as a module, but build-in to kernel.
> So we use "bool".
>
> Should we set it to tristate?

You still haven't answered "why", so I can't tell you.

...

> > > +               /*
> > > +                * Upper 16-bit word is mask. Lower 16-bit word is va=
lue.
> > > +                * Refer to descriptions of function sppctl_master_ge=
t().
> > > +                */
> > > +               reg_off =3D (offset / 16) * 4;
> > > +               bit_off =3D offset % 16;
> > > +               reg =3D BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT) |
> > > + BIT(bit_off);
> >
> > As I commented above use helper function which takes offset as input an=
d returns you reg
> > and reg_off.
>
> I'll modify code as shown below:
>
>                 reg =3D SPPCTL_SET_MOON_REG_BIT(bit_off);
>
> Sorry, I don't understand your meaning "returns you reg and reg_off".
> The helper macro will return reg but not reg_off, right?

Something like (fix types accordingly to your needs):

static inline u32 sppctl_get_reg_and_offset(unsigned int offset, u32 *roff)
{
              u32 boff =3D offset % 16;
              *roff =3D (offset / 16) * 4;

               return  MY_COOL_MACRO(boff); // BIT(boff +
SPPCTL_GPIO_MASK_SHIFT) | BIT(boff)
}

    reg =3D sppctl_get_reg_and_offset(offset, &reg_off);

...

> > > +       if (!of_find_property(pdev->dev.of_node, "gpio-controller", N=
ULL))
> > > +               return dev_err_probe(&pdev->dev, -EINVAL, "Not a
> > > + gpio-controller!\n");
> >
> > Why do you need this check for?
>
> By referring to other pinctrl driver, we check if property "gpio-controll=
er" exists?
> Will core help us check this?
> Is this redundant?

You should answer this question, not me.

...

> Should I also remove the assignment:
>
>                 gchip->base             =3D 0;

Actually this is a good catch. Why do you use 0 as a base? In the new
code we are supposed to have -1 to be assigned.

...

> > > +       case pinmux_type_fpmx:  /* fully-pinmux */
> >
> > Why do you need these comments?
> > Shouldn't you rather to kernel doc your enum entries?
>
> I'll remove the comments.
> Could you please tell me where I should write and put my kernel doc?
> Is there any examples I can refer to?

In the enum definition you do something like this (and read documentation):

/**
 * enum ...
 * @pinmux_type_fpmx: fully pin muxing
 * @pinmux_type_grp: group pin muxing
 * ...
 */

...

> > > +       if (unlikely(check_mul_overflow(sppctl->unq_grps_sz + 1,
> > > +                                       sizeof(*sppctl->g2fp_maps), &=
prod)))
> > > +               return -EINVAL;
> >
> > What the point to check it after? What the point to use it with kcalloc=
()? Please, do your
> > homework, i.e. read the code which implements that.
>
> I'll remove the "if (unlikely(check_mul_overflow()...) return -EINVAL" st=
atement next patch.
>
> I think I mis-understood your previous comment.
> I thought I was asked to add check_mul_overflow() function for devm_kcall=
oc(...).
> Sorry for strange codes.

There were basically two iterative comments, i.e.
first one suggested adding a check, but second one suggested switching
to kcalloc() API.

> I should study devm_kcalloc() furthermore. Now I know devm_kcalloc(...) d=
oes
> multiplication overflow check for us. That's why we need to devm_kzalloc(=
) with
> devm_kcalloc().
>
> One question left in my mind is, in this case, even we have 10,000 pins,
> we will never get overflow. It looks not so necessary.

But it's not your issue, the kcalloc() does it for you for the good sake.

...

> > > +       struct device_node *np =3D of_node_get(pdev->dev.of_node);
> >
> > What's the role of of_node_get()?
>
> I'll remove the unused codes.
> I think it was used to check if OF node exists.

And if it doesn't, what is the difference?

You are the author of this code, please be prepared to explain every line i=
n it.

...

> > > +       dev_info(&pdev->dev, "SP7021 PinCtrl by Sunplus/Tibbo Tech.")=
;
> >
> > Is it useful?
>
> I think yes. It tells users that Pinctrl driver has probed successfully.
> If no this message, users don't know if Pinctrl driver has probed
> successfully or not. For example, because that dts node of pinctrl is
> "disabled" or Pinctrl driver is even not enabled.
>
> Can I keep this?

You can, but I think it's not needed.
Users may easily get this from other sources. Why do you need to have
such noise in the valuable resource, i.e. kernel message buffer?

...

> > > + *    - mux_f_mux:  Select the pin to a fully-pinmux pin
> > > + *    - mux_f_gpio: Select the pin to a GPIO or IOP pin
> > > + *    - mux_f_keep: Don't change (keep intact)

> > > +       mux_f_mux =3D 0,          /* select fully-pinmux       */
> > > +       mux_f_gpio =3D 1,         /* select GPIO or IOP pinmux */
> > > +       mux_f_keep =3D 2,         /* keep no change            */

These comments are replaced by the kernel doc above, no need to keep them.

...

> > Why is this in the header?
>
> Do you mean I need to move this "struct sppctl_gpio_chip { ... }" declara=
tion
> to c file because it is only used by the c file?

Yes.

...

> Your previous comments:
> > > > > +static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, st=
ruct device_node *np_config,
> > > > > +                                struct pinctrl_map **map, unsign=
ed
> > > > > +int *num_maps) {
> > > >
> > > > Looking into this rather quite big function why you can't use what =
pin control core provides?
> > >
> > > No, we cannot use functions pin-control core provides.
> > > Please refer to dt-bindings document, "pinctrl/sunplus,sp7021-pinctrl=
.yaml".
> > > We have more explanation there.
> >
> > Fine, can you reuse some library functions, etc? Please, consider refac=
toring to make it more readable.
>
> Could you please share me your idea about "refactoring"?
> Or could you give me some hints?
> I think many times, but have no idea about refactoring.

Just split it to a few logical parts so that code can be easier to read.

--=20
With Best Regards,
Andy Shevchenko
