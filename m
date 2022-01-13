Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C78E48D7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiAMMYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:24:24 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:33867 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiAMMYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:05 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220113122404epoutp0108134d737bf228d0ce4d637c236294fa~J1AIV_3M31887018870epoutp015
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:24:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220113122404epoutp0108134d737bf228d0ce4d637c236294fa~J1AIV_3M31887018870epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076644;
        bh=mmh5VRk/Dl9IQw+U5cIxsY0TlsOQzZEFLN9GUflgjf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EAbek/2Ow39qVtShnXqonZfQIvqP07JQVx5yMPH3KAQnBPVvTSGWM23FxuUDBu9iq
         ft+lu3rz8N5l0JmMWeqHvFhMwprN7ayrqdNHwHumXmpULJxCuuS1lKzu1/OA7s5i2d
         GfeyX+K03vSJvVsXslMcT658b1z+W3dxCm3jIfHs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220113122404epcas5p1279cf6cef52d26c7c5afeb8836e3f7e2~J1AH7kFcy2652426524epcas5p1B;
        Thu, 13 Jan 2022 12:24:04 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZNrw6gWXz4x9Q6; Thu, 13 Jan
        2022 12:24:00 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.11.46822.0E910E16; Thu, 13 Jan 2022 21:24:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220113122400epcas5p34363ba8f477b4c273d601d0b64324afa~J1AEOlJUB2339223392epcas5p3y;
        Thu, 13 Jan 2022 12:24:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122400epsmtrp1bb5dd1f8bb669c6da92e08696df7cada~J1AENAUvo1911119111epsmtrp1N;
        Thu, 13 Jan 2022 12:24:00 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-6d-61e019e0600b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.A9.08738.FD910E16; Thu, 13 Jan 2022 21:23:59 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122356epsmtip2f3a3294d6d6b19894d6e7424a91f856a~J1AAdgRU01245812458epsmtip2p;
        Thu, 13 Jan 2022 12:23:55 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH 11/23] pinctrl: samsung: add FSD SoC specific data
Date:   Thu, 13 Jan 2022 17:41:31 +0530
Message-Id: <20220113121143.22280-12-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmlu4DyQeJBkdX2VgceH+QxeLBvG1s
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNaPL7+h81BwGPNvDWMHrMaetk8Nq3qZPO4c20Pm8fmJfUeV040sXr0
        bVnF6PGvaS67x+dNcgGcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5
        qbZKLj4Bum6ZOUBfKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz
        0vXyUkusDA0MjEyBChOyMw6smMtScEajonfHNPYGxunKXYycHBICJhKzfv9g7WLk4hAS2M0o
        cWDDbmYI5xOjxL/+5UwQzmdGiY2zFjDCtDzq3gzVsotRYt776+wgCSGBFiaJL6dkQWw2AW2J
        u9O3MIHYIgJuEjcaO8AmMQu0MkvMb93ODJIQFnCS2PHyPRuIzSKgKvH39DmwDbwCthJT+jZB
        bZOXWL3hAFA9BwcnUPzuqjyQORICKzkkzkx/wAJR4yLRfPU9K4QtLPHq+BZ2CFtK4mV/GztI
        r4RAtkTPLmOIcI3E0nnHoFrtJQ5cmcMCUsIsoCmxfpc+SJhZgE+i9/cTJohOXomONiGIalWJ
        5ndXoTqlJSZ2d0Mt9ZD4vqqBBRIkExglNr95zTyBUXYWwtQFjIyrGCVTC4pz01OLTQuM8lLL
        4fGUnJ+7iRGcNrW8djA+fPBB7xAjEwfjIUYJDmYlEd7+ovuJQrwpiZVVqUX58UWlOanFhxhN
        gSE2kVlKNDkfmLjzSuINTSwNTMzMzEwsjc0MlcR5T6dvSBQSSE8sSc1OTS1ILYLpY+LglGpg
        6rsVqsAraFe7Z67Ax2XlSqee6D6sX/Zn88cdc0+JB1Q/k10T1Pen6u61Q1/ZAmfIuhSvrL3d
        9GibeslxlUPNtevF3vbbX5d/NW2JOOMVHreOV8e9PQ7IH16oob3k6f1YLwb+NcX6mparFv94
        U11SmeY+fU7VbdkW42n2cyUuC5q/K9ru3te1ZRHfy53290OeMT57sMJ7v93F4GsPvl3/naOY
        5+6XlasYNK2kMJ+xJ8Ko+IEIo8XNj1m3bkTs8636O3nt0YwdrPxcLHcSM/MjizY1ycqEH19a
        XZpT2597eOka5ycdyQefl/Ty6mtLrZt4bOommZK85GsmLacUqhWDdBTE5R53uV5fdFL6wKkF
        SizFGYmGWsxFxYkAcfvH/SQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSvO59yQeJBiefqFgceH+QxeLBvG1s
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNaPL7+h81BwGPNvDWMHrMaetk8Nq3qZPO4c20Pm8fmJfUeV040sXr0
        bVnF6PGvaS67x+dNcgGcUVw2Kak5mWWpRfp2CVwZB1bMZSk4o1HRu2MaewPjdOUuRk4OCQET
        iUfdm1m7GLk4hAR2MEp07drBBpGQlri+cQI7hC0ssfLfc3aIoiYmial3pjCCJNgEtCXuTt/C
        BGKLCHhItP27xwxSxCwwlVli1YYuZpCEsICTxI6X78GmsgioSvw9fQ6smVfAVmJK3yZGiA3y
        Eqs3HACq5+DgBIrfXZUHEhYSsJE492o92wRGvgWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz
        0vWS83M3MYKDXktrB+OeVR/0DjEycTAeYpTgYFYS4e0vup8oxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9P+veujmV7lW0zMTRfMOL4y+czebMfoFV4Z
        3R/Wi3daz+nZXrqb52KK+u2ZVx/FXNOIes27Kj/3wME3u5o+Wi7q63+df/WEAPu88/b3GDS9
        i3g4+CT+6vtYBW2INmj4+EXC5EdsxofnFkviuxoNbh23W72INyZQwPPZDZat11NeqzTf+b65
        Zcq1I4zZPpPvvYw/YHg+68rLk0eYdi8qPf2z76XGhWu3zlopBTXc/GL7as/ujJRrj6OF2wvL
        BBg6Py7lYGZxEuObcOP38mzlLt/TbCnnJxZsjT8Tcf4Ff5xZ0599DnuOyx+PniHIZPVHffrG
        aUY7zqss6U0wmMG9bI1xxsyjkjVJm6b9OJyZ+S9UiaU4I9FQi7moOBEA+ndbjukCAAA=
