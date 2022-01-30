Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917B44A34EB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 08:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354334AbiA3HfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 02:35:01 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:48446 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354328AbiA3He6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 02:34:58 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220130073457epoutp011f9845fa0aec507072823f0c4877b5ac~O-BjOhMsC1944219442epoutp01F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 07:34:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220130073457epoutp011f9845fa0aec507072823f0c4877b5ac~O-BjOhMsC1944219442epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643528097;
        bh=fUBkDIMr4reFnVPgCPf0zCADp3QJ0trdqST8eC91qmA=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=CNyVZcukec1NWetlsmjhB6nX8gXSyrER4lfhXTNYgHoOUbyO6ds6jNTJlGyV88fNi
         +8/AuELr6WIng5YweHri1W4g3+135Z13UHKuCOspoARVg8MQ5+KnaACEnd1PLgk/c4
         H39ZuIN8LzefWlydAGde2+9uNNRclJX32w7sB7JI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220130073457epcas5p2fa4dffd174a4c6eb0c8b126cd43799ef~O-BiwmLKv3032930329epcas5p22;
        Sun, 30 Jan 2022 07:34:57 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JmjdT6qbWz4x9Pw; Sun, 30 Jan
        2022 07:34:53 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.A7.05590.D9F36F16; Sun, 30 Jan 2022 16:34:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220130073453epcas5p3cc8a3c6fc46752d322c62b73619f7c65~O-BfYD7JP2544525445epcas5p3g;
        Sun, 30 Jan 2022 07:34:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220130073453epsmtrp10ec468682a856e15aa9f9c2985ccf8e5~O-BfXqgWv2495324953epsmtrp1i;
        Sun, 30 Jan 2022 07:34:53 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-62-61f63f9db5cc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.A0.08738.C9F36F16; Sun, 30 Jan 2022 16:34:52 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220130073451epsmtip19af990e66553d12f0ae81b5b8c67d77f~O-Bdqt6nB0864608646epsmtip1p;
        Sun, 30 Jan 2022 07:34:51 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Lee Jones'" <lee.jones@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
In-Reply-To: <20220129175332.298666-2-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH 2/5] arm64: dts: exynos: drop unneeded syscon phandle in
 Exynos5433 LPASS
