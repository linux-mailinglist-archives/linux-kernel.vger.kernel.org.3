Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3734847BF87
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbhLUMPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:15:53 -0500
Received: from inva021.nxp.com ([92.121.34.21]:51134 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhLUMPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:15:52 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 96A96201224;
        Tue, 21 Dec 2021 13:15:50 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 896F320121F;
        Tue, 21 Dec 2021 13:15:50 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7CF2C203C3;
        Tue, 21 Dec 2021 13:15:49 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 1/3] dt-bindings: fsl: scu: Add i.MX8QM rtc binding
Date:   Tue, 21 Dec 2021 14:15:46 +0200
Message-Id: <1640088948-3690-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640088948-3690-1-git-send-email-abel.vesa@nxp.com>
References: <1640088948-3690-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QM rtc compatible to the SCU bindings documentation.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index f1470d562156..4633be2182dd 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -134,7 +134,9 @@ RTC bindings based on SCU Message Protocol
 ------------------------------------------------------------
 
 Required properties:
-- compatible: should be "fsl,imx8qxp-sc-rtc";
+- compatible:		Should be one of:
+			"fsl,imx8qm-sc-rtc",
+			"fsl,imx8qxp-sc-rtc".
 
 OCOTP bindings based on SCU Message Protocol
 ------------------------------------------------------------
-- 
2.31.1

