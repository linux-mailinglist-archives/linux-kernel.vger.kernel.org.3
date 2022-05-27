Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A508C53577F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiE0CXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiE0CXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:23:21 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BAFE27A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:23:17 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220527022311epoutp027583c0dcff4126824ff93afa7daf8313~y1PvhUti92153921539epoutp02F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:23:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220527022311epoutp027583c0dcff4126824ff93afa7daf8313~y1PvhUti92153921539epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653618191;
        bh=2CZI+w3XhkdOyKhTaypLqRNn8UD80IlvlQyzniR1tFY=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=XH4J0YVdGpYwOUps6TE3donpO8bFqckswzbI1h5mdONDpfOBhDmghIEwIiTLcapJz
         /9zhj3YAz539+AjBjsnFL29dJtnXnGPEdoINjPcKPG2T+aRg7fhKPvrO9hrEnRi3L6
         FW+D/G0Ou3WRmA49cHYdZt9NI+VVHRFsnAeOmJ7c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220527022310epcas5p1e2c8368b5f2c155b8a81287d78fae380~y1PvDdvNk2696726967epcas5p1Y;
        Fri, 27 May 2022 02:23:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L8T9k4dy2z4x9Pp; Fri, 27 May
        2022 02:23:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.FC.10063.A0630926; Fri, 27 May 2022 11:23:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220527022306epcas5p11745a7d845f93831e50806842d522b8a~y1Pqq-R-R2807828078epcas5p1G;
        Fri, 27 May 2022 02:23:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220527022306epsmtrp1347dda4b081aade5ccbde8cf8228dc86~y1Pqp7uTM2474924749epsmtrp1j;
        Fri, 27 May 2022 02:23:06 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-dc-6290360a2931
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.64.11276.A0630926; Fri, 27 May 2022 11:23:06 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220527022304epsmtip25833ea9dc3496a27c3ad2d6fdfafc041~y1PpQytSf0918309183epsmtip2R;
        Fri, 27 May 2022 02:23:04 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220526204323.832243-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 2/2] ARM: dts: exynos: adjust whitespace around '='
Date:   Fri, 27 May 2022 07:53:03 +0530
Message-ID: <025501d87170$b302a340$1907e9c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIH/dVSS7JGn0sU9NF+P6hjIQTSYwKWanZTAJ86D9esuThjUA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmpi6X2YQkg2WrVCzmHznHatH34iGz
        xd7XW9ktNj2+xmpxedccNosZ5/cxWbTuPcLuwO6xaVUnm8eda3vYPDYvqff4vEkugCUq2yYj
        NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
        UEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGnXMf
        mQp2S1Zs2r2MtYHxlmgXIweHhICJxOf7Vl2MXBxCArsZJa5/fswE4XxilDjxrIkNwvnGKPHt
        wGPmLkZOsI633TdYIBJ7gRLLjjGCJIQEXjJKrJwkBmKzCehK7FjcBtYtIrCJSeLL/r3sIAlO
        AVeJVw/vsoDsFhZwl5jYnwUSZhFQlVh25TcriM0rYCmxbN9VKFtQ4uTMJywgNrOAvMT2t3Og
        jlCQ+Pl0GStEXFzi5dEjYONFBJwk1qx6wA6yV0KgkUNi2quHUA0uEgfavrBA2MISr45vYYew
        pSRe9rexQ8LCQ2LRHymIcIbE2+XrGSFse4kDV+aAncwsoCmxfpc+xFo+id7fT5ggOnklOtqE
        IKpVJZrfXYVaJC0xsbubFWZ4ww8zSKhdZpQ40PmfdQKjwiwkT85C8uQsJI/NQli8gJFlFaNk
        akFxbnpqsWmBYV5qOTy2k/NzNzGCE6eW5w7Guw8+6B1iZOJgPMQowcGsJMJ74WlvkhBvSmJl
        VWpRfnxRaU5q8SFGU2DIT2SWEk3OB6buvJJ4QxNLAxMzMzMTS2MzQyVxXoH/jUlCAumJJanZ
        qakFqUUwfUwcnFINTMJvfUx7Y5dXlFz/+nPyJb0ZB9RCvmyMMFnS9Whd3/J47z3izkzSJitP
        5u3dHCpxTb13zqnQc4smPTxqrif9LCOnpryFc6ddR1hAwTf72aXGtrK3l6YV/mMSm/b0sd9B
        e6u1wgL95//a5uW3MC92kPzxtf+w8Lq4H9UV77Sk7Q7nft7C73TF0/+Iod3zwKKi4nK5ua8U
        J5aFTRZ/Xc+Ys0D8iHAC07wDs82ZbUxC5+vOrexcKBLnumlf2dr2E/eV5U9e9kgXMarpmyH8
        KOFC9BxGQfmEH7+0V6zUWae15ZzBlTCPReblMte9wuO17vh9rTitLteisWD1xMlL+NuLGrY7
        s2yKqFFWfLTjN7uZEktxRqKhFnNRcSIAt7NFTSUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvC6X2YQkg7tt3Bbzj5xjteh78ZDZ
        Yu/rrewWmx5fY7W4vGsOm8WM8/uYLFr3HmF3YPfYtKqTzePOtT1sHpuX1Ht83iQXwBLFZZOS
        mpNZllqkb5fAlXHn3Eemgt2SFZt2L2NtYLwl2sXIySEhYCLxtvsGC4gtJLCbUeL5syKIuLTE
        9Y0T2CFsYYmV/56zQ9Q8Z5Q4+wisnk1AV2LH4ja2LkYuDhGBbUwSq5r/gDlCAucZJb7uucEI
        UsUp4Crx6uFdoA4ODmEBd4mJ/VkgYRYBVYllV36zgti8ApYSy/ZdhbIFJU7OfAJWziygJ9G2
        EWwKs4C8xPa3c5gh7lGQ+Pl0GStEXFzi5dEjYLeJCDhJrFn1gH0Co9AsJJNmIUyahWTSLCTd
        CxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeJluYOxu2rPugdYmTiYDzEKMHB
        rCTCe+Fpb5IQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFIN
        TJn5Vzzq/vrOuhZWaN6ZfIbr91n5DWdfpwoEmtXk2bFWTZBb93helbL7+jVLjBJ389fqKNpN
        n784v0Xnz7dVEZcen8jot3Y4PnuVVabbH9F7pwXSRNZtFaqPs5uzZdrlM9rGDqueKjJMNJ9x
        cLZdvfbmFYKus6p4sqr8OiNO2bgE6fTIGUZwOnN6rc6JNQ1wXGJa5hDic6v2SfC5yG615/rq
        ka/OdD2b/qr98gTr4syPv1asM+afxz9/57rjhvk/lIT/m8iwNOkem3B5T45X8ZJ6s/DfU9al
        LO0PkJ7GPtt8S9Vby0lOwrrdZ3YuWDx9p21ZlHvuq5M+xkc9OV57ST3lnfoxcXKO7+c9lU9a
        lFiKMxINtZiLihMBZOUaBAEDAAA=
