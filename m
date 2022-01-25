Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D249B5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbiAYOE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:04:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54808 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiAYOA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:00:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F085661512;
        Tue, 25 Jan 2022 14:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64145C340E9;
        Tue, 25 Jan 2022 14:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643119226;
        bh=9awAQP4oKFlE1lZZ1KeVdAwXKINZ0vFGHrNIDlHoYCs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LtGAKvSbKL0VUM/VhFyPEShcpcV9FO6U0tOG9pslt9CU3GR9JwSNjNhsIfI/SXagT
         Bg+JIOg4Fo5gah5jM/zosakuqb/vR0PR4CvlXjnp6ViKpasSlBbhAplcTFpemnQxED
         2/FJFXBl9Hq6WNzzwniCvcgmiyr41+TCQk7D4WUjm5oMrmKxk9ZH5gE0Scze6eTrYD
         CRcQwMIzcFQSiuP3eiWe4D4KBV/7oJmJFjbTFJk42vtjCJUb+nUacFBK9Kx1pSHspe
         1kQxsZ65W7Y8q50uaJOgqx2fnxn8BsIKbUN0A3DHTJvxhN3D9ThYc3c0H2X+mxQ+no
         hwX70DXQMC1lA==
Received: by mail-ed1-f54.google.com with SMTP id a18so62792835edj.7;
        Tue, 25 Jan 2022 06:00:26 -0800 (PST)
X-Gm-Message-State: AOAM531PRd6ZiWV0WOBqdh4GqqAyh4eJ53Z1sf40Y2Z/mhtSZv4Bpdpo
        ggnu88NnbZAEJpfd5x6d6t2U5qvTnRz4ReXs1Q==
X-Google-Smtp-Source: ABdhPJzpLb/eBKpd+yZrCy2aAmQXbDlTvrjCdky51D0FFx0SdHMSqVbntVHTjHVMzz6VnkzGEBO7u5rPsDLV094wgLI=
X-Received: by 2002:a17:906:d184:: with SMTP id c4mr16020810ejz.20.1643119224639;
 Tue, 25 Jan 2022 06:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220110134659.30424-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110134659.30424-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 25 Jan 2022 08:00:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKnWwSEneKTvQWWmGk1gJG2dx37vAJAFWOLVm5wL5t31g@mail.gmail.com>
Message-ID: <CAL_JsqKnWwSEneKTvQWWmGk1gJG2dx37vAJAFWOLVm5wL5t31g@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] arm64: dts: renesas: Add initial DTSI for RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 7:47 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The RZ/V2L is package- and pin-compatible with the RZ/G2L. The only
> difference being the RZ/V2L SoC has additional DRP-AI IP (AI
> accelerator).
>
> Add initial DTSI for RZ/V2L SoC with below SoC specific dtsi files for
> supporting single core and dual core devices.
>
> r9a07g054l1.dtsi => RZ/V2L R9A07G054L1 SoC specific parts
> r9a07g054l2.dtsi => RZ/V2L R9A07G054L2 SoC specific parts
>
> Both RZ/G2L and RZ/V2L SMARC EVK SoM  are identical apart from SoC's
> used hence the common dtsi files (rzg2l-smarc*.dtsi) are share between
> RZ/G2L and RZ/V2L SMARC EVK. Place holders are added in device nodes to
> avoid compilation errors for the devices which have not been enabled yet
> on RZ/V2L SoC.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * None
> ---
>  arch/arm64/boot/dts/renesas/r9a07g054.dtsi   | 491 +++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi |  25 +
>  arch/arm64/boot/dts/renesas/r9a07g054l2.dtsi |  13 +
>  3 files changed, 529 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/r9a07g054.dtsi
>  create mode 100644 arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi
>  create mode 100644 arch/arm64/boot/dts/renesas/r9a07g054l2.dtsi
>
> diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
> new file mode 100644
> index 000000000000..5de8f343f12a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the RZ/V2L SoC
> + *
> + * Copyright (C) 2021 Renesas Electronics Corp.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/r9a07g054-cpg.h>

linux-next is failing because this header is missing:

In file included from arch/arm64/boot/dts/renesas/r9a07g054l2.dtsi:9,
                 from arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts:9:
arch/arm64/boot/dts/renesas/r9a07g054.dtsi:9:10: fatal error:
dt-bindings/clock/r9a07g054-cpg.h: No such file or directory
    9 | #include <dt-bindings/clock/r9a07g054-cpg.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
