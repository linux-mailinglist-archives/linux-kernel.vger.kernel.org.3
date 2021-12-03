Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E50466E9D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377872AbhLCAoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:17 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:34764 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377799AbhLCAoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:07 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswd0mQfU3; Fri, 03 Dec 2021 01:40:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492043; bh=YMmE0efrVaqG5tbeOzVTHIlQICKF+z3/1H4UWz20OJA=;
        h=From:To:Subject:Date:MIME-Version;
        b=DBNxZcO6ljJlLyTB1aeY3T8PkN4UL8FDnbFWE7Hbw+FEqnvp/Fu6+21rBdg7wtZT9
         yPVcw2u0I7BHchQab7KWaMD78AN0XYHZ53TGQ10dEtSiqWfwb+eaAktTtdbsRSwbbG
         HpK+/mHXcLvFX+si4BO1lLoPmeXFJ2YUlxxXx7Na5ZkSzKqmPoWKsQS/q7y/7WMco+
         zbI9RBY3Na7d9762CKnmQ6tZitQlseBDeRbRuTZxGvoU1rySFLnd7v1Xil4CIHOVtY
         GAwzgK86LS35KxAy4VGKg/JRmI11WuXzCK5tUyoe9Qg4GtrbyvRRAtdCAvvGJCylFQ
         kAVT28qU7/ErQ==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 05/17] ARM: dts: imx50: drop "fsl,imx-ckih1"
Date:   Fri,  3 Dec 2021 01:40:27 +0100
Message-Id: <20211203004039.48752-6-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
References: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCQu/wbeRkH6vFIdY0qfjeLF43GM4JchwuFShAk9dNtnb4HmfhJAc5AkwzIvZ0rS9u85B7uEZIZNpBtLusYgTZUC5k4l/b3mzPZGMC9zjHrQ43h53G3X
 vupaZqTJGKBouEB/Oq2C4ZYxxZ7Vhnd/3iFgEA3VZFX4RufZglNqiHxk1yb3t3iVvidRStfMNIFwMdegUYeZTTnq8O1FVrCVwZH8inPThZDUiaRq8Ca1clZs
 eQjlyfRFrwS9dAmLicCU/ys2FQZkV7Hc03BSkRJVnLWDoVFaVUXil+X7O/a6lYdkJWDXcvvnw7ycEZSYDQyfjmskMnZtkQAax7LxsVKYAzJCSjdAG5SpyQor
 eeci5nsYoJdYwYecr870YHYY4nrDSpSs73q1/Xz/65sCzLyYRQy0277umZnoW5lceDKCdso4MJWzr1vqZoau/yA8bjD0kO0dRu5cUTOouGGCPKJFrTgNINPY
 l7SdurelCGVwZ9rcpEs/N0dc8B8K/nH+5nc+AslVRY1VNZNGfO4nXrxSnpwtOLKCEyZHlOxs2/WTA3a8nX/3NtwIcGL35QllKnBFWZto/7t1ITFDuNfTUM7D
 5YM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"fsl,imx-ckih1" is useless since no driver deals with it, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imx50.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index aedbc3ec524f..7d603064247a 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -68,7 +68,7 @@ ckil {
 		};
 
 		ckih1 {
-			compatible = "fsl,imx-ckih1", "fixed-clock";
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <22579200>;
 		};
-- 
2.25.1

