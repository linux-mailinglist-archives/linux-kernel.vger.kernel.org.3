Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CAE48154A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhL2Qul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:50:41 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:52481 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbhL2Quk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:50:40 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 7141976b;
        Wed, 29 Dec 2021 17:50:38 +0100 (CET)
Date:   Wed, 29 Dec 2021 17:50:38 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, linux@armlinux.org.uk,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
In-Reply-To: <20211229160245.1338-1-jszhang@kernel.org> (message from Jisheng
        Zhang on Thu, 30 Dec 2021 00:02:38 +0800)
Subject: Re: [PATCH 0/7] arm/arm64: dts: Remove unused num-viewport from pcie node
References: <20211229160245.1338-1-jszhang@kernel.org>
Message-ID: <d3cb7b8439ee3d06@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jisheng Zhang <jszhang@kernel.org>
> Date: Thu, 30 Dec 2021 00:02:38 +0800
> 
> After commit 281f1f99cf3a("PCI: dwc: Detect number of iATU windows"),
> the number of iATU windows is detected at runtime, what's more,
> the 'num-viewport' property parsing has been removed, so remove the
> unused num-viewport from pcie node(s).
> 
> It's too late for linux-5.17-rc1, I will rebase and send out v2 if
> necessary when 5.17-rc1 is released.

Please no.  This only makes the device trees unnecessarily
incompatible with older kernels and other OSes that do rely on the
"num-viewport" property.  It really doesn't hurt to keep this property
even if future Linux kernels no longer look at it.

Thanks,

Mark

> Jisheng Zhang (7):
>   ARM: dts: ls1021a: remove unused num-viewport from pcie nodes
>   arm64: dts: visconti: Remove unused num-viewport from pcie node
>   arm64: dts: uniphier: Remove unused num-viewport from pcie node
>   arm64: tegra: Remove unused num-viewport from pcie node
>   arm64: dts: marvell: Remove unused num-viewport from pcie node
>   arm64: dts: freescale: Remove unused num-viewport from pcie node
>   arm64: dts: exynos: Remove unused num-viewport from pcie node
> 
>  arch/arm/boot/dts/ls1021a.dtsi                          | 2 --
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi              | 1 -
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi          | 1 -
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi          | 2 --
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi          | 3 ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi          | 3 ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi          | 3 ---
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi          | 4 ----
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi      | 1 -
>  arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts | 1 -
>  arch/arm64/boot/dts/marvell/cn9130-crb-A.dts            | 1 -
>  arch/arm64/boot/dts/marvell/cn9130-crb-B.dts            | 1 -
>  arch/arm64/boot/dts/marvell/cn9130-db.dtsi              | 1 -
>  arch/arm64/boot/dts/marvell/cn9131-db.dtsi              | 1 -
>  arch/arm64/boot/dts/marvell/cn9132-db.dtsi              | 2 --
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi                | 6 ------
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi        | 1 -
>  arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi        | 1 -
>  arch/arm64/boot/dts/toshiba/tmpv7708.dtsi               | 1 -
>  19 files changed, 36 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
