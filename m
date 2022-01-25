Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FFF49AB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390023AbiAYEmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:42:03 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:16854 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1323507AbiAYD2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:28:44 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220125032839epoutp030b0427871c9750ed4855b4844c160adb~NZcEoeXJQ0395603956epoutp03R
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:28:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220125032839epoutp030b0427871c9750ed4855b4844c160adb~NZcEoeXJQ0395603956epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643081319;
        bh=lEcoaPQ0wXcqoYAXTOO0tu1gYfLWrks8XW836Y3b+ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEogvZCTBsstC7u/TqmafhVHZ8cizOZvfPLPwCvsnJqnViJfw0gN5SqGSwJyVG7M/
         qELHEKXlhGT1hY1LZlla45G5yOXVIDKmeZkPP3RBozD4++aYFiN/JIHIhBt0TtNMXB
         NFpcj4n8bymF39fjgZr4d2mUtoltTA86aOnPibcQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220125032838epcas5p11badabcc9322c87661b3febcc85de2b7~NZcEE4CBr0816508165epcas5p1D;
        Tue, 25 Jan 2022 03:28:38 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JjXPV0fbvz4x9QN; Tue, 25 Jan
        2022 03:28:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.A7.06423.95E6FE16; Tue, 25 Jan 2022 12:28:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220125032825epcas5p2c5cf48a773fd26e089b31b0f6ddde83f~NZb3h_Npu0341303413epcas5p2M;
        Tue, 25 Jan 2022 03:28:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220125032825epsmtrp2452b7e6d8747082d6d48df1defbecf9f~NZb3hGjDy2646626466epsmtrp2U;
        Tue, 25 Jan 2022 03:28:25 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-ed-61ef6e59e5c2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.68.29871.95E6FE16; Tue, 25 Jan 2022 12:28:25 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220125032823epsmtip1ffba863d095402cfb1dd68b7fd32b49d~NZb1jkqKE0162601626epsmtip19;
        Tue, 25 Jan 2022 03:28:23 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Aswani Reddy <aswani.reddy@samsung.com>
Subject: [PATCH v3 2/3] spi: s3c64xx: Add spi port configuration for Tesla
 FSD SoC
