Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AF948D7D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiAMMZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:25:50 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:59718 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiAMMZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:25:06 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220113122505epoutp0474c7c91e5932de6d84f2e2ab53b3595f~J1BBL9h1y2694526945epoutp04L
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:25:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220113122505epoutp0474c7c91e5932de6d84f2e2ab53b3595f~J1BBL9h1y2694526945epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076705;
        bh=Dop1jFQruUIB1sW0kIUYmLUWX+qRkXKeuxvtRO13Wcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnXGMDRI5cdUmqY51kgxYy9yc0+X0y3yH3aEnjzopitanDHBNlKGR8BxuVntCfSnb
         q8owlM/6iJWI2uDIbtM5J1JcdTadl7EApjqK2of7ACQwaZ6Bv9yv2Q0Kxvom/lJ2iH
         B/xN+h9x3+VUeA51HN+fiWWUegEF6t/r4hdn6vZU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220113122504epcas5p36faf2524f27857177cb1d45240696835~J1A-6Rsjf1006210062epcas5p3t;
        Thu, 13 Jan 2022 12:25:04 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZNt13HPbz4x9Px; Thu, 13 Jan
        2022 12:24:57 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.D6.06423.81A10E16; Thu, 13 Jan 2022 21:24:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220113122456epcas5p35f6406ab03af58d2e56b0b7304d4d002~J1A4xDhmX1006210062epcas5p3l;
        Thu, 13 Jan 2022 12:24:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122456epsmtrp1e4a57807c0189ba6a67b00291a54298a~J1A4vpfXE2009320093epsmtrp1D;
        Thu, 13 Jan 2022 12:24:56 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-35-61e01a189812
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.B9.08738.81A10E16; Thu, 13 Jan 2022 21:24:56 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122453epsmtip2278c805cc6a7a9404a5cbed7bb323a8f~J1A2IUeYk1246112461epsmtip2X;
        Thu, 13 Jan 2022 12:24:53 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH 22/23] arm64: dts: fsd: Add ADC device tree node
