Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91FB49B367
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389665AbiAYL5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382664AbiAYLu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:50:29 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A39C061747;
        Tue, 25 Jan 2022 03:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=hkUccVp4P9p6ugtrSZv9QxAGFoIyyakvdi4VBQAA7go=; b=XW
        2qRRssGvSjIxDFxgFjrcKHua7lf5liOR/8IXw7ygQdDr7QPGh8L7JlbxVpApHnGzXGL+W2ww25zQu
        EOG6YVogM/72dPjlrqWl2GkpymVLsPYDo3Nk4Xg0vlSZ1bPw+4Z5eEqvOz6siigB2RROPOcZdwcmN
        JosSAevZgTe9JGFpLG2JB8ZRNSN/Xbpa4jZgTIEZWY9r5RnnrDb+HpBl8gRf6TvHhAO2hq0Kox9qE
        f96wh7gAQrAQ0P87jwSJEOWVzmhDT1Qtp8FwTgzfhE3Mg39jeUinwSze4cZaq7CUTHJBn3J8OR+o2
        87sxWRt6iFYb3iau+wmYrWmbyfJjM7Dw==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nCKL5-0002Dr-3Y; Tue, 25 Jan 2022 11:50:19 +0000
From:   John Keeping <john@metanate.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     John Keeping <john@metanate.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: fix MMC compatibles for rk3288
Date:   Tue, 25 Jan 2022 11:50:07 +0000
Message-Id: <20220125115007.3138311-1-john@metanate.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit 4bac670aa5cb ("mmc: dw_mmc: rockchip: use common_caps")
the mshcN aliases were used in an unusual way by the dw_mmc driver and
affected behaviour.  Now that this has been fixed, rename the mmc
aliases to use the standard form.

Signed-off-by: John Keeping <john@metanate.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index aaaa61875701..50fa0a4652b5 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -25,10 +25,10 @@ aliases {
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
-		mshc0 = &emmc;
-		mshc1 = &sdmmc;
-		mshc2 = &sdio0;
-		mshc3 = &sdio1;
+		mmc0 = &emmc;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio0;
+		mmc3 = &sdio1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.35.0

