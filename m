Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F1B481506
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbhL2QLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:11:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52230 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbhL2QLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:11:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79CC0B8184F;
        Wed, 29 Dec 2021 16:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5B8C36AED;
        Wed, 29 Dec 2021 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640794307;
        bh=vityWGqRnX8AIL4jzKrTggu2qzNNb9KeQS2DZR/PaAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5KSnoSiP7kuV5zV3bI5inCyF/thNNFrk4Ot1uRmHMIkOlAckUAmn8nvbE+T8c6P4
         RT2nToM1qn/bL5dqlCE8uKry9N4fV3mQqx7WpX7JRuTJFoyWiDnCWSfKPOc8B3ojKn
         JFON14hxgIiq+Dy7oJdJweuXGGwyr0yM9m8vf4Fpo3yiHFOe3cRbO//UPY+Tmi9jbk
         I6pE9LO5GGKKD1KdUKf3fQkTaFplLNK55YmEgK/t+xPynpAgwB+itDuaOxUTTDR6si
         Rk4nJPIpGB1vF89nUl7396ggifpQtvzmnuKvxBLANbmbS3BeYfssScYGxnrkNBlJ+s
         wS7jv6ULaf1PQ==
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
Subject: [PATCH 7/7] arm64: dts: exynos: Remove unused num-viewport from pcie node
Date:   Thu, 30 Dec 2021 00:02:45 +0800
Message-Id: <20211229160245.1338-8-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229160245.1338-1-jszhang@kernel.org>
References: <20211229160245.1338-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 281f1f99cf3a("PCI: dwc: Detect number of iATU windows"),
the number of iATU windows is detected at runtime, what's more,
the 'num-viewport' property parsing has been removed, so remove the
unused num-viewport from pcie nodes.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 4422021cf4b2..8d65a4115c47 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1960,7 +1960,6 @@ pcie: pcie@15700000 {
 				 <&cmu_fsys CLK_PCLK_PCIE_PHY>;
 			clock-names = "pcie", "pcie_bus";
 			num-lanes = <1>;
-			num-viewport = <3>;
 			bus-range = <0x00 0xff>;
 			phys = <&pcie_phy>;
 			ranges = <0x81000000 0 0	  0x0c001000 0 0x00010000>,
-- 
2.34.1

