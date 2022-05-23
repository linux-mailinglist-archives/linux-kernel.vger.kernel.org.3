Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50840530A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiEWH2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiEWH1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:27:15 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C2D33E3D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:24:25 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220523065837epoutp023e1137a7d74fdf4141b34fc344eef2ca~xqbFXQhcD2375623756epoutp02W
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:58:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220523065837epoutp023e1137a7d74fdf4141b34fc344eef2ca~xqbFXQhcD2375623756epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653289117;
        bh=WDjbzKlFHJB4sNanoPbt5VssymzXrSnoMfG86YXbq3w=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rJOFNixxEX7VcjZSjGXFhpO6+8NxkQR+57AjTqbc6xPx5wjsfvlgR4jCmIBAzIsoo
         GER41wL7tVSpsfeGQ0LohxhX7mGT7SCBzrkkyGo8RoYKJ91QTh4x7B7Xg+K1jMv+85
         n21keX3g+WNbjGblwgBtjF573iE+Y2DE4PFhUx5o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220523065836epcas5p1fef7a2c0339055c59ace6c8fa87fa4d0~xqbEyCxKD0407604076epcas5p1r;
        Mon, 23 May 2022 06:58:36 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L67TM6QBQz4x9QB; Mon, 23 May
        2022 06:58:31 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.10.10063.5903B826; Mon, 23 May 2022 15:58:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220523065829epcas5p3dc6257c87391637c95a251116f933573~xqa969YP62530425304epcas5p35;
        Mon, 23 May 2022 06:58:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220523065829epsmtrp14d4bbe44494aa140143c1dafae1b5834~xqa96DHv72471324713epsmtrp17;
        Mon, 23 May 2022 06:58:29 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-fb-628b30957858
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.92.11276.5903B826; Mon, 23 May 2022 15:58:29 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220523065827epsmtip19ab668bc9e5ad6999d0703c70729f506~xqa8oOKJS1230912309epsmtip18;
        Mon, 23 May 2022 06:58:27 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Juerg Haefliger'" <juerg.haefliger@canonical.com>,
        <krzysztof.kozlowski@linaro.org>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "'Juerg Haefliger'" <juergh@canonical.com>
In-Reply-To: <20220523064252.11938-3-juergh@canonical.com>
Subject: RE: [PATCH 2/3] ARM: s3c: Kconfig.s3c24xx: Fix indentation and
 replace some tabs
