Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8555748D780
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiAMMXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:23:33 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:21758 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiAMMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:23:24 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220113122323epoutp029e55051cd233a17545caa79b9ee6f62f~J0-iRLfxf2781527815epoutp02n
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:23:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220113122323epoutp029e55051cd233a17545caa79b9ee6f62f~J0-iRLfxf2781527815epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076603;
        bh=D97Zz5YLkcJ684ZcZpEiUyUANpC9RU0rT5t1s5pI0d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Md24NET1fWu7BZrk0WM+/x/fjpcDyZQpx1G3j5qsFTK41va8Ryzg+kzOrEHEjVhQq
         fuLe8MJG9O6fCLxXeiLp6yw1q25UxZtaRIF/nsp4naB5SSxbs+BVXs/41o6P9jwrd9
         o1ht6+M0QUIMFP0ae+GPP0sCgrRuUQMSHkfVBLMo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220113122322epcas5p2eddf2c054d781992725b2de8589c6887~J0-hbUGLW2479424794epcas5p2G;
        Thu, 13 Jan 2022 12:23:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZNr60J36z4x9Px; Thu, 13 Jan
        2022 12:23:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.31.05590.5B910E16; Thu, 13 Jan 2022 21:23:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220113122317epcas5p11937078e2701b319a13b29e044224ec0~J0-cX-7b21610816108epcas5p1I;
        Thu, 13 Jan 2022 12:23:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122317epsmtrp140cbc22710eda4766de4972b07f38e48~J0-cVANII1911119111epsmtrp1b;
        Thu, 13 Jan 2022 12:23:17 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-86-61e019b5a8dd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.99.08738.4B910E16; Thu, 13 Jan 2022 21:23:16 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122314epsmtip23e1b8747bd33638d73f8c8d98404bb32~J0-aEJDBH1245812458epsmtip2g;
        Thu, 13 Jan 2022 12:23:14 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com
Subject: [PATCH 02/23] dt-bindings: clock: Add bindings definitions for FSD
 CMU blocks
