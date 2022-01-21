Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41C495D44
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349736AbiAUKHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:07:48 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:44803 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiAUKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:07:47 -0500
Received: by mail-ua1-f53.google.com with SMTP id f24so15879993uab.11;
        Fri, 21 Jan 2022 02:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iX8pvu80FcPsA2BeiEF3hrIHf0rQSHLabn6lNyXbVY=;
        b=gX+ndLbWf+7Hgn2gQkqFx/0WF0A2iRnHBGB712+2BAqwy9garLuo5YGS186ifilEMD
         mwq0feeVsYod1n9hicxFXWsAQCC7Zv5Tguqifp+tScykxkDwhXRjUHNYbRDS5SCHn3hH
         592wvnDsYMo2Zpkiqa1sXyNr5qOD0pTXPOpgNCpAWTOGV4wYA/UPyaiHVTKFOwfBHmR2
         EcE+R+BNeQM2isZO8IYIYB0pbHI9m4AlaVee384zLXMgiKk4NLl3tU+OjX7m+4uN906f
         uYtVoNpXoV7BLWCmoX4XcspCPUFg1+bpPoMzHSkjoP+CnOkG2cMe2Da2vNnAueOK5/A4
         ktwg==
X-Gm-Message-State: AOAM533L6MtGhrTqxTqf1dqeapFw2i/yR811qsUR755dULNM2tWgAe4f
        a/3qiiUkXW0HSqtWBzYQ5QkcUJQeggnVFg==
X-Google-Smtp-Source: ABdhPJzGkAKku6BmywZhnKmw6+aI2ztqsRsw1NFpk1sNzmn/jCe9N2+K2r/vaoI3lkrpRlLnfwl1qw==
X-Received: by 2002:a67:d794:: with SMTP id q20mr1451884vsj.82.1642759666490;
        Fri, 21 Jan 2022 02:07:46 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id r14sm1227357vke.26.2022.01.21.02.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 02:07:46 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id p7so8768874uao.6;
        Fri, 21 Jan 2022 02:07:46 -0800 (PST)
X-Received: by 2002:a67:e985:: with SMTP id b5mr1116672vso.77.1642759665918;
 Fri, 21 Jan 2022 02:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20211225115308.2152364-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20211225115308.2152364-1-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 11:07:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXdW=bCxBeEu81bRBwAs5=x_KZmPcXoMe=CmFdWz=rdfQ@mail.gmail.com>
Message-ID: <CAMuHMdXdW=bCxBeEu81bRBwAs5=x_KZmPcXoMe=CmFdWz=rdfQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: ulcb-kf: add KF HDMI output
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Sat, Dec 25, 2021 at 12:54 PM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> This patch adds nodes needed to enable DRM video output over HDMI
> connector located on KF board.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> +++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> @@ -51,6 +51,31 @@ wlan_en: regulator-wlan_en {
>                 startup-delay-us = <70000>;
>                 enable-active-high;
>         };
> +
> +       hdmi_1v8: regulator-hdmi-1v8 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "hdmi-1v8";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +       };
> +
> +       hdmi_3v3: regulator-hdmi-3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "hdmi-3v3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +       };
> +
> +       hdmi1-out {

Sort order.

> +               compatible = "hdmi-connector";
> +               type = "a";
> +
> +               port {
> +                       hdmi1_con: endpoint {
> +                               remote-endpoint = <&adv7513_out>;
> +                       };
> +               };
> +       };
>  };
>
>  &can0 {

> @@ -236,6 +313,10 @@ gpio_exp_77: gpio@77 {
>         };
>  };
>
> +&du_out_rgb {

Sort order.

> +       remote-endpoint = <&adv7513_in>;
> +};
> +
>  &ohci0 {
>         dr_mode = "otg";
>         status = "okay";
> @@ -289,6 +370,18 @@ usb0_pins: usb0 {
>                 groups = "usb0";
>                 function = "usb0";
>         };
> +
> +       hdmi1_pins: hdmi1 {
> +               du {

More sort order.

> +                       groups = "du_rgb888", "du_sync", "du_clk_out_0", "du_disp";
> +                       function = "du";
> +               };
> +
> +               adv7513-interrupt {
> +                       pins = "GP_2_14";
> +                       bias-pull-up;
> +               };
> +       };
>  };

The rest looks good to me.
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18 with the sort order fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
