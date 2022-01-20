Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D564954FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377519AbiATTgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:36:35 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:35110 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377504AbiATTga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:36:30 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220120193628epoutp048aafd910946b221b065f93254b446028~MEaqmjOPo0363803638epoutp04f
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 19:36:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220120193628epoutp048aafd910946b221b065f93254b446028~MEaqmjOPo0363803638epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642707388;
        bh=sAPYODDmKobS/13ARdP8DagXGjJLIEbBlus+ku63euc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=onrN18kZy7JxGyElUrtg3rRVGFttnAp8Gyqo4sXR5uWGn9lZ3ZulUIDiumAwwwU9D
         exEE1EoZ6HIftjJyhZE8dkMYPLrP4JBeB5329yXEkOW+1Tj8y930iguuVauEf28odO
         m7rPSc+QrkcYlgLhLv/vHeBqbvbJeboWMvXUNZ1Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220120193628epcas5p3653549314ae792c4a72d61b5e687d4de~MEaqFJut70595105951epcas5p3F;
        Thu, 20 Jan 2022 19:36:28 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Jft6Z4C31z4x9Pp; Thu, 20 Jan
        2022 19:36:22 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.26.46822.DF8B9E16; Fri, 21 Jan 2022 04:33:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220120193622epcas5p3a65c8424c6a01aed9a87f5ac2a89eb06~MEakfKDpv1482614826epcas5p3M;
        Thu, 20 Jan 2022 19:36:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220120193622epsmtrp13bb5c602dbd6b8bdbabb96ef9ec4a559~MEakeIEN82029720297epsmtrp1T;
        Thu, 20 Jan 2022 19:36:22 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-cd-61e9b8fddcb0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.93.29871.5B9B9E16; Fri, 21 Jan 2022 04:36:22 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220120193619epsmtip2fa2f3bcf81e595e2d56979e6a574cef0~MEaiTpHlp2383823838epsmtip2K;
        Thu, 20 Jan 2022 19:36:19 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        Aswani Reddy <aswani.reddy@samsung.com>, linux-fsd@tesla.com,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v2 3/3] arm64: dts: fsd: Add SPI device nodes
Date:   Fri, 21 Jan 2022 00:54:38 +0530
Message-Id: <20220120192438.25555-4-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120192438.25555-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTQ/fvjpeJBv1nBSwezNvGZrH4x3Mm
        i0Obt7JbTH34hM1i/pFzrBYb3/5gspjyZzmTxabH11gtHr4Kt7i8aw6bxYzz+5gsGj/eZLdY
        tPULu0Xr3iPsDnwesxp62TyuL/nE7LFpVSebx51re9g8Ni+p9+jbsorR41/TXHaPz5vkAjii
        sm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5WUihL
        zCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRn
        zFnRzF5wSKRi4e5DjA2MkwS6GDk5JARMJJ6+e8MCYgsJ7GaUeNDq0cXIBWR/YpT4uewFI4Tz
        jVHi9cctTDAdUzf+Z4NI7GWUeLl1PguE08IkceTKfbBZbALaEnenQ3SICLhJ3GjsYAIpYha4
        wyTx7vojdpCEsICtxLc7/WANLAKqEi9/TQNr4BWwkZi/YhrUOnmJ1RsOMIPYnED13x//ALtJ
        QmAih8SlCVNZIIpcJH5fuscMYQtLvDq+hR3ClpJ42d8GZHMA2dkSPbuMIcI1EkvnHYNqtZc4
        cGUOC0gJs4CmxPpd+iBhZgE+id7fT5ggOnklOtqEIKpVJZrfXYXqlJaY2N3NCmF7SPy6MokZ
        Eg4TGCWOLNzGPoFRdhbC1AWMjKsYJVMLinPTU4tNC4zyUsvhEZWcn7uJEZwatbx2MD588EHv
        ECMTB+MhRgkOZiURXqn6Z4lCvCmJlVWpRfnxRaU5qcWHGE2BQTaRWUo0OR+YnPNK4g1NLA1M
        zMzMTCyNzQyVxHlPp29IFBJITyxJzU5NLUgtgulj4uCUamDq2Pk6wtP6yNcTdomioUuFGGbF
        zZS5bbm02Cija32qp92S2S8u779sxLiXy6dy5oEXdwJWBG/btHaV5RHHyKcKD1j6Dx1VDDm4
        JbVl+zNV/pWmmYc83E6I9naddlj3+s30s2Uf+6aGatuZ+5lXTGrrSjHJ15C4z1ZpN/FG+5Q7
        nuJKQlzn+k/7XGmyOmFusvpxcd2r+XGaKo/m/D/aVVvh8L2FZeOh49Fv+RZw3ioK2SJyY61A
        K5/E047y7oPF9vJey8umMPI/m7ddV6FrUdiqff7W8+4WHPrBaJN/Stvh5lHtUxsPS3z4qOzo
        KytdH5l5RShu1y/hxl/TGfYeExDdbNB+kytkmh//jIXKt/SUWIozEg21mIuKEwFQy+KVFgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvO62nS8TDS6vZrR4MG8bm8XiH8+Z
        LA5t3spuMfXhEzaL+UfOsVpsfPuDyWLKn+VMFpseX2O1ePgq3OLyrjlsFjPO72OyaPx4k91i
        0dYv7Bate4+wO/B5zGroZfO4vuQTs8emVZ1sHneu7WHz2Lyk3qNvyypGj39Nc9k9Pm+SC+CI
        4rJJSc3JLEst0rdL4MqYs6KZveCQSMXC3YcYGxgnCXQxcnJICJhITN34n62LkYtDSGA3o8TE
        A1vZIBLSEtc3TmCHsIUlVv57zg5R1MQkseTLHkaQBJuAtsTd6VuYQGwRAQ+Jtn/3mEGKmAVe
        MEkc3NgMViQsYCvx7U4/C4jNIqAq8fLXNLAGXgEbifkrIGwJAXmJ1RsOMIPYnED13x//AOsV
        Aqp5eH878wRGvgWMDKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYIDW0tzB+P2VR/0
        DjEycTAeYpTgYFYS4ZWqf5YoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTU
        gtQimCwTB6dUA1Ps3LjVy4/taM6xcj4m8+xW0OzSexrHVlw8OtG14d0nd4W7pgJXXrfJW3ts
        mXt19a+qgND3Zu+LP24/rn22JSeWP+/zZU6N88Yzbxx8fFmbxW97q8eaKyt/MWaLbd29ei0z
        74d9ah1Ve+MVp7wXqLnxqJfN4vT+R6bumZd2HHn8Y1bpAZ4yMQbJnaslFy/csdP2t1Hyg3UM
        QeUbTmlcYuwtex7C/FvYsMEsc39VpvHOc8/vHMxszPIwe2w96R3vvOzgY4s+5RlIlnmIdXAs
        Onp6WZ622VlR/T859Wdf7K6doRPkl9LBaXgz82rP7zuSey5lbfqRetQ94+KDgNszGqfnLK1y
        s6q0Lbk643ma1DRpJZbijERDLeai4kQAFe203dsCAAA=
