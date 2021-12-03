Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04E5466E97
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377810AbhLCAoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:08 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:36091 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377784AbhLCAoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:05 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswcymQfSa; Fri, 03 Dec 2021 01:40:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492041; bh=lIOINYzwKp18wAws6ji4eJ90698p+pOmxC6CwQQxfX0=;
        h=From:To:Subject:Date:MIME-Version;
        b=BzmZw6cUH6vRgciiNn6AUwHkdYo+gmMPsSpC5RFswT/RShcKWK5lywcYravloQZ9B
         sj7u3iUDVde1fE96qo0OyoBmk9Lb+P2GVdhfWVgYQZ+8ukui5vE8rr0x1H7lK1/pO6
         wgt++x9qK6jNSl0pSsbhEIcA0ZbH+UsZVNLcixW58RytLfruAHKLwRjXPlLXpbA1dQ
         9FPWNHEp/HqUS/SKBPX48H011EaGqvOAsnXstbLN3RuppHYv/ExejTcQyev0OqfR+z
         k3foZc+0vqotdR2zVqNQ21ZCJE4RxL2111ZAuHeR9gyTCGnUHQpxPL3B43G6IzXHAE
         za1ods3/L5MOQ==
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
Subject: [PATCH 01/17] ARM: dts: imx1: drop "fsl,imx-clk32"
Date:   Fri,  3 Dec 2021 01:40:23 +0100
Message-Id: <20211203004039.48752-2-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
References: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAqElclMiy7N++kBPTFFv0Hjx2EKjwyLL1azBu/inKsGvKPwWNQSIC6sHup+IqKsbHapPVZ0+QpiNRwha5fz2QSQFo7rxg6J+681EFkDtYP9/TdWpl+8
 eBSFz+G4rOJodSo8PnBVAGqWpKLZ95SN1D6FSIczHLew88B0L1P3+uzRW5gbTYPaRZ/Uuh0h6XATwMj5zE1d75G2HMCFUzgu6eSY6VinLJUWJ2/jK18Nt3ev
 T+TNDqAxE0PMZ6mkXvAA1Wewy5zlka00fVa/1MOujEJJD4aM+A1oOcQ0Tj3NpYIuEoFmYEx5OatpXv74kfz95lFM8Ob7/HcG98aKrUena9eyygJvfeFYEdig
 RqQloTIJrjmHZgH7wwUGm4EOwaFkXRrpIMKtlet4GfMaG56dVGwQBj8zaNwaVy1kEEFrNbCLMM0G8rN2fWSpE8SkW+7sVz7cwp0BTQB6lqKfQKlcMq6xBfoB
 QYzZ5iU0Xtl7Vy2P12Dckd6N2TlMJPsUUKJftn1xBn9aFrxPTCyKP3nVOYdssaLIGYwVFOuEgvOOZJxjtYeUQfdMoe0utNlKWQBFxJwPdI86NJtfVjSms05J
 siA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"fsl,imx-clk32" is useless since no driver deals with it, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imx1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index 9b940987864c..e312f1e74e2f 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -55,7 +55,7 @@ cpu@0 {
 
 	clocks {
 		clk32 {
-			compatible = "fsl,imx-clk32", "fixed-clock";
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32000>;
 		};
-- 
2.25.1