Date:   Mon, 23 May 2022 12:28:26 +0530
Message-ID: <000c01d86e72$81c02510$85406f30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJIkmbzPzFb+hSyrD8PLJObOMqOwQHZGnlqAeCa8lmsLfFAwA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmlu5Ug+4kgy2HVS2WTXnMbHFl7gJW
        i72vt7JbbHp8jdXi8q45bBYzzu9jsjg0dS+jA7vH5WsXmT1mNfSyedy5tofNY/OSeo/Pm+QC
        WKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlBS
        KEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUm
        ZGcs7rzAWNAkW/H4y0rWBsaF4l2MnBwSAiYSLyY8ZOti5OIQEtjNKHHn+3EmCOcTo8Thr3tZ
        IJxvjBLX9x1mg2k5veILVMteRomLa3ZCVb1klOh5+osRpIpNQFdix+I2sCoRgcOMEh8mzAaq
        4uBgFgiQmNQoAFLDKWAlcWFzFxOILSwQLbHzeCPYBhYBVYlZk9rZQWxeAUuJ59svMUHYghIn
        Zz5hAbGZBeQltr+dwwxxkYLEz6fLWEFsEQEniWXv5rFD1IhLvDx6hB3kBgmBmRwS2+dPgmpw
        kbg7p5EdwhaWeHV8C5QtJfGyv40d5E4JAQ+JRX+kIMIZEm+Xr2eEsO0lDlyZA/WKpsT6XfoQ
        q/gken8/YYLo5JXoaBOCqFaVaH53lQXClpaY2N3NCmF7SEw6+5R5AqPiLCSPzULy2CwkD8xC
        WLaAkWUVo2RqQXFuemqxaYFhXmo5PL6T83M3MYLTqJbnDsa7Dz7oHWJk4mA8xCjBwawkwrs9
        sSNJiDclsbIqtSg/vqg0J7X4EKMpMLQnMkuJJucDE3leSbyhiaWBiZmZmYmlsZmhkjivwP/G
        JCGB9MSS1OzU1ILUIpg+Jg5OqQYmsz9G7zR5Wr8/aLvCuc0uLeRpW20cv4qV3H2/i5Wz2hou
        V+kvTeAUinkxW9aw7SvX8hOGr7fY2c57fDDtuGnxjE3Rcoe6v6aFyjIHzdvnM33TxJQ/ovKl
        Ac0Waj802WcscQk/27PnkQbrovVXbh7Yu+XDn5fuk2onnNy19sB/5vvbpnfa3NzmcP9qUMqn
        nZpvPh6f8Hvmo3yRnhu5Vdw3TR5OWvQmM+CoV9PpTXXh255fEgu9+rPhAeOLwzMlP/nE3RLV
        qP0grnBZcJ6f2tOzL7XLUl/fSq+VXbBE5UaN9ba73aWnD4ZdeXqnYPHDky8XHVs4rXrT7rq+
        78f6V/5qi4hxF1hWOKVWduGS1CsLrW8osRRnJBpqMRcVJwIAQZOLCiwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTneqQXeSwfvpvBbLpjxmtrgydwGr
        xd7XW9ktNj2+xmpxedccNosZ5/cxWRyaupfRgd3j8rWLzB6zGnrZPO5c28PmsXlJvcfnTXIB
        rFFcNimpOZllqUX6dglcGYs7LzAWNMlWPP6ykrWBcaF4FyMnh4SAicTpFV/Yuhi5OIQEdjNK
        dDV+YoZISEtc3ziBHcIWllj57zk7RNFzRonbkxeBFbEJ6ErsWNwG1i0icJxR4t7hz2wgCWaB
        AImlfbOZIDp2MkpcnLeMBSTBKWAlcWFzFxOILSwQKTFr3RuwBhYBVYlZk9rB1vEKWEo8336J
        CcIWlDg58wlQLwfQUD2Jto2MEPPlJba/nQN1qYLEz6fLWEFsEQEniWXv5rFD1IhLvDx6hH0C
        o/AsJJNmIUyahWTSLCQdCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeTluYO
        xu2rPugdYmTiYDzEKMHBrCTCuz2xI0mINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJ
        JanZqakFqUUwWSYOTqkGJg5vSRP+aKn6XY4L98l8Xb3id6hJWH3mE8b9y0p65v1STLl2dj7X
        Kb20xIeSlbdjNXRnnvd6/3gqz6fgnrz9ZY6HUnxqjX7NSNkquVZLcv6sO8+WFi3lCNbV/7JV
        08k47Pv8tHUvGXZU7C+QKOxOn3p+3kplD8lt7/qF90wxe/WPfeGeOyfutDLLrJNc9GDRmqWN
        c89/W+CYOPewy7RV/0vz91o6RL2cVKaUzyUcqrOt2jVs9YHaEo9Fb2brNLxNNxZNXvm7YvMW
        /gKjk3wVqQxbL0X+2H41NreUt3XNOwXz9eltR9wWtLOwnpz5vyZhwjQ15eMTmu8amSz8PPXs
        7kO/u8q3Hyt7KbVljbN3uoUSS3FGoqEWc1FxIgDrdfKmFQMAAA==
X-CMS-MailID: 20220523065829epcas5p3dc6257c87391637c95a251116f933573
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220523064307epcas5p4c0c80598c5565b10df20eb471cea6890
References: <20220523064252.11938-1-juergh@canonical.com>
        <CGME20220523064307epcas5p4c0c80598c5565b10df20eb471cea6890@epcas5p4.samsung.com>
        <20220523064252.11938-3-juergh@canonical.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Juerg for your patch.