X-CMS-MailID: 20220527022306epcas5p11745a7d845f93831e50806842d522b8a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220526204336epcas5p1031b5e4203740cf2c12dff3539f28b28
References: <20220526204323.832243-1-krzysztof.kozlowski@linaro.org>
        <CGME20220526204336epcas5p1031b5e4203740cf2c12dff3539f28b28@epcas5p1.samsung.com>
        <20220526204323.832243-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Friday, May 27, 2022 2:13 AM
>To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>Subject: [PATCH 2/2] ARM: dts: exynos: adjust whitespace around '='
>
>Fix whitespace coding style: use single space instead of tabs or multiple
spaces
>around '=' sign in property assignment.  No functional changes (same DTB).
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>---
>
>Output compared with dtx_diff and fdtdump.
>---
> arch/arm/boot/dts/exynos3250-artik5.dtsi    | 2 +-
> arch/arm/boot/dts/exynos4210-trats.dts      | 2 +-
> arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi | 2 +-
> arch/arm/boot/dts/exynos5.dtsi              | 2 +-
> 4 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi
>b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>index 7b429622a288..0ac3f284fbb8 100644
>--- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
>+++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>@@ -357,7 +357,7 @@ &mshc_1 {
>
> &pinctrl_1 {
> 	bten: bten-pins {
>-		samsung,pins ="gpx1-7";
>+		samsung,pins = "gpx1-7";
> 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> 		samsung,pin-con-pdn = <EXYNOS_PIN_PDN_PREV>; diff --git
>a/arch/arm/boot/dts/exynos4210-trats.dts
>b/arch/arm/boot/dts/exynos4210-trats.dts
>index 01f44d95f671..b8e9dd23fc51 100644
>--- a/arch/arm/boot/dts/exynos4210-trats.dts
>+++ b/arch/arm/boot/dts/exynos4210-trats.dts
>@@ -180,7 +180,7 @@ panel@0 {
> 		vdd3-supply = <&vcclcd_reg>;
> 		vci-supply = <&vlcd_reg>;
> 		reset-gpios = <&gpy4 5 GPIO_ACTIVE_HIGH>;
>-		power-on-delay= <50>;
>+		power-on-delay = <50>;
> 		reset-delay = <100>;
> 		init-delay = <100>;
> 		flip-horizontal;
>diff --git a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
>b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
>index 03dffc690b79..aa7de6de8e19 100644
>--- a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
>+++ b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
>@@ -107,7 +107,7 @@ panel@0 {
> 		vdd3-supply = <&lcd_vdd3_reg>;
> 		vci-supply = <&ldo25_reg>;
> 		reset-gpios = <&gpf2 1 GPIO_ACTIVE_HIGH>;
>-		power-on-delay= <50>;
>+		power-on-delay = <50>;
> 		reset-delay = <100>;
> 		init-delay = <100>;
> 		flip-horizontal;
>diff --git a/arch/arm/boot/dts/exynos5.dtsi
>b/arch/arm/boot/dts/exynos5.dtsi index 9ce9fb3fc190..c8da0d4b1b33 100644
>--- a/arch/arm/boot/dts/exynos5.dtsi
>+++ b/arch/arm/boot/dts/exynos5.dtsi
>@@ -89,7 +89,7 @@ gic: interrupt-controller@10481000 {
> 			compatible = "arm,gic-400", "arm,cortex-a15-gic";
> 			#interrupt-cells = <3>;
> 			interrupt-controller;
>-			reg =	<0x10481000 0x1000>,
>+			reg = <0x10481000 0x1000>,
> 				<0x10482000 0x2000>,
> 				<0x10484000 0x2000>,
> 				<0x10486000 0x2000>;
>--
>2.34.1


