Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4994FB025
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243927AbiDJUel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242214AbiDJUee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:34:34 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318BC36696;
        Sun, 10 Apr 2022 13:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649622725; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jXdnh4aUEPVVkA6EtiCcN6TSmImKgdp4fMgYb0Rv0FSjx5WTBIjPBcQ4RpG/yQi59H2et8GaGLCBLxn/D+tgbd6iP74HuWdPpO34v3jegKpI4TM3Z/Czv4/NpWaKeyxV+FAaCarXYnYB5J65Osii6CNG9iyWOvk1lVV8u6D4t4s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649622725; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=3Bdr3ICR42EV4+Gp0uVKnzUG3CsEtqwPWuz6oFmIFog=; 
        b=PoySZ3s3FSrXk1zJTDM7EAidnQXtnpk+XRSnLy8YLBm3DjLR3HBwbb9TeZFXV7XtqbRlEP6CmFr7OB5sp4A9XDNo2+vDBQ4QV865v59dTJv9yjLvbp4RQPBIz0kMtpqQ8KTUKZR47ZnRcZ5R0zW7R1HkaiwjuQUEmUW/xCeqbOg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649622725;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=3Bdr3ICR42EV4+Gp0uVKnzUG3CsEtqwPWuz6oFmIFog=;
        b=Q2FD6ild+jvJRxdxl6l7vDoExFiAXBM/GXvduyOuywZX1gC4oWtXnHqo5LX23rhC
        hMJD7Vq6k2DWUjzbkoVLymjV/nEv46PlKWBoOmcgdbPg8NzSSMHH0MNks27LlDw7d6c
        9Vhyjqw8zBDTeqHji+ViPCVB2yeEakx3U0TgJ2co=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649622724346210.97787152203682; Sun, 10 Apr 2022 13:32:04 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH 1/3] mips: dts: mt7621: add mdio label to mdio-bus
Date:   Sun, 10 Apr 2022 23:31:36 +0300
Message-Id: <20220410203138.22513-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mdio label to the mdio-bus node to easily refer to it.

Use the newly created label on the GB-PC2 devicetree.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../boot/dts/ralink/mt7621-gnubee-gb-pc2.dts   | 18 ++++++++----------
 arch/mips/boot/dts/ralink/mt7621.dtsi          |  2 +-
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
index a7fce8de6147..b427ae9e081f 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
@@ -93,17 +93,15 @@ gpio-pinmux {
 	};
 };
 
-&ethernet {
-	gmac1: mac@1 {
-		status = "okay";
-		phy-handle = <&ethphy7>;
-	};
+&gmac1 {
+	status = "okay";
+	phy-handle = <&ethphy7>;
+};
 
-	mdio-bus {
-		ethphy7: ethernet-phy@7 {
-			reg = <7>;
-			phy-mode = "rgmii-rxid";
-		};
+&mdio {
+	ethphy7: ethernet-phy@7 {
+		reg = <7>;
+		phy-mode = "rgmii-rxid";
 	};
 };
 
diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 3222684915ac..40d0f28446ca 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -342,7 +342,7 @@ gmac1: mac@1 {
 			phy-mode = "rgmii-rxid";
 		};
 
-		mdio-bus {
+		mdio: mdio-bus {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-- 
2.25.1

