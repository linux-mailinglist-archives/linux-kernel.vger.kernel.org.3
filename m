Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E634E799D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376660AbiCYREs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCYREq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:04:46 -0400
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Mar 2022 10:03:07 PDT
Received: from mx.msync.work (mx.msync.work [IPv6:2001:41d0:d:357f:aaaa::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0773A6394;
        Fri, 25 Mar 2022 10:03:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5476331FD3;
        Fri, 25 Mar 2022 16:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1648227311; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=pLpMNG0SWs3st76DKfa6QZLTGIHjt4Fvns+4D2L2hMw=;
        b=r1ZBTNPeJLBy8SpxNSlEfzInb3Rjq3A9BQ9dT3qaId6QqvRhng9ZY5u2PC3Sj7DOukqopi
        uH6TELRf1gFq7s3TK8tsVIdyDoYT+Urfo7dslnVKkCKDYj+iPhMhG3b/iKOO5nTF9oDjQq
        VpshXKcwEH+ELdVZNE/kBrJkWQJ3iCnfuMvtRdTTJFv2LAnMH3PSp+zujEQmu1SsjFirQH
        QeQ/1B00oweIV7g+MQb8c18P3pmeSRBBhOF10aeKRZWxjhqEdxyVLCuLCX61rEBEAzN8bt
        fKBCPR47OewDAh+LRHQh/ZHkWgLpQcONnROyMAY0QxMDXNc3bpyirlAWONMCBw==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Vyacheslav Bocharov <devel@lexina.in>
Subject: [PATCH 1/3] arm64: meson: add dts bluetooth node for JetHub H1
Date:   Fri, 25 Mar 2022 19:54:59 +0300
Message-Id: <20220325165501.81551-2-adeep@lexina.in>
In-Reply-To: <20220325165501.81551-1-adeep@lexina.in>
References: <20220325165501.81551-1-adeep@lexina.in>
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

From: Vyacheslav Bocharov <devel@lexina.in>

Add bluetooth node for RTL8822CS uart to JetHub H1 dts file.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
index 6eafb908695f..a5ee7ed17efa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
@@ -213,6 +213,11 @@ &uart_A {
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
 	pinctrl-names = "default";
 	uart-has-rtscts;
+	bluetooth {
+		compatible = "realtek,rtl8822cs-bt";
+		enable-gpios  = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		host-wake-gpios = <&gpio GPIOX_18 GPIO_ACTIVE_HIGH>;
+       };
 };
 
 &uart_C {
-- 
2.30.2