Date:   Sun, 30 Jan 2022 13:04:49 +0530
Message-ID: <00d901d815ab$de78a8b0$9b69fa10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFgtqenDY7K+SNveA8HtgWqOAMTMQIDmjR6AeSCqamtSqlOEA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmlu5c+2+JBj/nSVvMP3KO1aJ58Xo2
        i41vfzBZ3P96lNFi0+NrrBaXd81hs5hxfh+TxZnFvewWa4/cZbdo3XuE3eLwm3ZWB26PWQ29
        bB6bVnWyedy5tofNY//cNewem5fUe/RtWcXo8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3
        cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCNSgpliTmlQKGAxOJiJX07m6L80pJUhYz8
        4hJbpdSClJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTsjFdH57MXbOGt6Nl9ga2B8Tp3FyMn
        h4SAicSfhl1MXYxcHEICuxklts38zwzhfGKUeDTxHCuE85lRYsbC2exdjBxgLef+OoN0Cwns
        YpRYtEYWouYlo8TBMy8ZQRJsAroSOxa3sYEkRARuMkus2tLCApLgFPCQ2Ny4H6xIWCBe4s2T
        A8wgNouAqsTH0z3sIDavgKXEyanboWxBiZMzn4D1MgvIS2x/O4cZ4m4FiZ9Pl7GC2CICThKN
        6z6zQ9SIS7w8eoQdZLGEwB4OiaOr/0M1uEjcmXuQDcIWlnh1fAs7hC0l8bK/DeqzbImeXcYQ
        4RqJpfOOsUDY9hIHrsxhASlhFtCUWL9LH2IVn0Tv7ydMEJ28Eh1tQhDVqhLN765CdUpLTOzu
        ZoWwPSTW9r+GhudNRonN814xT2BUmIXky1lIvpyF5JtZCJsXMLKsYpRMLSjOTU8tNi0wzkst
        h8d3cn7uJkZwCtby3sH46MEHvUOMTByMhxglOJiVRHhnbPqUKMSbklhZlVqUH19UmpNafIjR
        FBj0E5mlRJPzgVkgryTe0MTSwMTMzMzE0tjMUEmc91T6hkQhgfTEktTs1NSC1CKYPiYOTqkG
        pien/lhOFNx/zuBrUPMt4faH6XP8t/y3Ztb7+PJgbWfjnIxOJS4nu427DZ3uFZTPf3/tZ+nV
        jBdP7T8YFNxQdg5PlXXM8T6Z5+JWFro8bEN3vTbPT24tN7t763euDd18wvCC3vSdYou02bkK
        NdcxdeuzLdS7lbxsnVfum0m/sg/ptxps5bZh21/mo1kyc+oBXmXOPqu6f9dtrF657w/7Wv2i
        3kih6ekLgxrxJPGz19+y/W/sfCOovkBZWjojvj/nwr3AhRfeJ3d5H477k87VuytOQezVa+aN
        ebGJU696uqyffOrJQb5sjylvrB6+fvaEf81qnvoVrvyzdu8pnMD9dscKXmanx83JQipLLm6a
        qMRSnJFoqMVcVJwIAAYZ9kxKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnO4c+2+JBgt+WVvMP3KO1aJ58Xo2
        i41vfzBZ3P96lNFi0+NrrBaXd81hs5hxfh+TxZnFvewWa4/cZbdo3XuE3eLwm3ZWB26PWQ29
        bB6bVnWyedy5tofNY//cNewem5fUe/RtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfGq6Pz2Qu2
        8Fb07L7A1sB4nbuLkYNDQsBE4txf5y5GLg4hgR2MEr93TmDpYuQEiktLXN84gR3CFpZY+e85
        O0TRc0aJyR+msYEk2AR0JXYsbmMDSYgIPGSW2PVjEitE1VVGibfLXoG1cwp4SGxu3M8IYgsL
        xErM658MZrMIqEp8PN0DVsMrYClxcup2KFtQ4uTMJywg5zEL6Em0bQQrZxaQl9j+dg4zxEUK
        Ej+fLmMFsUUEnCQa131mh6gRl3h59Aj7BEahWUgmzUKYNAvJpFlIOhYwsqxilEwtKM5Nzy02
        LDDKSy3XK07MLS7NS9dLzs/dxAiONy2tHYx7Vn3QO8TIxMF4iFGCg1lJhHfGpk+JQrwpiZVV
        qUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTDlhO5/8PbFkjefFm9n
        vMlj3vmEkbEn4pLHXqvcG4vmHH/2cAr3LSs3SwEXlY2LFHpnvN7GzuTbw/VP+ck/Rqcv4lYF
        4bc9H2xyXL3iXcjuM5+m7vBnVN37f0ddaPeP+Fz/wOr59mGP/P55fm/Imcd5yKuqu4J32voL
        z5hcE9YnBu5mu7l57s/ktEdhv+8esG7PbPh20nLu1O8mQrtbbrE2qHdo7la6tnBh2675s4QZ
        so496p1zy2bqc8ay8qKiCvP5DYp77m+d63L07jv2uTa/tCfetNRJ8tHat6DTeSHf6hX6Uf3f
        5Lk9Pdj3bZZKcmi2Yvlx4bd51YVru32XK7n+MQrrLVvK6j29vH3TPfXLSizFGYmGWsxFxYkA
        HGgGeSYDAAA=
X-CMS-MailID: 20220130073453epcas5p3cc8a3c6fc46752d322c62b73619f7c65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220129175341epcas5p3a110f6f10b38206e008e2c377a6640d9
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
        <CGME20220129175341epcas5p3a110f6f10b38206e008e2c377a6640d9@epcas5p3.samsung.com>
        <20220129175332.298666-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Saturday, January 29, 2022 11:23 PM
>To: Lee Jones <lee.jones@linaro.org>; Rob Herring <robh+dt@kernel.org>;
>Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Sylwester Nawrocki
><s.nawrocki@samsung.com>; Marek Szyprowski
><m.szyprowski@samsung.com>; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-serial@vger.kernel.org
>Subject: [PATCH 2/5] arm64: dts: exynos: drop unneeded syscon phandle in
>Exynos5433 LPASS
>
>Exynos5433 LPASS audio node does not use syscon phandle since commit
>addebf1588ab ("mfd: exynos-lpass: Remove pad retention control").  It was
>also dropped from bindings.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> arch/arm64/boot/dts/exynos/exynos5433.dtsi | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>index b4cde77e02d3..661567d2dd7a 100644
>--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>@@ -1885,7 +1885,6 @@ audio-subsystem@11400000 {
> 			reg = <0x11400000 0x100>, <0x11500000 0x08>;
> 			clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
> 			clock-names = "sfr0_ctrl";
>-			samsung,pmu-syscon = <&pmu_system_controller>;
> 			power-domains = <&pd_aud>;
> 			#address-cells = <1>;
> 			#size-cells = <1>;
>--
>2.32.0