Date:   Thu, 13 Jan 2022 17:41:22 +0530
Message-Id: <20220113121143.22280-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTQ3er5INEg/+HlSwezNvGZvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdq8fBVuMXlXXPYLGac38dkcer6ZzaLRVu/sFu0
        7j3CbnH4TTurxePrf9gc+D3WzFvD6DGroZfNY9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/
        muaye3zeJBfAGZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIT
        oOuWmQP0gJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XE
        ytDAwMgUqDAhO2PLlktsBa/1K65uWsTUwHhJvYuRk0NCwERiwZMlzF2MXBxCArsZJW51vGKH
        cD4xSvxfvoMFpEpI4DOjxLteTpiOMxOeQXXsYpR49WAyK0RRC5NE6zpHEJtNQFvi7vQtTCC2
        iICbxI3GDiaQBmaBe0wSPw43MIMkhAUiJBadXcsOYrMIqErc3vMCLM4rYCOx8epNZoht8hKr
        NxwAsjk4OAVsJe6uygOZIyEwl0Ni16teRogaF4nzl+4zQdjCEq+Ob2GHsKUkXva3sYP0Sghk
        S/TsMoYI10gsnXeMBcK2lzhwZQ4LSAmzgKbE+l36IGFmAT6J3t9PmCA6eSU62oQgqlUlmt9d
        heqUlpjY3c0KYXtIvJv9BxoKExgllk50m8AoOwth6AJGxlWMkqkFxbnpqcWmBcZ5qeXwWErO
        z93ECE6UWt47GB89+KB3iJGJg/EQowQHs5IIb3/R/UQh3pTEyqrUovz4otKc1OJDjKbAAJvI
        LCWanA9M1Xkl8YYmlgYmZmZmJpbGZoZK4ryn0jckCgmkJ5akZqemFqQWwfQxcXBKNTAVVL9w
        443rKwtd/I9LwC9jBz9T/+zv3nJiFzdrHO/guC654W3+yl8HM9tXrHBmnLDVTMw+0VEuZudt
        5tRG1e/5yaEy6fYGHMGrrjjcU1K57PzMc2rh1gXBm/fcEUmuFjGYds7HqX92Qkmg2tGV+VHh
        hq9Ot0/ZP/v1hHlBR09x8SlszfK5eG/JRBXdrbt/HsniUnl+5yyL+vxVyWtP3VvVZvREdIOB
        a4dRgKM6V/nZGTpmay9NSZ345/X6ADe+KnXej35ZTyZ8tbhseb74HYOuoca19j+HsqqeXN9q
        mbNVju+M6tL1Kztnz/cV8H97NO1Y5WOFT4pTnpXoPenO3GC5SUjk8879Zu66Ta27d7srsRRn
        JBpqMRcVJwIAsYYXfx0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvO4WyQeJBvc6DCwezNvGZvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdq8fBVuMXlXXPYLGac38dkcer6ZzaLRVu/sFu0
        7j3CbnH4TTurxePrf9gc+D3WzFvD6DGroZfNY9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/
        muaye3zeJBfAGcVlk5Kak1mWWqRvl8CVsWXLJbaC1/oVVzctYmpgvKTexcjJISFgInFmwjPm
        LkYuDiGBHYwSj083MEEkpCWub5zADmELS6z895wdoqiJSeL/w16wIjYBbYm707eA2SICHhJt
        /+6BTWIWeANUdH8OSxcjB4ewQJjE/UZ5kBoWAVWJ23teMIPYvAI2Ehuv3mSGWCAvsXrDAWaQ
        ck4BW4m7q/JAwkJAJederWebwMi3gJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZG
        cKBrae1g3LPqg94hRiYOxkOMEhzMSiK8/UX3E4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6
        GS8kkJ5YkpqdmlqQWgSTZeLglGpg4mSqeLmY5fKlJQ0TZFybqq7GbswSLz/f9exz9c+HmTeb
        Hl31+BD7qyivNdyJybR3c3LR55qF60wXNv40rJucv9tBc82Rl2/tlhbvsXeTPj+xY+uqbR9m
        GCharntiFTvH9/v/k3aTDz70qrQuN69jK5djU3u/eVpkYPZ2259fuTbeNFGR5k9P5dY2mG1t
        n5T9Lyjh+58+lg/pXTOLXjwq+XYlZevmzPZoIakLzxaUMVje9XK1K7p6daL31uOrWIP52yTn
        N93aJ6552/D1DW9twZfVua9U1O6Kaf/11itMY2c0M+v6WvgrreqTnbJV/ialJ2GPmENmcZfP
        zvjr8sZ5t3JVb5V08ldZl6qqj7ZKLMUZiYZazEXFiQCBsnzi4wIAAA==
X-CMS-MailID: 20220113122317epcas5p11937078e2701b319a13b29e044224ec0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122317epcas5p11937078e2701b319a13b29e044224ec0
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122317epcas5p11937078e2701b319a13b29e044224ec0@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock controller driver of FSD platform is designed to have separate
instances for each particular CMU. So clock IDs in this bindings header
also start from 1 for each CMU block.

Cc: linux-fsd@tesla.com
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 include/dt-bindings/clock/fsd-clk.h | 146 ++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 include/dt-bindings/clock/fsd-clk.h

