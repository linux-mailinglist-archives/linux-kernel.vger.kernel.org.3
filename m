Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5385B4FBAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345580AbiDKLXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243208AbiDKLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:23:43 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC1042A02;
        Mon, 11 Apr 2022 04:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649676061; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=KvjB4g1IY7b+mOzCYMJW/0qOEEaSLHuB8PIAAUq+B535WJjBOM4sOytUNsn29TxcSSRzuN7x66P1b0SOsP3J6zO8ExXJbsU0sj6GWZw4ZoQcfRGAJkiBV8MFNj5VRU+Y56ztdKHOjai6ZwkZRrkEVbUYkhbxj6gS42Yu/Lxx8Nw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649676061; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=l8Cw8EpJJ1aRQC34dDhV085dThpqu+42RlTKhEGAu3M=; 
        b=nZW1pgR/jcjvxgdSndzs/NZ0YSwAFaiEJ+yjr4QDjE56faYNEqZ83RGM884Lat+ATmDuodBemnoGLmXJM4BUnaqW7wEGdNiQTsLvJDZhffOYGyxwY+acdXV2m48hgzW59QwIIJNR7Z3yEuakrr/oJ7X60AgcQ/jrCS9TnLAfif8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649676061;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=l8Cw8EpJJ1aRQC34dDhV085dThpqu+42RlTKhEGAu3M=;
        b=JdK5Ifnqu04wR5Ou6N6ptEw0Ow4YTZqEucw9xrjLwe+WhAdgJH6BmTCTyJ6nPZ5T
        TEfnmgvcFc+U9crdLHxegC2BAMEcpYOulMd+cdhddfOJBNFOh74wYiMTNGN2oDBkOVl
        3Nfp/P5wdB8Va4q9dIu13xY1Mnu8lkyFnsOyNj6U=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649676058761238.78642786378032; Mon, 11 Apr 2022 04:20:58 -0700 (PDT)
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
Subject: [PATCH v2 1/3] mips: dts: ralink: mt7621: add mdio label to mdio-bus
Date:   Mon, 11 Apr 2022 14:20:47 +0300
Message-Id: <20220411112049.18001-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
v2: add "ralink:" to the commit summary

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

