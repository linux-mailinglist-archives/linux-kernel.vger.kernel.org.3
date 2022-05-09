Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19C651FFE5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbiEIOba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbiEIObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:31:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C111411C352;
        Mon,  9 May 2022 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652106437; x=1683642437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sE8P8jfstaqRSnBMIC2Y8y6T/ZDavu/2NYcDCqLH/cs=;
  b=xlrtpNxjVqCGIfRJ3b4jZHCBeMZbXVmn67IDmBexcy+vehjqAtkWyi+i
   D+tmlMrqfllaBCfLga5ZkKxuItFB7me3JyX6p0wyaGvL1SbubKvjPHpTg
   xJ2pMqgdKmsDzntlSJIOg2ossJBQ4K++Dgf0kJJXXLkZjlmPh56q/49nD
   wNu/BfrF3hsYJSlsW42OomwUdo0d9FWPDfM233mOH/d1nABUQ/nwq21kv
   dqfnhuKrhNxVSefnQ8jCZqlfXaXzE//+sqElxiGxhjBcDriIDDe1Du9bH
   Vp4eE2ktp9e25kz2kv/gu14/gNGQXCjkadSheSSbkeWShwq3/W3Xn7Kzt
   g==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="155299047"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 07:27:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 07:27:13 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 9 May 2022 07:27:10 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 09/10] riscv: microchip: icicle: readability fixes
Date:   Mon, 9 May 2022 15:26:10 +0100
Message-ID: <20220509142610.128590-10-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220509142610.128590-1-conor.dooley@microchip.com>
References: <20220509142610.128590-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the sort order of the status properties, remove some
extra whitespace in the mmc entry & add whitespace to the mac entry
containing the phys so that the dt is easier to read.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index 739dfa52bed1..9cd1a30edf2c 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -64,8 +64,6 @@ &mmuart4 {
 };
 
 &mmc {
-	status = "okay";
-
 	bus-width = <4>;
 	disable-wp;
 	cap-sd-highspeed;
@@ -77,6 +75,7 @@ &mmc {
 	sd-uhs-sdr25;
 	sd-uhs-sdr50;
 	sd-uhs-sdr104;
+	status = "okay";
 };
 
 &spi0 {
@@ -106,16 +105,19 @@ &i2c2 {
 &mac0 {
 	phy-mode = "sgmii";
 	phy-handle = <&phy0>;
+	status = "okay";
 };
 
 &mac1 {
-	status = "okay";
 	phy-mode = "sgmii";
 	phy-handle = <&phy1>;
+	status = "okay";
+
 	phy1: ethernet-phy@9 {
 		reg = <9>;
 		ti,fifo-depth = <0x1>;
 	};
+
 	phy0: ethernet-phy@8 {
 		reg = <8>;
 		ti,fifo-depth = <0x1>;
-- 
2.35.2

