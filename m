Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDA4501BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345585AbiDNT2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345477AbiDNT2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:28:22 -0400
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D1E33B5;
        Thu, 14 Apr 2022 12:25:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1325045|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0344537-0.000618227-0.964928;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.NQo2Nje_1649964351;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NQo2Nje_1649964351)
          by smtp.aliyun-inc.com(33.40.38.164);
          Fri, 15 Apr 2022 03:25:52 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        paul@crapouillou.net
Cc:     linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dragancecavac@yahoo.com, hns@goldelico.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v3 3/3] MIPS: Ingenic: Refresh USB nodes to match driver changes.
Date:   Fri, 15 Apr 2022 03:25:37 +0800
Message-Id: <1649964337-114337-4-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649964337-114337-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1649964337-114337-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refresh USB nodes in the jz4780.dtsi, x1000.dtsi, and x1830.dtsi files.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v3:
    New patch.

 arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
 arch/mips/boot/dts/ingenic/x1000.dtsi  | 2 +-
 arch/mips/boot/dts/ingenic/x1830.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index b998301..c182a65 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -577,7 +577,7 @@
 	};
 
 	otg: usb@13500000 {
-		compatible = "ingenic,jz4780-otg", "snps,dwc2";
+		compatible = "ingenic,jz4780-otg";
 		reg = <0x13500000 0x40000>;
 
 		interrupt-parent = <&intc>;
diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 8bd27ede..343818a2 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -366,7 +366,7 @@
 	};
 
 	otg: usb@13500000 {
-		compatible = "ingenic,x1000-otg", "snps,dwc2";
+		compatible = "ingenic,x1000-otg";
 		reg = <0x13500000 0x40000>;
 
 		interrupt-parent = <&intc>;
diff --git a/arch/mips/boot/dts/ingenic/x1830.dtsi b/arch/mips/boot/dts/ingenic/x1830.dtsi
index 2595df8..6aff19f 100644
--- a/arch/mips/boot/dts/ingenic/x1830.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1830.dtsi
@@ -355,7 +355,7 @@
 	};
 
 	otg: usb@13500000 {
-		compatible = "ingenic,x1830-otg", "snps,dwc2";
+		compatible = "ingenic,x1830-otg";
 		reg = <0x13500000 0x40000>;
 
 		interrupt-parent = <&intc>;
-- 
2.7.4

