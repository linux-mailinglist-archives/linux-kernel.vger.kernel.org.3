Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADD446D568
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhLHOTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhLHOTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:19:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B83C061746;
        Wed,  8 Dec 2021 06:16:13 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id e3so8889791edu.4;
        Wed, 08 Dec 2021 06:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KLhxQdlpjbVMTlQMKSpDlPMiN1Zg/spaNOwCNsIH3Sg=;
        b=p1Jz0sTM/Vr8aJXiXX2cTU0ZaW24RdBC0G6MsKG8vXLzNQmp0CBoFth4oGQKT7AYSQ
         sVdgm1Qdbhs604SbT++465MGrJNGbPKr8fOi6tjtX4SHJeGgvnHtPspMLUsAo4GoDKyx
         RhQynqskCeaZEsH1zDJWAMxlo2sZnFN+gmWnzmIoX11NNibMzJ1Qd76SA63CP8vxdTUr
         Di1TYFCBrcTv2ZI4X0MvbGwD1xUhyR/eRy04DLA39spqCNR6a/fVDgxmpxqMZX1XP3/t
         0smt8iDCgijczUdlTvQpD46T+okPKBFrL6BjPyZsHxHrUJakRyhcq8QxrFU0fUFhwVTX
         moMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KLhxQdlpjbVMTlQMKSpDlPMiN1Zg/spaNOwCNsIH3Sg=;
        b=jREvoC0JBZKAIouVCyzkNO42zocodzJS4Wl7iNbvW1a1ne0pwkrSCDqhU0jRupfoup
         YGb1TrUuSDHjwKXMd2ElpWwNsfc06c2R46hjTM/1282Xer4usLju6WlrZC6XO9GEukIh
         IzY8xNTRm30uU50cg4QK6BaoVWmFG9Uvs+dVTKw8qAh8NzDUykVZ3yCgVGwsAb3ZCbos
         0ak8XD7iTIs6mjjoewbKuaKJFk4f1N9m5KXN+Gk9XkVwYctbtgHxh4a818wmCUSqNJKZ
         ZRLJ56nHE9JDKQaAA5BfEWnWIKvfFrcaKjq7QsvwMpCDDSXnxqMowQMygk3sRVk52keC
         vWYQ==
X-Gm-Message-State: AOAM5310RVytHMkFq7aXQIQQrGePkmHc7arMZ29z8YCOa2qkjJnno20W
        aDoZb3ld81LuStkHaTkILi8WXK3cgYy/ygIW+oM=
X-Google-Smtp-Source: ABdhPJxhOheYtaqyypDuzPCT0bxzTxaW5/lEo+dd8oH4Y3ZMYqGNankJpzTTMosXhJhZ79j9Rg9FaLxll18EF6B6K14=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr8177164ejc.141.1638972971450;
 Wed, 08 Dec 2021 06:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
 <20211207210823.1975632-6-j.neuschaefer@gmx.net> <CAHp75Vew=M_ofNM5pmeHtTJHXRUbbO4RrtgYAtLBznTBm3CS6Q@mail.gmail.com>
 <YbC6Bv2teZ5CFhFQ@latitude>
In-Reply-To: <YbC6Bv2teZ5CFhFQ@latitude>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Dec 2021 16:14:38 +0200
Message-ID: <CAHp75VdYtLbCLi7iD0UT7MrPi9oxJLWA9ZCBo7uGbWxNCBdGyw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] pinctrl: nuvoton: Add driver for WPCM450
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 3:58 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
> On Wed, Dec 08, 2021 at 01:24:18PM +0200, Andy Shevchenko wrote:
> > On Tuesday, December 7, 2021, Jonathan Neusch=C3=A4fer <j.neuschaefer@g=
mx.net>
> > wrote:

...

> > > +       ours =3D ((1UL << gpio->num_irqs) - 1) << gpio->first_irq_bit=
;
> >
> > BIT()
>
> I'll use it, but in this case, I think it doesn't simplify much the
> whole expression all that much.

It is still better to use in my opinion.

> Is there perhaps a macro that
> constructs a continuous bitmask of N bits, perhaps additionally
> left-shifted by M bits?

> Maybe somewhere in the bitmap_* API...

Maybe, I dunno since I haven't clearly got this code anyway, so up to
you to check and see what to do about it.

...

> > > +       struct fwnode_handle *np;
> >
> >  Either be fully OF, or don=E2=80=99t name =E2=80=98np' here. We usuall=
y use fwnode or
> > =E2=80=98child=E2=80=99 in this case.
>
> Ah, I thought "np" (=3D node pointer) was still appropriate because I'm
> dealing with firmware _nodes_. My intention was indeed to switch fully
> to the fwnode API.

Just a convention "de facto".

...

> > > +               ret =3D gpiochip_add_pin_range(&gpio->gc,
> > > dev_name(pctrl->dev),
> > > +                                            0, bank->base, bank->len=
gth);
> > > +               if (ret) {
> > > +                       dev_err(pctrl->dev, "Failed to add pin range =
for
> > > GPIO bank %u\n", reg);
> > > +                       return ret;
> > > +               }
> >
> > Please move it to the corresponding callback.
>
> What's the corresponding callback?

https://elixir.bootlin.com/linux/latest/source/include/linux/gpio/driver.h#=
L400

--=20
With Best Regards,
Andy Shevchenko
