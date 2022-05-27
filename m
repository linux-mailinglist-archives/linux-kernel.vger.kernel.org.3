Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB02253583E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 06:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbiE0EWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 00:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiE0EWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 00:22:36 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD9F76289
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:22:33 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220527042227epoutp046b4a506fe5119b42038348938861b026~y234P1yVJ0839908399epoutp04K
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:22:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220527042227epoutp046b4a506fe5119b42038348938861b026~y234P1yVJ0839908399epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653625347;
        bh=kTMSku+wRHw3/iaNA0Ocg3i0O4FTebz0XJKPrB/YrEE=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=JVnotfeurfDbol1v9+08KEZm2XfWkRKBP62Yyph1WB2hTwifQhRaeqZZfmWDgS+ux
         ObjO1hkGPIbRsRVXv1Huaot29kaw8yA65qzznRFY7DW8UTRPLD2fG4sump1Y+Jenub
         VVNP/Z2CYeCNkSqBAb26M2PqdcDPunv1pKDpvSCs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220527042227epcas2p1289fcf7446d6ff65cff00daf9b1e9f5b~y233t_xM81349313493epcas2p1P;
        Fri, 27 May 2022 04:22:27 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L8WqM6YNFz4x9Q3; Fri, 27 May
        2022 04:22:23 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.69.10069.DF150926; Fri, 27 May 2022 13:22:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220527042221epcas2p48eba371da8b9a5b940efd852e36c6f3a~y23yKRP2i2554025540epcas2p4T;
        Fri, 27 May 2022 04:22:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220527042221epsmtrp150b905b9660238b9eaf864baaf0e6e1b~y23yJJKmu3019630196epsmtrp1N;
        Fri, 27 May 2022 04:22:21 +0000 (GMT)
X-AuditID: b6c32a45-a8fff70000002755-70-629051fda327
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.9F.11276.CF150926; Fri, 27 May 2022 13:22:20 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220527042220epsmtip1dab27ca6a53a2f6ab90bfc88d7d30890~y23x5QWgq3031830318epsmtip1W;
        Fri, 27 May 2022 04:22:20 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
In-Reply-To: <20220526143707.767490-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/7] ARM: dts: s3c2410: use local header for pinctrl
 register values
