Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D6749DA81
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiA0GRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiA0GRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:17:49 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041EDC061749
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:17:48 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e8so1609200ilm.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+PEDmguhAETuYbK/cZB9FOANOyYAp2S8+nEc9n/mQU=;
        b=iDybhItg/XzNzWl80CoExdT2RTvnURVMAVlackcztP3KfCh9u2X200bSpeRm2yptL9
         nwqTmmZsPP9PcD6RYHKvEhNrACcSwm1apV7RDr3PwczX9lH0Yl4fCD+IsD+/mxCPssbC
         ZlcZiFQ3SwtPR4RJNICJ1sEaj0zhmyfuoA5Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+PEDmguhAETuYbK/cZB9FOANOyYAp2S8+nEc9n/mQU=;
        b=e5nV20h9sbuKKQAK9y3mjdXb1Zn5zyIka6uj8fCUASCc1nILx58SZ+OzIk5SiCStFp
         Go6DE0z0DPdhK6MBkW4XkaKktKdYmsMPd0B5mJoxGJlw01sPh3PpIoJqqTZcv3itMGhc
         5NypvofSi8nzwCHBwtJyySjtlvv6NRgBk8da8qBhgg2OFVQx9PhcCcmnvjJHvjSex5Vc
         8/7R170GaXYxeYdJSOp0MSN9V8GTZhojQlPV0j3fo+nQ+HfD/HIMpJiDeNHsCOXAFPWL
         Q6LQ+1M7iIgS/1t7It7kZk/M7CUC/SlLDxyY4DGmLvK5r7euZSb8FilmGiRUz85pZBZW
         XeTg==
X-Gm-Message-State: AOAM530qFy3x7tYEF/VkddGT0ZktOp/F+PfJ9mBaVBhTzgq/41mDMZ24
        g+cWHKOpJGGVi4R3s5J50MuURCIJS+hQz0KikF08Cw==
X-Google-Smtp-Source: ABdhPJwhSX6ptuiWr7zLHXvs2G7rb4MFy6FF1+d1TTIL3R/m/aWyVpfm9LNnOKq47fodb8rEI/XldAUZnxMJKyapypQ=
X-Received: by 2002:a92:ca0c:: with SMTP id j12mr1638728ils.105.1643264268223;
 Wed, 26 Jan 2022 22:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20220105022726.2458-1-allen-kh.cheng@mediatek.com> <20220105022726.2458-8-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220105022726.2458-8-allen-kh.cheng@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 27 Jan 2022 14:17:22 +0800
