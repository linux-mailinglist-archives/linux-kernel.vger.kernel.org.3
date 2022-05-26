Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03A0535673
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346644AbiEZXla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349333AbiEZXl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:41:28 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6451E3DB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 16:41:24 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220526234119epoutp04e7e0a209ab1da6beb6615043c4fe4693~yzCaTJ-Xa0931309313epoutp04k
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:41:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220526234119epoutp04e7e0a209ab1da6beb6615043c4fe4693~yzCaTJ-Xa0931309313epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653608479;
        bh=sWEQ4Tu5+xeBKhu2wDFq5JZM6JOMoDMGgNK+wvM1jjE=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=iOE0expX0YDSU2fvAjNENKS6+TzvQNMlp7oe5MX7JNBOLBPjTHOFKgoE3zbzvx0w8
         bnHCHF+MQDUqymeGX7GacQhd7tf7TRWT8Xo68GS9prSeOFaQ+sKJER3rNiqZVB9UnX
         BTJBH0SINrCwyMcph4or1oekHFCbbgVg9To1KmLU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220526234118epcas2p3f9ee4bf25d0551d848002a33f46c963d~yzCZXHi0F0496804968epcas2p3l;
        Thu, 26 May 2022 23:41:18 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L8PZw65Cwz4x9QJ; Thu, 26 May
        2022 23:41:12 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.ED.09764.81010926; Fri, 27 May 2022 08:41:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220526234112epcas2p17ccbecc3a1cf82cacc337c01191f61be~yzCTkS4SZ1662616626epcas2p1d;
        Thu, 26 May 2022 23:41:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220526234112epsmtrp21d08302eb5b883ad7d75294bb3ea94eb~yzCTjZRcn0338103381epsmtrp2U;
        Thu, 26 May 2022 23:41:12 +0000 (GMT)
X-AuditID: b6c32a46-f75ff70000002624-17-629010183c01
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.C1.11276.71010926; Fri, 27 May 2022 08:41:11 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220526234111epsmtip1500074813cf583e8ab511da603f9cdd2~yzCTU6mrp2372123721epsmtip1G;
        Thu, 26 May 2022 23:41:11 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220526204323.832243-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/2] arm64: dts: exynos: adjust whitespace around '='