>-----Original Message-----
>From: Juerg Haefliger [mailto:juerg.haefliger@canonical.com]
>Sent: Monday, May 23, 2022 12:13 PM
>To: krzysztof.kozlowski@linaro.org; alim.akhtar@samsung.com;
>linux@armlinux.org.uk; linux-arm-kernel@lists.infradead.org; linux-samsung-
>soc@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org; Juerg Haefliger <juergh@canonical.com>
>Subject: [PATCH 2/3] ARM: s3c: Kconfig.s3c24xx: Fix indentation and replace
>some tabs
>
>The convention for indentation seems to be a single tab. Help text is
further
>indented by an additional two whitespaces. Fix the lines that violate these
>rules.
>
>While add it, replace tabs before comments with whitespaces and squeeze
>multiple empty lines.
>
>Signed-off-by: Juerg Haefliger <juergh@canonical.com>
>---
> arch/arm/mach-s3c/Kconfig.s3c24xx | 26 ++++++++++++--------------
> 1 file changed, 12 insertions(+), 14 deletions(-)
>
>diff --git a/arch/arm/mach-s3c/Kconfig.s3c24xx b/arch/arm/mach-
>s3c/Kconfig.s3c24xx
>index 000e3e234f71..a7625e772905 100644
>--- a/arch/arm/mach-s3c/Kconfig.s3c24xx
>+++ b/arch/arm/mach-s3c/Kconfig.s3c24xx
>@@ -17,8 +17,6 @@ config PLAT_S3C24XX
> 	help
> 	  Base platform code for any Samsung S3C24XX device
>
>-
>-
> menu "Samsung S3C24XX SoCs Support"
>
> comment "S3C24XX SoCs"
>@@ -268,7 +266,7 @@ config MACH_VR1000
> 	help
> 	  Say Y here if you are using the Thorcom VR1000 board.
>
>-endif	# CPU_S3C2410
>+endif # CPU_S3C2410
>
> config S3C2412_PM_SLEEP
> 	bool
>@@ -342,7 +340,7 @@ config MACH_VSTMS
> 	help
> 	  Say Y here if you are using an VSTMS board
>
>-endif	# CPU_S3C2412
>+endif # CPU_S3C2412
>
> if CPU_S3C2416
>
>@@ -390,7 +388,7 @@ config MACH_S3C2416_DT
> 	  Note: This is under development and not all peripherals can be
>supported
> 	  with this machine file.
>
>-endif	# CPU_S3C2416
>+endif # CPU_S3C2416
>
> if CPU_S3C2440 || CPU_S3C2442
>
>@@ -419,7 +417,7 @@ config S3C2440_PLL_16934400
> 	default y if S3C24XX_PLL
> 	help
> 	  PLL tables for S3C2440 or S3C2442 CPUs with 16.934MHz crystals.
>-endif
>+endif # CPU_S3C2440 || CPU_S3C2442
>

This change is more then what commit message tells, so please mention these
in the commit message as well
Rest looks fine to me.


> if CPU_S3C2440
>
>@@ -515,7 +513,7 @@ config SMDK2440_CPU2440
> 	default y if ARCH_S3C2440
> 	select S3C2440_XTAL_16934400
>
>-endif	# CPU_S3C2440
>+endif # CPU_S3C2440
>
> if CPU_S3C2442
>
>@@ -535,7 +533,7 @@ config MACH_NEO1973_GTA02
> 	select S3C24XX_PWM
> 	select S3C_DEV_USB_HOST
> 	help
>-	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM
>Phone
>+	  Say Y here if you are using the Openmoko GTA02 / Freerunner GSM
>+Phone
>
> config MACH_RX1950
> 	bool "HP iPAQ rx1950"
>@@ -547,9 +545,9 @@ config MACH_RX1950
> 	select S3C24XX_PWM
> 	select S3C_DEV_NAND
> 	help
>-	   Say Y here if you're using HP iPAQ rx1950
>+	  Say Y here if you're using HP iPAQ rx1950
>
>-endif	# CPU_S3C2442
>+endif # CPU_S3C2442
>
> if CPU_S3C2443 || CPU_S3C2416
>
>@@ -558,7 +556,7 @@ config S3C2443_SETUP_SPI
> 	help
> 	  Common setup code for SPI GPIO configurations
>
>-endif	# CPU_S3C2443 || CPU_S3C2416
>+endif # CPU_S3C2443 || CPU_S3C2416
>
> if CPU_S3C2443
>
>@@ -571,13 +569,13 @@ config MACH_SMDK2443
> 	help
> 	  Say Y here if you are using an SMDK2443
>
>-endif	# CPU_S3C2443
>+endif # CPU_S3C2443
>
> config PM_H1940
> 	bool
> 	help
> 	  Internal node for H1940 and related PM
>
>-endmenu	# Samsung S3C24XX SoCs Support
>+endmenu # "Samsung S3C24XX SoCs Support"
>
>-endif	# ARCH_S3C24XX
>+endif # ARCH_S3C24XX
>--
>2.32.0


