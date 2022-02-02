Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1604A6C34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiBBHRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:17:14 -0500
Received: from ptr.189.cn ([183.61.185.103]:11844 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233659AbiBBHRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:17:12 -0500
HMM_SOURCE_IP: 10.64.8.31:49686.384428371
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 92AFA100220;
        Wed,  2 Feb 2022 15:17:06 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id d9a2da96ae7042899cccab6844eda3da for dan.carpenter@oracle.com;
        Wed, 02 Feb 2022 15:17:07 CST
X-Transaction-ID: d9a2da96ae7042899cccab6844eda3da
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v5 2/3] dt-bindings: ls2k1000: add the display controller device node
Date:   Wed,  2 Feb 2022 15:16:57 +0800
Message-Id: <20220202071658.4769-3-15330273260@189.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220202071658.4769-1-15330273260@189.cn>
References: <20220202071658.4769-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: suijingfeng <suijingfeng@loongson.cn>

The display controller is a pci device, its vendor id is 0x0014
its device id is 0x7a06.

Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
index 8143a61111e3..6510b0e6928a 100644
--- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
@@ -198,6 +198,17 @@
 				interrupt-parent = <&liointc0>;
 			};
 
+			lsdc: dc@6,0 {
+				compatible = "pci0014,7a06.0",
+						   "pci0014,7a06",
+						   "pciclass030000",
+						   "pciclass0300";
+
+				reg = <0x3000 0x0 0x0 0x0 0x0>;
+				interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-parent = <&liointc0>;
+			};
+
 			pci_bridge@9,0 {
 				compatible = "pci0014,7a19.0",
 						   "pci0014,7a19",
-- 
2.20.1

