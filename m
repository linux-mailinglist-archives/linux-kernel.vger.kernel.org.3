Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3994954F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377467AbiATTgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:36:31 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:35086 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377475AbiATTg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:36:27 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220120193626epoutp04e2d2d50022e77e23f843b0a7b26c9c7a~MEaoFn3BG0220202202epoutp04F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 19:36:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220120193626epoutp04e2d2d50022e77e23f843b0a7b26c9c7a~MEaoFn3BG0220202202epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642707386;
        bh=OXLHdsWUhfZFmJ9Ejv8VvylkUjH8YGcav1V1Ne9AU6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ykx5EEahlBhilrX2bwqntWM5TAM7AFsr+VQ4Bhf8OvLhfu9w2+XVm4/VzwVXBlXi/
         ePcJ9L7fKUMUVfKqgsRcpPyfoo4x7Yf+uDqQxmczwpS91daV1RBM1F7mKJibHq2Vih
         e7+zD+GDxLi/rdKBOoUE5DTTesnmH36wnqcAOWr4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220120193625epcas5p42f7342df310fd0fece0934b5983d8033~MEanLxz6l1365513655epcas5p4h;
        Thu, 20 Jan 2022 19:36:25 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Jft6W5F79z4x9Pp; Thu, 20 Jan
        2022 19:36:19 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.AE.06423.3B9B9E16; Fri, 21 Jan 2022 04:36:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220120193618epcas5p45be1db500363072e647bf179623f8e7a~MEag_DhCT1365513655epcas5p4b;
        Thu, 20 Jan 2022 19:36:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220120193618epsmtrp2a4df038168af578aa4bf80e3f5c76761~MEag9Oav51490214902epsmtrp2y;
        Thu, 20 Jan 2022 19:36:18 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-71-61e9b9b37dd3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.94.08738.2B9B9E16; Fri, 21 Jan 2022 04:36:18 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220120193615epsmtip2fc87e94d71c8d3de74d5ba2ef83379ae~MEaeRpWqj1544215442epsmtip2F;
        Thu, 20 Jan 2022 19:36:15 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Aswani Reddy <aswani.reddy@samsung.com>
Subject: [PATCH v2 2/3] spi: s3c64xx: Add spi port configuration for Tesla
 FSD SoC
Date:   Fri, 21 Jan 2022 00:54:37 +0530
Message-Id: <20220120192438.25555-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120192438.25555-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTS3fzzpeJBu8vaFs8mLeNzWLxj+dM
        Foc2b2W3mPrwCZvF/CPnWC02vv3BZDHlz3Imi02Pr7FaPHwVbnF51xw2ixnn9zFZNH68yW6x
        aOsXdovWvUfYHfg8ZjX0snlcX/KJ2WPTqk42jzvX9rB5bF5S79G3ZRWjx7+muewenzfJBXBE
        ZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2tpFCW
        mFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO
        2PFxN1PBXa6K7X+b2RsYf3J0MXJwSAiYSEy6JNDFyMUhJLCbUWLbnAtMEM4nRokNDVMZIZzP
        jBLT3+xl72LkBOv4fu4oVNUuRonHjxeyQjgtTBJfd84Hq2IT0Ja4O30LE4gtIuAmcaOxA6yD
        WeAOk8SL5z/BEsICIRJHLnWzgNgsAqoSu8/tZAOxeQVsJDYe+8wIsU5eYvWGA8wgNqeArcT3
        xz/AbpIQ6OWQ2L/jAdRNLhLNnU1MELawxKvjW6DiUhKf3+1lg/g0W6JnlzFEuEZi6bxjLBC2
        vcSBK3NYQEqYBTQl1u/SBwkzC/BJ9P5+wgTRySvR0SYEUa0q0fzuKlSntMTE7m5WCNtDYtvU
        P2yQcJjAKLFzTS/zBEbZWQhTFzAyrmKUTC0ozk1PLTYtMMxLLYdHVHJ+7iZGcGrU8tzBePfB
        B71DjEwcjIcYJTiYlUR4peqfJQrxpiRWVqUW5ccXleakFh9iNAUG2URmKdHkfGByziuJNzSx
        NDAxMzMzsTQ2M1QS5z2dviFRSCA9sSQ1OzW1ILUIpo+Jg1Oqganlc6GuQNMbnux3HVtb4uLt
        jK0O7LtmMtt5/4SEoDTB9hrPM/s4fL8Fc5b9i25gsovS59OZcDvZe9ZZkTgOzoB36yx0cxnW
        fu60T2JN2vP6rrsH7++Hu/ckZVa+SeDybGl8k2VicGRW8431NfXJK0pu2a8oSskISHFIfjdn
        T/GTBe+V5lwviji49cCX4OWd/EwL32tK3f523d5YZfq8OpPUMj7FC3eY0t8nVS4y6RS7c/V2
        MdtFlquyJY3GjZYXLrp+uJX26+EDWcVjMbIbwrgezawJOrEvcqXuDMNW4bvc8fvifKYsLRbU
        jjhR12WUrZPBFvcmxD/D8OyNPZ8VLPL9pjMk3d6wfFXUC/8AJZbijERDLeai4kQAUEuX2xYE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSvO6mnS8TDZZ38ls8mLeNzWLxj+dM
        Foc2b2W3mPrwCZvF/CPnWC02vv3BZDHlz3Imi02Pr7FaPHwVbnF51xw2ixnn9zFZNH68yW6x
        aOsXdovWvUfYHfg8ZjX0snlcX/KJ2WPTqk42jzvX9rB5bF5S79G3ZRWjx7+muewenzfJBXBE
        cdmkpOZklqUW6dslcGXs+LibqeAuV8X2v83sDYw/OboYOTkkBEwkvp87ytTFyMUhJLCDUWLR
        r2PMEAlpiesbJ7BD2MISK/89Z4coamKSuHZuLRNIgk1AW+Lu9C1gtoiAh0Tbv3tgzcwCL5gk
        ltzOAbGFBYIkVnccZwGxWQRUJXaf28kGYvMK2EhsPPaZEWKBvMTqDQfAejkFbCW+P/4BFhcC
        qnl4fzvzBEa+BYwMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgsNaS2sH455VH/QO
        MTJxMB5ilOBgVhLhlap/lijEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC
        1CKYLBMHp1QDU1PG1B8nmRRtE5evVFm0oYl50pNYcc/cVfa/X6pm6ee5uL2K1K9k4rq2g4tN
        YmPBW0bRz7e/+i28eKP/1vXv5cyPYoLq5s7hqfZbHH7dN+rldln3iIeGbzSKvRg+HQ2O/BK+
        cG3M7YlNjC8u9807/PjUZcVXxlvkPmY/LWBqNPv99uWtmTueGT3j+725MslqSaxmPat674RS
        iWdB8teWHKzfZfmzceXWzSo/uYovd7bVPf7/Nv5bokkrk/oujWVVkRq/+5365X85GOX+WerK
        ov3xxLkkCe33FaIHV7EEqbzg12SuP7fXaNvefqb0CT9VcsUtJL7LF9ycZWMtq/3o68wNjRdU
        bpfE9hrdYL4crsRSnJFoqMVcVJwIAGmqYMjaAgAA
X-CMS-MailID: 20220120193618epcas5p45be1db500363072e647bf179623f8e7a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220120193618epcas5p45be1db500363072e647bf179623f8e7a
References: <20220120192438.25555-1-alim.akhtar@samsung.com>
        <CGME20220120193618epcas5p45be1db500363072e647bf179623f8e7a@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds compatible and port configuration for spi controller
for Tesla Full Self-Driving SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
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

