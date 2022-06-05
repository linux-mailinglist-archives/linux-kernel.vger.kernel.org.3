Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6689A53DAF6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiFEJNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiFEJNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:13:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9998518377
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 02:13:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w21so10547186pfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=t40w8M/0e+7jzPaXKU8sHRs+0HYfLIpNt+JXgYblSMg=;
        b=ocyh0GC00EAoaldlX1NjY7vXM7LbDtFDCA/7kXfCx1Ot+WKDvRO2xAoQE4IatRDfQE
         iggeZJFMvcTXFNuSAHi269fFf0Y7FYT/7p7FgnjfU/0uYk4Y3dcrKAX1+i2bUYqFHOSa
         nx9ZzclCH+yphK8vDpAp1cpBhgTl+ZyCbBuFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=t40w8M/0e+7jzPaXKU8sHRs+0HYfLIpNt+JXgYblSMg=;
        b=hEunNdHkQzHb/XeU/zHxLyfA3ZqDseGWQXAFS/RRiGsOa3tjn48GACz/VrqRVOxziU
         VYlV0zqh/z8HYxCRc/jn0t+aWDplTVDRZOIzXmBMPPNp2TXGQMNmfBPJYi4cWHCcm6+r
         8fP7hLKwuwQZbpb8wujNfiXTSqzN3aN8Uje6XqTsgt6+TrKhMwsU0s5pCLAQbDOsd4ku
         OWcbV1tmJAXy5Z1EMRUNsO+9GNRY5+ug+oejozj2v3g2muPVNrkQ6sO1bOeuOPQp6Y3+
         2/ewU5tuPnKdN5GJtopxCcGhCujTCOI3EH7or5vah24y8GIQYGLVza8ACqd8DJtjbyAG
         W2XQ==
X-Gm-Message-State: AOAM531xNyNP4hgjViUCYbZIWRsfXUP+9AtX2YFO4fEXZcFvkNsoyE4u
        6tiEf/6NjTyMDGuhL1P/RmWGOOLz9hyOnq59y5oJwg==
X-Google-Smtp-Source: ABdhPJyfM9d7kMlMNvdUeRn2dk39OQ/Usv5Q6CYgHbkGf9STAOM6qa29oOgODMY+MUkxTGzGNRvQeI1jGiWN9/fZwuA=
X-Received: by 2002:a05:6a00:2402:b0:4e1:3df2:5373 with SMTP id
 z2-20020a056a00240200b004e13df25373mr85499945pfh.40.1654420423926; Sun, 05
 Jun 2022 02:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220604183905.1025201-1-michael@amarulasolutions.com>
In-Reply-To: <20220604183905.1025201-1-michael@amarulasolutions.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Sun, 5 Jun 2022 11:13:31 +0200
Message-ID: <CAOf5uwm=TTZSevG7GtYzB9x0kk4f+DMeJMrTvzrogPwqe9utZA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-bsh-smm-s2/pro: Add pmic clock connection
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have some problems here. Open to suggestion:

On Sat, Jun 4, 2022 at 8:39 PM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> pmic clock is connected to svns_rtc using RTC_XTALI pin,
> and wifi/bluetooth chipset
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  .../boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi     | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
> index c11895d9d582..a21ec0d1d003 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
> @@ -28,6 +28,8 @@ usdhc2_pwrseq: usdhc2-pwrseq {
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&pinctrl_usdhc2_pwrseq>;
>                 reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
> +               clocks = <&bd71847>;
> +               clock-names = "ext_clock";
>         };
>  };
>
> @@ -214,6 +216,11 @@ &i2c4 {
>         status = "okay";
>  };
>
> +&snvs_rtc {
> +       clocks = <&bd71847>;
> +       clock-names = "snvs-rtc";
> +};
> +
>  &uart2 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_uart2>;
> @@ -235,6 +242,8 @@ bluetooth {
>                 shutdown-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
>                 device-wakeup-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
>                 host-wakeup-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +               clocks = <&bd71847>;
> +               clock-names = "lpo";
>                 max-speed = <3000000>;
>         };
>  };

I've done more testing in suspend/resume and it can not work. I have
modelled differently and extended the svns block to receive an
external clock and make it always enabled. The problem here is the cpu
takes the clock from the pmic that is enabled by default and the pmic
clock even wifi and bluetooth. If I want to register the driver I
would like to connect all of them but it seems that osc_32k is the
basic clock of the cpu and can be modelled using pmic easily. Even I
have created the ext clock on the snvs block so  should be always
enabled suspend/resume. The device can not resume from suspend.

Michael

> --
> 2.25.1
>


-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
