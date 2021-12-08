Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C37746CEAB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbhLHILz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:11:55 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51214 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbhLHILy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:11:54 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B887k5j104900;
        Wed, 8 Dec 2021 02:07:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638950866;
        bh=K8qVcnbdAS7FrvSyvjos3JkzmSR0OREPlehmogBLeuI=;
        h=From:To:CC:Subject:Date;
        b=l2YUEE+6+mbJ4+2xsjvMvL9LB9wGJDjC8PNTLX+GMCcUzlOS7FKQjfTMZ/tIbA3v+
         99FKrw3k80e89P+HGqfXEoNWKr5yTqBxD4nQAO6j+2XXqfCm6pGFGXsqDEpWhGnqbo
         jvnw0F1r5wmFxDnmbFOTsNusURiF6PpPMa597zDc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B887j3j014431
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Dec 2021 02:07:46 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Dec 2021 02:07:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Dec 2021 02:07:45 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B887dU2067208;
        Wed, 8 Dec 2021 02:07:40 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Zenghui Yu <yuzenghui@huawei.com>, Nishanth Menon <nm@ti.com>,
        Saravana Kannan <saravanak@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: defconfig: Increase the maximum number of 8250/16550 serial ports
Date:   Wed, 8 Dec 2021 13:37:35 +0530
Message-ID: <20211208080737.10761-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some TI SoCs the number of UART instances used can be greater than 4.
For example in TI's J721S2 SoC, 11th instance of UART is used as console.
So, increase the maximum number of instances to 16.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0da6a944d5cd..adb9f1f0802d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -409,6 +409,8 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_BCM2835AUX=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_OMAP=y
+CONFIG_SERIAL_8250_NR_UARTS=16
+CONFIG_SERIAL_8250_RUNTIME_UARTS=16
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_8250_UNIPHIER=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
2.17.1

