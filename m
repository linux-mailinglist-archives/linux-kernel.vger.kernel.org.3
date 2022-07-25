Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4BD57FFFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiGYNdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiGYNdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:33:16 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A0DEB3;
        Mon, 25 Jul 2022 06:33:10 -0700 (PDT)
Received: from mail-ed1-f47.google.com ([209.85.208.47]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MF418-1oIB8W2NC4-00FVHH; Mon, 25 Jul 2022 15:33:08 +0200
Received: by mail-ed1-f47.google.com with SMTP id t3so13984731edd.0;
        Mon, 25 Jul 2022 06:33:08 -0700 (PDT)
X-Gm-Message-State: AJIora89bRqDDz//xVeXLWONCcZ2Aa6Da8hDCDMx0IrlcmdUIN67eUJv
        Ikkwtf3i9k1DNVpFCbTnVJJYKejLuVpjYtQl8Ls=
X-Google-Smtp-Source: AGRyM1uBYx31EaoHvVg4a6DoO8wdFAmnQxUFYQH4EXTFcFL/POUpdGvHyymM2kU6xA5JVH+KIVtQV6KhInfa2bs5xZo=
X-Received: by 2002:a05:6402:1003:b0:43a:75d8:a0e with SMTP id
 c3-20020a056402100300b0043a75d80a0emr13240149edu.303.1658755988158; Mon, 25
 Jul 2022 06:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220725131521.607904-1-robert.marko@sartura.hr> <20220725131521.607904-2-robert.marko@sartura.hr>
In-Reply-To: <20220725131521.607904-2-robert.marko@sartura.hr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Jul 2022 15:32:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1mL7Pm5+0Ce89LTrup476WaxSQKpTgn=o98_uFuOdfyQ@mail.gmail.com>
Message-ID: <CAK8P3a1mL7Pm5+0Ce89LTrup476WaxSQKpTgn=o98_uFuOdfyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: microchip: sparx5: dont use PSCI for core bringup
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hgPNv7fT6KgSLyogNS0KnDb3EN14lo1+D2ZjToCDJX13T17WaJZ
 TJ7hUXUujONX1X6I11mew17rx4/bhv0OjBI0VxlBw/z+337vrg8La66hoBMkLchwi1wWTqg
 MvJfxku6QmKSzT18eOnA/IZLNvxfNz7PSP9rtIhL+foqMCu1SJDi9zelRw4R/ghjCqcwkDP
 mt6bSvAzNMUETiT45lzMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+KAQEH0sBqY=:QrvrzKehAlU1GDA/j8wyiC
 Folzvti2NOPjQuDBTRHUIqUrgkcW2oGKSbWgzCzRxqyQjJ/C10bR2Q4UXS9MS7bO3RE+JkrF7
 mJparIQ1ZLdjm+BSIqLrEPgX6OBqL2O8w/J3ynpDsDjh1sMnSotJYMiFPfjZ6BVyQrpbYVGRO
 7xkwmBwZQokvZPwO+HEK7aWhi7BlDjW3IBA17MKqfdjQZMEYICieaIzVbFm0LvjTwJsLwnh3p
 Uv7idJKlaAUwNSVtu7gmKpkBZDx3cGQAoDHbRENB5qzToOHZnPuAzqyY8KqcLl9u0Z5xs56Qq
 BIMrAjAhTEjpSuRd68LEBE2xAYGvb6DwvM0I1B4DJ+cb0Q/lNjgCEeIKxLXqeEoDGqLS21K2q
 09z4P2baN2DN32/JBerGu3fCA4cAg3BxYDNaqANWmPtUypIDqrEmjGimAaMKEBptumvdy1wcN
 X5IbS+cVvL/mWsfhd8dD3Ta3s78kLMrRxvXNa0+10VeTVnWKp2AyYiGG0EnjvUPlwgYYWYJ1P
 AVj6M6irjf4LGnfpUQthWO2trccScJVdjuRRplH7phSGHEfkaCvXbQEtd9pbhSOnvWVjRJA61
 HxYMZiPI+Hf1DCtiSP/YBQx1eJFZKmWK4H7+G17utmIT53rhcTsTdpb38TNxQg151nGNg/EEF
 RVQ5n85xeLm5kIMcvqRvMSGAS8bcAVycZiq7NqfouafdnoFHMjcyVQa6zMWP4rU8wicDknOY5
 M6385ul+ZllyOqOv4Ql82LacYqa1BEttwaJQsvTg+NT4gE1EtvRX3CgET2iGDuIPoqY2o8k+V
 HWSyNiZtnm8vWH+l6ZsoH1WkDnzE3hKDBOQeMzC19qo4/HMpv4Iis5jkwNje6iyqLejn/n6jW
 advdEn/XtlQ6BCMm4zZg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 3:15 PM Robert Marko <robert.marko@sartura.hr> wrote:
>
> As described in previous commit, PSCI is not implemented on this SoC at
> all, so use spin-tables to bringup the cores.
>
> Tested on PCB134 with eMMC (VSC5640EV).
>
> Fixes: 6694aee00a4b ("arm64: dts: sparx5: Add basic cpu support")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---

Surely this is only a machine specific bug in the boot loader, not something
the SoC is incapable of supporting, right?

>  arch/arm64/boot/dts/microchip/sparx5.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> index 38da24c1796c..ea2b07ca2887 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> @@ -40,14 +40,16 @@ cpu0: cpu@0 {
>                         compatible = "arm,cortex-a53";
>                         device_type = "cpu";
>                         reg = <0x0 0x0>;
> -                       enable-method = "psci";
> +                       enable-method = "spin-table";
> +                       cpu-release-addr = <0x0 0x0000fff8>;
>                         next-level-cache = <&L2_0>;
>                 };

I think the psci method should be kept in the dtsi file here, since actual
product boards would have to support it to be useful, you can just add
the spin-table as an override in the broken reference boards, with a
comment about which u-boot version is broken, in case this gets fixed
in the future.

       Arnd
