Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1349E5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243265AbiA0PRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:17:41 -0500
Received: from out28-51.mail.aliyun.com ([115.124.28.51]:46312 "EHLO
        out28-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243011AbiA0PRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:20 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.6810555|0.5696508;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_regular_dialog|0.0726309-0.00131609-0.926053;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=icenowy@nucleisys.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Mj85P0-_1643296634;
Received: from ice-e5v2.lan(mailfrom:icenowy@nucleisys.com fp:SMTPD_---.Mj85P0-_1643296634)
          by smtp.aliyun-inc.com(33.45.46.134);
          Thu, 27 Jan 2022 23:17:15 +0800
From:   Icenowy Zheng <icenowy@nucleisys.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Icenowy Zheng <icenowy@nucleisys.com>
Subject: [PATCH 11/12] MAINTAINERS: add myself as Nuclei SoCs/CPUs supporter
Date:   Thu, 27 Jan 2022 23:16:46 +0800
Message-Id: <20220127151647.2375449-12-icenowy@nucleisys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127151647.2375449-1-icenowy@nucleisys.com>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently I am working on mainlining Nuclei SoCs/CPUs Linux support.

Add myself as a supporter of this.

Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..499450d14625 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13733,6 +13733,13 @@ F:	drivers/nubus/
 F:	include/linux/nubus.h
 F:	include/uapi/linux/nubus.h
 
+NUCLEI RISCV CORES AND SOCS
+M:	Icenowy Zheng <icenowy@nucleisys.com>
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+N:	nuclei
+K:	[^@]nuclei
+
 NVIDIA (rivafb and nvidiafb) FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
 L:	linux-fbdev@vger.kernel.org
-- 
2.30.2

