Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29C4E7FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiCZHxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiCZHw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:52:59 -0400
Received: from mx.msync.work (mx.msync.work [51.91.38.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B9E1546A3;
        Sat, 26 Mar 2022 00:51:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4D4B33E47;
        Sat, 26 Mar 2022 07:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1648281082; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=nuCjbgkU9FFpQwTWnRL3j5RAJbuDiSRCb5bADP8wamo=;
        b=Uyzw46ZaXuX2GlvUkyn5RWpWLU/TQ8AOYG5L3ufiVVi14LOIZwxQAwQLt+xVlZfL6XzBo0
        haRhz3LBv1Cbw5p3EI/6u1CQlu4eSMgAslOj8griWdCNGQCQYyS+/vItqwTelU3BOyoK9+
        WG+3mHDccZA2QV5WsvhCyd6b7zMbGcB4iN32KBZYfiwT1MgJSCMO2CgKRPSAWKVwsMNcra
        N3GHbllUqbE7bcHFx/26WvorwIWMLKvj+/p5N2mie1IIH8/ttO7O+1EelavxFb1QOhnSSB
        0rng3zxgojYJqDo4sCIzOV+oM29DZZnarzCpeMdj260Iu8pHmuTitFM2wJpK7g==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: meson: update WiFi SDIO in dts for JetHub D1
Date:   Sat, 26 Mar 2022 10:51:10 +0300
Message-Id: <20220326075110.1462301-5-adeep@lexina.in>
In-Reply-To: <20220326075110.1462301-1-adeep@lexina.in>
References: <20220326075110.1462301-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the dts to match board's reference design:
- update the maximum SDIO frequency to match 3.3v regulator (Wi-Fi SDIO module)

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
index e52abffdf8cf..9d6d6dcb562c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
@@ -257,8 +257,7 @@ &sd_emmc_b {
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	sd-uhs-sdr104;
-	max-frequency = <200000000>;
+	max-frequency = <50000000>;
 	non-removable;
 	disable-wp;
 
-- 
2.30.2

