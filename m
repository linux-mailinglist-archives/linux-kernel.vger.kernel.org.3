Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3F44CD6B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbiCDOsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbiCDOsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:48:03 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF19848384;
        Fri,  4 Mar 2022 06:47:15 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id g26so17243172ybj.10;
        Fri, 04 Mar 2022 06:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CUW9eyq6olA9UOxPXQmSp+qMVQaP00he0KkU/RyKjq0=;
        b=ETyBEW7YhnLoIr1wJ94chKj8as25ZaiWCxdoQeJfM2137JFZx84RaD1MY+P+XNzoUy
         P165qPpM5aAS9MffBzqblSELPKK9kxtTairC8Js/3oG3r3IHbrDLi18scYeptCyna7SP
         TdxjaQ1rkJv7A03GmgIUFYy0DgSgLz7sBRlDUDER6ue7GgDUwaarpfbYV7BN1F5eTFlf
         MSkMadqL7DBmi4eCyISJMDa+TWbOhaU34nZeSmLfAL4Zq136Q2HPdBdsgf48VgsLcMyQ
         XNHCrMtwByGh/RsmKmeRc3AqDNe+FBnIz4FKJM4qKiAyj4Dd9ekHHh4i2tr4tAqlMK1D
         TngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CUW9eyq6olA9UOxPXQmSp+qMVQaP00he0KkU/RyKjq0=;
        b=WNsTQIGUV/jZFx7Q+LDaeTeKJwB3SRDXSZ7GLvGcx+lVdUuhI8SDulIuWECi3viQjM
         DePpDEoSKOLSc7DwU1AxvC+0fnP2Co8MvXwEupGe2dyjsFm9VSZTVg5KrfHsNbxpQI5O
         hYRsNjPEirnmS/Os7/KGyUopaMr6EXwYRbLjKtzUIJyWYGLOWJ3VaWrmS0PltYT2lBFC
         vrQru2weUKIMlJdxpbQyimam4NHNBwgwciiH23ZghUcdF4f8CutBnlhX5TsF/YdoGF8L
         uyET2Ddv8nOCMofHiuXkKr9iawtzt9lJmIkexMC06tsqlCqvTayQmdXp5TcVBtGXXp+t
         RZBA==
X-Gm-Message-State: AOAM531hOpco6ESSC5tqSlm/2ihKmO5jAV31gZWwem15GplQN232nJeQ
        HGYQhlBYG2FjN1dTQ4sgFOh8y8duv+LfTm9AVc7lYj9x3Dw=
X-Google-Smtp-Source: ABdhPJzL3K/jikdloz8L2WO3+zi/8Cp0G3owqWF4urVyT4uasuJoj++B4FPKa3BA6m7Ih1hTbhxRqbFNnawHLzBx2DA=
X-Received: by 2002:a05:6902:143:b0:628:7cf1:f2a9 with SMTP id
 p3-20020a056902014300b006287cf1f2a9mr17194704ybh.51.1646405234801; Fri, 04
 Mar 2022 06:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20220127230727.3369358-1-briannorris@chromium.org> <20220127150615.v2.12.I3a5c7f21ecd8221b42c2dbcd618386bce7b3e9a6@changeid>
In-Reply-To: <20220127150615.v2.12.I3a5c7f21ecd8221b42c2dbcd618386bce7b3e9a6@changeid>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 4 Mar 2022 09:47:03 -0500
Message-ID: <CAMdYzYo9Y_pEAAtreQU0B9DVzGsbUgpTA2g7HGRyUXcSBjMy4g@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] arm64: dts: rockchip: Enable dmc and dfi nodes
 on gru
To:     Brian Norris <briannorris@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Lin Huang <hl@rock-chips.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 6:17 PM Brian Norris <briannorris@chromium.org> wro=
te:
>
> From: Lin Huang <hl@rock-chips.com>
>
> Enable the DMC (Dynamic Memory Controller) and the DFI (DDR PHY
> Interface) nodes on gru boards so we can support DDR DVFS.
>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Ga=C3=ABl PORTAY <gael.portay@collabora.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Updates since the old series:
>
>  - reordered alphabetically by phandle name, per style
>  - drop a ton of deprecated/unused properties
>  - add required center-supply for scarlet
>  - add new *_idle_dis_freq properties
>  - drop the lowest (200 MHz) OPP; this was never stabilized for
>    production
>  - bump the voltage (0.9V -> 0.925V) for the highest OPP on Chromebook
>    models; later (tablet) models were more stable, with a fixed DDR
>    regulator
>  - bump odt_dis_freq to 666 MHz; early versions used 333 MHz, but
>    stabilization efforts landed on 666 MHz for production
>
> ---
>
> Changes in v2:
>  - Adapt to new properties
>
> Changes in v1:
> This was part of a previous series, at:
> https://lore.kernel.org/r/20210308233858.24741-3-daniel.lezcano@linaro.or=
g
> I've picked up a bunch of changes and fixes, so I've restarted the patch
> series numbering.