Date:   Fri, 27 May 2022 13:22:20 +0900
Message-ID: <012d01d87181$5b9e23c0$12da6b40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJyxhdZ1KlViaDZ4SOc3qllW0JPVwEeqvFKAv0c9XOr3JeZYA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmue7fwAlJBn3/tC0ezNvGZjH/yDlW
        i74XD5kt9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWM87vY7Jo3XuE3eLwm3ZWi1W7/jA6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79G3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnptkre
        wfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA3KimUJeaUAoUCEouLlfTtbIryS0tSFTLy
        i0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyMz6feshU8Fynon/pM6YGxi6VLkZO
        DgkBE4k7Z18yg9hCAjsYJf4s8e5i5AKyPzFK/Fs8gwnC+cYoMaV7JTNMx8xNS1khEnsZJX6u
        2cYI4bxglHjZ+4kRpIpNQF/iZcc2VhBbRKCTReJXvwuIzSngKnFj9RMmEFtYIEri2dP5YDaL
        gKrEprU3wWxeAUuJA5/3sEHYghInZz5hAbGZBeQltr+dA3WFgsTPp8tYIeIiErM725ghdjlJ
        PP7fDHaQhMAODomjR/qhGlwk1sx4ygJhC0u8Or6FHcKWknjZ3wZlF0ssnfWJCaK5gVHi8rZf
        bBAJY4lZz9qBpnIAbdOUWL9LH8SUEFCWOHIL6jY+iY7Df9khwrwSHW1CEI3qEge2T4faKivR
        PeczK4TtIXGo/wnTBEbFWUi+nIXky1lIPpuFsHcBI8sqRrHUguLc9NRiowJDeGQn5+duYgQn
        Xy3XHYyT337QO8TIxMF4iFGCg1lJhPfC094kId6UxMqq1KL8+KLSnNTiQ4ymwHCfyCwlmpwP
        TP95JfGGJpYGJmZmhuZGpgbmSuK8XikbEoUE0hNLUrNTUwtSi2D6mDg4pRqYtj8yF7k2b/um
        3JAfrnL/b2Yv9Uw8F8Z95tWONdPDbrhLSK32mqig2P9Za4X+lxmvs979ETuokx5adVm/8Rzr
        +u45Xpt3+1sZKC9ZuoOR4SxPMdvDPU9/l3M05XKa6ElrnniWdZv3uqGYuEj8n3r3h1/DJ2/l
        m/sj7MTHKbIn1YL2mQdvX3nJ68rz+7b5dTM4Nzf89t915pFZZYzO8bSftwN+b+t8MOvIFzuN
        bxfNdCZ+OHLc//5fngDFKwHVAesKV70zYLWQUlrxPNR3dbp/3pm+9w0JuvJ7Jz2cvmiNzGMz
        09UrXLP9ryZ+/cPp0L7wrclNHv+gSSILM229ZvY9KzpjzeulmfTt9xX3DrbII0osxRmJhlrM
        RcWJAHfVmS5HBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnO6fwAlJBj1nrS0ezNvGZjH/yDlW
        i74XD5kt9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWM87vY7Jo3XuE3eLwm3ZWi1W7/jA6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79G3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZn089ZCp4
        rlPRv/QZUwNjl0oXIyeHhICJxMxNS1m7GLk4hAR2M0qsXNDIDJGQlXj2bgc7hC0scb/lCFTR
        M0aJR23LWEASbAL6Ei87trGC2CICE1kkrq5IhCg6zyjxesslsEmcAq4SN1Y/Yepi5OAQFoiQ
        mL5LAyTMIqAqsWntTSYQm1fAUuLA5z1sELagxMmZT8DmMwvoSaxfP4cRwpaX2P52DtRxChI/
        ny5jhYiLSMzubGOGuMFJ4vH/ZsYJjEKzkIyahWTULCSjZiFpX8DIsopRMrWgODc9t9iwwDAv
        tVyvODG3uDQvXS85P3cTIzjitDR3MG5f9UHvECMTB+MhRgkOZiUR3gtPe5OEeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYNq/6NHjvY7TI89fP5tvvVKE
        Zf6yjdviaqfX1B1nK1/NUDhX8Zy623aeKtet0zz+Tl+duJvVX1L45ZQfOlyazzcfu3nZea56
        TK7J5dSfH8XPrFI6MzO3++yNZcyh/1k0HslZHt84y/zWx+81GtX/12xjSdzrvLq1eMbFKdHs
        /Is93s2P9UjYFrC5Q5D13f83Gw+8mJizsThBv2+BmsyvWVf+FOz4YJ4R7r/13d1pNpE7NrHO
        C74u+GH2xO8PfzgEp6Q7nLA03X7x4pQXulO0tGc+576x0rhOcLF5y5znzx2MvPtW3V0xv0ph
        n9q8fxY8B8w7mVm5xbUbZX8KJ4cITYjlf2lc7zj1nczulLd8n+WDlViKMxINtZiLihMBLThv
        fCcDAAA=
X-CMS-MailID: 20220527042221epcas2p48eba371da8b9a5b940efd852e36c6f3a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220526143736epcas2p27f8a54ddcb91aa4a66adc287af0491c3
References: <20220526143707.767490-1-krzysztof.kozlowski@linaro.org>
        <CGME20220526143736epcas2p27f8a54ddcb91aa4a66adc287af0491c3@epcas2p2.samsung.com>
        <20220526143707.767490-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 1/7] ARM: dts: s3c2410: use local header for pinctrl
