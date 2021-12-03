Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899B3467AAF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381908AbhLCQAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:00:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245493AbhLCQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638547044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SI1YU+5e3o1GhpSpRhdySXud9KfKjuS/f8EQzUXhnMM=;
        b=ZKG4DD/x25Is854q6bCCl5i+wIPU4v0WHDGKs+b5vR5juyyncX0hbF5eMpPIP/jPcyW5sI
        V9NkOzlxC5qeK9Qic7VK+A8o/uO8jQyxUaOUCnAVnSIDkMK+HnwqUX5Y5IIzWzVWITuSwl
        LhWrUZLIpsDrnyefow3wat3m1BeYkJk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-EJ89bcHSOi-qhUufiJm8mA-1; Fri, 03 Dec 2021 10:57:23 -0500
X-MC-Unique: EJ89bcHSOi-qhUufiJm8mA-1
Received: by mail-pf1-f199.google.com with SMTP id 184-20020a6217c1000000b0049f9aad0040so2131559pfx.21
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 07:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SI1YU+5e3o1GhpSpRhdySXud9KfKjuS/f8EQzUXhnMM=;
        b=UGXsbWYwJLS/JnxMSqo5UV2DmtROTirVraW5WctZry9byqzaRrAgJ9H4EfyJ7Tu3M2
         Vv6deI2BhB+WD8HdkajFmUS9S6lG4YoGhAWAyeTtA1+rx9ObN6i4n8VQbO00TXHDRu3k
         GiFp0rmo+xLYRBQP9CI+HmnPMk1Pquz7k+b5lDNAqcvu972Z0oEhnIQ1A087w+H8bLqy
         yOE2Uo2LPglw+4w/bkAp5c/OpL9RFDBcOOECETt+4kFtWgszMrHbtpsnZg/govEUj+Vx
         DJwT6TDwT4yvJfSTIwTYLnAW9eKWjETA5CmwkamCLCA6uW6Ix5RelawXewpH/PJNWGUV
         otvA==
X-Gm-Message-State: AOAM530/NG2kO1TfNKasm6uJiEb7wWNIXgO7p8ocCXV3EPzioj6dmdOV
        ijs7nbF0RhUNG45/fEQLrlAUGYxdsV3AyW4LNksMjZz9F4HbohfI10/0hhsXhpaJtcNltGlD7RD
        zvkQPVcnoaGYJmkL6N37a6yLIv3oqguEJWKO0yrBJ
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr15044629pjb.113.1638547042530;
        Fri, 03 Dec 2021 07:57:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7xrMTNB0QkbrgSng2lNDULxghTBGZ0ukHYDNd8EQcN9SxbRp/egMqv5t46VIGBXphmZyNHFofkRGvz2DXQhg=
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr15044574pjb.113.1638547042174;
 Fri, 03 Dec 2021 07:57:22 -0800 (PST)
MIME-Version: 1.0
References: <20211202115622.40153-1-alistair@alistair23.me> <20211202115622.40153-4-alistair@alistair23.me>
In-Reply-To: <20211202115622.40153-4-alistair@alistair23.me>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 3 Dec 2021 16:57:11 +0100
Message-ID: <CAO-hwJJ7jJJkExu+GxwiGn=6t+aUow9ktmCedMRCfNF0bLAXfQ@mail.gmail.com>
Subject: Re: [PATCH v15 3/3] ARM: dts: imx7d: remarkable2: add wacom digitizer device
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ping Cheng <Ping.Cheng@wacom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Alistair Francis <alistair23@gmail.com>,
        tatsunosuke.tobita@wacom.com,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jason Gerecke <Jason.Gerecke@wacom.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>, martin.chen@wacom.com,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 12:56 PM Alistair Francis <alistair@alistair23.me> wrote:
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 59 +++++++++++++++++++++++++

I think I am always asking the same question, but is it fine for me to
take this patch through the hid tree?
I seem to remember that this was a little bit free for all but I'd
like to get the confirmation first.

Cheers,
Benjamin


>  1 file changed, 59 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index 89cbf13097a4..a2a91bfdd98e 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -34,6 +34,19 @@ reg_brcm: regulator-brcm {
>                 startup-delay-us = <150>;
>         };
>
> +       reg_digitizer: regulator-digitizer {
> +               compatible = "regulator-fixed";
> +               regulator-name = "VDD_3V3_DIGITIZER";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               pinctrl-names = "default", "sleep";
> +               pinctrl-0 = <&pinctrl_digitizer_reg>;
> +               pinctrl-1 = <&pinctrl_digitizer_reg>;
> +               gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               startup-delay-us = <100000>; /* 100 ms */
> +       };
> +
>         wifi_pwrseq: wifi_pwrseq {
>                 compatible = "mmc-pwrseq-simple";
>                 pinctrl-names = "default";
> @@ -51,6 +64,26 @@ &clks {
>         assigned-clock-rates = <0>, <32768>;
>  };
>
> +&i2c1 {
> +       clock-frequency = <400000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +
> +       wacom_digitizer: digitizer@9 {
> +               compatible = "hid-over-i2c";
> +               reg = <0x09>;
> +               hid-descr-addr = <0x01>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_wacom>;
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
> +               touchscreen-inverted-x;
> +               touchscreen-inverted-y;
> +               vdd-supply = <&reg_digitizer>;
> +       };
> +};
> +
>  &snvs_pwrkey {
>         status = "okay";
>  };
> @@ -117,6 +150,25 @@ &wdog1 {
>         fsl,ext-reset-output;
>  };
>
> +&iomuxc_lpsr {
> +       pinctrl_digitizer_reg: digitizerreggrp {
> +               fsl,pins = <
> +                       /* DIGITIZER_PWR_EN */
> +                       MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6     0x14
> +               >;
> +       };
> +
> +       pinctrl_wacom: wacomgrp {
> +               fsl,pins = <
> +                       /*MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5   0x00000014 FWE */
> +                       MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4     0x00000074 /* PDCTB */
> +                       MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1     0x00000034 /* WACOM INT */
> +                       /*MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6   0x00000014 WACOM PWR ENABLE */
> +                       /*MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0   0x00000074 WACOM RESET */
> +               >;
> +       };
> +};
> +
>  &iomuxc {
>         pinctrl_brcm_reg: brcmreggrp {
>                 fsl,pins = <
> @@ -125,6 +177,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13  0x14
>                 >;
>         };
>
> +       pinctrl_i2c1: i2c1grp {
> +               fsl,pins = <
> +                       MX7D_PAD_I2C1_SDA__I2C1_SDA             0x4000007f
> +                       MX7D_PAD_I2C1_SCL__I2C1_SCL             0x4000007f
> +               >;
> +       };
> +
>         pinctrl_uart1: uart1grp {
>                 fsl,pins = <
>                         MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX    0x79
> --
> 2.31.1
>

