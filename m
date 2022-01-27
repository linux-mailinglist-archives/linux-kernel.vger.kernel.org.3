Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEB049E6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbiA0Pu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:50:28 -0500
Received: from mail.emtrion.de ([87.139.198.129]:55005 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243190AbiA0Pu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:50:26 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2022 10:50:24 EST
Received: from emtrion-yocto-comrzn1d.emtrion.local
 (2003:f9:5824:1:20c:29ff:fe08:43c4) by EMT-KA-S004.emtrion.local
 (2003:f9:5824:1:c59f:32f4:72e5:b9e1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.20; Thu, 27 Jan 2022 16:35:19 +0100
From:   <reinhold.mueller@emtrion.com>
To:     <festevam@gmail.com>
CC:     <robh+dt@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <shawnguo@kernel.org>,
        <linux-imx@nxp.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <reinhold.mueller@emtrion.com>
Subject: [RESEND PATCH v5 1/2] dt-bindings: arm: Add emtrion hardware emCON-MX8M Mini
Date:   Thu, 27 Jan 2022 16:34:59 +0100
Message-ID: <20220127153500.9236-2-reinhold.mueller@emtrion.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220127153500.9236-1-reinhold.mueller@emtrion.com>
References: <20220127153500.9236-1-reinhold.mueller@emtrion.com>
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
Acked-by: Rob Herring <robh+dt@kernel.org>
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

