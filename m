Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EFA4814EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbhL2QK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:10:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57450 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbhL2QKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:10:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79A886151F;
        Wed, 29 Dec 2021 16:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F49C36AE7;
        Wed, 29 Dec 2021 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640794253;
        bh=UZhiJB9/G49I9AGaCL6l/479CzUET5sAUUx3UrhgHPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RSpby1M8C89DIpSDiqpd87X+AOY0f/T4nrLbJvd7Ca5rOhr1dZclCzPbtzqfzpoZQ
         SDN7BRyATq3Ozu7UaOmrJ3AmvIbFBtQ13BjlauQyL62q9nIaqHurJ+CIx9il1VtyKo
         0G1crojHu1IzOCIitR4GoLEvDsKQHWFWQ2u1NTIVip6lq4OexWBVRBulSQtMC25akX
         1wnshl5qoJK0CiI3IYwOf0eZ4qAWaBZ1yahTp1S8w+etLevkkYKsstFkW6qxODArm2
         8BsYyQXv4kOOj4tSk1nERR25R1j+pKnR23PeExXKtzaQFSvFXUBjEVd4u+enfm5rdH
         uJXmnp/egSRkw==
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
Subject: [PATCH 2/7] arm64: dts: visconti: Remove unused num-viewport from pcie node
Date:   Thu, 30 Dec 2021 00:02:40 +0800
Message-Id: <20211229160245.1338-3-jszhang@kernel.org>
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
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
index 01d7ee61ad25..7ecbfedc02b7 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
@@ -481,7 +481,6 @@ pcie: pcie@28400000 {
 			device_type = "pci";
 			bus-range = <0x00 0xff>;
 			num-lanes = <2>;
-			num-viewport = <8>;
 
 			#address-cells = <3>;
 			#size-cells = <2>;
-- 
2.34.1

