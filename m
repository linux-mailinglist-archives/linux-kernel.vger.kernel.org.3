Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E452A49822D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbiAXO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:29:14 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:41748 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbiAXO3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:10 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220124142908epoutp0392206b3c3d0bad6761d58a90132bf309~NOzeOAJUO1227112271epoutp03X
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:29:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220124142908epoutp0392206b3c3d0bad6761d58a90132bf309~NOzeOAJUO1227112271epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034548;
        bh=Wox9HhWlqAWShRtdff4J3Oc6FxlUrzsyevoAhlB4FMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjMfx68sdQn4Oy0CFMkjcd9kK6EdqoJzFIhwUMW72xY1oeJGvTdhOpO7uTuzFA1lI
         PDGGTo7Noij7lJTclS680mf6il5pnN/i6QITFog4+rXpWspCuuYZG1aPNSdDNsqlgb
         MtNUQccGQQakUIkjcFGEiHmij6LxoeH96F7ZW/a4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220124142907epcas5p4749747ae1cc204972ee9693c63279a09~NOzdTah040105201052epcas5p4Y;
        Mon, 24 Jan 2022 14:29:07 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JjC665nw0z4x9Pq; Mon, 24 Jan
        2022 14:29:02 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.4D.46822.156BEE16; Mon, 24 Jan 2022 23:23:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220124142901epcas5p3776232af7911abfbf08d82358350f57c~NOzXf6rCw0627306273epcas5p3N;
        Mon, 24 Jan 2022 14:29:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220124142901epsmtrp2675f9994b0ee7cc9eaa96339cd4455ed~NOzXetx8c1656816568epsmtrp2p;
        Mon, 24 Jan 2022 14:29:01 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-f5-61eeb651914c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.DA.29871.DA7BEE16; Mon, 24 Jan 2022 23:29:01 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142858epsmtip1088e2e28d0ba0764055ccce47b6d35e0~NOzUuW0jA0831608316epsmtip1e;
        Mon, 24 Jan 2022 14:28:58 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v5 02/16] dt-bindings: clock: Add bindings definitions for
 FSD CMU blocks