Message-ID: <CAJMQK-j0F_yrWNnS418O7e1AdS7VH76XdQMx2boLoe2LVV0nYA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: Add Mediatek SoC MT8186 dts and
 evaluation board and Makefile
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 10:27 AM allen-kh.cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
>
> Add basic chip support for Mediatek MT8186
>
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>  arch/arm64/boot/dts/mediatek/mt8186-evb.dts |  24 ++
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi    | 352 ++++++++++++++++++++
>  3 files changed, 377 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 4f68ebed2e31..2271c3452c64 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -31,5 +31,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-evb.dts b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
> new file mode 100644
> index 000000000000..eb23d1f19f87
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + */
> +/dts-v1/;
> +#include "mt8186.dtsi"
> +
> +/ {
> +       model = "MediaTek MT8186 evaluation board";
> +       compatible = "mediatek,mt8186-evb", "mediatek,mt8186";
> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:921600n8";
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0 0x40000000 0 0x80000000>;
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> new file mode 100644
> index 000000000000..fce84c341291
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -0,0 +1,352 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + */
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +/ {
> +       compatible = "mediatek,mt8186";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu@000 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55", "arm,armv8";
> +                       reg = <0x0000>;
> +                       enable-method = "psci";
> +                       clock-frequency = <2000000000>;
> +                       cpu-idle-states = <&cpuoff_l &clusteroff_l &mcusysoff>;
> +                       next-level-cache = <&l2_0>;
> +               };
> +
> +               cpu1: cpu@001 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55", "arm,armv8";
> +                       reg = <0x0100>;
> +                       enable-method = "psci";
> +                       clock-frequency = <2000000000>;
> +                       cpu-idle-states = <&cpuoff_l &clusteroff_l &mcusysoff>;
> +                       next-level-cache = <&l2_0>;
> +               };
> +
> +               cpu2: cpu@002 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55", "arm,armv8";
> +                       reg = <0x0200>;
> +                       enable-method = "psci";
> +                       clock-frequency = <2000000000>;
> +                       cpu-idle-states = <&cpuoff_l &clusteroff_l &mcusysoff>;
> +                       next-level-cache = <&l2_0>;
> +               };
> +
> +               cpu3: cpu@003 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55", "arm,armv8";
> +                       reg = <0x0300>;
> +                       enable-method = "psci";
> +                       clock-frequency = <2000000000>;
> +                       cpu-idle-states = <&cpuoff_l &clusteroff_l &mcusysoff>;
> +                       next-level-cache = <&l2_0>;
> +               };
> +
> +               cpu4: cpu@100 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55", "arm,armv8";
> +                       reg = <0x0400>;
> +                       enable-method = "psci";
> +                       clock-frequency = <2000000000>;
> +                       cpu-idle-states = <&cpuoff_l &clusteroff_l &mcusysoff>;
> +                       next-level-cache = <&l2_0>;
> +               };
> +
> +               cpu5: cpu@101 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a55", "arm,armv8";
> +                       reg = <0x0500>;
> +                       enable-method = "psci";
> +                       clock-frequency = <2000000000>;
> +                       cpu-idle-states = <&cpuoff_l &clusteroff_l &mcusysoff>;
> +                       next-level-cache = <&l2_0>;
> +               };
> +
> +               cpu6: cpu@102 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a75", "arm,armv8";
> +                       reg = <0x0600>;
> +                       enable-method = "psci";
> +                       clock-frequency = <2050000000>;
> +                       cpu-idle-states = <&cpuoff_b &clusteroff_b &mcusysoff>;
> +                       next-level-cache = <&l2_1>;
> +               };
> +
> +               cpu7: cpu@103 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a75", "arm,armv8";
> +                       reg = <0x0700>;
> +                       enable-method = "psci";
> +                       clock-frequency = <2050000000>;
> +                       cpu-idle-states = <&cpuoff_b &clusteroff_b &mcusysoff>;
> +                       next-level-cache = <&l2_1>;
> +               };
> +
> +               cpu-map {
> +                       cluster0 {
> +                               core0 {
> +                                       cpu = <&cpu0>;
> +                               };
> +
> +                               core1 {
> +                                       cpu = <&cpu1>;
> +                               };
> +
> +                               core2 {
> +                                       cpu = <&cpu2>;
> +                               };
> +
> +                               core3 {
> +                                       cpu = <&cpu3>;
> +                               };
> +
> +                               core4 {
> +                                       cpu = <&cpu4>;
> +                               };
> +
> +                               core5 {
> +                                       cpu = <&cpu5>;
> +                               };
> +
> +                       };
> +                       cluster1 {
> +                               core0 {
> +                                       cpu = <&cpu6>;
> +                               };
> +
> +                               core1 {
> +                                       cpu = <&cpu7>;
> +                               };
> +                       };
> +               };
> +
> +               idle-states {
> +                       entry-method = "psci";
> +
> +                       cpuoff_l: cpu-off-l {
> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x00010001>;
> +                               local-timer-stop;
> +                               entry-latency-us = <50>;
> +                               exit-latency-us = <100>;
> +                               min-residency-us = <1600>;
> +                       };
> +
> +                       cpuoff_b: cpu-off-b {
> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x00010001>;
> +                               local-timer-stop;
> +                               entry-latency-us = <50>;
> +                               exit-latency-us = <100>;
> +                               min-residency-us = <1400>;
> +                       };
> +
> +                       clusteroff_l: cluster-off-l {
> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x01010001>;
> +                               local-timer-stop;
> +                               entry-latency-us = <100>;
> +                               exit-latency-us = <250>;
> +                               min-residency-us = <2100>;
> +                       };
> +
> +                       clusteroff_b: cluster-off-b {
> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x01010001>;
> +                               local-timer-stop;
> +                               entry-latency-us = <100>;
> +                               exit-latency-us = <250>;
> +                               min-residency-us = <1900>;
> +                       };
> +
> +                       mcusysoff: mcusys-off {
> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x01010002>;
> +                               local-timer-stop;
> +                               entry-latency-us = <300>;
> +                               exit-latency-us = <1200>;
> +                               min-residency-us = <2600>;
> +                       };
> +               };
> +
> +               l2_0: l2-cache0 {
> +                       compatible = "cache";
> +                       next-level-cache = <&l3_0>;
> +               };
> +
> +               l2_1: l2-cache1 {
> +                       compatible = "cache";
> +                       next-level-cache = <&l3_0>;
> +               };
> +
> +               l3_0: l3-cache {
> +                       compatible = "cache";
> +               };
> +       };
> +
> +       clk26m: oscillator-26m {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <26000000>;
> +       };
> +
> +       clk32k: oscillator-32k {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <32000>;
> +       };
> +
> +       psci {
> +               compatible      = "arm,psci-1.0";
> +               method          = "smc";
> +       };
> +

