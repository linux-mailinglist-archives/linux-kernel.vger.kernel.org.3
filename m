Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F0D489CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiAJP5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:57:02 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:34702 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAJP45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:56:57 -0500
Received: by mail-ua1-f48.google.com with SMTP id y4so24281050uad.1;
        Mon, 10 Jan 2022 07:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKrDGNi+gg98U9bw/lL+NYbJMypwOOc8TZbuy5d3uxA=;
        b=hBz8IYd9oaiEiQbgO0QloKBXEr9LRsBXWzlU3fzqZNZcfvbWKzd3q+xL6vVMvnxrEs
         CMHaIj5A1uTPg7Rcvgfff5JZJmpnJufAPJ/bGurfyAyCYUKVDCGx90CoZuqiO3zyZWty
         WMNhCKRMxGZWMZIkvJiYw7xujzi3ekVKBSQz0f0NRBBSAequmy5CfFwXVP/Ybw2Qh0q6
         rgkNCW49WjwnYJsTFvZTb9Rrr104Q4k4xh3zyGruFu8Vx7AZ4ESlzk7FHL07Vn0sTVD1
         55GHHUOe0hhhneFvJkPblyTcQRiHx/fobzNz9xEfBdnx3eii6QY7GyDU8SWCF+rQ6gpl
         vUCw==
X-Gm-Message-State: AOAM533/qY3tlR8q24v+oaW1HITABCNL3wSxvPDlxFKsj9q7kIvvPedo
        i3gG/EP6okfC+10UqGhJrKlAZmXef8dYgw==
X-Google-Smtp-Source: ABdhPJzYq9Ekrgn9e4D+tWP1peUVNa6iZ+q7Jd2K/m2PegnQVzCKb30XEYZ9/326+Mwh5DjPKwOwqg==
X-Received: by 2002:ab0:3402:: with SMTP id z2mr160179uap.56.1641830216926;
        Mon, 10 Jan 2022 07:56:56 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id h2sm4449914vsj.5.2022.01.10.07.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 07:56:56 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id m15so9867992uap.6;
        Mon, 10 Jan 2022 07:56:56 -0800 (PST)
X-Received: by 2002:ab0:4d5a:: with SMTP id k26mr154723uag.122.1641830216111;
 Mon, 10 Jan 2022 07:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20211226082530.2245198-4-nikita.yoush@cogentembedded.com> <20211226153349.2296024-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20211226153349.2296024-1-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 16:56:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUJfq+nFFMoiPiTt1=Ny9zOm-O1EAmq3n56n4RJ6H8tdA@mail.gmail.com>
Message-ID: <CAMuHMdUJfq+nFFMoiPiTt1=Ny9zOm-O1EAmq3n56n4RJ6H8tdA@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] arm64: dts: renesas: add MOST device
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Sun, Dec 26, 2021 at 4:34 PM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> This patch adds mlp device to dtsi files for R-Car Gen3 SoCs that have
> it.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
> Change from v1:
> - fix power domain ids so all dtbs build properly

Thanks for the update!

> --- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> @@ -2412,6 +2412,19 @@ ssi9: ssi-9 {
>                         };
>                 };
>
> +               mlp: mlp@ec520000 {
> +                       compatible = "renesas,rcar-gen3-mlp";

No SoC-specific compatible value?

> +                       reg = <0 0xec520000 0 0x800>;
> +                       interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
> +                               <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
> +                               <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
> +                               <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
> +                               <GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>;

What is the purpose of the various interrupts?
Perhaps you need interrupt-names?
The driver seems to use only the first two, which is strange, as
the second and third interrupt handle different channels.

> +                       clocks = <&cpg CPG_MOD 802>;
> +                       power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;

Missing resets property?

> +                       status = "disabled";
> +               };
> +

The rest looks sane to me.  But without any DT binding documentation
for this hardware block, this is hard to validate, and not yet ready for
upstream integration.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