X-CMS-MailID: 20220113122400epcas5p34363ba8f477b4c273d601d0b64324afa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122400epcas5p34363ba8f477b4c273d601d0b64324afa
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122400epcas5p34363ba8f477b4c273d601d0b64324afa@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Tesla FSD SoC specific data to enable pinctrl.
FSD SoC has similar pinctrl controller as found in the most
samsung/exynos SoCs.

Cc: linux-fsd@tesla.com
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 71 +++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c     |  2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |  1 +
 3 files changed, 74 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index 6b77fd24571e..b9175b4911ac 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -646,3 +646,74 @@ const struct samsung_pinctrl_of_match_data exynosautov9_of_data __initconst = {
 	.ctrl		= exynosautov9_pin_ctrl,
 	.num_ctrl	= ARRAY_SIZE(exynosautov9_pin_ctrl),
 };
+
+/*
+ * Pinctrl driver data for Tesla FSD SoC. FSD SoC includes three
+ * gpio/pin-mux/pinconfig controllers.
+ */
+
+/* pin banks of FSD pin-controller 0 (FSYS) */
+static const struct samsung_pin_bank_data fsd_pin_banks0[] __initconst = {
+	EXYNOS850_PIN_BANK_EINTG(7, 0x00, "gpf0", 0x00),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x20, "gpf1", 0x04),
+	EXYNOS850_PIN_BANK_EINTG(3, 0x40, "gpf6", 0x08),
+	EXYNOS850_PIN_BANK_EINTG(2, 0x60, "gpf4", 0x0c),
+	EXYNOS850_PIN_BANK_EINTG(6, 0x80, "gpf5", 0x10),
+};
+
+/* pin banks of FSD pin-controller 1 (PERIC) */
+static const struct samsung_pin_bank_data fsd_pin_banks1[] __initconst = {
+	EXYNOS850_PIN_BANK_EINTG(4, 0x000, "gpc8", 0x00),
+	EXYNOS850_PIN_BANK_EINTG(7, 0x020, "gpf2", 0x04),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x040, "gpf3", 0x08),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x060, "gpd0", 0x0c),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x080, "gpb0", 0x10),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x0a0, "gpb1", 0x14),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x0c0, "gpb4", 0x18),
+	EXYNOS850_PIN_BANK_EINTG(4, 0x0e0, "gpb5", 0x1c),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x100, "gpb6", 0x20),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x120, "gpb7", 0x24),
+	EXYNOS850_PIN_BANK_EINTG(5, 0x140, "gpd1", 0x28),
+	EXYNOS850_PIN_BANK_EINTG(5, 0x160, "gpd2", 0x2c),
+	EXYNOS850_PIN_BANK_EINTG(7, 0x180, "gpd3", 0x30),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x1a0, "gpg0", 0x34),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x1c0, "gpg1", 0x38),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x1e0, "gpg2", 0x3c),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x200, "gpg3", 0x40),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x220, "gpg4", 0x44),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x240, "gpg5", 0x48),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x260, "gpg6", 0x4c),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x280, "gpg7", 0x50),
+};
+
+/* pin banks of FSD pin-controller 2 (PMU) */
+static const struct samsung_pin_bank_data fsd_pin_banks2[] __initconst = {
+	EXYNOS850_PIN_BANK_EINTN(3, 0x00, "gpq0"),
+};
+
+const struct samsung_pin_ctrl fsd_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 FSYS0 data */
+		.pin_banks	= fsd_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(fsd_pin_banks0),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 1 PERIC data */
+		.pin_banks	= fsd_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(fsd_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 2 PMU data */
+		.pin_banks	= fsd_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(fsd_pin_banks2),
+	},
+};
+
+const struct samsung_pinctrl_of_match_data fsd_of_data __initconst = {
+	.ctrl		= fsd_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(fsd_pin_ctrl),
+};
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 23f355ae9ca0..4b348c038f7a 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1268,6 +1268,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = &exynos850_of_data },
 	{ .compatible = "samsung,exynosautov9-pinctrl",
 		.data = &exynosautov9_of_data },
+	{ .compatible = "tesla,fsd-pinctrl",
+		.data = &fsd_of_data },
 #endif
 #ifdef CONFIG_PINCTRL_S3C64XX
 	{ .compatible = "samsung,s3c64xx-pinctrl",
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 547968a31aed..43d8a8a139c3 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -341,6 +341,7 @@ extern const struct samsung_pinctrl_of_match_data exynos5433_of_data;
 extern const struct samsung_pinctrl_of_match_data exynos7_of_data;
 extern const struct samsung_pinctrl_of_match_data exynos850_of_data;
 extern const struct samsung_pinctrl_of_match_data exynosautov9_of_data;
+extern const struct samsung_pinctrl_of_match_data fsd_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c64xx_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c2412_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c2416_of_data;
-- 
2.17.1

