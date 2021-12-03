Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0411F466EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377890AbhLCAoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:24 -0500
Received: from smtpweb150.aruba.it ([62.149.158.150]:37208 "EHLO
        smtpweb150.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377839AbhLCAoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:11 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswd5mQfWi; Fri, 03 Dec 2021 01:40:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492047; bh=uI1Lp1GHcJptNaVP7azTFQ+ZxLSPN9WKdrEgXMMBfz4=;
        h=From:To:Subject:Date:MIME-Version;
        b=ad6iRwZSREul3KSUABRUj7dHXZCsuslYX36d4sgjJjc2y3/zCwxKWaCNjjUvWTUw6
         vDPqkvSeC3jf5Hxh8HoU2TdMnizDJDvS5MZFvF07+L5v0pbq2LnwbKEdotaFDzt9Qe
         bZIVsTAa3uSoXkFgHg3a8XmSMrC6apY3/h0HL3zut1Eqa1dGYn3xcVlCd/kR3/e8KL
         xmNQaAOKuBADICDxOWi/voRB+Qu66q2dowupaLesAKJ5dz5cL+F1pOie37gNvEihvz
         o6Dvo9nxyF82RPF+4urLkkbWKZ6HWDVMateinqWlWVK1FMT6IDBAeGWpWzaJWm4x/L
         s+4w2Amgc42ag==
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
Subject: [PATCH 14/17] ARM: dts: imx53: drop "fsl,imx-ckih2"
Date:   Fri,  3 Dec 2021 01:40:36 +0100
Message-Id: <20211203004039.48752-15-giulio.benetti@benettiengineering.com>
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

"fsl,imx-ckih2" is useless since no driver deals with it, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imx53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index fa1122e8a0be..244273ce96c0 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -98,7 +98,7 @@ ckih1 {
 		};
 
 		ckih2 {
-			compatible = "fsl,imx-ckih2", "fixed-clock";
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
-- 
2.25.1

