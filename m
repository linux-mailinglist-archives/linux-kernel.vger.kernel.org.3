Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED76E4C7778
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbiB1SVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbiB1SVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:21:12 -0500
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFED220D4;
        Mon, 28 Feb 2022 09:58:24 -0800 (PST)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 4A326201F1;
        Mon, 28 Feb 2022 17:50:06 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.156])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 5886F267CE;
        Mon, 28 Feb 2022 17:49:35 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id D602E2000E;
        Mon, 28 Feb 2022 17:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 3E3B62A378;
        Mon, 28 Feb 2022 17:49:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c7fNPPvqKdGq; Mon, 28 Feb 2022 17:49:03 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Mon, 28 Feb 2022 17:49:02 +0000 (UTC)
Received: from edelgard.icenowy.info (unknown [59.41.161.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 3A4FC405A4;
        Mon, 28 Feb 2022 17:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1646070542; bh=LULP0zQ1ZvfvYvSVqa6XKbmkljj5l8VtkKiZl1WBvIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5krynj2l3oFWH2XX0+o56R6rdO4tC9K6Fet3VAyOm/KrYj/an3u2NQphq0BQyAqg
         sJ+ACBugGcVBH/bRnFGq7uVbWOihxOty/50/A3U89qZSxYciouA2GhjTK6aT0tlhH4
         kPhxodzy3jG6Q1IVetSpFjZR+rGyfCMyH0iI2WgA=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/2] riscv: dts: sifive: add pwm leds for HiFive Unleashed
Date:   Tue,  1 Mar 2022 01:48:37 +0800
Message-Id: <20220228174837.602758-2-icenowy@aosc.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220228174837.602758-1-icenowy@aosc.io>
References: <20220228174837.602758-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_HTTP,
        RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM0 controller of HiFive Unleashed's FU540-C000 chip is connected
to 4 LEDs.

Add them to the device tree, with function and default trigger set from
the triggers used in old kernels done by SiFive.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../boot/dts/sifive/hifive-unleashed-a00.dts  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 44824d7e50ac7..2935719ca169e 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -3,6 +3,8 @@
 
 #include "fu540-c000.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pwm/pwm.h>
 
 /* Clock frequency (in Hz) of the PCB crystal for rtcclk */
 #define RTCCLK_FREQ		1000000
@@ -32,6 +34,46 @@ hfclk: hfclk {
 		clock-output-names = "hfclk";
 	};
 
+	led-controller {
+		compatible = "pwm-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			pwms = <&pwm0 0 10000000 PWM_POLARITY_INVERTED>;
+			active-low;
+			max-brightness = <255>;
+			function = LED_FUNCTION_HEARTBEAT;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			pwms = <&pwm0 1 10000000 PWM_POLARITY_INVERTED>;
+			active-low;
+			max-brightness = <255>;
+			function = LED_FUNCTION_MTD;
+			linux,default-trigger = "mtd";
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_GREEN>;
+			pwms = <&pwm0 2 10000000 PWM_POLARITY_INVERTED>;
+			active-low;
+			max-brightness = <255>;
+			function = LED_FUNCTION_LAN;
+			linux,default-trigger = "netdev";
+		};
+
+		led-3 {
+			color = <LED_COLOR_ID_GREEN>;
+			pwms = <&pwm0 3 10000000 PWM_POLARITY_INVERTED>;
+			active-low;
+			max-brightness = <255>;
+			function = LED_FUNCTION_PANIC;
+			linux,default-trigger = "panic";
+		};
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x2 0x00000000>;
-- 
2.30.2

