Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67154466E9F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377887AbhLCAoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:20 -0500
Received: from smtpweb150.aruba.it ([62.149.158.150]:46070 "EHLO
        smtpweb150.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377817AbhLCAoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:10 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswd2mQfVJ; Fri, 03 Dec 2021 01:40:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492045; bh=OCCitaq2uP3raGMIoTa+nlv96a72xchWQjkyA/NjDHo=;
        h=From:To:Subject:Date:MIME-Version;
        b=B/pQZx3zyOhAtzgFp+fsiuEfLYOHpZN/RMiH+gxFoxC7VDSeMMka8uxZUrgw4MvC0
         Vk8LHP2Go4+y54dsHRMPefVWCiSYSbUPjdDWCMWCxoOKIkg/fWPHxRXvTwrcEeVP9l
         6eG3sv8rnmeEr1KVsotkA6SQ8LzE+8aLn2ySbToRgcfJEEulVLs+Gg5gOWiJLLt8wM
         0+ywUKoi9wbuVZLy/fB6oXXWOvZLnlrbY3qxImJnMPfPQDhNwPrmJ3ZKoytKtMkIeZ
         XBggJBvifWcTR2VSOJ5Jj3xzyQWNkPiV3WkcRdYzXbre/30s/JBRfrhU7G9lIEKm/p
         WQsgvKnL7W0gw==
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
Subject: [PATCH 09/17] ARM: dts: imx51: drop "fsl,imx-ckih1"
Date:   Fri,  3 Dec 2021 01:40:31 +0100
Message-Id: <20211203004039.48752-10-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
References: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCuByBvyI49Bm1RvSgR8i9IWsyEekiq7ApbJifqLSJJ/kdXSlzd569tXxA+jzt9zCmWiRGxuLLfDBwenyDYTolegrO++v3+wgU3V7xkgabxROIQwpYWO
 HsgIXwLdzWNuIP5DlKtBynkyhiJfjPxv1zZpEE3qhi6b7DYM4Mv1sO+aJBEi0gCamUK7ilcJFjYtbClUsGnx1tOQ/k0JYy4WH/3pFpxgCI2PW9pZOw6z3Xhx
 RmIoFZpTjyAuik/Asnpr2JCFMsgXDYBb1sF3Qk0sBLpJquzrYMTxaANVday6vyV4eDjZRv7FoJJUpiQG4c1HwZWHkAldDTcgNeStftDK/dbHOvwpFA4RsauM
 NSWRTzIRUOHxvsgfEj45psKIQU3pq1i3LH/TaPKvlmRKUL5iAO1INISk8YGT5EX4TsuN1hClXdh8NR+xKgVAs1tDMTciyeEmDD+3is8PvwqJyZmuwR9IxfTS
 biEMaHDTRpBzBxxmQQ880XrbIlEQ/qpLgBVKQou7brP8wS9l+y8+ScTE/7PRdSSNMKh/wr1vm9sgVMLciKrxLnjY8KjbnNlP92lsV8UM+EnrQfy9IjRrw6xE
 HTQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"fsl,imx-ckih1" is useless since no driver deals with it, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imx51.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 5ad15e889c40..9f895cba5a7e 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -54,7 +54,7 @@ ckil {
 		};
 
 		ckih1 {
-			compatible = "fsl,imx-ckih1", "fixed-clock";
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
-- 
2.25.1

