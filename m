Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487D3492914
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbiARPAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:00:32 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:28752 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbiARPA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:00:28 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220118150024epoutp01ef329b69e60af6f75d66da683cb88978~LZXDxU-5S3081430814epoutp01Q
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:00:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220118150024epoutp01ef329b69e60af6f75d66da683cb88978~LZXDxU-5S3081430814epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518024;
        bh=gIgOs3qkNFVngN84VQCU5xEu0J1z72BFtbLmQ4rbJ0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nPgUZTb4M9KTCwg0HEcoByL/nMehoY0Ve84lu5Ods7wa1i/FJo+3OijE/9HJl7+vQ
         JB09oIcb53NkzOmOrBpvI9uyG+n9gqi0tjyNjxMAxYB49bx2X7jvnSRNCemNTOgcp1
         zmtpmnNniPOU/eR0ee+N5bHXv8n1Eqs6r///fw2s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220118150024epcas5p3d62f33172e77b295707867e83fdc7dd7~LZXDGMU4o2328723287epcas5p39;
        Tue, 18 Jan 2022 15:00:24 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JdX4z2Klpz4x9Pr; Tue, 18 Jan
        2022 15:00:19 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.09.06423.306D6E16; Wed, 19 Jan 2022 00:00:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220118150018epcas5p32642af7af63869d08a861d00d97e3b68~LZW9cBbbJ2789827898epcas5p3A;
        Tue, 18 Jan 2022 15:00:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220118150018epsmtrp194bcdd1e3b79eb14ecdcf9422234bc17~LZW9bFVjL1945719457epsmtrp1v;
        Tue, 18 Jan 2022 15:00:18 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-fb-61e6d60301a3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.91.29871.106D6E16; Wed, 19 Jan 2022 00:00:18 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150015epsmtip1b7a181a5da71f944adc1b6afabbf296c~LZW7KwnDs0761107611epsmtip1U;
        Tue, 18 Jan 2022 15:00:15 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com
Subject: [PATCH v2 02/16] dt-bindings: clock: Add bindings definitions for
 FSD CMU blocks
