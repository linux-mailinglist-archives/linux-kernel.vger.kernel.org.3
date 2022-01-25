Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C529749AB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389905AbiAYEkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:40:47 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:16812 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1323503AbiAYD2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:28:44 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220125032837epoutp03606cfcfbd5d83bc79a2941f928e06058~NZcC2Yz5X0538805388epoutp03j
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:28:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220125032837epoutp03606cfcfbd5d83bc79a2941f928e06058~NZcC2Yz5X0538805388epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643081317;
        bh=+7Cu9Kn9/33bdLL2XPVxaJ2bvv5PfxM0zoSifz4NBsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqtl9BAu2B1VbAls5k2m2ZrenQMFP0tNl0uwtziRHz8SFmZHof3yKJJmiq1YJ5Vxm
         zQdzwzZNfmZoJa1k5L79GSZEX2QigL73WVhHTEaWMdCv7KQTELRcQjl+H8jQEhSpg9
         zyVYRkXWOfL2FBLJFgn5iW1T/1mZFurUxRNf/PLs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220125032836epcas5p23e2340ab1dc13f5bd9f0df39fee4769a~NZcCWE6Ag2291022910epcas5p2s;
        Tue, 25 Jan 2022 03:28:36 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JjXPT1rZ1z4x9Q8; Tue, 25 Jan
        2022 03:28:29 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.CC.05590.D5E6FE16; Tue, 25 Jan 2022 12:28:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220125032828epcas5p22fbacf42ebfb1b78c1f74f48d37aa381~NZb6mVl592291022910epcas5p2a;
        Tue, 25 Jan 2022 03:28:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220125032828epsmtrp2503af6965ec8161deef83a1bd2bd7cc4~NZb6lilEY2646626466epsmtrp2a;
        Tue, 25 Jan 2022 03:28:28 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-d6-61ef6e5dd4dd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.48.08738.C5E6FE16; Tue, 25 Jan 2022 12:28:28 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220125032826epsmtip1aeef21ca7ca03a0be6e3748a5d256238~NZb4lRMbG0543005430epsmtip1O;
        Tue, 25 Jan 2022 03:28:26 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        Aswani Reddy <aswani.reddy@samsung.com>, linux-fsd@tesla.com,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 3/3] arm64: dts: fsd: Add SPI device nodes
