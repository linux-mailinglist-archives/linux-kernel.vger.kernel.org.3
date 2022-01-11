Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEBB48A41C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbiAKAAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbiAKAAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:00:34 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDE1C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 16:00:33 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z3so14540010plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 16:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zuq3NXRWllFEinxDVSxSn6g55pIWnkmVxTKgeR8Rvso=;
        b=wK3kJ8twvyqAdlIet7Bftfc3sJdLQooxkdrhGyBdNfyEtl40wHZO0HrWRug7XvBnLf
         4IDPJbPOvCihEAIFLkJkNPzySy8EGL7254MLvO0HAf0XK1xaGzvNn8cs7grrN87iq/JP
         MQLpdcGjm4UGrLL2CFpsYN/Oy7GMpXx1b9cb3siu7chrfeG27fqy1JYpKIhLcEqNkonX
         oRzqBrllAsG8XiUmfTC0+gI+WNY9ua2c0pyAkY4cULPvdxWYAoA4AJp8hETX5ldWrlel
         SLEUl2hDlpcpcMPYg+GngkuyxY8cAi5haoYpDHtOACZlIp76SxVkCw78u+qP2Piz82g3
         hJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zuq3NXRWllFEinxDVSxSn6g55pIWnkmVxTKgeR8Rvso=;
        b=mGy1khU4ysRjrYZXC2mVmQdkZ9JuU8TtHnHUPozcrNhrAKf8kmX6Z8yYeI4bEhUjmU
         kR6F6OezYJEas1ESHjE/YuHjGIMxwesONySGBk3URD2uPPRryHwV2LcAJx2tbHXOMsae
         BCu+2XKHSCfJSyLfUVHViL9XwZv9oHivPNuJvjPS4baokZRM3pEXwP6ZjUXg+M2f5y8V
         1NLuB2NJTr4Glr5PGy353zjp+LfK0dxFDulnFE5yah469VeKyT9HYZmUMnEMtEYuyPYz
         aKgc0jeZCPJmA/fOgCHyO7x2atYlQpfLlNB0+iHhB/L1TfNmz489r4XYCMWkOrYVxDA3
         j3Yw==
X-Gm-Message-State: AOAM531soER4EQSrH1oAtqExjzrV33eM21REumzsXyjjgr6tCQ3qd31Z
        fvANFz8oNuorSOTLTOWL4IL19HOOEBI+gbfWKO9C2Q==
X-Google-Smtp-Source: ABdhPJwT03HQS2JGvNVaddNqSHmcxSEOVZzwNIZztfB8jJ2rTbKuFz6Gk3SMdi7Xf/qpN6HWnOs/jCmCKwbnKyCb/iw=
X-Received: by 2002:aa7:9543:0:b0:4bf:2a07:5bc7 with SMTP id
 w3-20020aa79543000000b004bf2a075bc7mr1995022pfq.73.1641859232915; Mon, 10 Jan
 2022 16:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20211214213630.14819-1-tharvey@gateworks.com>
