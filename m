Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735D9495102
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376473AbiATPHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376422AbiATPGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:06:55 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D8C061574;
        Thu, 20 Jan 2022 07:06:55 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c6so18661531ybk.3;
        Thu, 20 Jan 2022 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGjHIa2jvXZWf1yR2M9MGgRIENQb982AcoZ4m2JeeJo=;
        b=lRGLIa4GeTFkep7n9Wuwyh5/c93qO0qQ24HfRGrUUzmCDs2/HU09tVDae9+JPYkqKk
         JR2awu1Sq9NWVw+ThpWh+OroTgtSDuuejlVcsr2NGHP6XpTz6/f3WzgdVGO7mQKGVkz0
         eKNm7XSZMqfWJO4sbVILc5eTaHhe7mbJCpMDODMqRuInZe63kin2DX9YXMO5xAvES1lQ
         PNf7lieMlJgiu4HfiD68b8S72QcV/AYgHPb0/YfUHf/gDx5uaQz2IZX8bJGqvulfD0tF
         1cY+/L0/Zw5tpedrneWY3OvUaa4UNuiq7mv86QvFxfQAAMpExPAMbZ13uhkuc87R9G/I
         nzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGjHIa2jvXZWf1yR2M9MGgRIENQb982AcoZ4m2JeeJo=;
        b=Hzq4EiERUAu1B/rJev59AooQ15m/Rxt180pDD6S5OLGiphKJU2K++xzE0oTt/eD95g
         EvG99Kh/nAHOJNWXxCh+chN7ailHZJqqsSEaY2tYTKJAawBjuR6a02ehnrOdAGq6FeI7
         GvfQr73lSYO3nE3KL8ucRe+KYBsZWW2VhZAx81I4auV5+EfJJ8c4h++KtFm87mvibSJv
         sanC/gj8UpeJDkpTHTvfyVkTis9OmeWCDaYVphJWCzWzXycIc2+93lCx/DZS8kV+0nRR
         1UYYLFZpw6UtgfRH/SvIb/KSOGtP7zyAW1qN/jqU4WBIAhIacdQjMuIrn93kH6097NMP
         D51w==
X-Gm-Message-State: AOAM531eKGWdWhOJJPcaU/Duj4mB/ckNp2ALlcr0kuLSZyIXc6fYQAYZ
        08tmsObtMxqBJ24Rdj4Xh2TeX0ZhYIWtIcBY/B4=
X-Google-Smtp-Source: ABdhPJzwEQxsm+6uQCgTAdIN4x6j/M6Hgid4CJkWRsT2UHShukUYuLvUDLexpLYEr5YA4FTOI74fq2aAeavh8m6juds=
X-Received: by 2002:a5b:a4c:: with SMTP id z12mr16083524ybq.490.1642691214228;
 Thu, 20 Jan 2022 07:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20220119134948.1444965-1-quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220119134948.1444965-1-quentin.schulz@theobroma-systems.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 20 Jan 2022 10:06:43 -0500
Message-ID: <CAMdYzYr+UXU-x=OakdHnOzLe1e4Y0xdGR-rybsmpLCMGbsWwXg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: fix rk3399-puma eMMC HS400 signal integrity
To:     quentin.schulz@theobroma-systems.com
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 8:52 AM <quentin.schulz@theobroma-systems.com> wrote:
>
> From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
>
> There are signal integrity issues running the eMMC at 200MHz on Puma
> RK3399-Q7.
>
> Similar to the work-around found for RK3399 Gru boards, lowering the
> frequency to 100MHz made the eMMC much more stable, so let's lower the
> frequency to 100MHz.
>
> It might be possible to run at 150MHz as on RK3399 Gru boards but only
> 100MHz was extensively tested.
>
> Cc: Quentin Schulz <foss+kernel@0leil.net>
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>
> Note/RFC: as opposed to gru DTSI, max-frequency is used here instead of
> assigned-clock-rates.
>
> AFAIU, max-frequency applies to the SD bus rate, while
> assigned-clock-rates applies to the clock fed to the SD host controller
> inside the SoC. max-frequency does not interact with the clock subsystem
> AFAICT. assigned-clock-rates sets the clock rate at probe, regardless of
> eMMC tuning.
> Technically, the Arasan SDHC IP supports silicon-hardcoded clock
> multiplier so I think setting assigned-clock-rates as a way of rate
> limiting the eMMC block is incorrect and max-frequency should be used
> instead (as done in this patch). Otherwise the SDHC could still potentially
> derive a 200MHz clock from a lower rate clock thanks to its multiplier.
>
>  arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> index fb67db4619ea..a6108578aae0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> @@ -425,6 +425,12 @@ vcc5v0_host_en: vcc5v0-host-en {
>  };
>
>  &sdhci {
> +       /*
> +        * Signal integrity isn't great at 200MHz but 100MHz has proven stable
> +        * enough.
> +        */
> +       max-frequency = <100000000>;
> +
>         bus-width = <8>;
>         mmc-hs400-1_8v;
>         mmc-hs400-enhanced-strobe;

I don't have these boards nor the schematics handy for them, but
wouldn't it be better to simply switch to mmc-hs200-1_8v?
Other rk3399 boards don't have issues with hs200 at full 200mhz, and
as I understand it hs400-es exhibits stability issues on most rk3399
boards.

Feel free to disregard my comments if you've already tested this.

> --
> 2.34.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
