Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7AC46E82A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhLIMNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:13:30 -0500
Received: from mail.emtrion.de ([87.139.198.129]:27664 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229850AbhLIMN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:13:27 -0500
Received: from emtrion-yocto-comrzn1d.emtrion.local
 (2003:f9:5824:1:20c:29ff:fe08:43c4) by EMT-KA-S004.emtrion.local
 (2003:f9:5824:1:c59f:32f4:72e5:b9e1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 13:09:52 +0100
From:   <reinhold.mueller@emtrion.com>
To:     <robh+dt@kernel.org>
CC:     <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <inux-arm-kernel@lists.infradead.org>,
        <reinhold.mueller@emtrion.com>
Subject: [PATCH 0/2] new emtrion hardware emCON-MX8M Mini
Date:   Thu, 9 Dec 2021 13:09:32 +0100
Message-ID: <20211209120934.4815-1-reinhold.mueller@emtrion.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [2003:f9:5824:1:20c:29ff:fe08:43c4]
X-ClientProxiedBy: EMT-KA-S004.emtrion.local
 (2003:f9:5824:1:c59f:32f4:72e5:b9e1) To EMT-KA-S004.emtrion.local
 (2003:f9:5824:1:c59f:32f4:72e5:b9e1)
X-C2ProcessedOrg: 5b249fcb-306f-4927-9982-5d11b1d300ce
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinhold Mueller <reinhold.mueller@emtrion.com>

This patch series splits the former patch
Re: [PATCH v2] arm64: dts: imx8mm: Add support for emtrion emCON-MX8M Mini
in dts patches and yaml patches.

Changes

[PATCH 0/2]
	- split former patch in dts -and yaml patches
[PATCH 1/2]
	- removing character '\t'
[PATCH 2/2]
	- correct entry compatible in spi-flash@0

Reinhold Mueller (2):
  dt-bindings: arm: Add emtrion hardware emCON-MX8M Mini
  arm64: dts: imx8mm: Add support for emtrion emCON-MX8M Mini

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   3 +-
 .../boot/dts/freescale/imx8mm-emcon-avari.dts |  23 +
 .../dts/freescale/imx8mm-emcon-avari.dtsi     | 141 ++++
 .../boot/dts/freescale/imx8mm-emcon.dtsi      | 645 ++++++++++++++++++
 5 files changed, 812 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi

-- 
2.20.1