> register values
> 
> The DTS uses hardware register values directly in pin controller pin
> configuration.  These are not some IDs or other abstraction layer but raw
> numbers used in the registers.
> 
> These numbers were previously put in the bindings header to avoid code
> duplication and to provide some context meaning (name), but they do not
> fit the purpose of bindings.  It is also quite confusing to use constants
> prefixed with Exynos for other SoC, because there is actually nothing here
> in common, except the actual value.
> 
> Store the constants in a header next to DTS and use them instead of
> bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/s3c2410-pinctrl.h    | 19 +++++++++++++
>  arch/arm/boot/dts/s3c2416-pinctrl.dtsi | 38 +++++++++++++-------------
>  2 files changed, 38 insertions(+), 19 deletions(-)  create mode 100644
> arch/arm/boot/dts/s3c2410-pinctrl.h
> 
> diff --git a/arch/arm/boot/dts/s3c2410-pinctrl.h
> b/arch/arm/boot/dts/s3c2410-pinctrl.h
> new file mode 100644
> index 000000000000..71cb0ac815b3
> --- /dev/null
> +++ b/arch/arm/boot/dts/s3c2410-pinctrl.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Samsung's Exynos pinctrl bindings

"Exynos" -> "s3c2410"

Best Regards,
Chanho Park

> + *
> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + * Copyright (c) 2022 Linaro Ltd
> + * Author: Krzysztof Kozlowski <krzk@kernel.org>  */
> +
> +#ifndef __DTS_ARM_SAMSUNG_S3C2410_PINCTRL_H__
> +#define __DTS_ARM_SAMSUNG_S3C2410_PINCTRL_H__
> +
> +#define S3C2410_PIN_FUNC_INPUT		0
> +#define S3C2410_PIN_FUNC_OUTPUT		1
> +#define S3C2410_PIN_FUNC_2		2
> +#define S3C2410_PIN_FUNC_3		3
> +
> +#endif /* __DTS_ARM_SAMSUNG_S3C2410_PINCTRL_H__ */
> diff --git a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
> b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
> index 20a7d72827c2..3268366bd8bc 100644
> --- a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
>   */
> 
> -#include <dt-bindings/pinctrl/samsung.h>
> +#include "s3c2410-pinctrl.h"
> 
>  &pinctrl_0 {
>  	/*
> @@ -82,91 +82,91 @@ gpm: gpm-gpio-bank {
> 
>  	uart0_data: uart0-data-pins {
>  		samsung,pins = "gph-0", "gph-1";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	uart0_fctl: uart0-fctl-pins {
>  		samsung,pins = "gph-8", "gph-9";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	uart1_data: uart1-data-pins {
>  		samsung,pins = "gph-2", "gph-3";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	uart1_fctl: uart1-fctl-pins {
>  		samsung,pins = "gph-10", "gph-11";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	uart2_data: uart2-data-pins {
>  		samsung,pins = "gph-4", "gph-5";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	uart2_fctl: uart2-fctl-pins {
>  		samsung,pins = "gph-6", "gph-7";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	uart3_data: uart3-data-pins {
>  		samsung,pins = "gph-6", "gph-7";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	extuart_clk: extuart-clk-pins {
>  		samsung,pins = "gph-12";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	i2c0_bus: i2c0-bus-pins {
>  		samsung,pins = "gpe-14", "gpe-15";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	spi0_bus: spi0-bus-pins {
>  		samsung,pins = "gpe-11", "gpe-12", "gpe-13";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	sd0_clk: sd0-clk-pins {
>  		samsung,pins = "gpe-5";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	sd0_cmd: sd0-cmd-pins {
>  		samsung,pins = "gpe-6";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	sd0_bus1: sd0-bus1-pins {
>  		samsung,pins = "gpe-7";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	sd0_bus4: sd0-bus4-pins {
>  		samsung,pins = "gpe-8", "gpe-9", "gpe-10";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	sd1_cmd: sd1-cmd-pins {
>  		samsung,pins = "gpl-8";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	sd1_clk: sd1-clk-pins {
>  		samsung,pins = "gpl-9";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	sd1_bus1: sd1-bus1-pins {
>  		samsung,pins = "gpl-0";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
> 
>  	sd1_bus4: sd1-bus4-pins {
>  		samsung,pins = "gpl-1", "gpl-2", "gpl-3";
> -		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
>  	};
>  };
> --
> 2.34.1


