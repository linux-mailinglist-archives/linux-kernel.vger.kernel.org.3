Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB7B57539E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbiGNRCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiGNRCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BB94E851;
        Thu, 14 Jul 2022 10:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A599D620B0;
        Thu, 14 Jul 2022 17:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF2CC341C6;
        Thu, 14 Jul 2022 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657818135;
        bh=zXANWtzbnyxmqVMxW1EvIJdJ0gn5BhRKKX+GkEwlWnI=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=L4/Tnm5Uar0wMG+j4pkMu+tZKXO2y5fFx1lVBQTiNACef5pZO31sN/mHaG+RurEGO
         DEH71e8XLmJwYpov9Eojr1TFJljDddP7j/KifNEZ1Km1hM9zU2qXFaklSkRD7TmkC1
         RZsbNSGYXMv+Z/3mun/jmKAs1yOJdtOc2AnODmHUS5NBViWiMjECNyStNbCJYlMb/u
         p/7Fw9HTkkDKLuWK8/fMJLwXyjbw7qQbfNL0XymhvcTg/ysevbuCnanDWu8H3o1jjP
         ob97UuufWt46wvMH+nIhcqScnM6fP91IatFCnGvcmwkbcSygA8m5TTR0Yefoa5BC9W
         s8fW1fdMJppFw==
Received: by mail-vs1-f50.google.com with SMTP id 189so2041644vsh.2;
        Thu, 14 Jul 2022 10:02:14 -0700 (PDT)
X-Gm-Message-State: AJIora9RJvPOJ0ahxKdfd/WUfb0G1imfbx7dR/8QROpvKzBs1466tdD7
        attkS2qiiPmMgXzqdZQGD6Rc13jUaKDN6+mjbds=
X-Google-Smtp-Source: AGRyM1vJYETbyBnDzWJi60rOSZnZM0poZwqUuIBT2wznh3l2ngixajoW9MvEPDHzdJbrzgKsaUjm/SWvQSJkelCR5uU=
X-Received: by 2002:a05:6102:3034:b0:357:7290:aa45 with SMTP id
 v20-20020a056102303400b003577290aa45mr4041571vsa.16.1657818133999; Thu, 14
 Jul 2022 10:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com> <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
 <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com> <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
In-Reply-To: <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Fri, 15 Jul 2022 01:02:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Ehbu1wrib2CzF1fDZuD3fHZQDhKfVusyUF9KnxTvi+Q@mail.gmail.com>
Message-ID: <CAGb2v65Ehbu1wrib2CzF1fDZuD3fHZQDhKfVusyUF9KnxTvi+Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4
To:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 12:27 AM Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:
>
> mmc/SD-card initialization may fail on NanoPi r4s with
> "mmc1: problem reading SD Status register" /
> "mmc1: error -110 whilst initialising SD card"
>
> Moreover, rebooting would also sometimes hang.
>
> This is caused by the gpio entry for the vcc3v0-sd regulator;
> even though it appears to be the correct GPIO pin, the presence
> of the binding causes these errors.
>
> Fix the regulator to drop the gpio binding and add a comment
> to prevent accidental reintroduction of that entry.
>
> Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm6=
4/boot/dts/rockchip/rk3399-nanopi4.dtsi
> index 8c0ff6c96e03..d5f8a62e01be 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> @@ -67,7 +67,7 @@ vcc1v8_s3: vcc1v8-s3 {
>         vcc3v0_sd: vcc3v0-sd {
>                 compatible =3D "regulator-fixed";
>                 enable-active-high;
> -               gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
> +               // gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>; // breaks S=
DHC card support

This change only means that the regulator no longer gets cycled when
it probes. It's not a proper fix. You're leaving the kernel without
any control over SD card power, and with whatever state the bootloader
left the GPIO in. If the bootloader left the GPIO low, then you don't
get to use the SD card, ever.

It cycles because of the lack of regulator-boot-on, so the driver
requests the GPIO with initial low state, and then drives it
high to enable the regulator.

>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <&sdmmc0_pwr_h>;
>                 regulator-always-on;

I think dropping "regulator-always-on" so that Linux can cycle power
and properly reset the SD card is the proper fix to the card being
stuck in UHS and not responding.

Also, the regulator used is RT9193, according to the schematics. That
chip has an enable delay under 50 micro-seconds. If that needs to be
modeled, then add regulator-enable-ramp-delay.


Regards
ChenYu

> --
> 2.36.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
