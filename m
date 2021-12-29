Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2C14814F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbhL2QLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbhL2QLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:11:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA9BC06173E;
        Wed, 29 Dec 2021 08:11:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C77236152F;
        Wed, 29 Dec 2021 16:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D856CC36AE9;
        Wed, 29 Dec 2021 16:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640794278;
        bh=S0LERJwyzEMFDpJ3sNkuJ61BavzIBBGkD+j0SrotwVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFB8v42obF7l8nh+zXxUc+I/Umk0E1v0oHceiGi4OXini+LZiNqBvuHwzVRRt1z04
         ZJKCVF2mPLVXyp4EldnzaO0O17nilRbFi/sZ33Dvnvm5p7Q2JaQTNJZDOzQxV6H6iE
         NpRvHQZBxzKBCMuSKr+yx2XVtt5ADqCSKgCr3lVmCjuFmFRl1XNbQf5QViuxjMPcN4
         NUG3nNQMuBHiw5xqS+EM/grPdV6RMGg09KFdrK5uGv5W7Hv6Pu0ZAqOEgi6kAQlwL6
         zsBuN7qZJ0hmxXb5J1f8lzPg7rEO5027UUyN0pF5MDgLn2cg7Yegx+S+3cYHbwLn2G
         QEw3FCgM17Adg==
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
Subject: [PATCH 4/7] arm64: tegra: Remove unused num-viewport from pcie node
Date:   Thu, 30 Dec 2021 00:02:42 +0800
Message-Id: <20211229160245.1338-5-jszhang@kernel.org>
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
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 851e049b3519..e5c7c22b1c05 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -2007,7 +2007,6 @@ pcie@14100000 {
 		#size-cells = <2>;
 		device_type = "pci";
 		num-lanes = <1>;
-		num-viewport = <8>;
 		linux,pci-domain = <1>;
 
 		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_1>;
@@ -2061,7 +2060,6 @@ pcie@14120000 {
 		#size-cells = <2>;
 		device_type = "pci";
 		num-lanes = <1>;
-		num-viewport = <8>;
 		linux,pci-domain = <2>;
 
 		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_2>;
@@ -2115,7 +2113,6 @@ pcie@14140000 {
 		#size-cells = <2>;
 		device_type = "pci";
 		num-lanes = <1>;
-		num-viewport = <8>;
 		linux,pci-domain = <3>;
 
 		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_3>;
@@ -2169,7 +2166,6 @@ pcie@14160000 {
 		#size-cells = <2>;
 		device_type = "pci";
 		num-lanes = <4>;
-		num-viewport = <8>;
 		linux,pci-domain = <4>;
 
 		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_4>;
@@ -2223,7 +2219,6 @@ pcie@14180000 {
 		#size-cells = <2>;
 		device_type = "pci";
 		num-lanes = <8>;
-		num-viewport = <8>;
 		linux,pci-domain = <0>;
 
 		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
@@ -2277,7 +2272,6 @@ pcie@141a0000 {
 		#size-cells = <2>;
 		device_type = "pci";
 		num-lanes = <8>;
-		num-viewport = <8>;
 		linux,pci-domain = <5>;
 
 		pinctrl-names = "default";
-- 
2.34.1

