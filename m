Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12EA4814E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbhL2QKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhL2QKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:10:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D723C061574;
        Wed, 29 Dec 2021 08:10:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40133B81904;
        Wed, 29 Dec 2021 16:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B02C36AE9;
        Wed, 29 Dec 2021 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640794230;
        bh=8t7mrNFu3LPmCwf7053YLkDEk1ZfHFwv2/JCjqAhjJ4=;
        h=From:To:Cc:Subject:Date:From;
        b=kdKr/oV/pCcCp2EJq7Pm/JFgmwkuhph7KGIe+5GWj7NGSsVpSI9WMKtSCBkkzI5U8
         jrAwi95tGe0HIOHDNvwwvLktREFIL8JRi0VcYFWJ2TyaLsbKzi7LcOVutXbP7Yx2ul
         Fn0trEk1mkbxK1Eh3rWDcGIAFz2fUM3UFxzm/IKWcyu6ipI9ojgMPgjltluiHgZdrZ
         s0M39YiIAGOrm8zrgexTH9WOr/bnhr/WtTWbsJpkONnLfSOaIBQmlPDfsUM8MC1cd0
         Uhn5+7/wKRQFaA1fVlJjve6wvBOdtaPsum+h2/gRFXeG+BdDLZqOfErofvWIfP6OdI
         h3tJPnYSU9Xnw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 0/7] arm/arm64: dts: Remove unused num-viewport from pcie node
Date:   Thu, 30 Dec 2021 00:02:38 +0800
Message-Id: <20211229160245.1338-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 281f1f99cf3a("PCI: dwc: Detect number of iATU windows"),
the number of iATU windows is detected at runtime, what's more,
the 'num-viewport' property parsing has been removed, so remove the
unused num-viewport from pcie node(s).

It's too late for linux-5.17-rc1, I will rebase and send out v2 if
necessary when 5.17-rc1 is released.

Jisheng Zhang (7):
  ARM: dts: ls1021a: remove unused num-viewport from pcie nodes
  arm64: dts: visconti: Remove unused num-viewport from pcie node
  arm64: dts: uniphier: Remove unused num-viewport from pcie node
  arm64: tegra: Remove unused num-viewport from pcie node
  arm64: dts: marvell: Remove unused num-viewport from pcie node
  arm64: dts: freescale: Remove unused num-viewport from pcie node
  arm64: dts: exynos: Remove unused num-viewport from pcie node

 arch/arm/boot/dts/ls1021a.dtsi                          | 2 --
 arch/arm64/boot/dts/exynos/exynos5433.dtsi              | 1 -
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi          | 1 -
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi          | 2 --
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi          | 3 ---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi          | 3 ---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi          | 3 ---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi          | 4 ----
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi      | 1 -
 arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts | 1 -
 arch/arm64/boot/dts/marvell/cn9130-crb-A.dts            | 1 -
 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts            | 1 -
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi              | 1 -
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi              | 1 -
 arch/arm64/boot/dts/marvell/cn9132-db.dtsi              | 2 --
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                | 6 ------
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi        | 1 -
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi        | 1 -
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi               | 1 -
 19 files changed, 36 deletions(-)

-- 
2.34.1

