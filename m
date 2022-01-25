Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0782F49B646
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbiAYObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:31:10 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:44941 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579171AbiAYOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:24:12 -0500
Received: by mail-ua1-f48.google.com with SMTP id f24so37548314uab.11;
        Tue, 25 Jan 2022 06:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAnke+D6ckPyUnCwTZ2+u4TaSpv96tbXWZba/2UslR8=;
        b=5MKpUYW7F8DVmb5R/0qNn/BZ0LsgruxaGa0lR3tKUfhywgfT/S44otpaz2/DvWcTvR
         jOlQpHQ+6Tbx/mqEenDKZy79q/N/E3iNOt8sPhARod7YKIgmq+BpVDTiF413d7sPlG/V
         MJlkmoWVV8eq71Q2Y9w84+n9YRDQTk4XMBtkRj8Qx8iPcegvAyvEzUnatUSDjSvewTfG
         n3ciSLEagUVuQkzhTV+X/ffQKKnsQ6h5V7sGRTda+V32gj3yWbHayEjaZW9nakEp352c
         wNZJAZY/SjIHEZuZPQ3dyDgwA7UQ3hj5xXYKL+a1MpMYVCmtZ1SswNyPAxzvEiTiPPkp
         fjyg==
X-Gm-Message-State: AOAM5314vxIs4/hdzdkqO4gh7TRtbwJXCgSxWsVws9ED3OKgnHKdlb3M
        JEhUzPNCLhymYIozD8i4h/XWqB6r6mCeiiK9
X-Google-Smtp-Source: ABdhPJxJmJtTE/62A4hzMm/0VtrqyqG1UIUvM4ID8D/ckB6hHLudnxMEi2oV1Sb4W7oqROwALuHUGQ==
X-Received: by 2002:ab0:484:: with SMTP id 4mr7451936uaw.62.1643120647821;
        Tue, 25 Jan 2022 06:24:07 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id e17sm605735vsl.21.2022.01.25.06.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 06:24:07 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id y4so37695300uad.1;
        Tue, 25 Jan 2022 06:24:07 -0800 (PST)
X-Received: by 2002:a05:6102:34e:: with SMTP id e14mr644513vsa.68.1643120647054;
 Tue, 25 Jan 2022 06:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110134659.30424-11-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAL_JsqKnWwSEneKTvQWWmGk1gJG2dx37vAJAFWOLVm5wL5t31g@mail.gmail.com>
In-Reply-To: <CAL_JsqKnWwSEneKTvQWWmGk1gJG2dx37vAJAFWOLVm5wL5t31g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jan 2022 15:23:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUz-E1NNYMpB8PXT67H1_SGEn9=FOR2DZHqBDFbRSmbtA@mail.gmail.com>
Message-ID: <CAMuHMdUz-E1NNYMpB8PXT67H1_SGEn9=FOR2DZHqBDFbRSmbtA@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] arm64: dts: renesas: Add initial DTSI for RZ/V2L SoC
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Jan 25, 2022 at 3:00 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Mon, Jan 10, 2022 at 7:47 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > The RZ/V2L is package- and pin-compatible with the RZ/G2L. The only
> > difference being the RZ/V2L SoC has additional DRP-AI IP (AI
> > accelerator).
> >
> > Add initial DTSI for RZ/V2L SoC with below SoC specific dtsi files for
> > supporting single core and dual core devices.
> >
> > r9a07g054l1.dtsi => RZ/V2L R9A07G054L1 SoC specific parts
> > r9a07g054l2.dtsi => RZ/V2L R9A07G054L2 SoC specific parts
> >
> > Both RZ/G2L and RZ/V2L SMARC EVK SoM  are identical apart from SoC's
> > used hence the common dtsi files (rzg2l-smarc*.dtsi) are share between
> > RZ/G2L and RZ/V2L SMARC EVK. Place holders are added in device nodes to
> > avoid compilation errors for the devices which have not been enabled yet
> > on RZ/V2L SoC.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
> > @@ -0,0 +1,491 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/*
> > + * Device Tree Source for the RZ/V2L SoC
> > + *
> > + * Copyright (C) 2021 Renesas Electronics Corp.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/clock/r9a07g054-cpg.h>
>
> linux-next is failing because this header is missing:
>
> In file included from arch/arm64/boot/dts/renesas/r9a07g054l2.dtsi:9,
>                  from arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts:9:
> arch/arm64/boot/dts/renesas/r9a07g054.dtsi:9:10: fatal error:
> dt-bindings/clock/r9a07g054-cpg.h: No such file or directory
>     9 | #include <dt-bindings/clock/r9a07g054-cpg.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks, I have already removed the offending commits from renesas-next.
as the header is not ready yet.

Interestingly, kernel test robot reported a success for that branch...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
