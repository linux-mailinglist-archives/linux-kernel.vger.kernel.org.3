Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A54962FF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378612AbiAUQih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351463AbiAUQie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:38:34 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCBFC06173B;
        Fri, 21 Jan 2022 08:38:34 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 23so29116558ybf.7;
        Fri, 21 Jan 2022 08:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHZcjfZniLH+nwXIkqFM0COnR9misHlg1zvEqkI44uA=;
        b=SDfBhQ9mjvklnQKARZG77q7v6BWF09ryP70Y9dUmGzM681DX+6f0hV0nL5gvPPm01c
         0fLmGh8Yq5GvKjmWh8VPh/BLiQGAX9Lx5CYq6wdM85f35Z/PrnFRooCLGCoWCqo7OY+z
         5qxsmqJUyqfjvYS+o+wiVoRa+fF5FsPsrkoHKdWz5Ts0idHXoYpqW1PlKfvxTX3iUtZj
         K/rGXhgfO2cChxoYDq86+NDHGPMl0a9T7qkE33TNgPu99hYJ8kgQoT2AVs6MUCylaKBp
         G7QCPHA344mOeam9uOk1N7jqbDOMRQqb0D45r3GtGpsQqLNv1BRp/nBj8M0Zsa1Oqwug
         MWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHZcjfZniLH+nwXIkqFM0COnR9misHlg1zvEqkI44uA=;
        b=zZk7FaHopr0OlLF52Z52P6O4fOZPwPsJ5yY8HqBCCL5JE9rpG1mrVsdx6Geg1+Qgw1
         oq+vlk9/E+MkE+LOCuZapDRASLpmJBoZmRDZFQGPkCRlInOr0qkHpDfmEgkkiViBe/ef
         28jM+JuBmdey3zIy1X7fvWD4n3NDqa1dl0+rsHOvmHOkitocr3sepjaAumaW+u2fv+Gy
         tGVWYYiV0SFvyruu+79jnC7EjVLGQ9XblX5KXgc9dq7NIqfEaiSYfDa2p67zCX5L46zE
         nAgZxg20sH4ii/QvwbBVcWMUZGf9Zvf5CL68EfBm/eUcc9LAa32kXV8y05UPEgKmLo9u
         JxsQ==
X-Gm-Message-State: AOAM533C6O15dbxhY7tnWqbbdOtD+jKipxDMm7lGyenf007sErqa4osr
        jbmwqz6oazHJSWaEKqlfNxaM9v97MmUcIGpdDCU=
X-Google-Smtp-Source: ABdhPJxuixbrNHpPtHIwoMOs8uf3+ZpaBQ/P5TM6dtdBZJDA95VBFRxmimMs4csRn21DFrU4eA1NTnr1it1ZrBRkq5A=
X-Received: by 2002:a25:3716:: with SMTP id e22mr7085879yba.690.1642783113796;
 Fri, 21 Jan 2022 08:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110134659.30424-13-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUopcuP6XAd_Fw___04=-CyqJPEfNcwkrYgtdQz11yYvg@mail.gmail.com>
In-Reply-To: <CAMuHMdUopcuP6XAd_Fw___04=-CyqJPEfNcwkrYgtdQz11yYvg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 21 Jan 2022 16:38:07 +0000
Message-ID: <CA+V-a8t5LHWCMerxdyFwSqrXKG0TCsykgXwrt4P6_nwm=11kxQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] arm64: dts: renesas: Add support for r9a07g044c1/r9a07g054l1-smarc.dts
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Ouch please ignore this patch.

Now I know where I missed the v2 combining "[PATCH 01/16] dt-bindings:
arm: renesas: Document Renesas RZ/V2L SoC" and "[PATCH 02/16]
dt-bindings: arm: renesas: Document SMARC EVK". I picked a wrong
commit-id vehicle sending a v2!

This patch is intended for internal build testing atm. We are yet to
test r9a07g044c1/r9a07g054l1 on actual HW.

Sorry about the inconvenience.

Cheers,
Prabhakar

On Fri, Jan 21, 2022 at 2:47 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar, Biju,
>
> On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/Makefile
> > +++ b/arch/arm64/boot/dts/renesas/Makefile
> > @@ -77,4 +77,6 @@ dtb-$(CONFIG_ARCH_R8A77965) += r8a779m5-salvator-xs.dtb
> >
> >  dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
> >  dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c2-smarc.dtb
> > +dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c1-smarc.dtb
>
> Please preserve sort order, and add a blank line to separate
> different SoCs.
>
> >  dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
> > +dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l1-smarc.dtb
>
> Sort order.
>
> Given this patch adds boards with two different SoCs, and the two
> DTS files are quite dissimilar, I think this patch should be split in
> two parts.
>
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g044c1-smarc.dts
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/*
> > + * Device Tree Source for the RZ/G2LC SMARC EVK board
> > + *
> > + * Copyright (C) 2021 Renesas Electronics Corp.
> > + */
> > +
> > +/dts-v1/;
> > +#include "r9a07g044c1.dtsi"
> > +#include "rzg2lc-smarc-som.dtsi"
> > +#include "rzg2lc-smarc-pinfunction.dtsi"
> > +#include "rzg2l-smarc.dtsi"
> > +
> > +/ {
> > +       model = "Renesas SMARC EVK based on r9a07g044c2";
> > +       compatible = "renesas,smarc-evk", "renesas,r9a07g044c2", "renesas,r9a07g044";
>
> "renesas,r9a07g044c1"
>
> > +
> > +};
> > +
> > +&canfd {
> > +       /delete-property/ pinctrl-0;
> > +       status = "disabled";
> > +};
>
> Looks like the corresponding pinctrl-names properties should be
> removed, too.  Else "make dtbs_check" complains.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
