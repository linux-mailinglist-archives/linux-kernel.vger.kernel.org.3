Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8439B4CD2E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbiCDK6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbiCDK6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:58:17 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AEFBA7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:57:29 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220304105727epoutp04ae54e618e860553d9b9c7de869411e2a~ZKExkK_WI2055520555epoutp04P
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:57:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220304105727epoutp04ae54e618e860553d9b9c7de869411e2a~ZKExkK_WI2055520555epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646391447;
        bh=SBB2NfJR0+XZwMZfHTVuj270qJKCvFhlQYN1Bj2gnvo=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=dx+Y0UcVdO/SuVHUp/z3deli0Ub/Nj/teiTRmQZlnipYKFdyJbNfcGQP3vbmo13fo
         Wpd/Sg75eoZwMOr9GXAyJCyMxbtiF+/itgjT844OXNA8ZxTHiTWmJHMO+GrmAhsDZB
         1TX2eOLLzxJMd++hT3/alynLnkx4fKIxUZeLSt6s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220304105726epcas5p2ae2259b6d9c71b28865643a49a8ffab8~ZKExDd4G42563525635epcas5p2f;
        Fri,  4 Mar 2022 10:57:26 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4K94Ys3TFTz4x9Px; Fri,  4 Mar
        2022 10:57:21 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.C6.46822.96EE1226; Fri,  4 Mar 2022 19:48:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220304105714epcas5p258fa9222087828369ff0eb3a4318ffbf~ZKEl5Y5_J2563525635epcas5p2R;
        Fri,  4 Mar 2022 10:57:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220304105714epsmtrp12ffc9a04d9404da0b9d0575737781f01~ZKEl4pQQD2033620336epsmtrp1p;
        Fri,  4 Mar 2022 10:57:14 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-3a-6221ee69cc70
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.66.29871.A80F1226; Fri,  4 Mar 2022 19:57:14 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220304105713epsmtip128eafd71aaf74d2107378c66f85c3d88~ZKEkovfyL1867618676epsmtip1Q;
        Fri,  4 Mar 2022 10:57:13 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20220225153650.289923-3-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH 3/3] arm64: dts: exynos: add a specific compatible to
 MCT