diff --git a/include/dt-bindings/clock/fsd-clk.h b/include/dt-bindings/clock/fsd-clk.h
new file mode 100644
index 000000000000..9b97417ea6a1
--- /dev/null
+++ b/include/dt-bindings/clock/fsd-clk.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017 - 2022: Samsung Electronics Co., Ltd.
+ *             https://www.samsung.com
+ * Copyright (c) 2017-2022 Tesla, Inc.
+ *             https://www.tesla.com
+ *
+ * The constants defined in this header are being used in dts
+ * and fsd platform driver.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_FSD_H
+#define _DT_BINDINGS_CLOCK_FSD_H
+
+/* CMU */
+#define DOUT_CMU_PLL_SHARED0_DIV4		1
+#define DOUT_CMU_PERIC_SHARED1DIV36		2
+#define DOUT_CMU_PERIC_SHARED0DIV3_TBUCLK	3
+#define DOUT_CMU_PERIC_SHARED0DIV20		4
+#define DOUT_CMU_PERIC_SHARED1DIV4_DMACLK	5
+#define DOUT_CMU_PLL_SHARED0_DIV6		6
+#define DOUT_CMU_FSYS0_SHARED1DIV4		7
+#define DOUT_CMU_FSYS0_SHARED0DIV4		8
+#define DOUT_CMU_FSYS1_SHARED0DIV8		9
+#define DOUT_CMU_FSYS1_SHARED0DIV4		10
+#define CMU_CPUCL_SWITCH_GATE			11
+#define DOUT_CMU_IMEM_TCUCLK			12
+#define DOUT_CMU_IMEM_ACLK			13
+#define DOUT_CMU_IMEM_DMACLK			14
+#define GAT_CMU_FSYS0_SHARED0DIV4		15
+#define CMU_NR_CLK				16
+
+/* PERIC */
+#define PERIC_SCLK_UART0			1
+#define PERIC_PCLK_UART0			2
+#define PERIC_SCLK_UART1			3
+#define PERIC_PCLK_UART1			4
+#define PERIC_DMA0_IPCLKPORT_ACLK		5
+#define PERIC_DMA1_IPCLKPORT_ACLK		6
+#define PERIC_PWM0_IPCLKPORT_I_PCLK_S0		7
+#define PERIC_PWM1_IPCLKPORT_I_PCLK_S0		8
+#define PERIC_PCLK_SPI0                         9
+#define PERIC_SCLK_SPI0                         10
+#define PERIC_PCLK_SPI1                         11
+#define PERIC_SCLK_SPI1                         12
+#define PERIC_PCLK_SPI2                         13
+#define PERIC_SCLK_SPI2                         14
+#define PERIC_PCLK_TDM0                         15
+#define PERIC_PCLK_HSI2C0			16
+#define PERIC_PCLK_HSI2C1			17
+#define PERIC_PCLK_HSI2C2			18
+#define PERIC_PCLK_HSI2C3			19
+#define PERIC_PCLK_HSI2C4			20
+#define PERIC_PCLK_HSI2C5			21
+#define PERIC_PCLK_HSI2C6			22
+#define PERIC_PCLK_HSI2C7			23
+#define PERIC_MCAN0_IPCLKPORT_CCLK		24
+#define PERIC_MCAN0_IPCLKPORT_PCLK		25
+#define PERIC_MCAN1_IPCLKPORT_CCLK		26
+#define PERIC_MCAN1_IPCLKPORT_PCLK		27
+#define PERIC_MCAN2_IPCLKPORT_CCLK		28
+#define PERIC_MCAN2_IPCLKPORT_PCLK		29
+#define PERIC_MCAN3_IPCLKPORT_CCLK		30
+#define PERIC_MCAN3_IPCLKPORT_PCLK		31
+#define PERIC_PCLK_ADCIF			32
+#define PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I  33
+#define PERIC_EQOS_TOP_IPCLKPORT_ACLK_I		34
+#define PERIC_EQOS_TOP_IPCLKPORT_HCLK_I		35
+#define PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_I	36
+#define PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I	37
+#define PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK	38
+#define PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK	39
+#define PERIC_HCLK_TDM0				40
+#define PERIC_PCLK_TDM1				41
+#define PERIC_HCLK_TDM1				42
+#define PERIC_EQOS_PHYRXCLK_MUX			43
+#define PERIC_EQOS_PHYRXCLK			44
+#define PERIC_DOUT_RGMII_CLK			45
+#define PERIC_NR_CLK				46
+
+/* FSYS0 */
+#define UFS0_MPHY_REFCLK_IXTAL24		1
+#define UFS0_MPHY_REFCLK_IXTAL26		2
+#define UFS1_MPHY_REFCLK_IXTAL24		3
+#define UFS1_MPHY_REFCLK_IXTAL26		4
+#define UFS0_TOP0_HCLK_BUS			5
+#define UFS0_TOP0_ACLK				6
+#define UFS0_TOP0_CLK_UNIPRO			7
+#define UFS0_TOP0_FMP_CLK			8
+#define UFS1_TOP1_HCLK_BUS			9
+#define UFS1_TOP1_ACLK				10
+#define UFS1_TOP1_CLK_UNIPRO			11
+#define UFS1_TOP1_FMP_CLK			12
+#define PCIE_SUBCTRL_INST0_DBI_ACLK_SOC		13
+#define PCIE_SUBCTRL_INST0_AUX_CLK_SOC		14
+#define PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC	15
+#define PCIE_SUBCTRL_INST0_SLV_ACLK_SOC		16
+#define FSYS0_EQOS_TOP0_IPCLKPORT_CLK_PTP_REF_I 17
+#define FSYS0_EQOS_TOP0_IPCLKPORT_ACLK_I	18
+#define FSYS0_EQOS_TOP0_IPCLKPORT_HCLK_I	19
+#define FSYS0_EQOS_TOP0_IPCLKPORT_RGMII_CLK_I	20
+#define FSYS0_EQOS_TOP0_IPCLKPORT_CLK_RX_I	21
+#define FSYS0_DOUT_FSYS0_PERIBUS_GRP		22
+#define FSYS0_NR_CLK				23
+
+/* FSYS1 */
+#define PCIE_LINK0_IPCLKPORT_DBI_ACLK		1
+#define PCIE_LINK0_IPCLKPORT_AUX_ACLK		2
+#define PCIE_LINK0_IPCLKPORT_MSTR_ACLK		3
+#define PCIE_LINK0_IPCLKPORT_SLV_ACLK		4
+#define PCIE_LINK1_IPCLKPORT_DBI_ACLK		5
+#define PCIE_LINK1_IPCLKPORT_AUX_ACLK		6
+#define PCIE_LINK1_IPCLKPORT_MSTR_ACLK		7
+#define PCIE_LINK1_IPCLKPORT_SLV_ACLK		8
+#define FSYS1_NR_CLK				9
+
+/* IMEM */
+#define IMEM_DMA0_IPCLKPORT_ACLK		1
+#define IMEM_DMA1_IPCLKPORT_ACLK		2
+#define IMEM_WDT0_IPCLKPORT_PCLK		3
+#define IMEM_WDT1_IPCLKPORT_PCLK		4
+#define IMEM_WDT2_IPCLKPORT_PCLK		5
+#define IMEM_MCT_PCLK				6
+#define IMEM_TMU_CPU0_IPCLKPORT_I_CLK_TS	7
+#define IMEM_TMU_CPU2_IPCLKPORT_I_CLK_TS	8
+#define IMEM_TMU_TOP_IPCLKPORT_I_CLK_TS		9
+#define IMEM_TMU_GPU_IPCLKPORT_I_CLK_TS		10
+#define IMEM_TMU_GT_IPCLKPORT_I_CLK_TS		11
+#define IMEM_NR_CLK				12
+
+/* MFC */
+#define MFC_MFC_IPCLKPORT_ACLK			1
+#define MFC_NR_CLK				2
+
+/* CAM_CSI */
+#define CAM_CSI0_0_IPCLKPORT_I_ACLK		1
+#define CAM_CSI0_1_IPCLKPORT_I_ACLK		2
+#define CAM_CSI0_2_IPCLKPORT_I_ACLK		3
+#define CAM_CSI0_3_IPCLKPORT_I_ACLK		4
+#define CAM_CSI1_0_IPCLKPORT_I_ACLK		5
+#define CAM_CSI1_1_IPCLKPORT_I_ACLK		6
+#define CAM_CSI1_2_IPCLKPORT_I_ACLK		7
+#define CAM_CSI1_3_IPCLKPORT_I_ACLK		8
+#define CAM_CSI2_0_IPCLKPORT_I_ACLK		9
+#define CAM_CSI2_1_IPCLKPORT_I_ACLK		10
+#define CAM_CSI2_2_IPCLKPORT_I_ACLK		11
+#define CAM_CSI2_3_IPCLKPORT_I_ACLK		12
+#define CAM_CSI_NR_CLK				13
+#endif /* _DT_BINDINGS_CLOCK_FSD_H */
-- 
2.17.1

