Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8925466EA3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377888AbhLCAoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:25 -0500
Received: from smtpweb150.aruba.it ([62.149.158.150]:44882 "EHLO
        smtpweb150.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377832AbhLCAoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:11 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswd4mQfW8; Fri, 03 Dec 2021 01:40:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492046; bh=LvTEXKcLRKbUdnfnBu6nNDYlNok7EV/88vkdO3I15eg=;
        h=From:To:Subject:Date:MIME-Version;
        b=RlYph7686QXpKrix5cVQ4CJPAqe8iXTRxJbAN1togl7aNIOj4WCXcAJvvFJWQfJTB
         ZEZHizji1a8QgfX2e/++S7A4gAg6sBAtbYl0ieQ62hl2EOnde9K13sbSQ2eYXfOuwM
         PW7QhJXHG6X67krCCBCyEr8qttcBRIOnZT0Tl5irUAHYwMHcoWm5Mmh6ffcd3GndJ7
         UgO1e1UiYYNjjkg4mz8jEae5MwY6S1DiSsZWv3xI/1ockqOiOi8oXd6UE7hfLAjUKw
         1khJfTDWoqC431PtE7OAIzKM2bvUN14uKrqxgvNZNjLaPloVF8ErXha2FF37D+/Tl9
         PK/8vA0AGiTZg==
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
Subject: [PATCH 12/17] ARM: dts: imx53: drop "fsl,imx-ckil"
Date:   Fri,  3 Dec 2021 01:40:34 +0100
Message-Id: <20211203004039.48752-13-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
References: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFsCTXzt9h0Jk+CnEDBEeCpPTEngGVMiX9z3mwyzxfXsl7/xizcpD9s/T+k2LnpprrOwrS3La5otE0mu9QRpD5buzDUSSHZdK5yZXL0S/gCUAkj5w5xe
 YGvIkIzxBMCW2gvOdYY10XU1Pc4MHAF8ninrLC0t6D1Ohe64dtOmFz1kJPtSY25E9DRc4WAx9w3TN6hJ14v8E6EFcSgPc1xWpJcyvwCW9x4UlII5gsDpRjFy
 Vj5fhTsgcZTv3DIQDrFsCK5KegmMAn4wD40pw9aMeFzDHcpaoAsintVc7hHd/H547VrbGrSh0jY0K18YARpFRT08JFF4udlkklykdwVMkjaJziq03HSbH8tl
 +LySyvD2Ppnwp0sBbDQYM4FLtUEHQx9s1NJ1swvCXwi1nSlML/3pGUNAotC8nHtQP3x1Zf3WFA80Epl5alkAMD6wTCCZvL3Tgb+O5gsnF+L3cGkV1dODU3ZX
 6bY/x58XYyF+QcWG8cFGwOytx7wRALbZ9wZD7yqBlPir8oku16FEAMIZ+GrNoeKW7w7ptbmJe6I8rQR1AVEYJyjY6iqTOvRuFHGDIml3UilAbaAVT9Zmmm0B
 PeA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"fsl,imx-ckil" is useless since no driver deals with it, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imx53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 06e089fd618d..c1d171ffd44d 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -86,7 +86,7 @@ tzic: tz-interrupt-controller@fffc000 {
 
 	clocks {
 		ckil {
-			compatible = "fsl,imx-ckil", "fixed-clock";
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
-- 
2.25.1

