Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EAE4F064A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353160AbiDBUtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354565AbiDBUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:49:28 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490DC8F983;
        Sat,  2 Apr 2022 13:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1648932429; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=UQautQa6oGBP6OSsDtJc5nDEQ4o9YR4lVDA3jnSfOfQwJIyGPasR0AzibS4OnwZzX0y2LeJueXws1sTXAIUAG+FANqoGIAtJ5UHTNSFF2JLt4gmmINGhOvr12kqWArPUtjNRDsA7ER51bq//OW/sdKy+ynadasRmIRhTVVzlJzo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1648932429; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=jxKdYoJjmi1tmdXcjDwSIdRNmtEpRM2sygXNAEsxYdc=; 
        b=aYpal4+X+qH0ZTx5oZH7Ba8O5Q5vaQeMU9hS/011CQRslsX/a7AN4H7xMv0T/rxuH4cLcpnP9G2fJXDFS7O5JN51Q9pUS0pMuEJhnb11bCLaA+1g2ump+K0+Q8sWRYAHd9vlI6mrcoXaGPO9j5aOS1Rx8X1wL/jextdC7v7gHOM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1648932429;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=jxKdYoJjmi1tmdXcjDwSIdRNmtEpRM2sygXNAEsxYdc=;
        b=CjhuDRP9NMgHR+0+b7SxRdW2izCnkIjVfcanrEO7oWaDp/9sRX95QLVwYPijnFAH
        7tUWWy5FwjHk+H2KbMLMkOVR/EvF2igJK1mOxIZJrAevWTth7ba+iepm9DBwLu+jBoI
        I5V0LO9naiTiYAlW8qUKCXb8LZE1D1PzdHeikqtU=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1648932426117981.5903705693622; Sat, 2 Apr 2022 13:47:06 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH v2 3/4] ARM: dts: BCM5301X: Fix compatible strings for BCM53012 and BCM53016 SoC
Date:   Sat,  2 Apr 2022 23:46:21 +0300
Message-Id: <20220402204622.3360-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402204622.3360-1-arinc.unal@arinc9.com>
References: <20220402204622.3360-1-arinc.unal@arinc9.com>
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

Fix compatible strings for devicetrees using the BCM53012 and BCM53016 SoC.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/bcm53016-meraki-mr32.dts | 2 +-
 arch/arm/boot/dts/bcm953012er.dts          | 2 +-
 arch/arm/boot/dts/bcm953012hr.dts          | 2 +-
 arch/arm/boot/dts/bcm953012k.dts           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
index 66c64a6ec414..daca63f25134 100644
--- a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
+++ b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
@@ -13,7 +13,7 @@
 #include <dt-bindings/leds/common.h>
 
 / {
-	compatible = "meraki,mr32", "brcm,brcm53016", "brcm,bcm4708";
+	compatible = "meraki,mr32", "brcm,bcm53016", "brcm,bcm4708";
 	model = "Meraki MR32";
 
 	chosen {
diff --git a/arch/arm/boot/dts/bcm953012er.dts b/arch/arm/boot/dts/bcm953012er.dts
index 52feca0fb906..dd63a148a16b 100644
--- a/arch/arm/boot/dts/bcm953012er.dts
+++ b/arch/arm/boot/dts/bcm953012er.dts
@@ -37,7 +37,7 @@
 
 / {
 	model = "NorthStar Enterprise Router (BCM953012ER)";
-	compatible = "brcm,bcm953012er", "brcm,brcm53012", "brcm,bcm4708";
+	compatible = "brcm,bcm953012er", "brcm,bcm53012", "brcm,bcm4708";
 
 	memory@0 {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/bcm953012hr.dts b/arch/arm/boot/dts/bcm953012hr.dts
index 9140be7ec053..b070b69466bd 100644
--- a/arch/arm/boot/dts/bcm953012hr.dts
+++ b/arch/arm/boot/dts/bcm953012hr.dts
@@ -37,7 +37,7 @@
 
 / {
 	model = "NorthStar HR (BCM953012HR)";
-	compatible = "brcm,bcm953012hr", "brcm,brcm53012", "brcm,bcm4708";
+	compatible = "brcm,bcm953012hr", "brcm,bcm53012", "brcm,bcm4708";
 
 	aliases {
 		ethernet0 = &gmac0;
diff --git a/arch/arm/boot/dts/bcm953012k.dts b/arch/arm/boot/dts/bcm953012k.dts
index de40bd59a5fa..f1e6bcaa1edd 100644
--- a/arch/arm/boot/dts/bcm953012k.dts
+++ b/arch/arm/boot/dts/bcm953012k.dts
@@ -36,7 +36,7 @@
 
 / {
 	model = "NorthStar SVK (BCM953012K)";
-	compatible = "brcm,bcm953012k", "brcm,brcm53012", "brcm,bcm4708";
+	compatible = "brcm,bcm953012k", "brcm,bcm53012", "brcm,bcm4708";
 
 	aliases {
 		serial0 = &uart0;
-- 
2.25.1

