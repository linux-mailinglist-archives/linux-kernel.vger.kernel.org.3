Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB314C7777
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbiB1SV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbiB1SVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:21:11 -0500
X-Greylist: delayed 457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 09:58:24 PST
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB82220D3;
        Mon, 28 Feb 2022 09:58:24 -0800 (PST)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id EF130201F2;
        Mon, 28 Feb 2022 17:50:22 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id CCA29206D3;
        Mon, 28 Feb 2022 17:49:29 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id C304A3F201;
        Mon, 28 Feb 2022 17:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 2C94C2A6DF;
        Mon, 28 Feb 2022 17:48:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ajWsz5Lt1Fza; Mon, 28 Feb 2022 17:48:57 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Mon, 28 Feb 2022 17:48:57 +0000 (UTC)
Received: from edelgard.icenowy.info (unknown [59.41.161.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 209A5405A4;
        Mon, 28 Feb 2022 17:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1646070536; bh=EUzRPh29lTz0HC2sOaanLBcm5/67RZ1K8csq/rZ5tF0=;
        h=From:To:Cc:Subject:Date:From;
        b=lm4d08q9QW/jYV2uymu/ojKgPwtij1OU7udNcw7HWUfexmbojWX0184HRSkqwvtFc
         12PZmrrV3b++TueVDtpz+16uZ3fOUNbHdfueF1wIPUJmx1DDwUfcLCY9L+hsEyLglW
         niRTQDnKGS5mgt+J2woUn5mnCkMGwpYPU9yNl5Hw=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/2] riscv: dts: sifive: sort Unleashed DT nodes under /
Date:   Tue,  1 Mar 2022 01:48:36 +0800
Message-Id: <20220228174837.602758-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.30.2
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

The device tree nodes at root in HiFive Unleashed DT is currently not
sorted.

Sort them alphabetically.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../boot/dts/sifive/hifive-unleashed-a00.dts      | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index ced0d4e479385..44824d7e50ac7 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -20,9 +20,9 @@ cpus {
 		timebase-frequency = <RTCCLK_FREQ>;
 	};
 
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x2 0x00000000>;
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
 	};
 
 	hfclk: hfclk {
@@ -32,16 +32,17 @@ hfclk: hfclk {
 		clock-output-names = "hfclk";
 	};
 
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x2 0x00000000>;
+	};
+
 	rtcclk: rtcclk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <RTCCLK_FREQ>;
 		clock-output-names = "rtcclk";
 	};
-	gpio-restart {
-		compatible = "gpio-restart";
-		gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
-	};
 };
 
 &uart0 {
-- 
2.30.2