Date:   Thu, 13 Jan 2022 17:41:42 +0530
Message-Id: <20220113121143.22280-23-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmlq6E1INEg6st1hYP5m1js3i/rIfR
        Yv6Rc6wWG9/+YLKY8mc5k8Wmx9dYLT723GO1ePgq3OLyrjlsFjPO72OyuNu6mN3i1PXPbBaL
        tn5ht2jde4Td4vCbdlaLx9f/sDkIeKyZt4bRY1ZDL5vHplWdbB53ru1h89i8pN7jyokmVo++
        LasYPf41zWX3+LxJLoAzKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
        1VbJxSdA1y0zB+gLJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWle
        ul5eaomVoYGBkSlQYUJ2xu6T29kLurkq/r65xtLAuISji5GTQ0LARGLurOtMXYxcHEICuxkl
        ztyczgbhfGKU+LThNTOE85lR4l3zRBaYllXrr7JCJHYxShx88guqv4VJ4uyhRiaQKjYBbYm7
        07eA2SICbhI3GjvAipgFmpkl5k08CDSKg0NYwEHi1YwAEJNFQFXi7343kHJeAVuJ022XmCGW
        yUus3nCAGaSEEyh+d1UeyBQJgZUcEh0TvzBB1LhI7Py6mhHCFpZ4dXwLO4QtJfGyv40dpFdC
        IFuiZ5cxRLhGYum8Y1C/2EscuDIH7BhmAU2J9bv0QcLMAnwSvb+fMEF08kp0tAlBVKtKNL+7
        CtUpLTGxu5sVwvaQ2LRpDiMkECYwSpxasIp1AqPsLISpCxgZVzFKphYU56anFpsWGOallsOj
        KTk/dxMjOGlqee5gvPvgg94hRiYOxkOMEhzMSiK8/UX3E4V4UxIrq1KL8uOLSnNSiw8xmgID
        bCKzlGhyPjBt55XEG5pYGpiYmZmZWBqbGSqJ855O35AoJJCeWJKanZpakFoE08fEwSnVwKQx
        5Wi/0RUX09NlzXNb2MJ+ntaNNv6azXu78r/+5QyBbROmXl5159sCu3Clg/9eCMo9+cAfFmXH
        Hb3z4+SEJK9mj0chjI0btuV1Txeoj3NTnTo/vCl/QmM2w0Z1r0bJrpkBp6r3P9BgW8T281rG
        G1v3q507uuOPMn2pfKVrvWk3+wJFEX3+wmQuOwbhBQcZCj8sT5bLmrYwK2hxJlcyyzxr8w6L
        /ae/neN7cU5ZyyfP9bF37QOHfW031r/8felT1Yfg56JHk3KOhex9ZDalvfvB3Vs7zoVxMH+X
        NPzWL//Pwcomqu/kF/9LKmaHPi9ft/b/oRddc4J/e/+/vHTToh2ffG+8UnuTePel0+vZ3g+U
        WIozEg21mIuKEwGBNSk7IwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvK6E1INEgwUr2CwezNvGZvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdq8fBVuMXlXXPYLGac38dkcbd1MbvFqeuf2SwW
        bf3CbtG69wi7xeE37awWj6//YXMQ8Fgzbw2jx6yGXjaPTas62TzuXNvD5rF5Sb3HlRNNrB59
        W1Yxevxrmsvu8XmTXABnFJdNSmpOZllqkb5dAlfG7pPb2Qu6uSr+vrnG0sC4hKOLkZNDQsBE
        YtX6q6xdjFwcQgI7GCWuv5rJBpGQlri+cQI7hC0ssfLfc3aIoiYmiabm02BFbALaEnenb2EC
        sUUEPCTa/t1jBiliFpjMLDH9xWygsRwcwgIOEq9mBICYLAKqEn/3u4GU8wrYSpxuu8QMMV9e
        YvWGA8wgJZxA8bur8kDCQgI2EuderWebwMi3gJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66
        XnJ+7iZGcMBrae1g3LPqg94hRiYOxkOMEhzMSiK8/UX3E4V4UxIrq1KL8uOLSnNSiw8xSnOw
        KInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg8li34Oq6z0KrClU/HeXP8HuwcnPRcm+fW3HF
        PgJpH6c25B4+LyHw88olpZ6T/EUuh78WyinOjIj+MClJW3HNya/S6wT3CsYvtNpkMmWObZ79
        vQl851x3V9xO5Tq5geVz6TGNhoaYcN6n3xf8Mn5yenL97T2+FW5Lc6STZLlfHC8+3qHjXvVK
        35h31boP4hv4pvJe/sb7LF5GxuLkpdc/VPnPHstavHHpHbuq1/IrAh6tPbgmwJXFfFUR09+4
        /+w2G5Pu3p2woWXdHY/s5UedfZtPlGjy7Kg+131+Rvaio3pVGhUGlt89Hns8sviYKqIc9MzU
        /X/dfVVFyYbD3XuUebYEPxFcbPF7z91bsb8dzyixFGckGmoxFxUnAgBdqSO25wIAAA==
X-CMS-MailID: 20220113122456epcas5p35f6406ab03af58d2e56b0b7304d4d002
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122456epcas5p35f6406ab03af58d2e56b0b7304d4d002
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122456epcas5p35f6406ab03af58d2e56b0b7304d4d002@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ADC device tree node and enables the same
on fsd platform.

Cc: linux-fsd@tesla.com
Signed-off-by: Tamseel Shams <m.shams@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd.dts  |  4 ++++
 arch/arm64/boot/dts/tesla/fsd.dtsi | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dts b/arch/arm64/boot/dts/tesla/fsd.dts
index 7f3bb6212e50..dd6c75fc3221 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dts
+++ b/arch/arm64/boot/dts/tesla/fsd.dts
@@ -150,3 +150,7 @@
 &spi_2 {
 	status = "okay";
 };
+
+&adc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 7e687c6f74f6..058a9d381aed 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -788,6 +788,17 @@
 			num-cs = <1>;
 			status = "disabled";
 		};
+
+		adc: adc@141A0000 {
+			compatible = "samsung,exynos-adc-v3";
+			reg = <0x0 0x141A0000 0x0 0x100>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_peric PERIC_PCLK_ADCIF>;
+			clock-names = "adc";
+			#io-channel-cells = <1>;
+			io-channel-ranges;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1