Date:   Tue, 18 Jan 2022 20:18:37 +0530
Message-Id: <20220118144851.69537-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmpi7ztWeJBlt38ls8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNaPL7+h81BwGPNvDWMHr9/TWL0mNXQy+axaVUnm8eda3vYPDYvqfe4
        cqKJ1aNvyypGj39Nc9k9Pm+SC+CKyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBX
        nJhbXJqXrpeXWmJlaGBgZApUmJCd8e7mc/aCPQYVX0+vYm5gnKnRxcjJISFgIrGtew07iC0k
        sJtRovVrXRcjF5D9iVFi2+0vbBDON0aJPXdPM3cxcoB1fHsSDRHfyyixdOMuqO4WJolNE8JA
        bDYBbYm707cwgdgiAm4SNxo7mEAamAXeMklM3/edDSQhLBAtsfj5QkYQm0VAVaKjaSXYIF4B
        G4n97YvZIc6Tl1i94QAziM0pYCsxtWEq2EUSAls4JLZ/+MQCUeQisfvxOTYIW1ji1fEtUM1S
        Ei/729ghrs6W6NllDBGukVg67xhUq73EgStzWEBKmAU0Jdbv0gcJMwvwSfT+fsIE0ckr0dEm
        BFGtKtH87ipUp7TExO5uVgjbQ+L4hz5mSDBMYJR41Ok5gVF2FsLQBYyMqxglUwuKc9NTi00L
        DPNSy+GxlJyfu4kRnDy1PHcw3n3wQe8QIxMH4yFGCQ5mJRFeqfpniUK8KYmVValF+fFFpTmp
        xYcYTYEhNpFZSjQ5H5i+80riDU0sDUzMzMxMLI3NDJXEeU+nb0gUEkhPLEnNTk0tSC2C6WPi
        4JRqYFq6tNczW27Nw27jXoHCb60p3y6VX6+Yv0x/6e55Bt21n7Yc3MNZyKu81/BoqCP3s/X7
        C3Qudhnwx5e5yJpIuzf7szHmivVGM026F7Xe4NnWKR9vhdSJMk2T6Ne+7RH3+t4LcZ7LrDI7
        7e9vN1QKskjcNt+v03DRFatnl6qa1gds0LKa3fBR/8esO066W3nP+yokOMtfOiq4qLtM/GxR
        3Hrz4Mv6y8KSc+xuz2NNSGj8dvKebrODpu2W3jQNprvJ9rtdGEWVxFkvP71+haVuN0P//fnB
        bpoK03s1i080T/bL0zvZtnyy6f4dZyI71BVntSfapH+ZXMqwKmBfdSgPo8DTtd531zEU67oy
        3T2kxFKckWioxVxUnAgAHhh5SScEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnC7TtWeJBtdmMlo8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNaPL7+h81BwGPNvDWMHr9/TWL0mNXQy+axaVUnm8eda3vYPDYvqfe4
        cqKJ1aNvyypGj39Nc9k9Pm+SC+CK4rJJSc3JLEst0rdL4Mp4d/M5e8Eeg4qvp1cxNzDO1Ohi
        5OCQEDCR+PYkuouRi0NIYDejxJKjK5m6GDmB4tIS1zdOYIewhSVW/nvODlHUxCTx/v8esASb
        gLbE3elbwBpEBDwk2v7dYwYpYhb4yyTx9fVDRpCEsECkxNZTD5lBbBYBVYmOppVgzbwCNhL7
        2xdDbZCXWL3hAFgNp4CtxNSGqWwgthBQzcWV05gnMPItYGRYxSiZWlCcm55bbFhgmJdarlec
        mFtcmpeul5yfu4kRHP5amjsYt6/6oHeIkYmD8RCjBAezkgivVP2zRCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYJq6tUrF8Xj0l/POp6XveW36bZqC8
        5p6Nj/gPVklprugGgaO3J1UdD4i+k/L01cION0vTPQ9Zj7GvezS/5IC/5dyiSX8CV5yffiU1
        heFu/LR9f15+Dfp63UTa5lr7RyVe/yeK7V2Rq54YFrRfnWq08n3znAvFSnm9h/LlnrMWLQ2Z
        aNBW3Fp7YW3IrO+nNh5gP2V0Y/l0hu9izJIHTkt+eRco8qRVMSRm8WsXzSMsF/1/vvCVufC7
        t9/h0lzfxc7n0jS4Fv+Qub3297P7XzbZPWeYN6GKzeWA4P6ly+2fXt1jxFLRvrtpy5ICNiOe
        +11RJ3XNutot91296Hb1rojmZh91vYAFk2T3187k80r78UWJpTgj0VCLuag4EQA0L9B27gIA
        AA==
X-CMS-MailID: 20220118150018epcas5p32642af7af63869d08a861d00d97e3b68
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150018epcas5p32642af7af63869d08a861d00d97e3b68
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150018epcas5p32642af7af63869d08a861d00d97e3b68@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock controller driver of FSD platform is designed to have separate
instances for each particular CMU. So clock IDs in this bindings header
also start from 1 for each CMU block.

Cc: linux-fsd@tesla.com
Reported-by: kernel test robot <lkp@intel.com>
[robot: reported missing #endif]
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 include/dt-bindings/clock/fsd-clk.h | 149 ++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 include/dt-bindings/clock/fsd-clk.h

diff --git a/include/dt-bindings/clock/fsd-clk.h b/include/dt-bindings/clock/fsd-clk.h
new file mode 100644
index 000000000000..8cf45d2430b0
--- /dev/null
+++ b/include/dt-bindings/clock/fsd-clk.h
@@ -0,0 +1,149 @@
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
+#endif /*_DT_BINDINGS_CLOCK_FSD_H */
-- 
2.25.1

