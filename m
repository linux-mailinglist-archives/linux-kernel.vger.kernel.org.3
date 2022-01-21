Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DEB496185
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381410AbiAUOrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:47:10 -0500
Received: from mail-vk1-f174.google.com ([209.85.221.174]:44660 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345996AbiAUOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:47:07 -0500
Received: by mail-vk1-f174.google.com with SMTP id b77so5677009vka.11;
        Fri, 21 Jan 2022 06:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rz63SkibEn38erp8p/aTMOlV26SxK/MGIxWsaVpLBaY=;
        b=Z6sYz5PdBt9ssWHFpd2z5wLl0c02NwUQeXq72s7k/BHo+ePzQ0j5X78XANx3ccRou8
         717tx9mpSMOvuyUth5mQThzQwv1L/zgg2MdWP586A11p1bEFkwMlDlI8H5xWDdqywQF1
         Pkov0dczEfDPE81CgrUh6uuawarkFVXdlmryR7B7aL/mSBmVgxxvsqmXjGAze03Ins1j
         4SZKqxrbfjz7ERshs/8o3+XYDISH04lS7Rjh9xrJId9APdXE56VB1mr2G0l+3yik4mn/
         o+YtybHFrB0O69dNrjlxyi8l1L+jFZluOEh3RMIB3qzPhqXNb+mtVNbgHTDAxGrtZZtG
         Ja3A==
X-Gm-Message-State: AOAM530DHUhHFrHZ5VYhkTE5aI08X66Qcur/u791EWxFTq3kxSgEL09f
        5RVvcwHB96YpTTJ2qickFNvQn0Lr424LxA==
X-Google-Smtp-Source: ABdhPJwuffPAmuK2E7gxqRwS7KEBFGThTCssHxkPOWP0iBG6ogey51PsZhOhbotgf8uuuP8wKhidBQ==
X-Received: by 2002:a1f:aed3:: with SMTP id x202mr1882982vke.40.1642776426270;
        Fri, 21 Jan 2022 06:47:06 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id o131sm1401684vkc.42.2022.01.21.06.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 06:47:06 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id c36so17231803uae.13;
        Fri, 21 Jan 2022 06:47:05 -0800 (PST)
X-Received: by 2002:a67:e985:: with SMTP id b5mr1507440vso.77.1642776425511;
 Fri, 21 Jan 2022 06:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220110134659.30424-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110134659.30424-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 15:46:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUopcuP6XAd_Fw___04=-CyqJPEfNcwkrYgtdQz11yYvg@mail.gmail.com>
Message-ID: <CAMuHMdUopcuP6XAd_Fw___04=-CyqJPEfNcwkrYgtdQz11yYvg@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] arm64: dts: renesas: Add support for r9a07g044c1/r9a07g054l1-smarc.dts
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar, Biju,

On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/Makefile
> +++ b/arch/arm64/boot/dts/renesas/Makefile
> @@ -77,4 +77,6 @@ dtb-$(CONFIG_ARCH_R8A77965) += r8a779m5-salvator-xs.dtb
>
>  dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
>  dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c2-smarc.dtb
> +dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c1-smarc.dtb

Please preserve sort order, and add a blank line to separate
different SoCs.

>  dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
> +dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l1-smarc.dtb

Sort order.

Given this patch adds boards with two different SoCs, and the two
DTS files are quite dissimilar, I think this patch should be split in
two parts.

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r9a07g044c1-smarc.dts
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the RZ/G2LC SMARC EVK board
> + *
> + * Copyright (C) 2021 Renesas Electronics Corp.
> + */
> +
> +/dts-v1/;
> +#include "r9a07g044c1.dtsi"
> +#include "rzg2lc-smarc-som.dtsi"
> +#include "rzg2lc-smarc-pinfunction.dtsi"
> +#include "rzg2l-smarc.dtsi"
> +
> +/ {
> +       model = "Renesas SMARC EVK based on r9a07g044c2";
> +       compatible = "renesas,smarc-evk", "renesas,r9a07g044c2", "renesas,r9a07g044";

"renesas,r9a07g044c1"

> +
> +};
> +
> +&canfd {
> +       /delete-property/ pinctrl-0;
> +       status = "disabled";
> +};

Looks like the corresponding pinctrl-names properties should be
removed, too.  Else "make dtbs_check" complains.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