In-Reply-To: <20211214213630.14819-1-tharvey@gateworks.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 10 Jan 2022 16:00:21 -0800
Message-ID: <CAJ+vNU0U7HknAZcnua39r9to+kJBea6Fg3NiJ9ybZ1xygKoF4g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw73xx-0x: add dt overlays for
 serial modes
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 1:36 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> The imx8mm-venice-gw73xx-0x som+baseboard combination has a multi-protocol
> RS-232/RS-485/RS-422 transceiver to an off-board connector which
> can be configured in a number of ways via UART and GPIO configuration.
>
> The default configuration per the imx8mm-venice-gw73xx-0x dts is for
> UART2 TX/RX and UART4 TX/RX to be available as RS-232:
>  J15.1 UART2 TX out
>  J15.2 UART2 RX in
>  J15.3 UART4 TX out
>  J15.4 UART4 RX in
>  J15.5 GND
>
> Add dt overlays to allow additional the modes of operation:
>
> rs232-rts (UART2 RS-232 with RTS/CTS hardware flow control)
>  J15.1 TX out
>  J15.2 RX in
>  J15.3 RTS out
>  J15.4 CTS in
>  J15.5 GND
>
> rs485 (UART2 RS-485 half duplex)
>  J15.1 TXRX-
>  J15.2 N/C
>  J15.3 TXRX+
>  J15.4 N/C
>  J15.5 GND
>
> rs422 (UART2 RS-422 full duplex)
>  J15.1 TX-
>  J15.2 RX+
>  J15.3 TX+
>  J15.4 RX-
>  J15.5 GND
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  3 +
>  .../imx8mm-venice-gw73xx-0x-rs232-rts.dts     | 53 ++++++++++++++++
>  .../imx8mm-venice-gw73xx-0x-rs422.dts         | 61 +++++++++++++++++++
>  .../imx8mm-venice-gw73xx-0x-rs485.dts         | 61 +++++++++++++++++++
>  4 files changed, 178 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index a14a6173b765..5ec8d59347b6 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -44,6 +44,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs422.dtbo
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs485.dtbo
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts
> new file mode 100644
> index 000000000000..c184cf4aea4e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2021 Gateworks Corporation
> + *
> + * GW73xx RS232 with RTS/CTS hardware flow control:
> + *  - GPIO4_0 rs485_en needs to be driven low (in-active)
> + *  - UART4_TX becomes RTS
> + *  - UART4_RX becomes CTS
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "imx8mm-pinfunc.h"
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +       compatible = "gw,imx8mm-gw73xx-0x";
> +};
> +
> +&gpio4 {
> +       rs485_en {
> +               gpio-hog;
> +               gpios = <0 GPIO_ACTIVE_HIGH>;
> +               output-low;
> +               line-name = "rs485_en";
> +       };
> +};
> +
> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart2>;
> +       rts-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;
> +       cts-gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
> +       uart-has-rtscts;
> +       status = "okay";
> +};
> +
> +&uart4 {
> +       status = "disabled";
> +};
> +
> +&iomuxc {
> +       pinctrl_uart2: uart2grp {
> +               fsl,pins = <
> +                       MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
> +                       MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX     0x140
> +                       MX8MM_IOMUXC_UART4_TXD_GPIO5_IO29       0x140
> +                       MX8MM_IOMUXC_UART4_RXD_GPIO5_IO28       0x140
> +               >;
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts
> new file mode 100644
> index 000000000000..3e6404340d52
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2021 Gateworks Corporation
> + *
> + * GW73xx RS422 (RS485 full duplex):
> + *  - GPIO1_0 rs485_term selects on-chip termination
> + *  - GPIO4_0 rs485_en needs to be driven high (active)
> + *  - GPIO4_2 rs485_hd needs to be driven low (in-active)
> + *  - UART4_TX is DE for RS485 transmitter
> + *  - RS485_EN needs to be pulled high
> + *  - RS485_HALF needs to be low
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "imx8mm-pinfunc.h"
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +       compatible = "gw,imx8mm-gw73xx-0x";
> +};
> +
> +&gpio4 {
> +       rs485_en {
> +               gpio-hog;
> +               gpios = <0 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "rs485_en";
> +       };
> +
> +       rs485_hd {
> +               gpio-hog;
> +               gpios = <2 GPIO_ACTIVE_HIGH>;
> +               output-low;
> +               line-name = "rs485_hd";
> +       };
> +};
> +
> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart2>;
> +       rts-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
> +       linux,rs485-enabled-at-boot-time;
> +       status = "okay";
> +};
> +
> +&uart4 {
> +       status = "disabled";
> +};
> +
> +&iomuxc {
> +       pinctrl_uart2: uart2grp {
> +               fsl,pins = <
> +                       MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
> +                       MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX     0x140
> +                       MX8MM_IOMUXC_UART4_TXD_GPIO5_IO29       0x140
> +               >;
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts
> new file mode 100644
> index 000000000000..97f19c15c3d0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2021 Gateworks Corporation
> + *
> + * GW73xx RS485 HD:
> + *  - GPIO1_0 rs485_term selects on-chip termination
> + *  - GPIO4_0 rs485_en needs to be driven high (active)
> + *  - GPIO4_2 rs485_hd needs to be driven high (active)
> + *  - UART4_TX is DE for RS485 transmitter
> + *  - RS485_EN needs to be pulled high
> + *  - RS485_HALF needs to be pulled high
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "imx8mm-pinfunc.h"
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +       compatible = "gw,imx8mm-gw73xx-0x";
> +};
> +
> +&gpio4 {
> +       rs485_en {
> +               gpio-hog;
> +               gpios = <0 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "rs485_en";
> +       };
> +
> +       rs485_hd {
> +               gpio-hog;
> +               gpios = <2 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "rs485_hd";
> +       };
> +};
> +
> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart2>;
> +       rts-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
> +       linux,rs485-enabled-at-boot-time;
> +       status = "okay";
> +};
> +
> +&uart4 {
> +       status = "disabled";
> +};
> +
> +&iomuxc {
> +       pinctrl_uart2: uast2grp {
> +               fsl,pins = <
> +                       MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
> +                       MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX     0x140
> +                       MX8MM_IOMUXC_UART4_TXD_GPIO5_IO29       0x140
> +               >;
> +       };
> +};
> --
> 2.17.1
>

gentle ping.

I'm mostly interested to see if my approach to dt fragments here and
the naming of the files makes sense to others.

This patch causes the kernel to build dtbo files for:
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtbo
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtbo

The intention is that these files are used by boot firmware (U-Boot)
to adjust the dtb before passing it to the kernel.

Best regards,

Tim
