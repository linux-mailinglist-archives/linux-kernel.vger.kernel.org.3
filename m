Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D509346CD79
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 07:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbhLHGMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 01:12:46 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36934 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbhLHGMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 01:12:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B8691Dk074752;
        Wed, 8 Dec 2021 00:09:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638943741;
        bh=VgXgIvhEq1ibs/HgZEa1zCm/Da+XDn+E4jikIKI846o=;
        h=From:To:CC:Subject:Date;
        b=vxQXv7Qu21yAAudqvD8YGDYp+rbTKeZ3YedC3TKGoUO5cJUNKiyfkwlI26eCzg7tQ
         mP7Evwk18iQYTq54lxaQYka1Zpa3xHuSwcJsO0/Y0dXs4zwt0AuPQlOR8041goSTH9
         YWoP+pcH793YRDfSkNdfhbPjISx5LRSdyb3EgHjg=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B8691Us108026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Dec 2021 00:09:01 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Dec 2021 00:09:01 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Dec 2021 00:09:01 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B868wQU112199;
        Wed, 8 Dec 2021 00:08:58 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tom Rini <trini@konsulko.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] arm64: defconfig: Enable USB, PCIe and SERDES drivers for TI K3 SoC
Date:   Wed, 8 Dec 2021 11:38:56 +0530
Message-ID: <20211208060856.16106-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Cadence PCIe, Cadence USB, TI USB and PCIe wrappers and required
SERDES drivers to support USB and PCIe on TI K3 SoCs.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/configs/defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0da6a944d5cd..55bb1e0e222d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -236,6 +236,10 @@ CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_HISI_STB=y
 CONFIG_PCIE_TEGRA194_HOST=m
 CONFIG_PCIE_VISCONTI_HOST=y
+CONFIG_PCIE_CADENCE_PLAT_HOST=y
+CONFIG_PCIE_CADENCE_PLAT_EP=y
+CONFIG_PCI_J721E_HOST=y
+CONFIG_PCI_J721E_EP=y
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
@@ -823,6 +827,10 @@ CONFIG_USB_RENESAS_USBHS_HCD=m
 CONFIG_USB_RENESAS_USBHS=m
 CONFIG_USB_ACM=m
 CONFIG_USB_STORAGE=y
+CONFIG_USB_CDNS_SUPPORT=m
+CONFIG_USB_CDNS3=m
+CONFIG_USB_CDNS3_GADGET=y
+CONFIG_USB_CDNS3_HOST=y
 CONFIG_USB_MTU3=y
 CONFIG_USB_MUSB_HDRC=y
 CONFIG_USB_MUSB_SUNXI=y
@@ -1124,6 +1132,7 @@ CONFIG_RESET_RZG2L_USBPHY_CTRL=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_SUN4I_USB=y
+CONFIG_PHY_CADENCE_SIERRA=m
 CONFIG_PHY_MIXEL_MIPI_DPHY=m
 CONFIG_PHY_HI6220_USB=y
 CONFIG_PHY_HISTB_COMBPHY=y
@@ -1147,6 +1156,8 @@ CONFIG_PHY_SAMSUNG_UFS=y
 CONFIG_PHY_UNIPHIER_USB2=y
 CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_TEGRA_XUSB=y
+CONFIG_PHY_AM654_SERDES=m
+CONFIG_PHY_J721E_WIZ=m
 CONFIG_ARM_SMMU_V3_PMU=m
 CONFIG_FSL_IMX8_DDR_PMU=m
 CONFIG_HISI_PMU=y
-- 
2.34.1

