Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553FF48DD6F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbiAMSGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiAMSGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:06:17 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7339FC061574;
        Thu, 13 Jan 2022 10:06:16 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id k15so26010544edk.13;
        Thu, 13 Jan 2022 10:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jm0IN7OuQqYoHMgQAF3hasCHaG8wJhHFzsPPlKKF2VE=;
        b=VLvv8XZyDLHHO/LKcFoOGnSRFo6Ipchbza9EqqUyl+J5nRE+tygJmLL+FYGR80f0Q4
         tGCykf7UE6ufTWnXfpqLiuKS1E2wIl7raKCMd6NTYqeTwfi0epFUfkv0vUEKQW/Paolv
         GbljhyA9WonlUOE+TXX1S43oBHtO91eMMAxPRJXsr25EcPmcrbRwZVn0wJ93l0IYVpdx
         TfiLfPg3fGN4Lm8iUGZxa/1A2OobuBh5x8T0VvFUhwtk2MxmY5DFekLyqYympmnTH0a/
         Ye1sZPPLFxPtQPIXZ/ghKWKItOuqzVLjl6p6U7M/Xx7yv+V936P0lDjBQ/GCYxZedIXv
         YuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jm0IN7OuQqYoHMgQAF3hasCHaG8wJhHFzsPPlKKF2VE=;
        b=dB5zvHB16qB3gqJFcUXi6mh1+sSLdUkqb+7J3HGHWBA94FgkxBZbgyqd1Yl5beT9MI
         NlJzEPOG08aqRZfuEsOSnsz51vT00F//lKpNF6v935IO1KuJrtmjlNmZXAkuU7ZAGXNb
         WVkPRa4R6U4wVOBmm2VRaWnq1WzNx8/bbbOTs7e/g3hJt/RUs6M4XFDd0XRu/4i+Sqvd
         8UQ9JrGUklzu7hp78ibOuYqMwtaX9RBbEqJTInN4QLzDa2kcOmT8pnDSuNy0rMJ2Btfa
         kuUvhRbhv/2BFuCsohxPpmnR0eNLxru/CT2pHU0KAzWdX12axdCss1v6end6FLPyBezU
         K/5A==
X-Gm-Message-State: AOAM5301JuDGb2xylptURDi1KjL+eKsNzZftjBF6Qk5yp9+5CvspRLAJ
        EVozAGgKFoImbCpzbSzaZVMlNPJRHKrIBTGe79o=
X-Google-Smtp-Source: ABdhPJwYzKGaMqd0LTSao7N9p+ByRU8ZSuhIRyDQQebjD8+362ZauRmnZHpxCQfym5MWLjoldpIGIDl1fJCCuMCKB04=
X-Received: by 2002:aa7:ccda:: with SMTP id y26mr5231276edt.218.1642097174560;
 Thu, 13 Jan 2022 10:06:14 -0800 (PST)
MIME-Version: 1.0
References: <1640331779-18277-1-git-send-email-wellslutw@gmail.com>
 <1640331779-18277-3-git-send-email-wellslutw@gmail.com> <CAHp75Vd3iMM+NteJXP_mMAyw5momk3xzp1Y2GX-YJZfFSAwo9A@mail.gmail.com>
 <f87b21407ed44630a86b2661deab4a58@sphcmbx02.sunplus.com.tw>
 <CAHp75VcPB_K6RD8tnMarwGCeaOKcQ_knxvKEW9WNn_4ce41szw@mail.gmail.com> <cf53f5dc57e342078ec14a771ba639ca@sphcmbx02.sunplus.com.tw>
In-Reply-To: <cf53f5dc57e342078ec14a771ba639ca@sphcmbx02.sunplus.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Jan 2022 20:04:28 +0200
Message-ID: <CAHp75Vf0=Sf8sGtgCo7bMjVFGYDcJOasLqdSHTnQ0YPgSbrr2g@mail.gmail.com>
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

On Thu, Jan 13, 2022 at 7:04 PM Wells Lu =E5=91=82=E8=8A=B3=E9=A8=B0 <wells=
.lu@sunplus.com> wrote:

...

> > > > > +       bool "Sunplus SP7021 PinMux and GPIO driver"
> > > >
> > > > Why bool and not tristate?
> > >
> > > Pinctrl driver is selected by many drivers in SP7021 platform.
> > > We never build it as a module, but build-in to kernel.
> > > So we use "bool".
> > >
> > > Should we set it to tristate?
> >
> > You still haven't answered "why", so I can't tell you.
>
> I am puzzled because I think I have answered "why".

Nope. :-)

> Because Pinctrl driver is necessary for all SP7021-based platforms.

"Why?" Why is it necessary (to be built-in)?

...

> > > > > +       struct device_node *np =3D of_node_get(pdev->dev.of_node)=
;
> > > >
> > > > What's the role of of_node_get()?
> > >
> > > I'll remove the unused codes.
> > > I think it was used to check if OF node exists.
> >
> > And if it doesn't, what is the difference?
> >
> > You are the author of this code, please be prepared to explain every li=
ne in it.
>
> From kernel-doc comment, of_node_get() increments refcount of a node.
> I think as a platform driver, we don't need to check if the node exists o=
r not.
> If not exist, platform driver will not be probed.

Right!

...

> > > > Why is this in the header?
> > >
> > > Do you mean I need to move this "struct sppctl_gpio_chip { ... }"
> > > declaration to c file because it is only used by the c file?
> >
> > Yes.
>
> But "struct sppctl_gpio_chip" is not only used in c file, but also used i=
n the
> same header file just beneath it. Refer to code below:

Thanks for the snippet. It actually shows the opposite. No, below is
the user of the _pointer_ to the struct of that type. You may easily
use the "opaque pointer" approach. I.o.w. my comment stays.

> struct sppctl_gpio_chip {
>         :
>         :
> };
>
> struct sppctl_pdata {
>         :
>         :
>         struct sppctl_gpio_chip *spp_gchip;
>         :
>         :
> };

--=20
With Best Regards,
Andy Shevchenko
