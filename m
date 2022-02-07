Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8684ACAC0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiBGUuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiBGUuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:50:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A5AC06173B;
        Mon,  7 Feb 2022 12:50:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id eg42so17050814edb.7;
        Mon, 07 Feb 2022 12:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qANdVIXCMVhjPuSivu0hrfa8oVru7nw+lgS/w//R+RE=;
        b=JoNuzVH/O+lLHTezpYLCs+MUz3Rrigv/zPwrdB/Cr6Or812bKwPMSHL+15qJz3t35Q
         eF+fL+nakoKfoA4mYbcjYn+Q/tMirBm+jfju65smbn+cZOwZOT94/e7hnQpyRTNK0ski
         JZSXYY4NvZtdlYRDfFJSx1bj3pDz0G4Km0ywk7NGjQcFUx6i4u4MW6CrkHFNR045BeaJ
         VKUwU7y/mZ+XG6EzC/r4NrAYanpEaRJLL4Iilo/4AaCI4m1GpQ9lDWUvdQ2EiGbdUZO4
         ZOspzY2T/cB5xQ0w2QsezfKaoT6K8SGtYW4KHtB0fjSIas73Y/7dHoTAuUcwPEFigyAH
         CX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qANdVIXCMVhjPuSivu0hrfa8oVru7nw+lgS/w//R+RE=;
        b=iXcB5WmP+RbEhAfU4Br/hlAw+TqVxwLEMtE4+dUVXlyJGpw57tPliVSGsg2n2qQce/
         bBIvu0eqeZ+5794yYxs2go7GmNNGqWsQ9zGiQx2cbtDMxuOtfA1NOFPG+apJZg/CShpr
         HjqqBZxzW7hC2ekJq5x+5vx42fgplCSpgE5bUCkpLW995I4UpinJprNTswGy7psJhgOo
         3cyDDW/yZ1wKmCziFTd94yxc2tibVWK6QAA9tHEdYWYepsp+Xp+FKfetg1ssQkhBzYYm
         Jj8XVAE8jue9DuoJ0Sgaytq0xB+JZlelHzcR7j011lHSt0JT85QGMRBE+LvYlksVfCRR
         L8Gg==
X-Gm-Message-State: AOAM533cfsZPTWrrwYGS5CrSCFikLSr8LbGjxlbipzddkrx4i1lqu1pF
        5xhrZK10Oj633sEqN7um/zvsZQkJpTsWRwOqtOk=
X-Google-Smtp-Source: ABdhPJwUkvLG3szeNM72tsDqCo7WERJYIsWjEU0x/ajOdiio0nC4TYaVtjs7HDFrhdAG0j5IL8ZSUVHc73eBW5CqG0I=
X-Received: by 2002:a05:6402:268d:: with SMTP id w13mr1263663edd.287.1644267005940;
 Mon, 07 Feb 2022 12:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20220204225706.1539818-1-marcel@ziswiler.com> <20220204225706.1539818-13-marcel@ziswiler.com>
In-Reply-To: <20220204225706.1539818-13-marcel@ziswiler.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 7 Feb 2022 17:49:55 -0300
Message-ID: <CAOMZO5D-i5m8ktXkxSmTcTr2NzpnuYFF3KsqTOO+HCxypkRNmQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] arm64: dts: freescale: add initial support for
 verdin imx8m mini
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Li Yang <leoyang.li@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Fri, Feb 4, 2022 at 7:58 PM Marcel Ziswiler <marcel@ziswiler.com> wrote:

> +/* On-module Wi-Fi */
> +&usdhc3 {
> +       bus-width = <4>;
> +       keep-power-in-suspend;
> +       non-removable;
> +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_wifi_ctrl>;
> +       pinctrl-1 = <&pinctrl_usdhc3_100mhz>, <&pinctrl_wifi_ctrl>;
> +       pinctrl-2 = <&pinctrl_usdhc3_200mhz>, <&pinctrl_wifi_ctrl>;
> +       vmmc-supply = <&reg_wifi_en>;
> +       wifi-host;

wifi-host is not a valid property.

> +               /* Use the kernel configuration settings instead */
> +               /delete-node/ linux,cma;
> +
> +               rpmsg_reserved: rpmsg@b8000000 {

I suppose this comes from the NXP vendor BSP and does not apply upstream.

> +/* Verdin CAN_1 (On-module) */
> +&ecspi3 {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>,
> +                  <&gpio1 5 GPIO_ACTIVE_LOW>;
> +       spi-num-chipselects = <2>;

No need to specify "spi-num-chipselects". It is implicit by cs-gpios.

> +
> +&usbmisc1 {
> +       vbus-wakeup-supply = <&reg_vdd_3v3>;

Not a valid property.

> +};
> +
> +&usbmisc2 {
> +       vbus-wakeup-supply = <&reg_vdd_3v3>;

Ditto.

> +};
> +
> +/* Verdin USB_1 */
> +&usbotg1 {
> +       adp-disable;
> +       dr_mode = "otg";
> +       hnp-disable;
> +       over-current-active-low;
> +       picophy,dc-vol-level-adjust = <7>;

I guess you meant: samsung,picophy-dc-vol-level-adjust

> +       picophy,pre-emp-curr-control = <3>;

I guess you meant: samsung,picophy-pre-emp-curr-control

> +&usbotg2 {
> +       dr_mode = "host";
> +       over-current-active-low;
> +       picophy,dc-vol-level-adjust = <7>;
> +       picophy,pre-emp-curr-control = <3>;

Same here.