Date:   Tue, 25 Jan 2022 08:46:03 +0530
Message-Id: <20220125031604.76009-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220125031604.76009-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTUzcy732iwYSPGhYP5m1js1j84zmT
        xaHNW9ktpj58wmYx/8g5VouNb38wWUz5s5zJYtPja6wWD1+FW1zeNYfNYsb5fUwWjR9vslss
        2vqF3aJ17xF2Bz6PWQ29bB7Xl3xi9ti0qpPN4861PWwem5fUe/RtWcXo8a9pLrvH501yARxR
        2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGcrKZQl
        5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
        HvYvZSw4x11x9NUplgbGB5xdjJwcEgImEvtnr2brYuTiEBLYzSjx+stKFgjnE6PEx44uJgjn
        G6PE6tt7mGBa9rx/zAiR2MsocbZ5HpTTwiTRvuwuI0gVm4C2xN3pW8A6RATcJG40doCNYha4
        wyTx4vlPsISwQIjEo2UP2EBsFgFVidOH17GA2LwCNhJ/l16DWicvsXrDAeYuRg4OTgFbieYJ
        HCBzJAR6OSRmzfzGCFHjIvHt1h4WCFtY4tXxLewQtpTE53d72UB6JQSyJXp2GUOEaySWzjsG
        VW4vceDKHBaQEmYBTYn1u/RBwswCfBK9v58wQXTySnS0CUFUq0o0v7sK1SktMbG7mxXC9pA4
        MO8XKyQYJjBKzDxxgW0Co+wshKkLGBlXMUqmFhTnpqcWmxYY5qWWwyMqOT93EyM4NWp57mC8
        ++CD3iFGJg7GQ4wSHMxKIrz/vd8nCvGmJFZWpRblxxeV5qQWH2I0BYbYRGYp0eR8YHLOK4k3
        NLE0MDEzMzOxNDYzVBLnPZ2+IVFIID2xJDU7NbUgtQimj4mDU6qByVri1pYpXl9u620xZr+s
        phDkNNdVjTV4z9zqgD8ij9X/18d1z15XeNFyeYPdnnJuPX71KB9H2WVMaQK+YeGq73l/nbg3
        a98ut1nbfyk9Y7z5RyfDRlexOMz9bd7nk3rforfvmHFv1+yZrteubLZ4sZ/XXLbkQqCwbkRh
        JuPdwy9eTwrfuKh1ZlS89+o5jA9XREuJOHpmtj8Xvz+x+8pUR+ktxy1Evh5IPaH7WKn1d0yI
        1u5zbL/3Vv+c+yzl2NHqA6HLWzcnGWSpr1RI2fBC/4fZ+yjxjhL1A/wdVodF2uRvKV/rKTZu
        UfvJ3MI6P99/odpWmSqxj3/+rDJ8bL9FdNPkM+WxLz5EMEsnt81UVGIpzkg01GIuKk4EAFiS
        0i8WBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnG5k3vtEg9/XOC0ezNvGZrH4x3Mm
        i0Obt7JbTH34hM1i/pFzrBYb3/5gspjyZzmTxabH11gtHr4Kt7i8aw6bxYzz+5gsGj/eZLdY
        tPULu0Xr3iPsDnwesxp62TyuL/nE7LFpVSebx51re9g8Ni+p9+jbsorR41/TXHaPz5vkAjii
        uGxSUnMyy1KL9O0SuDIe9i9lLDjHXXH01SmWBsYHnF2MnBwSAiYSe94/Zuxi5OIQEtjNKPF+
        ylR2iIS0xPWNE6BsYYmV/56zQxQ1MUl86VzMBJJgE9CWuDt9C5gtIuAh0fbvHjOIzSzwgkli
        ye0cEFtYIEhi6ZePYHEWAVWJ04fXsYDYvAI2En+XXmOCWCAvsXrDAaAaDg5OAVuJ5gkcIKYQ
        UMn7RRoTGPkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDmktzR2M21d90DvE
        yMTBeIhRgoNZSYT3v/f7RCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphak
        FsFkmTg4pRqYlrWHyDt+CtmbYd/gs04v+bXZiX//fqxUyOHaLlu//HTrC8+2mxe4XTeUnSxc
        WLuS4fxJu5tlDOW/PAXbo85rBUV1t2tbSEqsjTpq+qBNYuEu1fCmyLuzMnSOrQjMWJjq9ZYn
        il2IeUn09dNHglfkBrGUxU3R/rbqpWZe/5L71/L3Sh0Jn9beKpT4/deOX51GN0NDF3DGJVi9
        Pf0pLHPGHZcDF578qnlixTktOeLX2ey/PAasaoKfL7Cuvp9/l9uCM5jprMvFCN9jXzt/LHgl
        cvFu2Zvjpb8cPrC16b4xnjA7+9tMTV2LJ01Pz7H1SKe1Oirfay4s2iK2r/9A/rRAlVfJ1/av
        Ff4QtnvLDD4lJZbijERDLeai4kQAgWx9WdgCAAA=
X-CMS-MailID: 20220125032825epcas5p2c5cf48a773fd26e089b31b0f6ddde83f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220125032825epcas5p2c5cf48a773fd26e089b31b0f6ddde83f
References: <20220125031604.76009-1-alim.akhtar@samsung.com>
        <CGME20220125032825epcas5p2c5cf48a773fd26e089b31b0f6ddde83f@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible and port configuration for spi controller
for Tesla Full Self-Driving SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
---
 drivers/spi/spi-s3c64xx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 386550fca81c..423518bf0270 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1440,6 +1440,16 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
+static struct s3c64xx_spi_port_config fsd_spi_port_config = {
+	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+	.high_speed	= true,
+	.clk_from_cmu	= true,
+	.clk_ioclk	= false,
+	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
+};
+
 static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 	{
 		.name		= "s3c2443-spi",
@@ -1470,6 +1480,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "samsung,exynos5433-spi",
 			.data = (void *)&exynos5433_spi_port_config,
 	},
+	{ .compatible = "tesla,fsd-spi",
+			.data = (void *)&fsd_spi_port_config,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, s3c64xx_spi_dt_match);
-- 
2.25.1

