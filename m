Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D524788E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhLQKaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbhLQKaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:30:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2CDC061747;
        Fri, 17 Dec 2021 02:30:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D10B0620F8;
        Fri, 17 Dec 2021 10:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1615C36AE1;
        Fri, 17 Dec 2021 10:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639737005;
        bh=uf6JxDdnzyqJElQbsppbLQiVy+i5ap0eM73vSTE5d94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2m6fWD84gm/uWtxAAcW2R9O16n/+7XbldeZQqOoeKM8Sv99e+FwhvYigQkKj6KCI
         1JE7p2aDk1nKqGb3+IRTahvh7SDoIH7tvTBwjRPGEHP69MJ9YFnyn2Xp6dWNqbxvSd
         +YFG8GR3/Rs5BGR1Dy1GTqPAAnCTvTJCkhRz/WSukc8KYLTGIXaikIEywRoG6K8Bg5
         EYz20zdW2vgX0Euq4hFe81ewYnLKr/eZM8oAdpZeI99hnYfAKHBHLFw0ZbiZjy4dBl
         jNrX9BgEYweYB8aumuIGerkLuHphr4G9fId9zS4D+O5aPab7DEJeFxT1KEJiIkf5Oa
         N27AtkY13ckMQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzysztof.kozlowski@canonical.com, tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 4/4] arm64: arch_k3: Select GPMC device driver
Date:   Fri, 17 Dec 2021 12:29:45 +0200
Message-Id: <20211217102945.17432-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217102945.17432-1-rogerq@kernel.org>
References: <20211217102945.17432-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPMC controller is present on some K3 SoCs.
It provides access to NOR/NAND flashes and asynchronous
SRAM-like memories and ASICs.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 1aa8b7073218..f447b120f863 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -122,6 +122,7 @@ config ARCH_K3
 	select TI_SCI_INTR_IRQCHIP
 	select TI_SCI_INTA_IRQCHIP
 	select TI_K3_SOCINFO
+	select OMAP_GPMC
 	help
 	  This enables support for Texas Instruments' K3 multicore SoC
 	  architecture.
-- 
2.17.1

