Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A92466EA7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377925AbhLCAoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:32 -0500
Received: from smtpweb150.aruba.it ([62.149.158.150]:49423 "EHLO
        smtpweb150.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377841AbhLCAoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:11 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswd4mQfWO; Fri, 03 Dec 2021 01:40:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492047; bh=u3eidnxRkTP9vfdmgGbm7dE1Ekzr+AyUIRRAlK4/cK0=;
        h=From:To:Subject:Date:MIME-Version;
        b=Fq/r3quFC8dor/UYV5YwjjrpDPpskoJuhyQUVs/If2hhGk8Y5m+dOnKbNbnE8YghW
         SwtMKdWcxiD7DW/gJQHvZ5lWNJIgaLPH+DXXUD8Mdx1WwXxHr/MQs2CuatoWg/ZZ2n
         A9oM6iz44f/OuPCmOOVAx28BneT3H4eOsRJ/Ip4HbkeUxF1uNWmlikUxpJ41sofe4s
         +MWyme52KhjBNOeGk5eBk2MezZHrnEZvJxn9YhBC4oXOccEANBIk3SAVS+P1AQ9Pew
         mcLErPLDM/d2hamSiITuWsFfbYvLDS4WfbQKXd26CU8gk0Onk/ZN7nelo/1zsDDkon
         VVKA+F7sgeN/w==
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
Subject: [PATCH 13/17] ARM: dts: imx53: drop "fsl,imx-ckih1"
Date:   Fri,  3 Dec 2021 01:40:35 +0100
Message-Id: <20211203004039.48752-14-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
References: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfI74Fm7EkDv6GAlcUDmW+j/TLC+4+NzGuRtOqvYcUBMmrtNCySeuVmhr751ZVacm85JOWjqSfnl8CnFiPRJ2ZtE3ByxnyJ6v8GNsciH7ErRPgrorYQWX
 onfCO/0ygATHn6nHjWjWTb82PYtU7Cb5N19mVEHzia64Nplr+dFSOpwC8ojtSWW4S3HVcJc8RJso2zo2NVRklwmNAcb0eCaNehBLmdzEnWcsSHY3c33+ttfc
 ydjPR9dzCgnGkUnpa1SQh0+i0UpJfCBot52P8ga+S6U5y3mqoFDKsuF90YtY9OUq+qA1J9Y+WCF148co1Ml4a8mCcEDv2FTvxujcK7DUVGXU9Y+rcYlisBt3
 uX79H2Gmqp1sDuKWl+W5jgb9nQio7fulkv02Tv/YFOaL8a+LYEVs+Wu4zJ2JLICnGq66oLY79vafuEX6+j2kWA++4LBDRTkvqNqgH2TLfVJwvnIayorbxReM
 1CxgYFVOUdo/v/vtVj8kufT1CIG7JNhDrrLTLA0goCwqfR6uB1W/wK8bKwMXSqBNRh622NiOTpiavo3nluOOjeNoTBLg/m3s008COGsrfr4b48rCem6lq691
 7II=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"fsl,imx-ckih1" is useless since no driver deals with it, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imx53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index c1d171ffd44d..fa1122e8a0be 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -92,7 +92,7 @@ ckil {
 		};
 
 		ckih1 {
-			compatible = "fsl,imx-ckih1", "fixed-clock";
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <22579200>;
 		};
-- 
2.25.1

