Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFAF466E9E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377882AbhLCAoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:19 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:36091 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377812AbhLCAoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:09 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswd2mQfV0; Fri, 03 Dec 2021 01:40:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492044; bh=1GwZdZs71y1Y7zRJH7MP0kRXMRTEVCxiWPznzuV4wJA=;
        h=From:To:Subject:Date:MIME-Version;
        b=bi+ZNhQEchdc1w90aE2LeXP1xuRsFflIOgTFcQQcorCQfUlJt5j2dN4khYQqkMBp+
         eRg4DMSL9qx0rWKWAF87hJbV43IdhTaqSroa1jLaDYcozCs2Pq28aR3M3aJVWETKoP
         uyM8AZ7wTJH4TuOBoAGkO1k9o8qAWXKOSYHhta2IKbyOpT1VfkrcbHmaIXfs7P4uTi
         M4E9CH95A7lBaNh7x+YCvs2tjRgDBBX4pue0hB9e97GdpLchV0tZp4OD0bVOW9VsNF
         SfqguNKTUAFlq3goMHcfa+2ZRJtKrdsZDnCYm6toqT5R0VOhR0H2Vfp4mFYQL7f0ss
         cn0lcBwg4Bvxw==
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
Subject: [PATCH 08/17] ARM: dts: imx51: drop "fsl,imx-ckil"
Date:   Fri,  3 Dec 2021 01:40:30 +0100
Message-Id: <20211203004039.48752-9-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
References: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPw4TLXbP7TB9gSMVGQWxwkbcYI0ad+JV6rZWktdEADQ+3EepDz76xbZCajUXznSrylZPcf7dyXFmrNjfA7qsqs259hFR86biBE3xdAkoYpmZYoPrdLn
 dJmZiRX1qcmaFFS4nEAqDvoS0JIvrM1Dbn1TtPZrIySxXTtfk6oE0LBKgaCB+RvU00+tquo6yZkC2vJ8nqlN/9gZWLjDyteadKcltLWcr254NGHF7og9xRtd
 w9dWwpcnCmb9sosVJSq5dcENiCMm5+OS1TF4PUjvpzxFiVXwK2q2g2UkU+1SfgsbPAedSNP9CIrb+lCA2Vrm+MZZ49MQ3Jx08HaBMJPRv90TdopMuHQyC0In
 xfCMnIRavpWcJwyzB32655jbL9Q8Kx9IIcJYSVd7iBjZtdH1pw3mamQysgUFPfm3H1lfbOC9Ws2MxGAjAze3sbslFXk4vQax7oUzo+M/lWrJbp/rFRWSiriH
 MfQyXVgFfwxEF69nRAJzt8jaBbFXqt+PEj85eqzq7izr9JVO5XGLf8dGvh2ZyAaxxKX+87Pv1sJe2pWKEUA+Qn0RppNhL5ct/RwKJ+5owK8v9BK1PnjXSDm4
 MaU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"fsl,imx-ckil" is useless since no driver deals with it, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imx51.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index ccabccf32786..5ad15e889c40 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -48,7 +48,7 @@ tzic: tz-interrupt-controller@e0000000 {
 
 	clocks {
 		ckil {
-			compatible = "fsl,imx-ckil", "fixed-clock";
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
-- 
2.25.1

