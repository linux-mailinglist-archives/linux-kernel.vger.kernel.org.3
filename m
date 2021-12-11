Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69FA47174D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 00:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhLKXia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 18:38:30 -0500
Received: from ixit.cz ([94.230.151.217]:42234 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhLKXi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 18:38:29 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 7EBA124AF0;
        Sun, 12 Dec 2021 00:38:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639265907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xWjajEwtY2wkVt9fXD7egUyXtBkTDdRKLHGRSaEMSwQ=;
        b=HUkfzoIoi9pc7KYnLff/yfNWfsFO+daPCyEYcqyHW5BPhricY6fUdPC5u7mkVoYOhyaCcY
        5CAmphLik0onMuoIQzeRQjDtLeSwSjruKaAoHIES1ELhsuFYnb7Yw9DBKkIsVerTqgzUB/
        W9i4Jc0pa1+4u6rWidbrrd6RfJFzoP8=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: rockchip: Add missing secondary compatible for PX30 DSI
Date:   Sun, 12 Dec 2021 00:38:17 +0100
Message-Id: <20211211233818.88482-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add second DSI compatible to comply with DT schema validation
comming in the second patch.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 00f50b05d55a..f972704dfe7a 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1072,7 +1072,7 @@ vpu_mmu: iommu@ff442800 {
 	};
 
 	dsi: dsi@ff450000 {
-		compatible = "rockchip,px30-mipi-dsi";
+		compatible = "rockchip,px30-mipi-dsi", "snps,dw-mipi-dsi";
 		reg = <0x0 0xff450000 0x0 0x10000>;
 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru PCLK_MIPI_DSI>;
-- 
2.33.0

