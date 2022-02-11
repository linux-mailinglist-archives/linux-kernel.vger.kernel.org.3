Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1231A4B1A71
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346371AbiBKAdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:33:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346363AbiBKAdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:33:08 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE3D5F64
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:33:07 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5FD042C05DB;
        Fri, 11 Feb 2022 00:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1644539583;
        bh=5d4aGdtzzJ4A4TyeCtQK+SET2xSB90uuC2RRaOEyQt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RH389wkBdkpSyWrIjzryc+KM9SHlXGakVdFyCSlCXBc6Fz3pl0lVa7ZK5TZogAUge
         wasWUuu2FobTFhDpGivi7cHIk+ZXmVz9NbBmo8nUgc96KOE0axptAuFkaTfKnK1ojr
         f8ZPMLqeHQNf4unsOWA9boYQeydnxIfxcW2XzvQ8EY6ObouMuvWA3olSvQUbjwkbPm
         vfiH4Wy+A9HvKOy+UIfafb2RxvvhKEr4BHla81n4OGT97bRmvfDkkcPJvIyJimu6wd
         Ab98EEnNW/g5QiN+ZUPkv+swHF+fJjcV5+pZGeTnKyGDeEH/vNGsnoJHNuFWJeDrfr
         FGmEe//CD+7qw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6205aec00001>; Fri, 11 Feb 2022 13:33:04 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 3927013ECE9;
        Fri, 11 Feb 2022 13:33:03 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 1FC2A2A00D0; Fri, 11 Feb 2022 13:32:59 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com, robh+dt@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 1/2] ARM: dts: armada-xp: add interrupts for watchdog
Date:   Fri, 11 Feb 2022 13:32:56 +1300
Message-Id: <20220211003257.2037332-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211003257.2037332-1-chris.packham@alliedtelesis.co.nz>
References: <20220211003257.2037332-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=c43Vvi1l c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oGFeUVbbRNcA:10 a=pDUyuL2EwPZigLCUKl4A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first interrupt is for the regular watchdog timeout. Normally the
RSTOUT line will trigger a reset before this interrupt fires but on
systems with a non-standard reset it may still trigger.

The second interrupt is for a timer1 which is used as a pre-timeout for
the watchdog.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 1 +
 arch/arm/boot/dts/armada-xp.dtsi          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dt=
s/armada-xp-98dx3236.dtsi
index 38a052a0312d..0e561dfc0ca9 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -286,6 +286,7 @@ &watchdog {
 	compatible =3D "marvell,armada-xp-wdt";
 	clocks =3D <&coreclk 2>, <&refclk>;
 	clock-names =3D "nbclk", "fixed";
+	interrupts =3D <93>, <38>;
 };
=20
 &cpurst {
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-=
xp.dtsi
index 6c19984d668e..4297482da62f 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -260,6 +260,7 @@ &watchdog {
 	compatible =3D "marvell,armada-xp-wdt";
 	clocks =3D <&coreclk 2>, <&refclk>;
 	clock-names =3D "nbclk", "fixed";
+	interrupts =3D <93>, <38>;
 };
=20
 &cpurst {
--=20
2.35.1

