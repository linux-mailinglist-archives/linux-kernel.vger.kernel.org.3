Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491A846E82C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbhLIMNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:13:31 -0500
Received: from mail.emtrion.de ([87.139.198.129]:27664 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229891AbhLIMNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:13:30 -0500
Received: from emtrion-yocto-comrzn1d.emtrion.local
 (2003:f9:5824:1:20c:29ff:fe08:43c4) by EMT-KA-S004.emtrion.local
 (2003:f9:5824:1:c59f:32f4:72e5:b9e1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 13:09:53 +0100
From:   <reinhold.mueller@emtrion.com>
To:     <robh+dt@kernel.org>
CC:     <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <inux-arm-kernel@lists.infradead.org>,
        <reinhold.mueller@emtrion.com>
Subject: [PATCH 1/2] dt-bindings: arm: Add emtrion hardware emCON-MX8M Mini
Date:   Thu, 9 Dec 2021 13:09:33 +0100
Message-ID: <20211209120934.4815-2-reinhold.mueller@emtrion.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211209120934.4815-1-reinhold.mueller@emtrion.com>
References: <20211209120934.4815-1-reinhold.mueller@emtrion.com>
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

This patch presents the yaml patch for the emtrion GmbH
emCON-MX8M Mini.

Signed-off-by: Reinhold Mueller <reinhold.mueller@emtrion.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0b595b26061f..e2c70c87baef 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -723,6 +723,7 @@ properties:
           - enum:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
               - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
+              - emtrion,emcon-mx8mm-avari # emCON-MX8MM SoM on Avari Base
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
               - gw,imx8mm-gw71xx-0x       # i.MX8MM Gateworks Development Kit
-- 
2.20.1