Good Morning,

I'm trying to bring this series over to rockpro64 (and eventually the
pinephone-pro) and am running into some snags.
Essentially, anytime a transition happens, the board locks up.
I've disabled the extra power save disable flags and adjusted the OPPs
for rockpro64's power.
Transitions anywhere from the default 800mhz cause a lock.

I'm digging deeper, but I'm hoping you can answer some questions in
the meantime:
1. Does this require something from firmware that isn't available on
Mainline ATF? (AKA special firmware to the Chromebook line)
2. If not, do you have any recommendations off the top of your head?

Thanks,
Peter Geis

>
>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  7 +++++
>  .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 12 ++++++++
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 28 +++++++++++++++++++
>  .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 25 +++++++++++++++++
>  4 files changed, 72 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/ar=
ch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> index 9b2c679f5eca..cc8950046d94 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> @@ -234,6 +234,13 @@ &cdn_dp {
>         extcon =3D <&usbc_extcon0>, <&usbc_extcon1>;
>  };
>
> +&dmc {
> +       center-supply =3D <&ppvar_centerlogic>;
> +       rockchip,pd-idle-dis-freq-hz =3D <800000000>;
> +       rockchip,sr-idle-dis-freq-hz =3D <800000000>;
> +       rockchip,sr-mc-gate-idle-dis-freq-hz =3D <800000000>;
> +};
> +
>  &edp {
>         status =3D "okay";
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/=
arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> index a9817b3d7edc..913d845eb51a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> @@ -391,6 +391,18 @@ &cru {
>                 <400000000>;
>  };
>
> +/* The center supply is fixed to .9V on scarlet */
> +&dmc {
> +       center-supply =3D <&pp900_s0>;
> +};
> +
> +/* We don't need .925 V for 928 MHz on scarlet */
> +&dmc_opp_table {
> +       opp03 {
> +               opp-microvolt =3D <900000>;
> +       };
> +};
> +
>  &gpio0 {
>         gpio-line-names =3D /* GPIO0 A 0-7 */
>                           "CLK_32K_AP",
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/bo=
ot/dts/rockchip/rk3399-gru.dtsi
> index 162f08bca0d4..23bfba86daab 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -373,6 +373,34 @@ &cru {
>                 <200000000>;
>  };
>
> +&dfi {
> +       status =3D "okay";
> +};
> +
> +&dmc {
> +       status =3D "okay";
> +
> +       rockchip,pd-idle-ns =3D <160>;
> +       rockchip,sr-idle-ns =3D <10240>;
> +       rockchip,sr-mc-gate-idle-ns =3D <40960>;
> +       rockchip,srpd-lite-idle-ns =3D <61440>;
> +       rockchip,standby-idle-ns =3D <81920>;
> +
> +       rockchip,ddr3_odt_dis_freq =3D <666000000>;
> +       rockchip,lpddr3_odt_dis_freq =3D <666000000>;
> +       rockchip,lpddr4_odt_dis_freq =3D <666000000>;
> +
> +       rockchip,sr-mc-gate-idle-dis-freq-hz =3D <1000000000>;
> +       rockchip,srpd-lite-idle-dis-freq-hz =3D <0>;
> +       rockchip,standby-idle-dis-freq-hz =3D <928000000>;
> +};
> +
> +&dmc_opp_table {
> +       opp03 {
> +               opp-suspend;
> +       };
> +};
> +
>  &emmc_phy {
>         status =3D "okay";
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi b/arch/arm6=
4/boot/dts/rockchip/rk3399-op1-opp.dtsi
> index 2180e0f75003..6e29e74f6fc6 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> @@ -110,6 +110,27 @@ opp05 {
>                         opp-microvolt =3D <1075000>;
>                 };
>         };
> +
> +       dmc_opp_table: dmc_opp_table {
> +               compatible =3D "operating-points-v2";
> +
> +               opp00 {
> +                       opp-hz =3D /bits/ 64 <400000000>;
> +                       opp-microvolt =3D <900000>;
> +               };
> +               opp01 {
> +                       opp-hz =3D /bits/ 64 <666000000>;
> +                       opp-microvolt =3D <900000>;
> +               };
> +               opp02 {
> +                       opp-hz =3D /bits/ 64 <800000000>;
> +                       opp-microvolt =3D <900000>;
> +               };
> +               opp03 {
> +                       opp-hz =3D /bits/ 64 <928000000>;
> +                       opp-microvolt =3D <925000>;
> +               };
> +       };
>  };
>
>  &cpu_l0 {
> @@ -136,6 +157,10 @@ &cpu_b1 {
>         operating-points-v2 =3D <&cluster1_opp>;
>  };
>
> +&dmc {
> +       operating-points-v2 =3D <&dmc_opp_table>;
> +};
> +
>  &gpu {
>         operating-points-v2 =3D <&gpu_opp_table>;
>  };
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
