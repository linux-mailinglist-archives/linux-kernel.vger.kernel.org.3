Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9EB49CD4A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbiAZPFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:05:09 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:35398 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiAZPFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:05:07 -0500
Received: by mail-ua1-f54.google.com with SMTP id m90so43478024uam.2;
        Wed, 26 Jan 2022 07:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mDTecA4t0paCjRyo/FBzGJVQh+lQjw7qkADmkkdfcA=;
        b=MgVlOXZEWwRZ8Z10NAnONx+zWwfe82Ird75iIAFYnrmV2wvegK0tAOHu6zm/aBeSrr
         CiAM/OBqKdtXKgfXqMFWSlisnB+WtnlQyPGphPrgqSWXkXcTyttWymLItekZOjyH/ACH
         JNCDtOphIjXjsIHLgcugmImIMo2QkeW2a/8r7kQ5Do/ApJL31BXETgptl6BrFPsssOkr
         gvRYDpyRTHZKRsxtjWoe9Z609wvB6+gwGJMAtyzzak+vZRN3KJRbDJIVzqH7MVd4HmOx
         83Sjy0u3pqoJofMxOHDC0Gny01ZijEG4odzi0hE4ZnhIQal5xzKFIQZ+YDe/vn+7u632
         U/RQ==
X-Gm-Message-State: AOAM531jCVkJyIhWvoUd/KXylRkpxtxxv7lFKQQfUQXAosVuYCE1W4v6
        FmU+yO5lYAh0pHTy2v7SM3Ww0veE9rmZHX7e
X-Google-Smtp-Source: ABdhPJwK5fuFPCVtlVLyqTLjpMzkku4JKTn+9/3jNmNNtmIhLl0sgYRPUoVC9r6ol8JQfGnhOKyTrA==
X-Received: by 2002:a67:d590:: with SMTP id m16mr5884132vsj.5.1643209506590;
        Wed, 26 Jan 2022 07:05:06 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id r11sm542949uaw.7.2022.01.26.07.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 07:05:05 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id u6so43473745uaq.0;
        Wed, 26 Jan 2022 07:05:05 -0800 (PST)
X-Received: by 2002:a05:6102:34e:: with SMTP id e14mr2690352vsa.68.1643209505159;
 Wed, 26 Jan 2022 07:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20220112205205.4082026-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20220112205205.4082026-1-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jan 2022 16:04:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVidg7fQkq2gFE+cvxkvBOXYRRvj-yCGmsJfjANBny=4w@mail.gmail.com>
Message-ID: <CAMuHMdVidg7fQkq2gFE+cvxkvBOXYRRvj-yCGmsJfjANBny=4w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: ulcb-kf: add 9-asix sensor device
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

On Wed, Jan 12, 2022 at 9:52 PM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> This adds nodes for lsm9ds0 sensor installed on the KF board.
>
> With this patch, the sensor data becomes available over iio sysfs
> interface.
>
> Interrupt definition is not added yet, because the interrupt lines of
> lsm9ds0 are pulled to VCC on the board, which implies need for
> active-low configuration. But st_sensors drivers currently can't work
> with active-low interrupts on this chip.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Forgot something...

> --- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> +++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> @@ -66,6 +66,13 @@ hdmi_3v3: regulator-hdmi-3v3 {
>                 regulator-max-microvolt = <3300000>;
>         };
>
> +       accel_3v3: regulator-acc-3v3 {

Please move up, to preserve sort order.

> +               compatible = "regulator-fixed";
> +               regulator-name = "accel-3v3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +       };
> +
>         hdmi1-out {
>                 compatible = "hdmi-connector";
>                 type = "a";
> @@ -208,6 +215,22 @@ pcm3168a_endpoint_c: endpoint {
>                                         };
>                                 };
>                         };
> +
> +                       lsm9ds0_acc_mag@1d {

Please move up, to preserve sort order.

> +                               compatible = "st,lsm9ds0-imu";
> +                               reg = <0x1d>;
> +
> +                               vdd-supply = <&accel_3v3>;
> +                               vddio-supply = <&accel_3v3>;
> +                       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
