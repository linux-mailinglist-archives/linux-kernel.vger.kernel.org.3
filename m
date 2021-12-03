Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EBF466E9A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377838AbhLCAoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:44:12 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:53562 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377794AbhLCAoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:44:06 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swcymiEudrmmOswd0mQfTU; Fri, 03 Dec 2021 01:40:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638492042; bh=f4+oNuCx5ubPawZ4eUv4e5bqcJ2BWNEhT8PGqbaPtDc=;
        h=From:To:Subject:Date:MIME-Version;
        b=UD6iVJ4wT0LJeolB/ijxO8X58umLkXZCpgBlcGAlhZGHSKL0kEEUBnwpw1iI/WuhI
         FteUoVMpF8f1YKKGvD2+k2wSUMUdXA40iU9nZF7RyCJQqGbqsOVEsUqjLXyOZwzjVC
         rB2XCyufXQuUpWnQ7MQ0Fj7VA1gy3R70TthiCaiKtb0fBXQqWHliolDw3VnYHa9mb9
         CWO7RQ3Il2DuI7CL79ihc6L/MhwS2mbAv9hfzPN9y/edKuX5896zgcnPL7TQKq6HFu
         2iyFYQXUT3sVnOLiA2ZGZ1mXByEEsoZkTOMlY3wojidXiamj+PR8BCUWF8Mn6Q97Tz
         nHRbiIw0SvT0A==
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
Subject: [PATCH 04/17] ARM: dts: imx50: drop "fsl,imx-ckil"
Date:   Fri,  3 Dec 2021 01:40:26 +0100
Message-Id: <20211203004039.48752-5-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
References: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBBRZa2PD1Ty+Hi82+qhZY6FbP7jFI+85RLUqc/XvBhKJV8QOeqcTqy1rwzZ/gXKS7t7RgcyOwVs/WS9AsQlR8z9VFJsu8eUAEsL1hhRS/hOZCitnxeo
 GWdCmTByonkyJaYvY1Yq4eQS2NZiAXXQovGwrDsoy1EBt1sXZX75lt4N5juhp7l+lhySf0pQYn7z3AD7ks892OPbcPuOLudOxG+Emu0BDWgRhJqP62M64C7V
 AVg8K3ab7eH8cGjVis4JJKySOJHtwnY9kDbgpOq2WqJ7lmkkDSO0deSgc+gp5ms2c46j21HXxZFRepkl1KSnVVrS1T+wZRqnb7DkqCnRjIIJZcF9Pc9t7LJD
 hUFcS/4QURo/PL7MuwMsY0YkR/3M1pCnNgm6d0I8oDJlSN11aDPJoZB3u1aFyLq6VBauKtYe/HdFHFCIxrAajDCWxWvCPlWqlSr68bJviUorJAjTKqAs7+qZ
 83AM5vHLIlUstVMb2rnaMEoY5xQ+DhquWLasZoC6rNfeEjO91RWXbstYWlIWXWuAAvCfWcKQrdBy1bcapHSZgz4fVb0XDtiCX4+xgaMA5I0vRAjx7ZvuHUc7
 nuU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"fsl,imx-ckil" is useless since no driver deals with it, so let's drop it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imx50.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 9d853b72b5b2..aedbc3ec524f 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -62,7 +62,7 @@ tzic: tz-interrupt-controller@fffc000 {
 
 	clocks {
 		ckil {
-			compatible = "fsl,imx-ckil", "fixed-clock";
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
-- 
2.25.1

