Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5EA529FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiEQKmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344458AbiEQKml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:42:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E48CE1D;
        Tue, 17 May 2022 03:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652784156; x=1684320156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WBs2eI6X8CZ5YiF7kldg80ncAuzPV9s8G23gHoKP1l0=;
  b=hIOQCk5sPE7Ox63waenkmLEssNJTware8Kg7pEcWXo23vDzFuVZnKT3m
   yCwh+YQ2DhpxfijttqdkO558+a2VhYBYtLMdfQdt59D446u/gzqazLc1/
   mC6IqipH15GvLCfk4viV6wp48EaUDhE+C8oPLRw+HUXlRQOE7XKcQHQGO
   /eh9Jc/LaATIEtXRPCPh/rTuZ2YCsZEYaNMpMGwdu/iyLgVEBzeKL1dcw
   QfKgYX2/JcQjbtEXlkKjU0EwvWFCssYR4Vwx/pNn/gCqMDy52h4QybP1P
   R8/dIRLuaftePiKIUst/9nadQG/J0SrEZTto4OFfPjKbLf10DOmSx6xhV
   w==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="156367300"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2022 03:42:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 17 May 2022 03:42:34 -0700
Received: from conor-HP-Z240-Tower-Workstation.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 17 May 2022 03:42:32 -0700
From:   Conor Paxton <conor.paxton@microchip.com>
To:     <conor.dooley@microchip.com>, Palmer Dabbelt <palmer@dabbelt.com>
CC:     Lewis Hanly <lewis.hanly@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Conor Paxton <conor.paxton@microchip.com>
Subject: [PATCH] riscv: dts: microchip: fix gpio1 reg property typo
Date:   Tue, 17 May 2022 11:40:58 +0100
Message-ID: <20220517104058.2004734-1-conor.paxton@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix reg address typo in the gpio1 stanza.

Signed-off-by: Conor Paxton <conor.paxton@microchip.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 746c4d4e7686..cf2f55e1dcb6 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -366,7 +366,7 @@ gpio0: gpio@20120000 {
 
 		gpio1: gpio@20121000 {
 			compatible = "microchip,mpfs-gpio";
-			reg = <000 0x20121000 0x0 0x1000>;
+			reg = <0x0 0x20121000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
-- 
2.25.1