Date:   Mon, 24 Jan 2022 19:46:30 +0530
Message-Id: <20220124141644.71052-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfUwbdRje79peD1zNrYzwAxXJRVC2QCkr3TFBUZHcPhLBxcw5M7yVS9v0
        016ZwkyEsbkBZQLOCBvDbQymtYZCGTZ8ibRjhplqItC54bLZCRkyOmnF0iGztEz/e573fZ73
        zfuBcYQtaAKm1BoZg5ZWE2g0t9eR+lxaUe88nRHsSCJvtfai5D+No3zS22EC5OdOF4/suhdA
        yJPLFxGy2zPJI/803eSRt2f3kD/3taBk049DCDnm9qHk+Ut+Pnl00MknHXPHeOTKZBeX9LiX
        0bwNlKXVAqgHwUZAnaqoQ6luczVKTU0OoJTtwofU+PeHedSJHjOgVg6f4VO+7sTC6LdUOQqG
        LmEMSYxWpitRauW5xM7dxa8UZ0kzxGnibHIrkaSlNUwukb+rMK1AqQ7NQyQdpNWloVAhzbKE
        6IUcg67UyCQpdKwxl2D0JWq9RJ/O0hq2VCtP1zLGbeKMjMyskPAdlaI52M/VW8Xvj/mcoAJU
        ptaAKAziEni5/SqoAdGYEO8H8OGNem6ELADoXXHzImQRwGZHL++RZSq4gEQSgwC6fHZ+hBxB
        4GhwJqxC8c3w1896kFW8ES+A1yqPhx0c/CECu0wd6GoiBt8H7Z9aOKuYiyfDroErYbMAz4F+
        xx8g0u5p+JV1OKyJwnNh67nFcCGI2zHYZJtZE+VD1/2/13AMnL3Sw4/gBOibHww1w0JYBU19
        WyLhD2B76yg3gl+Ew+Mt3FUJB0+FnX2i1TAHfxzWPbiDRJwCePwjYUSdDKvmJ9acT8CG2tq1
        pVBw0D8dnkqI1wNY852mHjx16v+iZwEwg3hGz2rkDJulz9Qy7/13KJlO0w3Cb7pphx3cvnU/
        fQQgGBgBEOMQGwXlJfO0UFBCl5UzBl2xoVTNsCMgK7SxBk5CrEwX+nOtsVgsyc6QSKVSSfYW
        qZiIE1yVW2khLqeNjIph9IzhkQ/BohIqkCFvzO+Wia7nXdfj21Z4zqWyvCwdWnS2jdu5Oc6z
        3y+Lsx9RHsoe9pDb81+bKsr2WDMrrMvzjszr57y2a7Hui4nSL3+YuVl5wmJeUO3dJ1NJLrwb
        u4gFXhft2n7g5FKbsboqgNydhh32J9/GTOVDbV/n3HipnR1dN4cxY9NbUxK8zb6jncqy9VXb
        Dp2u3RMdnzg20CjxjJf30zp0ZJ1N/FdyvtV+z+N6+Vn/8rGAe6jyzQN13+wM2PbvNfvKpwoe
        qwrkNYhSan3pIv30xwfdrU2zKfGXL52eWL+bCJ5XJ377y7JzycSj7rzx2xef/CSci5IPqxUx
        dxurXq3O0z7DH9hBcFkFLd7EMbD0vzLZl1MvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnO7a7e8SDZ62y1o8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8bMX7tZCjYYVpz6fISx
        gbFRs4uRk0NCwETizq9PTF2MXBxCArsZJd78aGOGSEhLXN84gR3CFpZY+e85O0RRE5PEgn+v
        WEESbALaEnenb2ECsUUEPCTa/t1jBiliFpjILLFx71kWkISwQKTE/KWfGEFsFgFViY17joM1
        8wrYSHw5/JoRYoO8xOoNB8A2cwrYSsxb+A1oKAfQNhuJc79VJjDyLWBkWMUomVpQnJueW2xY
        YJiXWq5XnJhbXJqXrpecn7uJERwJWpo7GLev+qB3iJGJg/EQowQHs5IIb1XKu0Qh3pTEyqrU
        ovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamBr++JeVck9j8JN8Hr8g
        egJLy2xrmchXHoYTJl09wKXxpXQe/+5b1v4P/lYriV+OT15pIb1/v9HGmCploZXTf0f+eRPh
        t/7Z7yoRZsdVHt1KWjzeKhOU068qzUyPEzV4s3eGULK8ncyPhQuPvbm8s3jrtkmlPoYlPtOq
        RRqiZ906aay84srNuXpSZxKK5O459Rr56vyTchU5+uPx1LjAwsUzGPYsPP/QJq/o1ezuevsU
        X910DS7u2tcTOZ5/2lue+e9fz/T4nYXzRO82a72JvXxca8bzih47vwoOTUWbpHXKH2S+PvP7
        f+SYwBO/vcJ7F3z58074QGhdasjsOMdix6M2Qu+OFu2rfb4o3qksRomlOCPRUIu5qDgRAO5D
        czbzAgAA
X-CMS-MailID: 20220124142901epcas5p3776232af7911abfbf08d82358350f57c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142901epcas5p3776232af7911abfbf08d82358350f57c
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142901epcas5p3776232af7911abfbf08d82358350f57c@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock controller driver of FSD platform is designed to have separate
instances for each particular CMU. So clock IDs in this bindings header
also start from 1 for each CMU block.

Cc: linux-fsd@tesla.com
Reported-by: kernel test robot <lkp@intel.com>
[robot: reported missing #endif]
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 include/dt-bindings/clock/fsd-clk.h | 150 ++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 include/dt-bindings/clock/fsd-clk.h

diff --git a/include/dt-bindings/clock/fsd-clk.h b/include/dt-bindings/clock/fsd-clk.h
new file mode 100644
index 000000000000..c8a2af1dd1ad
--- /dev/null
+++ b/include/dt-bindings/clock/fsd-clk.h
@@ -0,0 +1,150 @@
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
+
+#endif /*_DT_BINDINGS_CLOCK_FSD_H */
-- 
2.25.1

