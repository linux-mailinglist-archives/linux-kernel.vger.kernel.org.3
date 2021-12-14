Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE324740C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhLNKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:49:45 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:45827 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhLNKta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:49:30 -0500
Received: by mail-ua1-f48.google.com with SMTP id ay21so34045407uab.12;
        Tue, 14 Dec 2021 02:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3XtNHu0m7Ih3Mq0LbQ5xM/zIwyARHBTJDqSktTzsjY=;
        b=SbiiYaRnNPBc1KANSyHp0b8aDYQoYoK1AaeodgkUMG/TjtVZ/ewfGJJ3qwqiyrJPaf
         iVkIAw8XwcAhhTFEpjduvys6czI50Cj6Lybn/iGRR/s0+Pm6p1TCKYUxS47H3s7YqW/z
         CakxknzhPr1vHrtTdGa0LaEuS4HbE8nWWnAmEcrR+Lv025DFVsPr1Z9bzVoxrOtYo5zI
         rpkb16+NFgb3aOC+a/+X0hCZhmhT95P+JoXT2D5E54WGYchhvNmXZAFUVv9UUyuERPEB
         a560jZCMmnlGPOY5y2ax8Ia0YbiLV9Eljg7SntZYGACYGZrzbVBFXTFdKP7Chz0HAHN4
         /x1g==
X-Gm-Message-State: AOAM531pvs09SNs0+8TZ+qTtcWaUeS1U2S44YY9Ew9WeG9Y7rwDN7YU3
        9PFCD6k2IKXsiEOnzVjQ8fSs3GAEOxzeDw==
X-Google-Smtp-Source: ABdhPJyTlh3uugAxFSTp71tofHfOfP+GAjA+I+BJlDOJKBl9TWgZXYTrarr0wOg4yOBNMGK4DIEkng==
X-Received: by 2002:a9f:2c4a:: with SMTP id s10mr4253448uaj.50.1639478967114;
        Tue, 14 Dec 2021 02:49:27 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id f188sm4351581vsc.16.2021.12.14.02.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 02:49:26 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id w23so34111997uao.5;
        Tue, 14 Dec 2021 02:49:26 -0800 (PST)
X-Received: by 2002:a05:6102:c89:: with SMTP id f9mr4134352vst.68.1639478966486;
 Tue, 14 Dec 2021 02:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20211130164311.2909616-1-kieran.bingham+renesas@ideasonboard.com> <20211130164311.2909616-3-kieran.bingham+renesas@ideasonboard.com>
In-Reply-To: <20211130164311.2909616-3-kieran.bingham+renesas@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Dec 2021 11:49:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW81VE=J+ChT5jVMhHmVnMi_eQix7aXjLQPJk+qKp-EdQ@mail.gmail.com>
Message-ID: <CAMuHMdW81VE=J+ChT5jVMhHmVnMi_eQix7aXjLQPJk+qKp-EdQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: renesas: r8a779a0: falcon-cpu: Add DSI
 display output
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Tue, Nov 30, 2021 at 5:43 PM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
> Provide the display output using the sn65dsi86 MIPI DSI bridge
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.17.

> --- a/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi

> @@ -146,6 +190,41 @@ &i2c1 {
>
>         status = "okay";
>         clock-frequency = <400000>;
> +
> +       sn65dsi86@2c {
> +               compatible = "ti,sn65dsi86";
> +               reg = <0x2c>;
> +
> +               clocks = <&sn65dsi86_refclk>;
> +               clock-names = "refclk";
> +
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;

Does the driver use this interrupt, and is it triggered?
If yes, as GP1_24 == IRQ0, you can switch from a GPIO to an INTC_EX IRQ,
(don't forget to configure pinctrl) and test the INTC_EX driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