Date:   Fri, 4 Mar 2022 16:27:12 +0530
Message-ID: <000201d82fb6$9b672090$d23561b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJxTl5cVJJB5hst+orov2J0YUHPrQLp50vPAtRiSaerTt2kcA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmlm7mO8Ukgz2rOS3mfZa1mH/kHKvF
        xrc/mCw2Pb7GanF51xw2ixnn9zFZtO49wm6xedNUZgcOj1kNvWwem1Z1snncubaHzePduXPs
        HpuX1Ht83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITtjY9NztoLnQhWH13xka2BsEuhi5OSQEDCROD/jN2sXIxeHkMBuRok9vY+Z
        IZxPjBJLns5jg3C+MUocbHkBVMYB1rJhkTpEfC+jxMWF36A6XjJKbLl9gB1kLpuArsSOxW1g
        3SICl5gkTnS0MIEkOAU8JJa9XMQKYgsL+Eusvb8SbCqLgIrEjnsOIGFeAUuJWY/+sEDYghIn
        Zz4Bs5kF5CW2v53DDHG3gsTPp8vAxogIOElcnfWfFaJGXOLl0SPsIHslBOZySLxbfwDqaheJ
        S9fMIXqFJV4d38IOYUtJvOxvY4coyZbo2WUMEa6RWDrvGAuEbS9x4MocFpASZgFNifW79CE2
        8Un0/n7CBNHJK9HRJgRRrSrR/O4qVKe0xMTublYI20Oi598pNhBbSOAmo8Spf74TGBVmIflx
        FpIfZyH5ZRbC4gWMLKsYJVMLinPTU4tNC4zyUsvhsZ2cn7uJEZxUtbx2MD588EHvECMTB+Mh
        RgkOZiURXktNhSQh3pTEyqrUovz4otKc1OJDjKbAcJ/ILCWanA9M63kl8YYmlgYmZmZmJpbG
        ZoZK4ryn0zckCgmkJ5akZqemFqQWwfQxcXBKNTBZPdzSs2bpEVGL1+xHdxj9zHCJYatc9ufq
        7B6bJm7jyNPTpILfn7t5sYT3Gl97w4oX35xUvp5qW6VxZua7gN9HjwrvuPhhRkNn8Ieox1Mu
        Nt/rr97dN33Z5bvTq3Q+mkdqSCx4ujeLcTLPU2Gm+C5/WaU9ahN+9LnOE+lhvLLz2rkFXaLh
        cVkZ/UrHE/c+FamZVPt8Brtarthz/3UvhTtql9sdzGF8xXU6rpx983bzZXfEprG+3m6U13rk
        rKqF7sbW+Dm9O5g/2Tw9nKBhnN7zrfuIMufllu0v77YeP39Y1droTJJU+X/x4gV2z7y+nbXd
        1VXweOPD02pO8ycusz98l/uW3ZM1/DNTFFx5T/NcVWIpzkg01GIuKk4EACaG74kzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnG7XB8Ukg8Nf1S3mfZa1mH/kHKvF
        xrc/mCw2Pb7GanF51xw2ixnn9zFZtO49wm6xedNUZgcOj1kNvWwem1Z1snncubaHzePduXPs
        HpuX1Ht83iQXwBbFZZOSmpNZllqkb5fAlbGx6TlbwXOhisNrPrI1MDYJdDFycEgImEhsWKTe
        xcjFISSwm1Hi3PMZzF2MnEBxaYnrGyewQ9jCEiv/PWeHKHrOKHH5aBMrSIJNQFdix+I2NpCE
        iMANJonpB24yQVRdZZSY2zyHBaSKU8BDYtnLRWAdwgK+EreurWcHWc0ioCKx454DSJhXwFJi
        1qM/LBC2oMTJmU9YQEqYBfQk2jYygoSZBeQltr+dA3WcgsTPp8vAJooIOElcnfWfFaJGXOLl
        0SPsExiFZiGZNAth0iwkk2Yh6VjAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4
        hrQ0dzBuX/VB7xAjEwfjIUYJDmYlEV5LTYUkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7G
        CwmkJ5akZqemFqQWwWSZODilGphmMrinN1YHz3l/nIvXv3BiT57hA+X0mKlfjX96PHjm8u6q
        6cXSr/rvH+14Kr2GfcG7/hjBBcXtescsgooyFVfqLtvLpnkstGi5gczXjY6Kt+zzovLu/YtY
        E+TJuTa1X59rXf+rr4tX/EyRtetetkVKkdG9yM7E8XqPEOOk2Y8bf9lzhIQUs8/93f8gxLO6
        SHZdDnNY1U4W44+bbdkepWlebS3xXvhCY81a803a727o7V3n9pf9Oufcmy5fhZ7wXd158PO9
        LX8+eb25tvrUI0b1xlgebRv925NvPn205HXhT9ULWU//73QQvyCs6L3n+UVzka1/guzXXOz7
        Xfn1yWkPraQH/Ybmm/e/9LeZwX9JiaU4I9FQi7moOBEAK4z+mBADAAA=
X-CMS-MailID: 20220304105714epcas5p258fa9222087828369ff0eb3a4318ffbf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220225180502epcas5p4a8126555d09513b92fb1947669529176
References: <20220225153650.289923-1-krzysztof.kozlowski@canonical.com>
        <CGME20220225180502epcas5p4a8126555d09513b92fb1947669529176@epcas5p4.samsung.com>
        <20220225153650.289923-3-krzysztof.kozlowski@canonical.com>
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
>Subject: [PATCH 3/3] arm64: dts: exynos: add a specific compatible to MCT
>
>One compatible is used for the Multi-Core Timer on most of the Samsung
Exynos
>SoCs, which is correct but not specific enough.  These MCT blocks have
different
>number of interrupts, so add a second specific compatible to Exynos5433 and
>Exynos850.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---
> arch/arm64/boot/dts/exynos/exynos5433.dtsi | 3 ++-
>arch/arm64/boot/dts/exynos/exynos850.dtsi  | 3 ++-
> 2 files changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>index 661567d2dd7a..017ccc2f4650 100644
>--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>@@ -806,7 +806,8 @@ tmu_isp: tmu@1007c000 {
> 		};
>
> 		timer@101c0000 {
>-			compatible = "samsung,exynos4210-mct";
>+			compatible = "samsung,exynos5433-mct",
>+				     "samsung,exynos4210-mct";

Just a though, do we still need to keep Samsung,exyno4210-mct compatible?
In anyway:

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> 			reg = <0x101c0000 0x800>;
> 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> 				<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
>diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi
>b/arch/arm64/boot/dts/exynos/exynos850.dtsi
>index d1700e96fee2..12f7ddc6fd0a 100644
>--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
>+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
>@@ -181,7 +181,8 @@ chipid@10000000 {
> 		};
>
> 		timer@10040000 {
>-			compatible = "samsung,exynos4210-mct";
>+			compatible = "samsung,exynos850-mct",
>+				     "samsung,exynos4210-mct";
> 			reg = <0x10040000 0x800>;
> 			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
> 				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
>--
>2.32.0


