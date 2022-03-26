Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C598F4E7FDB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiCZHxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiCZHw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:52:57 -0400
Received: from mx.msync.work (mx.msync.work [51.91.38.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E07154484;
        Sat, 26 Mar 2022 00:51:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AAA733E46;
        Sat, 26 Mar 2022 07:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1648281080; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=lMkPsT9wmYQRWVhCSgEyUxO6l9DD/Z5L18efF0PKVNA=;
        b=kpVE8K/GUTEr29vPglh/NXLZr1GTnRwE0ju4MrsUyJyWE2jDnjtYEm6O7UP3I7zVNzajby
        bd7oUCvhof40NcyGIbyH+f2U1d1xcOR3X6FOiuRQaHM7xjm+um6ffxnI5jmPJkLVi5mnGs
        Bf4YEDqO2TsmjpFD+a+stv8z1Us5RSag1vLuERF5CAyU+FS2nw4ybmNRBHqxM2BStTXbBK
        dduZhRQDd20Zb9Pc1gcFg5ZRzWjIx7KlZohzdI9txEFuTqJjsdUXtTgxx8kOxufbPbYkn5
        +pbN39yl4vRT3A80X8o5CPFpJ8G8u6b0pe+oMu+7nTTetTEtUavklIRwE8aErg==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] arm64: meson: dts: update serial alias in dts for JetHub D1
Date:   Sat, 26 Mar 2022 10:51:08 +0300
Message-Id: <20220326075110.1462301-3-adeep@lexina.in>
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

Change zigbee serial port alias to ttyAML2 for backward compatibility.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
index 52ebe371df26..66c1eeba8f48 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
@@ -18,7 +18,7 @@ / {
 	model = "JetHome JetHub J100";
 	aliases {
 		serial0 = &uart_AO;   /* Console */
-		serial1 = &uart_AO_B; /* External UART (Wireless Module) */
+		serial2 = &uart_AO_B; /* External UART (Wireless Module) */
 		ethernet0 = &ethmac;
 	};
 
-- 
2.30.2

