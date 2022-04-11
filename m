Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B064FBAC5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbiDKLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiDKLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:23:43 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD6642A06;
        Mon, 11 Apr 2022 04:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649676065; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=CNOTXYv8Sx8j1g4oPY7guZ7x8Y+9W4nAWbaAtTVJaGAEjnPEbPURRROrxlPeiVlexU6os8+D6poyT2IuNj2J3ppdiMFrLipTTRI+g4xaKxkfras9goVVn4eCqKi38bpQXE4TWQT+f3qfvaVRnMivOWrnPw3BD4dmpR4c6ssNcGY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649676065; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=5/jbDAF5X5kezjSRAK51Yoit+uFd9VQLdmTmKwAwHMY=; 
        b=dseB4UyKiR9WxMIcSnQZDK6jMcO05AtaGhRY3jPfFS0Sx/OyeGOIJIL4tzjRqdsbZbrl78erto5C6VVuxy6xe0izsgYnKSoAXnwopNMFrERtKAOG1tXJ5cFzWPE8PYJ7gXIm81ImfN/alB6R6WWX6c2UeGWybjlwlqwzlOMIz2k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649676065;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=5/jbDAF5X5kezjSRAK51Yoit+uFd9VQLdmTmKwAwHMY=;
        b=I8/9xBIsYdFV55onKD8dTdAAGKHxevBRAhV0IDExLNV+mCSXvemhUwqNJ3ODxduz
        sT78ypYJCINSDizM9Sd6RSB8pUcgbHTsuwmkN2QxsxRuUgusBcvkMIvV09qKSx+TrNz
        dr2ZBB5PcMAdPYxEt8YlxzAt7Kib3DozynGuReBg=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649676064932643.1336824950525; Mon, 11 Apr 2022 04:21:04 -0700 (PDT)
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
Subject: [PATCH v2 3/3] mips: dts: ralink: mt7621: remove defining gpio function for pin groups
Date:   Mon, 11 Apr 2022 14:20:49 +0300
Message-Id: <20220411112049.18001-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411112049.18001-1-arinc.unal@arinc9.com>
References: <20220411112049.18001-1-arinc.unal@arinc9.com>
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

All pin groups function as gpio unless set otherwise. Therefore, remove
this unnecessary binding.

Tested on UniElec U7621-06-16M on OpenWrt.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
v2: add "ralink:" to the commit summary

---
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts | 12 ------------
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts | 12 ------------
 2 files changed, 24 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
index 75f3b0425487..c307a0edb91f 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
@@ -97,18 +97,6 @@ &pcie {
 	status = "okay";
 };
 
-&pinctrl {
-	pinctrl-names = "default";
-	pinctrl-0 = <&state_default>;
-
-	state_default: state-default {
-		gpio-pinmux {
-			groups = "uart3", "wdt";
-			function = "gpio";
-		};
-	};
-};
-
 &gmac1 {
 	status = "okay";
 	phy-handle = <&ethphy4>;
diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
index b427ae9e081f..8268d738e74f 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
@@ -81,18 +81,6 @@ &pcie {
 	status = "okay";
 };
 
-&pinctrl {
-	pinctrl-names = "default";
-	pinctrl-0 = <&state_default>;
-
-	state_default: state-default {
-		gpio-pinmux {
-			groups = "wdt";
-			function = "gpio";
-		};
-	};
-};
-
 &gmac1 {
 	status = "okay";
 	phy-handle = <&ethphy7>;
-- 
2.25.1

