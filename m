Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B83049E5A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242871AbiA0PRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:17:04 -0500
Received: from out29-99.mail.aliyun.com ([115.124.29.99]:36760 "EHLO
        out29-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242847AbiA0PRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:02 -0500
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6349558|-1;BR=01201311R141b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_system_inform|0.0327302-0.00826224-0.959008;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=icenowy@nucleisys.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Mj85OzO_1643296617;
Received: from ice-e5v2.lan(mailfrom:icenowy@nucleisys.com fp:SMTPD_---.Mj85OzO_1643296617)
          by smtp.aliyun-inc.com(33.45.46.134);
          Thu, 27 Jan 2022 23:16:58 +0800
From:   Icenowy Zheng <icenowy@nucleisys.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Icenowy Zheng <icenowy@nucleisys.com>
Subject: [PATCH 02/12] RISC-V: add Nuclei SoC Kconfig option
Date:   Thu, 27 Jan 2022 23:16:37 +0800
Message-Id: <20220127151647.2375449-3-icenowy@nucleisys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127151647.2375449-1-icenowy@nucleisys.com>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a CPU core vendor, Nuclei has some "DemoSoCs" that uses Nuclei CPU
cores and modified peripherals from Hummingbird E203.

Add a Kconfig option for this.

Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
---
 arch/riscv/Kconfig.socs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 6ec44a22278a..e4488ac8c72b 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -7,6 +7,12 @@ config SOC_MICROCHIP_POLARFIRE
 	help
 	  This enables support for Microchip PolarFire SoC platforms.
 
+config SOC_NUCLEI
+	bool "Nuclei SoCs"
+	select SIFIVE_PLIC
+	help
+	  This enables support for Nuclei SoC platform hardware.
+
 config SOC_SIFIVE
 	bool "SiFive SoCs"
 	select SERIAL_SIFIVE if TTY
-- 
2.30.2

