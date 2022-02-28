Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9114C6DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiB1NUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiB1NUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:20:20 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74BA22B3E;
        Mon, 28 Feb 2022 05:19:41 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8CA7EDFE13;
        Mon, 28 Feb 2022 05:12:55 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XoIFEqnc3zYT; Mon, 28 Feb 2022 05:12:55 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, krzysztof.kozlowski@canonical.com,
        shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, kernel@puri.sm, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 5/5] arm64: dts: imx8mq-librem5-r4: add the correct panel
Date:   Mon, 28 Feb 2022 14:12:22 +0100
Message-Id: <20220228131222.917137-6-martin.kepplinger@puri.sm>
In-Reply-To: <20220228131222.917137-1-martin.kepplinger@puri.sm>
References: <20220228131222.917137-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Günther <agx@sigxcpu.org>

The r4 ("Evergreen") hardware revision of the Librem 5 phone includes a
slightly different panel than the revisions before it. Since its'
description is available, describe it properly for the board.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
index 30d65bef6939..1056b7981bdb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
@@ -18,6 +18,10 @@ &led_backlight {
 	led-max-microamp = <25000>;
 };
 
+&lcd_panel {
+	compatible = "ys,ys57pss36bh5gq";
+};
+
 &proximity {
 	proximity-near-level = <10>;
 };
-- 
2.30.2