Date:   Fri, 27 May 2022 08:41:11 +0900
Message-ID: <00b701d8715a$14f73410$3ee59c30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQIgSz7hxXHuabc42aSexo0uotKmUgIH/dVSrJHdcuA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmma6EwIQkg6ULBS0ezNvGZjH/yDlW
        i74XD5kt9r7eym6x6fE1VovLu+awWcw4v4/JonXvEXYHDo9NqzrZPO5c28PmsXlJvUffllWM
        Hp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQw
        MDIFKkzIznj8aDNbwTGOih/3tBoY/7J1MXJySAiYSCyYe4Spi5GLQ0hgB6PExQ3nGSGcT4wS
        T17eYIdwvjFKNC07Btfy4UIbVMteRokVj1aBJYQEXjBKLGjlBrHZBPQlXnZsYwUpEhG4zyTx
        +es8VpAEp4CrROPU54wgtrCAp8S7DU/YQWwWAVWJyR9bwOK8ApYSC++2MEPYghInZz5hAbGZ
        BeQltr+dwwxxhYLEz6fLWCHiIhKzO9vA4iICVhJtH2+D/SAh0MkhsfLAdiCHA8hxkfixPwqi
        V1ji1fEt7BC2lMTnd3uhPiuWWDrrExNEbwOjxOVtv6ASxhKznrWDzWEW0JRYv0sfYqSyxJFb
        UKfxSXQc/ssOEeaV6GgTgmhUlziwfToLhC0r0T3nMyuE7SFxqOcT+wRGxVlInpyF5MlZSB6b
        hbB3ASPLKkax1ILi3PTUYqMCI3hcJ+fnbmIEJ1Ittx2MU95+0DvEyMTBeIhRgoNZSYT3wtPe
        JCHelMTKqtSi/Pii0pzU4kOMpsBgn8gsJZqcD0zleSXxhiaWBiZmZobmRqYG5krivF4pGxKF
        BNITS1KzU1MLUotg+pg4OKUamBTWvQjkWnv1m8Cc23uKCsteHepgCY4p5+z4UZd0L4nrxydD
        xuMcBtrvefQfztouVGn7n2XpS6/5oSFtNfof7Zm6MzLPC0mZZx8P6+XUcrj6/NIHpV3GkTG1
        dW0JBqlXH1q/cjkh2BIhzmJo/1DbrbCToUpyb+WTjClXbeIFA3mTQ8QDv988dzPG/25sr5bF
        7GNPypgKYrht/uS1sTNPn5wZ4tPmnNR6u3/5Vm5Ldd7Lv7t17zvdlbv7wNZEt1b74T5uiYDT
        2y83fNt+U3uD/jFOpwdb3Z7r+pl8bdo8m9dlqxnnv8MpKSpn+y7YrjyqZecmeNb+pJLFywa3
        134FZnxJRmmfOnx2cS6akanEUpyRaKjFXFScCAASjI7rLQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnK64wIQkgxXrTS0ezNvGZjH/yDlW
        i74XD5kt9r7eym6x6fE1VovLu+awWcw4v4/JonXvEXYHDo9NqzrZPO5c28PmsXlJvUffllWM
        Hp83yQWwRnHZpKTmZJalFunbJXBlPH60ma3gGEfFj3taDYx/2boYOTkkBEwkPlxoY+pi5OIQ
        EtjNKLHz8SVGiISsxLN3O9ghbGGJ+y1HWCGKnjFKXH3wD6ybTUBf4mXHNrCEiMBjJonmf58Y
        IaqmMUos2rQQbBSngKtE49TnYLawgKfEuw1PwMayCKhKTP7YAhbnFbCUWHi3hRnCFpQ4OfMJ
        C4jNLKAnsX79HEYIW15i+9s5zBAnKUj8fLqMFSIuIjG7sw0sLiJgJdH28TbjBEahWUhGzUIy
        ahaSUbOQtC9gZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcQVqaOxi3r/qgd4iR
        iYPxEKMEB7OSCO+Fp71JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgt
        gskycXBKNTBFs26a6nRrh3ZwwOe1fW/DKmz8f2zjWeh1f4HjP33BhUd8kk/sFbNN2RsZuSn4
        j5zJRPbtNbk2eape6SETZT7ozz9yqS3cfuueG2q2odE/Em0u33DtUZlxQif7vNiNrGNhz9cZ
        qmdeObvJ/PD1Oy1bDDL2tN6NNH/jPXVl1aupf6U+trv9TPn49vmviz1z8hQYflVOu7vThSFy
        YmXjDkHbwhmmN3ziSo0n9XBdv1i80oalcuuWwi9ftF8f0XZnT7I7ExXnYXBDY5d1f7Zfzn3t
        Bv3GErcbxkkszOmBj7UmzeJfPS1L3vn8Ods6vqTvv6J0TFakCAfrXdtjxSrd68JsU5XTeWmf
        5+3X5k6qx5VYijMSDbWYi4oTAcllov8PAwAA
X-CMS-MailID: 20220526234112epcas2p17ccbecc3a1cf82cacc337c01191f61be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220526204417epcas2p44f9bcd1f7917389f6346464085634e66
References: <CGME20220526204417epcas2p44f9bcd1f7917389f6346464085634e66@epcas2p4.samsung.com>
        <20220526204323.832243-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fix whitespace coding style: use single space instead of tabs or multiple
> spaces around '=' sign in property assignment.  No functional changes
> (same DTB).
> 

Thanks for the correction :)
Reviewed-by: Chanho Park <chanho61.park@samsung.com>

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Output compared with dtx_diff and fdtdump.
> ---
>  arch/arm64/boot/dts/exynos/exynosautov9.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> index 0ce46ec5cdc3..5827e1228fa9 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> @@ -364,7 +364,7 @@ ufs_0_phy: ufs0-phy@17e04000 {
>  		};
> 
>  		ufs_0: ufs0@17e00000 {
> -			compatible ="samsung,exynosautov9-ufs";
> +			compatible = "samsung,exynosautov9-ufs";
> 
>  			reg = <0x17e00000 0x100>,  /* 0: HCI standard */
>  				<0x17e01100 0x410>,  /* 1: Vendor-specific
*/
> --
> 2.34.1


