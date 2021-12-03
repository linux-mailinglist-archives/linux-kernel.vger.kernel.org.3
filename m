Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD7D466EA4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377907AbhLCAo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:26 -0500
Received: from smtpweb150.aruba.it ([62.149.158.150]:41658 "EHLO
        smtpweb150.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377855AbhLCAoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:13 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswd6mQfXc; Fri, 03 Dec 2021 01:40:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492049; bh=aGCPFqajCMl1i2im53TPumZwZRUvjzem3K/WfI6jqYs=;
        h=From:To:Subject:Date:MIME-Version;
        b=GgVGr07Lnt9RI0lG0Wc4Wwbr6suzkjyBFIpbjBdV/yBgPdieGXwLZsfd8cHsUHfZM
         iErI5dSjBWMt/bKPcN2UBghunPcHGGIeIkEQuDXRqgWHUDjNYYPjW3bEgxuF1lzhcN
         QMpoxu6nx5HtmZxwxwziGLGOw1JZgSn6UKUSh1eQyud6YcSevQDspZw8ZNuKX0Fsrv
         Ao17kG6aYxsty6JOLjptLjvv8fXG5WnbuWm7Pni6QwbuBQxSQCROjIxzd4ElwHpfMN
         J2u6YFfaMHu1PK9VbYKdl6rfZ2G5ASCsiyZ8oqqepvrmNTLFkeDC0HHRrmi/OwD58U
         Kr9SMtqZ0om0g==
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
Subject: [PATCH 17/17] ARM: dts: imx6qdl: drop "fsl,imx-ckih1"
Date:   Fri,  3 Dec 2021 01:40:39 +0100
Message-Id: <20211203004039.48752-18-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
References: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIlFaOYGDSgCyRE3rJ3IAAr4OUyJn7DF+9xUpQQ1FoJ6ORjQcqTwcqJpIQuTKoWCe/MZdJdpIjCAyZ0I7bLKj1M1g1EymneNXU9aA/pI+vEEG4LNS8kj
 rRaiGS00tu3LIpqXYeZrzOtJtfq12ZdEQW7Sn57w/Tq1LQT08h/VcKt2IeJdbGVSyMC2W0UImyynp8rUYDLWYP8cZlE3bkFAYrXKc+cNSXhWXATjt5/83wpC
 3JBNsZDJfFrHYUIJhq0RzekyMXw3pPHWZXdVtnj99SQQXbrQu+YETCSC21jxmtniXFrnp9xEJ63ZM6/vpntO3FLdpzNNH7Xpx9LNEtV3zPLLoGaMJtKX44Rd
 yXLW+lerfwdSgmdkxi+m7+HWm+5cMF5DLks34PD4wSFps0+sh5koxdmuHe3chBZw6FZB1z1Og548ENtE5PKGoXyF/pOb+oRzHUEFItjCEfwf2GHH26u+NLiV
 WksMNw6g0PbuUSNzCLp61cNoDmT83r4LXXSfUaUOXtDvbJzuodedqTr+XMP5QMDnl253UdOrh2+vQ0Kne3yDK1cmkMmat8RZUglCN8dOmG0IMAeqrX5dK4hA
 AJA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"fsl,imx-ckih1" is useless since no driver deals with it, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 215e835a9b93..d0e4b6b18fca 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -61,7 +61,7 @@ ckil {
 		};
 
 		ckih1 {
-			compatible = "fsl,imx-ckih1", "fixed-clock";
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
-- 
2.25.1

