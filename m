Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE7A4CD2D5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbiCDKzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbiCDKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:55:50 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7361AEECF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:55:02 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220304105501epoutp0192bf0895e0672e3551a55dec15742608~ZKCpXYS4H1654316543epoutp01N
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:55:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220304105501epoutp0192bf0895e0672e3551a55dec15742608~ZKCpXYS4H1654316543epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646391301;
        bh=PeKxTyJYomZgkUR9VUiGwHMm2Y0LyuPIS5zGUqsb2qo=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=NvOmRBBROv/yoZkCDiGO1TBWhlzB/1ZtfqtJR08mliDHioFWtqpWuzpIg7EORqu1y
         ZMMKNZ3YFjJ4TkLjmDGTcud5UZRVKIGJE0NOH3O5boZipQgdtc4InWgMr+gEtDNiT0
         vGDuTVkYR29niTnqvTBvr3BmLHY3OLuGP7n5tZgg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220304105500epcas5p410dea918415264a49db48ae1e38edc1f~ZKCo7IiXZ1841218412epcas5p4K;
        Fri,  4 Mar 2022 10:55:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4K94W06mFkz4x9QW; Fri,  4 Mar
        2022 10:54:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.63.05590.EEFE1226; Fri,  4 Mar 2022 19:54:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220304105438epcas5p2dd384708df0503a3217011409b14d583~ZKCUh2zSP3003130031epcas5p2B;
        Fri,  4 Mar 2022 10:54:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220304105438epsmtrp1d0ac0e9501e28bdd1b4f73707394fc23~ZKCUhDuFA1956019560epsmtrp1N;
        Fri,  4 Mar 2022 10:54:38 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-86-6221efeee1c1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.26.29871.EEFE1226; Fri,  4 Mar 2022 19:54:38 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220304105437epsmtip1bea365639ce88721ca76c177658e7a20~ZKCTO6vm61640716407epsmtip1W;
        Fri,  4 Mar 2022 10:54:37 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20220225153650.289923-2-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH 2/3] ARM: dts: exynos: add a specific compatible to MCT
Date:   Fri, 4 Mar 2022 16:24:36 +0530
Message-ID: <000101d82fb6$3e613160$bb239420$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJxTl5cVJJB5hst+orov2J0YUHPrQJrEfyiAQR8T5irYVLBUA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmuu6794pJBieW21jM+yxrMf/IOVaL
        jW9/MFlsenyN1eLyrjlsFjPO72OyaN17hN1i86apzA4cHrMaetk8Nq3qZPO4c20Pm8e7c+fY
        PTYvqff4vEkugC0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6BwlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbGnWe7mQq+SFWcnfqSsYHxilgXIyeHhICJxKSJj5i7GLk4hAR2M0p8mvSL
        EcL5xCgxe8JyJgjnG6PEno3X2WBabm7tZoFI7GWU2Pp5AiuE85JR4vm9PlaQKjYBXYkdi9vY
        QBIiApeYJE50tDCBJDgFPCRWTjvJCGILC3hL/L3dCjaWRUBFYtqj/UBjOTh4BSwllm7lBwnz
        CghKnJz5hAXEZhaQl9j+dg4zxBUKEj+fLgPbJSLgJLFs2zJGiBpxiZdHj7CD7JUQmMkh8XrW
        L6gGF4k/H88xQdjCEq+Ob2GHsKUkXva3sYPslRDIlujZZQwRrpFYOu8YC4RtL3Hgyhyw05gF
        NCXW79KHWMUn0fv7CRNEJ69ER5sQRLWqRPO7q1Cd0hITu7tZIUo8JFpOOEBC6iajxMoTK9gm
        MCrMQvLkLCRPzkLyzCyExQsYWVYxSqYWFOempxabFhjnpZbD4zs5P3cTIzixannvYHz04IPe
        IUYmDsZDjBIczEoivJaaCklCvCmJlVWpRfnxRaU5qcWHGE2BAT+RWUo0OR+Y2vNK4g1NLA1M
        zMzMTCyNzQyVxHlPpW9IFBJITyxJzU5NLUgtgulj4uCUamA6N8Nv05uNkwqPJqRXTRW0NJ8w
        dZZP5frXl4Tn6cy7zlxyWGzj/zk3NO+lP491qK4IrN8b4xE1UWvFDo0LXtHznLyX7Uicy3y/
        ZAbrZkH2XOaF6/erW2aJOKuxrdi6f1LbBDkrSVXtdPXtnGt2qy6v2FB5KuPLF/81z8re+b++
        17Lqs+di7ujHeQvvZek/TDf+s/1ci3KDgflWp89Xb+YFODO/fhFbtWbFZYFVX42FRE9cODt9
        kqDW5hVcHRYnb705yi346TJreOfOvtagqpMNN5umsJnNW/hWXaG0ZmWU46GLd6/633e76T7n
        rbzs8l1hct8e79nFddmb5SSLRrCfx8/Hq1eIhtg1TmFg++7moMRSnJFoqMVcVJwIAGZxavA1
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnO6794pJBm+PqFjM+yxrMf/IOVaL
        jW9/MFlsenyN1eLyrjlsFjPO72OyaN17hN1i86apzA4cHrMaetk8Nq3qZPO4c20Pm8e7c+fY
        PTYvqff4vEkugC2KyyYlNSezLLVI3y6BK+POs91MBV+kKs5OfcnYwHhFrIuRk0NCwETi5tZu
        li5GLg4hgd2MEp2rv7JDJKQlrm+cAGULS6z895wdoug5o8SsH3fYQBJsAroSOxa3sYEkRARu
        MElMP3CTCaLqKqNE7+plrCBVnAIeEiunnWQEsYUFvCX+3m4F62YRUJGY9mg/0G4ODl4BS4ml
        W/lBwrwCghInZz4BCzML6Em0bQTrZBaQl9j+dg4zxEEKEj+fQkwXEXCSWLZtGVSNuMTLo0fY
        JzAKzUIyaRbCpFlIJs1C0rGAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwFGlp
        7mDcvuqD3iFGJg7GQ4wSHMxKIryWmgpJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJI
        TyxJzU5NLUgtgskycXBKNTCVfM7eenn7p0PrZkfPjb3Zc6t9kbi9wAmR1FDhgj7Decz/Fh5X
        28J8bnHHvbnfHnVwPAiwuO69NmpBhvzbT3MjQ4tTWzhCgk6fL16wWkHs5QM9xuCKXIXudxmp
        8un5rwo/sMgqS8x0lot7foDzhF/VCvfmXTptjRUvSk1be5eICjXM3CLN9uVMX8npTclHQqc4
        /vAyODrrR8XyiZNFjjDOeKi9Z/ENV9erR/hNlFR778Y3aMscvq19e39T0k1esVvN854Z32hx
        elF+Wa17ZsI6kfDqrYwus37ynhd/fP4ev5Xm7Mi06xxZpyOcuTKM7HgCBS/yNFetmJJ+2a6x
        /oNrX4jM5sBn92OzmY7ufKHEUpyRaKjFXFScCACZVUs7EQMAAA==