X-CMS-MailID: 20220120193622epcas5p3a65c8424c6a01aed9a87f5ac2a89eb06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220120193622epcas5p3a65c8424c6a01aed9a87f5ac2a89eb06
References: <20220120192438.25555-1-alim.akhtar@samsung.com>
        <CGME20220120193622epcas5p3a65c8424c6a01aed9a87f5ac2a89eb06@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswani Reddy <aswani.reddy@samsung.com>

Adds device tree node for SPI IPs

Cc: linux-fsd@tesla.com
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd.dtsi | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index bab63c9f79dc..86cf1446d1fc 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -29,6 +29,9 @@ aliases {
 		pinctrl0 = &pinctrl_fsys0;
 		pinctrl1 = &pinctrl_peric;
 		pinctrl2 = &pinctrl_pmu;
+		spi0 = &spi_0;
+		spi1 = &spi_1;
+		spi2 = &spi_2;
 	};
 
 	cpus {
@@ -667,6 +670,60 @@ pinctrl_fsys0: pinctrl@15020000 {
 			reg = <0x0 0x15020000 0x0 0x1000>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		spi_0: spi@14140000 {
+			compatible = "tesla,fsd-spi";
+			reg = <0x0 0x14140000 0x0 0x100>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 4>, <&pdma1 5>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_peric PERIC_PCLK_SPI0>,
+				<&clock_peric PERIC_SCLK_SPI0>;
+			clock-names = "spi", "spi_busclk0";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_bus>;
+			num-cs = <1>;
+			status = "disabled";
+		};
+
+		spi_1: spi@14150000 {
+			compatible = "tesla,fsd-spi";
+			reg = <0x0 0x14150000 0x0 0x100>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 6>, <&pdma1 7>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_peric PERIC_PCLK_SPI1>,
+				<&clock_peric PERIC_SCLK_SPI1>;
+			clock-names = "spi", "spi_busclk0";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_bus>;
+			num-cs = <1>;
+			status = "disabled";
+		};
+
+		spi_2: spi@14160000 {
+			compatible = "tesla,fsd-spi";
+			reg = <0x0 0x14160000 0x0 0x100>;
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 8>, <&pdma1 9>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_peric PERIC_PCLK_SPI2>,
+				<&clock_peric PERIC_SCLK_SPI2>;
+			clock-names = "spi", "spi_busclk0";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi2_bus>;
+			num-cs = <1>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.25.1