Date:   Tue, 25 Jan 2022 08:46:04 +0530
Message-Id: <20220125031604.76009-4-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220125031604.76009-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTUzc2732iwZZbfBYP5m1js1j84zmT
        xaHNW9ktpj58wmYx/8g5VouNb38wWUz5s5zJYtPja6wWD1+FW1zeNYfNYsb5fUwWjR9vslss
        2vqF3aJ17xF2Bz6PWQ29bB7Xl3xi9ti0qpPN4861PWwem5fUe/RtWcXo8a9pLrvH501yARxR
        2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGcrKZQl
        5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
        Wk6IFLwTqeh9O42xgXGnQBcjJ4eEgInE6SkNbF2MXBxCArsZJW4vmcUC4XxilGhY+RAq85lR
        4mLrLzaYlqc7v7BCJHYxSnxqvswE4bQwSdxaPoEFpIpNQFvi7vQtTCC2iICbxI3GDrAiZoE7
        TBLvrj9iB0kIC9hKvDu5B6yBRUBV4te19cxdjBwcvAI2Et0//CG2yUus3nAALMwJVN48gQNk
        jIRAL4fEk2e7oC5ykXh/eyUrhC0s8er4FnYIW0ri87u9bCC9EgLZEj27jCHCNRJL5x1jgbDt
        JQ5cmcMCUsIsoCmxfpc+SJhZgE+i9/cTJohOXomONiGIalWJ5ndXoTqlJSZ2d0Mt9ZBoaloN
        DbgJjBKrJpxnnMAoOwth6gJGxlWMkqkFxbnpqcWmBcZ5qeXwaErOz93ECE6LWt47GB89+KB3
        iJGJg/EQowQHs5II73/v94lCvCmJlVWpRfnxRaU5qcWHGE2BATaRWUo0OR+YmPNK4g1NLA1M
        zMzMTCyNzQyVxHlPpW9IFBJITyxJzU5NLUgtgulj4uCUamByC0qVS139ce+nb1Pna61f9tgg
        rdbVQPD2r09n8nzZF0/795Ip+Pl1NS/B89u6HW4/yzrIvejnFc7DvtOaFM/JTD423VZkdvOh
        hnjVzfmND87UVbRLGSumHlzJ8W9RO+f6nFrHggeM5+4V9Zg1nF9/v9b+w3VXxfqtD25/ePj/
        UoXEtrXRDOa+mbYaWeY3PF44zprUW3Emd4POTwa55fc7lF9l9b13ubL9dFvGWnWRM/Uxk5Yq
        O661ml+4ZteK1hvVjMlqLV3PrwUuqZvqLbcvenN9i1zorp4gk7ArfgIXOCT5ato4L6ucmaQw
        a6lh0b38OQ/e7bB88fGxeevMbbMsIxW7lSxehHK927n2RmuiEktxRqKhFnNRcSIAyuOhRhQE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSnG5M3vtEg4430hYP5m1js1j84zmT
        xaHNW9ktpj58wmYx/8g5VouNb38wWUz5s5zJYtPja6wWD1+FW1zeNYfNYsb5fUwWjR9vslss
        2vqF3aJ17xF2Bz6PWQ29bB7Xl3xi9ti0qpPN4861PWwem5fUe/RtWcXo8a9pLrvH501yARxR
        XDYpqTmZZalF+nYJXBktJ0QK3olU9L6dxtjAuFOgi5GTQ0LAROLpzi+sXYxcHEICOxglnky+
        zQaRkJa4vnECO4QtLLHy33N2iKImJolDZ++xgiTYBLQl7k7fwgRiiwh4SLT9u8cMUsQs8IJJ
        4uDGZkaQhLCArcS7k3tYQGwWAVWJX9fWAxVxcPAK2Eh0//CHWCAvsXrDAbAwJ1B58wQOEFMI
        qOL9Io0JjHwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEB7SW1g7GPas+6B1i
        ZOJgPMQowcGsJML73/t9ohBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtS
        i2CyTBycUg1M8VfC9Y1kp/g1vc96tfnI5X9fGNb5sc7fsMtVq+qR+6z4BKur7N9v2zsYnwyz
        +ZIw76YNW+mh3x285brHGCx0JN/1nOXxS+rfmvq6YVdLnlz2pNRTYSwV6z9Y1MYHGX8XLV58
        kiXEirX3m8RC1Yzba9cIO3pIvD6qJFnrdG+B6f8dc5nmqhk8mb4ya6LLvWsPg3u81J/9+WPK
        W80QK61ysqRv6++Wvc8rpzTsuHKVlfGD35+M/6rcKazfp4sqdvxU9uwXvMs35X+HmtEL22V5
        LlOPx0Vv/b03yY6xclvGMvs8Wesf8ae3cjs8qzR90y152LH7fkJSyz7XkgvGTPnLSs9fqU/8
        dkThZE+yYrISS3FGoqEWc1FxIgA0f3f01wIAAA==
X-CMS-MailID: 20220125032828epcas5p22fbacf42ebfb1b78c1f74f48d37aa381
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220125032828epcas5p22fbacf42ebfb1b78c1f74f48d37aa381
References: <20220125031604.76009-1-alim.akhtar@samsung.com>
        <CGME20220125032828epcas5p22fbacf42ebfb1b78c1f74f48d37aa381@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswani Reddy <aswani.reddy@samsung.com>

Adds device tree node for SPI IPs

Cc: linux-fsd@tesla.com
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
---
 arch/arm64/boot/dts/tesla/fsd.dtsi | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index b7f05f78c601..da4acd68b976 100644
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
@@ -668,6 +671,60 @@ pinctrl_fsys0: pinctrl@15020000 {
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

