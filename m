Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49F546D396
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhLHMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbhLHMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:50:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21800C061746;
        Wed,  8 Dec 2021 04:46:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFB3CB81F79;
        Wed,  8 Dec 2021 12:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E570C341C3;
        Wed,  8 Dec 2021 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638967587;
        bh=uf6JxDdnzyqJElQbsppbLQiVy+i5ap0eM73vSTE5d94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9jQomTAPi9TsgGgqYNNVfKKHiDmpjZM9GJCQDnLj9BAopHck6E6GsczJ7gN+IIiz
         /hPbWVQ+GHSe5kAkDsVKhOU31SNC+TVekRnBhnj73bYTSGFDkQrxSo3a7hnNByRDim
         ATKylPzARZ8Nm5oKnTmthQfsheC5me91tVMUFRRPNqdlkV0kU88cw6NDIhx3CqxZaS
         naM7MJ60xGJVDPow/6Cza8D/tOwrsLAKx9LTZcK/I/wQGd1FbSY/7s4l4U5d4laNS/
         1LSags3INEDIsc7paGenzcWjnEDtSSdo0DSB/0/XGbF+773BbPgy12UqLcSoLbFcuG
         rDu9jwi6nY5uw==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzysztof.kozlowski@canonical.com, tony@atomide.com
Cc:     kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 4/4] arm64: arch_k3: Select GPMC device driver
Date:   Wed,  8 Dec 2021 14:46:11 +0200
Message-Id: <20211208124611.16843-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208124611.16843-1-rogerq@kernel.org>
References: <20211208124611.16843-1-rogerq@kernel.org>
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