X-CMS-MailID: 20220304105438epcas5p2dd384708df0503a3217011409b14d583
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220225180401epcas5p1688ae4e0752f11522aaf6c33295ebc53
References: <20220225153650.289923-1-krzysztof.kozlowski@canonical.com>
        <CGME20220225180401epcas5p1688ae4e0752f11522aaf6c33295ebc53@epcas5p1.samsung.com>
        <20220225153650.289923-2-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Friday, February 25, 2022 9:07 PM
>To: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
><tglx@linutronix.de>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; linux-kernel@vger.kernel.org;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org
>Subject: [PATCH 2/3] ARM: dts: exynos: add a specific compatible to MCT
>
>One compatible is used for the Multi-Core Timer on most of the Samsung
Exynos
>SoCs, which is correct but not specific enough.  These MCT blocks have
different
>number of interrupts, so add a second specific compatible to Exynos3250 and
all
>Exynos5 SoCs.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> arch/arm/boot/dts/exynos3250.dtsi | 3 ++-
arch/arm/boot/dts/exynos5250.dtsi
>| 3 ++-  arch/arm/boot/dts/exynos5260.dtsi | 3 ++-
>arch/arm/boot/dts/exynos54xx.dtsi | 3 ++-
> 4 files changed, 8 insertions(+), 4 deletions(-)
>
>diff --git a/arch/arm/boot/dts/exynos3250.dtsi
>b/arch/arm/boot/dts/exynos3250.dtsi
>index ae644315855d..41bb421e67c2 100644
>--- a/arch/arm/boot/dts/exynos3250.dtsi
>+++ b/arch/arm/boot/dts/exynos3250.dtsi
>@@ -269,7 +269,8 @@ gic: interrupt-controller@10481000 {
> 		};
>
> 		timer@10050000 {
>-			compatible = "samsung,exynos4210-mct";
>+			compatible = "samsung,exynos3250-mct",
>+				     "samsung,exynos4210-mct";
> 			reg = <0x10050000 0x800>;
> 			interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> 				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>, diff
--
>git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>index 5baaa7eb71a4..63d1dcf2c55c 100644
>--- a/arch/arm/boot/dts/exynos5250.dtsi
>+++ b/arch/arm/boot/dts/exynos5250.dtsi
>@@ -245,7 +245,8 @@ clock_audss: audss-clock-controller@3810000 {
> 		};
>
> 		timer@101c0000 {
>-			compatible = "samsung,exynos4210-mct";
>+			compatible = "samsung,exynos5250-mct",
>+				     "samsung,exynos4210-mct";
> 			reg = <0x101C0000 0x800>;
> 			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
> 			clock-names = "fin_pll", "mct";
>diff --git a/arch/arm/boot/dts/exynos5260.dtsi
>b/arch/arm/boot/dts/exynos5260.dtsi
>index 56271e7c4587..ff1ee409eff3 100644
>--- a/arch/arm/boot/dts/exynos5260.dtsi
>+++ b/arch/arm/boot/dts/exynos5260.dtsi
>@@ -333,7 +333,8 @@ chipid: chipid@10000000 {
> 		};
>
> 		mct: timer@100b0000 {
>-			compatible = "samsung,exynos4210-mct";
>+			compatible = "samsung,exynos5260-mct",
>+				     "samsung,exynos4210-mct";
> 			reg = <0x100B0000 0x1000>;
> 			clocks = <&fin_pll>, <&clock_peri PERI_CLK_MCT>;
> 			clock-names = "fin_pll", "mct";
>diff --git a/arch/arm/boot/dts/exynos54xx.dtsi
>b/arch/arm/boot/dts/exynos54xx.dtsi
>index 2ddb7a5f12b3..3ec43761d8b9 100644
>--- a/arch/arm/boot/dts/exynos54xx.dtsi
>+++ b/arch/arm/boot/dts/exynos54xx.dtsi
>@@ -74,7 +74,8 @@ smp-sram@53000 {
> 		};
>
> 		mct: timer@101c0000 {
>-			compatible = "samsung,exynos4210-mct";
>+			compatible = "samsung,exynos5420-mct",
>+				     "samsung,exynos4210-mct";
> 			reg = <0x101c0000 0xb00>;
> 			interrupts-extended = <&combiner 23 3>,
> 					      <&combiner 23 4>,
>--
>2.32.0


