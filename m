Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229C951472A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357674AbiD2KpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357559AbiD2Koy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:44:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264876F9EA;
        Fri, 29 Apr 2022 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651228896; x=1682764896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aKR3tJNHcnSUKAVT7Q3BQcuQSowY0bVH8z3w3WzyYKU=;
  b=EAc05mOEb+F8GbKP9HAdheio/KqOSyhvps97bz3UVvDcEyOKzpp5WVJL
   PmBc18E5AJSGa+KP/JczxHLR9IoOAP6gSTn7KR6mvrdIrifwKg7R3Uk/2
   ze1JgoIwl2fHnUHFRgOFwA3HbwBkzKB39PpxrXjphARUyyIJCsu3nycpF
   XL2Ga6uNCkGOzzSmmSA7mXtxbKxedhbNuefmUGTYit4YXNqm3hqXQ9QDW
   xo65Yxxcz/2Ol0ALcigdbUhaMMT4YqzzCBvvjDh6gr7+B4TYT0iDeAykx
   0AK0+u1XNXcj6KXwBysm4ByqknDIKsRPXIxPiGXa8VQ1WvweCPldQp7w2
   g==;
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="154297285"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Apr 2022 03:41:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 29 Apr 2022 03:41:35 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 29 Apr 2022 03:41:32 -0700
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
        <linux-kernel@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>
Subject: [PATCH v1 3/8] riscv: dts: microchip: remove soc vendor from filenames
Date:   Fri, 29 Apr 2022 11:40:36 +0100
Message-ID: <20220429104040.197161-4-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220429104040.197161-1-conor.dooley@microchip.com>
References: <20220429104040.197161-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having the SoC vendor both as the directory and in the filename adds
little. Remove microchip from the filenames so that the files will
resemble the other directories in riscv (and arm64). The new names
follow a soc-board.dts & soc{,-fabric}.dtsi pattern.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile                          | 2 +-
 .../microchip/{microchip-mpfs-fabric.dtsi => mpfs-fabric.dtsi}  | 0
 .../{microchip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts}      | 2 +-
 .../riscv/boot/dts/microchip/{microchip-mpfs.dtsi => mpfs.dtsi} | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-fabric.dtsi => mpfs-fabric.dtsi} (100%)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts} (98%)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs.dtsi => mpfs.dtsi} (99%)

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index 855c1502d912..af3a5059b350 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-mpfs-icicle-kit.dtb
+dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
 obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi
similarity index 100%
rename from arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi
rename to arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
similarity index 98%
rename from arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
rename to arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index c71d6aa6137a..84b0015dfd47 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -3,7 +3,7 @@
 
 /dts-v1/;
 
-#include "microchip-mpfs.dtsi"
+#include "mpfs.dtsi"
 
 /* Clock frequency (in Hz) of the rtcclk */
 #define RTCCLK_FREQ		1000000
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
similarity index 99%
rename from arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
rename to arch/riscv/boot/dts/microchip/mpfs.dtsi
index bf21a2edd180..cc3386068c2d 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -3,7 +3,7 @@
 
 /dts-v1/;
 #include "dt-bindings/clock/microchip,mpfs-clock.h"
-#include "microchip-mpfs-fabric.dtsi"
+#include "mpfs-fabric.dtsi"
 
 / {
 	#address-cells = <2>;
-- 
2.35.2

