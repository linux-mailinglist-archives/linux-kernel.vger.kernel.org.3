Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25131466E98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377826AbhLCAoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:09 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:57331 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349629AbhLCAoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:05 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswczmQfSq; Fri, 03 Dec 2021 01:40:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492041; bh=VsmKVWTBThaO3ICGZ8hn6iI+TKSv7wZPdTjoWY2+lOE=;
        h=From:To:Subject:Date:MIME-Version;
        b=ReAADG26BEur2UkAuCzpG3Hbr5hUceIhpHfOTELiDoHg+1wQWilj11QCxVXtJfPEP
         Z7RLaLppNruuCnNMuWuXZLKPDsHVjRtkQ7Q5shlSY8D+t1dd5z8tz/KkylYnzMxZcF
         m9Jb1UMX1juuV7SQ/lZh+rHFJXoonD3r62EnY3iFC7EEmNuIQ8lG1WflpWbsxiWeWd
         uUFgt4Z6Z4zym0JCAmmjxjaw/a0lkY0cSrda40mLcXDlF1B5afZTDWN1g5a6KmABuw
         KUZD4kVyUxPT/hV9K62awwRFLN61n63jNuclsBcv6MEB7UF/mSQL3k8ru2isy7Ul3B
         Z+uMkV33u1NCw==
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
Subject: [PATCH 02/17] ARM: dts: imx25: drop "fsl,imx-osc"
Date:   Fri,  3 Dec 2021 01:40:24 +0100
Message-Id: <20211203004039.48752-3-giulio.benetti@benettiengineering.com>
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

"fsl,imx-osc" is useless since no driver deals with it, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imx25.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index fdcca82c9986..89cadc91034f 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -62,7 +62,7 @@ asic: asic-interrupt-controller@68000000 {
 
 	clocks {
 		osc {
-			compatible = "fsl,imx-osc", "fixed-clock";
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <24000000>;
 		};
-- 
2.25.1