please move below nodes into soc {}


> +       gic: interrupt-controller {
> +               compatible = "arm,gic-v3";
> +               #interrupt-cells = <3>;
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               #redistributor-regions = <1>;
> +               interrupt-parent = <&gic>;
> +               interrupt-controller;
> +               reg = <0 0x0c000000 0 0x40000>, // distributor
> +                     <0 0x0c040000 0 0x200000>; // redistributor
> +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       watchdog: watchdog@10007000 {
> +               compatible = "mediatek,mt8186-wdt",
> +                               "mediatek,mt6589-wdt";
> +               reg = <0 0x10007000 0 0x1000>;
> +       };
> +
> +       sys_timer@10017000 {
> +               compatible = "mediatek,mt8186_timer",
> +                            "mediatek,mt6765-timer";
> +               reg = <0 0x10017000 0 0x1000>;
> +               interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&clk26m>;
> +       };
> +
> +       timer: timer {
> +               compatible = "arm,armv8-timer";
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +                               <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +                               <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +                               <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +               clock-frequency = <13000000>;
> +       };
> +
> +       uart0: serial@11002000 {
> +               compatible = "mediatek,mt8186-uart",
> +                            "mediatek,mt6577-uart";
> +               reg = <0 0x11002000 0 0x1000>;
> +               interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&clk26m>, <&clk26m>;
> +               clock-names = "baud", "bus";
> +       };
> +
> +       uart1: serial@11003000 {
> +               compatible = "mediatek,mt8186-uart",
> +                            "mediatek,mt6577-uart";
> +               reg = <0 0x11003000 0 0x1000>;
> +               interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&clk26m>, <&clk26m>;
> +               clock-names = "baud", "bus";
> +               status = "disabled";
> +       };
> +
> +       uart2: serial@11018000 {
> +               compatible = "mediatek,mt8186-uart",
> +                            "mediatek,mt6577-uart";
> +               reg = <0 0x11018000 0 0x1000>;
> +               interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&clk26m>, <&clk26m>;
> +               clock-names = "baud", "bus";
> +               status = "disabled";
> +       };
> +
> +       mmc0: mmc@11230000 {
> +               compatible = "mediatek,mt8186-mmc", "mediatek,mt8183-mmc";
> +               reg = <0 0x11230000 0 0x1000>,
> +                     <0 0x11cd0000 0 0x1000>;
> +               interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&clk26m>,
> +                        <&clk26m>,
> +                        <&clk26m>,
> +                        <&clk26m>;
> +               clock-names = "source", "hclk", "source_cg",
> +                             "ahb_clk";
> +               status = "disabled";
> +       };
> +
> +       mmc1: mmc@11240000 {
> +               compatible = "mediatek,mt8186-mmc", "mediatek,mt8183-mmc";
> +               reg = <0 0x11240000 0 0x1000>,
> +                     <0 0x11c90000 0 0x1000>;
> +               interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&clk26m>,
> +                        <&clk26m>,
> +                        <&clk26m>;
> +               clock-names = "source", "hclk", "source_cg";
> +               status = "disabled";
> +       };
> +
> +       u3phy1: usb-phy1@11c80000 {
> +               compatible = "mediatek,mt8186-tphy", "mediatek,generic-tphy-v2";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +               status = "okay";
> +
> +               u2port1: usb2-phy1@11c80000 {
> +                       reg = <0 0x11c80000 0 0x700>;
> +                       clocks = <&clk26m>;
> +                       clock-names = "ref";
> +                       #phy-cells = <1>;
> +                       status = "okay";
> +               };
> +
> +               u3port1: usb3-phy1@11c80900 {
> +                       reg = <0 0x11c80900 0 0x700>;
> +                       clocks = <&clk26m>;
> +                       clock-names = "ref";
> +                       #phy-cells = <1>;
> +                       status = "okay";
> +               };
> +       };
> +
> +       u3phy0: usb-phy@11ca0000 {
> +               compatible = "mediatek,mt8186-tphy", "mediatek,generic-tphy-v2";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +               status = "okay";
> +
> +               u2port0: usb2-phy@11ca0000 {
> +                       reg = <0 0x11ca0000 0 0x700>;
> +                       clocks = <&clk26m>;
> +                       clock-names = "ref";
> +                       #phy-cells = <1>;
> +                       mediatek,discth = <0x8>;
> +                       status = "okay";
> +               };
> +       };
> +};
> --
> 2.18.0
>
