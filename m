Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432814FAD18
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 11:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbiDJJtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 05:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbiDJJs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 05:48:57 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0902AE34;
        Sun, 10 Apr 2022 02:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649583974; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IVcX0fVbhg5OMdbn7yaaahvzH6Jk2UFXb6S57wQE6mF64PN465M9ikQr9DQOJX4N9SUNymMsaAmH02J1bKWBcOgOaffuK8jJwtakMfILGMoSSQ3wDk2XQ24OtIA7B64sISbYhtDNziyJWdbduZiQCOHwtWurbwgbxn5DsNjY0TU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649583974; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=7poOT/rw9kdWGl9YXFYkvmc3/pYXbV5NbQ/hwxad42M=; 
        b=KlPTgF95iaPYLBCkM8ali76274TsIaK2wS0PTd2d8gK+LRaZ89eRkKGr8rWdxl3dYJlT+Hu/pF4ZeuFJtDDXubg1+4U+iMBb5rI8okd3pLQy6meSgYSnG5WZqWu3mIHHDwWbtRQZkuDiYcwR3579wO+EH7WxiHVkSZojF3eXPAg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649583974;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=7poOT/rw9kdWGl9YXFYkvmc3/pYXbV5NbQ/hwxad42M=;
        b=N9gfTA2+3liFeCJtn3lIw243pbKnDgkmCdHkETOQoZmaJ1DM1QsnQI+EBblwQ/Zn
        8xCojxGwoSFXwsHMC0kVtPMrwcUcktXLA/cmqYXf5ZEr/plM6dPTT7DJA1w4X9s5svq
        AA9Ydhhpm9wqljShTE5pMbV+5y+UAA4cqgBZ/Y/g=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649583972146345.7919696113951; Sun, 10 Apr 2022 02:46:12 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH] ARM: dts: BCM5301X: Disable gmac0 and enable port@8 on Asus RT-AC88U
Date:   Sun, 10 Apr 2022 12:44:55 +0300
Message-Id: <20220410094454.2788-1-arinc.unal@arinc9.com>
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

Disable gmac0 which is not connected to any switch MAC. Enable port@8 of
the Broadcom switch which is connected to gmac2.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts b/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts
index 2f944d1c0330..d8503758342b 100644
--- a/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts
+++ b/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts
@@ -232,7 +232,6 @@ port@8 {
 			reg = <8>;
 			ethernet = <&gmac2>;
 			label = "cpu";
-			status = "disabled";
 
 			fixed-link {
 				speed = <1000>;
@@ -242,6 +241,10 @@ fixed-link {
 	};
 };
 
+&gmac0 {
+	status = "disabled";
+};
+
 &gmac1 {
 	nvmem-cells = <&et1macaddr>;
 	nvmem-cell-names = "mac-address";
-- 
2.25.1

