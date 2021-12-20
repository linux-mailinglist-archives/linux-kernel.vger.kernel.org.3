Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F6D47A55C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 08:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhLTHXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 02:23:51 -0500
Received: from mail.emtrion.de ([87.139.198.129]:49751 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234251AbhLTHXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 02:23:50 -0500
Received: from emtrion-yocto-comrzn1d.emtrion.local
 (2003:f9:5824:1:20c:29ff:fe08:43c4) by EMT-KA-S004.emtrion.local
 (2003:f9:5824:1:c59f:32f4:72e5:b9e1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 08:23:48 +0100
From:   <reinhold.mueller@emtrion.com>
To:     <festevam@gmail.com>
CC:     <robh+dt@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <shawnguo@kernel.org>,
        <linux-imx@nxp.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <reinhold.mueller@emtrion.com>
Subject: [PATCH v4 0/2] new emtrion hardware emCON-MX8M Mini
Date:   Mon, 20 Dec 2021 08:23:30 +0100
Message-ID: <20211220072332.81072-1-reinhold.mueller@emtrion.com>
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

This patchset adds support for the emtrion emCON-MX8M Mini

Changes

v4:
[PATCH 1/2]
	- no fixes, already Acked-by: Rob Herring <robh@kernel.org>
[PATCH 2/2]
	- removed reserved memory nodes
	- added a child node in fec for the phy reset gpios

v3:
[PATCH 1/2]
	- no fixes, Acked-by: Rob Herring <robh@kernel.org>
[PATCH 2/2]
	- inserted hyphen in some node names
	- spell out regulator in some regulator nodes
	- order of properties
	- sort label node alphabetically
	- inserting space before node name

v2:
[PATCH 1/2]
	- no fixes
[PATCH 2/2]
	- replaced GPIO_ACTIVE_LOW by IRQ_TYPE_LEVEL_LOW

v1:
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
 .../dts/freescale/imx8mm-emcon-avari.dtsi     | 139 ++++
 .../boot/dts/freescale/imx8mm-emcon.dtsi      | 626 ++++++++++++++++++
 5 files changed, 791 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi

-- 
2.20.1

