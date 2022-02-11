Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E384B2395
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344886AbiBKKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:43:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349279AbiBKKnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:43:01 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18043D51;
        Fri, 11 Feb 2022 02:43:00 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id fj5so19077361ejc.4;
        Fri, 11 Feb 2022 02:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyCvwNNEqd9Koq/FvgmU4Dc9w7df+bVXHik2gZ5DpqE=;
        b=bvOQxf3GCJRlgOtyJ+Pkqp/3PPoPKk8unOQ4IqCKiSqPUAHyyRh8eS3OLskYP+0lq1
         70g2ehUsq0ppHciiP+e2g4wTppZEEypWQfqDiif2kp77QVedwf9tjkRS4g8aSPPztwUx
         KR3fiH5+6BUixXToHBvNcPm6rGx9CLmioRbo1N9sDsLcj4ybUwB5E+MbCOs8tIvvAWg3
         ug+ekQ76SWnBrdtdvYs3tp+EoGoHplSsbrbSSUAIb5yLDwTX8J/80KuRm+tMuTvmU7+m
         68yhyC+RG8WjsB9ba0WL0GTlIDKxeTFfrrkMC/VcauMXbRhwWhFO3QIUzsf7QeB4U1Q2
         7+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyCvwNNEqd9Koq/FvgmU4Dc9w7df+bVXHik2gZ5DpqE=;
        b=scp0vopMc58J/9ndSKS8jDgPxpsJrSw7n1YjkagzKoP81lhkIwcUF62bLvmozmRzeU
         1dynDRp2F3iAPTDCm7ze9pozLmSeMvDtEexIRiFTrfkkiCPo8xmmCC2B5lNuL6mEuqZq
         1LHqy7/PNB+DfO9IISPgihIoGnnfyvFuIvq+qaiFybmNgB0gRwcGDL92kegjP+bNe1ND
         vjgLJtn0g1tf6ZCr/I2JZKTtwx6UwCmJtnh6to8qTqY54e3V/8v+OGpycRh7a5mz3CgF
         UHAc44wnR2/e3t1oOaVwZwgn4X8bFLWeCcNhKtfL15GioUmB0yPr99RiQBhzi0xkuV1T
         f5Zw==
X-Gm-Message-State: AOAM530/jMjr6/iLjaq61vO88BF/UlAIVwYbxvL8ZW2fJzSX4lbSk3s/
        xE/KAvs3Z2JssxUdaqID1zPc2BWSqtrPFRwwhUn3Ch3x
X-Google-Smtp-Source: ABdhPJwAMjWA9kgWb2WmRKT+VqTzWvc0Zv4GydQAYInH4eQ5DPFQtytRou/bKoWTy66pVn0CFl5CbJgNi9EKQDhgAOA=
X-Received: by 2002:a17:906:ad8e:: with SMTP id la14mr853369ejb.492.1644576178517;
 Fri, 11 Feb 2022 02:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20220211092322.287487-1-marcel@ziswiler.com> <20220211092322.287487-13-marcel@ziswiler.com>
In-Reply-To: <20220211092322.287487-13-marcel@ziswiler.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 11 Feb 2022 07:42:48 -0300
Message-ID: <CAOMZO5CoP82hd==Au1GCB6y1Y+QeYMJ185ZuyD1tHGd3H5gZzQ@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] arm64: dts: freescale: add initial support for
 verdin imx8m mini
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>, Chester Lin <clin@suse.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Lucas Stach <dev@lynxeye.de>,
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

On Fri, Feb 11, 2022 at 6:24 AM Marcel Ziswiler <marcel@ziswiler.com> wrote:
>
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> This patch adds the device tree to support Toradex Verdin iMX8M Mini a
> computer on module which can be used on different carrier boards.
>
> The module consists of an NXP i.MX 8M Mini family SoC (either i.MX 8M
> Mini Quad or 8M Mini DualLite), a PCA9450A PMIC, a Gigabit Ethernet PHY,
> 1 or 2 GB of LPDDR4 RAM, an eMMC, a TLA2024 ADC, an I2C EEPROM, an
> RX8130 RTC, an optional SPI CAN controller plus an optional Bluetooth/
> Wi-Fi module.
>
> Anything that is not self-contained on the module is disabled by
> default.
>
> The device tree for the Dahlia includes the module's device tree and
> enables the supported peripherals of the carrier board.
>
> The device tree for the Verdin Development Board includes the module's
> device tree as well as the Dahlia one as it is a superset and supports
> almost all peripherals available.
>
> So far there is no display functionality supported at all but basic
> console UART, PCIe, USB host, eMMC and Ethernet and PCIe functionality
> work fine.
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
