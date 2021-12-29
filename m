Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2200D4814EF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbhL2QLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240591AbhL2QLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:11:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDB3C061574;
        Wed, 29 Dec 2021 08:11:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F6C1B8184F;
        Wed, 29 Dec 2021 16:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4A9C36AED;
        Wed, 29 Dec 2021 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640794265;
        bh=MCJ1c2G0AvkOxBK7lYQWdzYLDOnQRNszMz4pYucFSEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgYDRett4iHtFytcsCIZm8KrqlEcu5/pB+3aLmfJhwnHdZHEDT0CR+XW6/RAnCRoo
         8IvgvssmHbR9fc5qrD02J/5rxWMXSxhv9Jwn9n27LmKB2uzE3tq9wJGPhJW9mGV5zz
         EDdv+LuDJsVef0vNTEBfb2DfLuWmvOKZezC6S3gs/+7u26esHu7zEXMBHK7l3fZWXy
         0U5mKXDZLuV8VwdfznrtSC0hacEIAoYSecCtF0YrWmoCkZW/KSssvjYKyTvd5R2Bue
         FKiJdLjjTOZLdT9CNEyN8isFncNnhxZhD8FjeYhsUru5xM/VirZlxd0n4iuSzx3JGQ
         pLhK5hcx9GrYw==
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
Subject: [PATCH 3/7] arm64: dts: uniphier: Remove unused num-viewport from pcie node
Date:   Thu, 30 Dec 2021 00:02:41 +0800
Message-Id: <20211229160245.1338-4-jszhang@kernel.org>
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
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 1 -
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 8f2c1c1e2c64..cc7a18591921 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -905,7 +905,6 @@ pcie: pcie@66000000 {
 			clocks = <&sys_clk 24>;
 			resets = <&sys_rst 24>;
 			num-lanes = <1>;
-			num-viewport = <1>;
 			bus-range = <0x0 0xff>;
 			device_type = "pci";
 			ranges =
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index be97da132258..7646d14d1fa9 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -802,7 +802,6 @@ pcie: pcie@66000000 {
 			clocks = <&sys_clk 24>;
 			resets = <&sys_rst 24>;
 			num-lanes = <1>;
-			num-viewport = <1>;
 			bus-range = <0x0 0xff>;
 			device_type = "pci";
 			ranges =
-- 
2.34.1

