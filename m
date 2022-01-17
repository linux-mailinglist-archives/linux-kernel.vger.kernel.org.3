Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655A7491033
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242461AbiAQSVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:21:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33258 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241497AbiAQSVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:21:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DF48B8119C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 18:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8A7C36AE7;
        Mon, 17 Jan 2022 18:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642443673;
        bh=IiCVC4IjVBf3gaQdviLmNebLZkCDbYU5ERtTBZp2FAg=;
        h=From:To:Cc:Subject:Date:From;
        b=UzrKVcTvIZFRBJOoKQvciEjn+cpe4lel9RSvxsBMLtQgt7wZ7CWjmqPCtvWdhv5T/
         m3Uy7id9pNdUYJle5N8tOeiIOlHoLXV8I3NbfBsOo07VmBsJNYTOppmTb2bYmd5TOa
         zb+hxnBA7mgaoQgBu8B1C1W2MdfD6eDNyvneo12g60FdtAdEr8VLEfhB1UIAC5VFJL
         kkBCY48U0Bu/RvHowZpLWL/OBXW1IZkfgDeY3FJOOD4l0wf7RAIEnSh+rTSBup7hsc
         8ZbxvH4jkjXV1wNufDxxdXIOon5+6IvP1fyxVUhSDXpdslD2LRIrSjck3sH07wDOcs
         Pzb4uKPxFip+A==
Received: by pali.im (Postfix)
        id 6EF13871; Mon, 17 Jan 2022 19:21:10 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: armada-3720-turris-mox: Add missing ethernet0 alias
Date:   Mon, 17 Jan 2022 19:20:06 +0100
Message-Id: <20220117182006.31412-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U-Boot uses ethernet* aliases for setting MAC addresses. Therefore define
also alias for ethernet0.

Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 23e1b07c060a..6581092c2c90 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -18,6 +18,7 @@
 
 	aliases {
 		spi0 = &spi0;
+		ethernet0 = &eth0;
 		ethernet1 = &eth1;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
-- 
2.20.1

